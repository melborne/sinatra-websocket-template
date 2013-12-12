require 'thor'
require 'fileutils'

module SinatraWebsocketTemplate
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.join(__dir__, 'templates')
    end

    desc "new PROJECT", "Creates a skelton for your project"
    option :dir, aliases:"-d", default:Dir.pwd, banner:"Specify a target directory for your project."
    option :test, aliases:"-t", lazy_default:"rspec", banner:"Generate a test directory(default: rspec)."
    option :bin, aliases:"-b", type: :boolean, default:false, banner:"Generate a binary."
    def new(project_name)
      target = File.join(options[:dir], project_name)
      opts = {
        module_name: project_name.split('_').map(&:capitalize).join,
        namespaced_path: project_name
      }

      template("project/Procfile.tt", File.join(target, "Procfile"))
      template("project/config.ru.tt", File.join(target, "config.ru"), opts)
      lib_path = File.join(target, "lib")
      template("project/lib/app.rb.tt", File.join(lib_path, "app.rb"), opts)
      template("project/lib/views/index.haml.tt", File.join(lib_path, "views", "index.haml"), opts)
      template("project/lib/public/css/main.css.tt", File.join(lib_path, "public", "css", "main.css"))
      template("project/lib/public/js/application.js.tt", File.join(lib_path, "public", "js", "application.js"))
      template("project/lib/project/backend.rb.tt", File.join(lib_path, project_name, "backend.rb"), opts)

      execute_and_edit_bundle_gem(project_name, options)
    end

    desc "version", "Prints the SinatraWebsocketTemplate's version"
    def version
      puts "SinatraWebsocketTemplate version #{SinatraWebsocketTemplate::VERSION}"
    end
    map %w(-v --version) => :version

    no_commands do
      def execute_and_edit_bundle_gem(project_name, options)
        dir = options[:dir]
        opts = %i(test bin).map do |k|
          "--#{k}=#{options[k]}" if options[k]
        end.join(" ")

        FileUtils.mkdir_p(dir)
        Dir.chdir(dir) { system("bundle gem #{project_name} #{opts}") }
        gemspec = File.join(dir, project_name, "#{project_name}.gemspec")
        edit_gemspec(gemspec)
      rescue => e
        abort "Execute 'bundle gem' failed: #{e.message}"
      end

      def edit_gemspec(file)
        content = File.read(file)
        content.sub!(/^end\n$/, '')
        content.concat(<<-EOS)
  spec.add_development_dependency "foreman"

  spec.add_dependency "faye-websocket"
  spec.add_dependency "puma"
  spec.add_dependency "sinatra"
  spec.add_dependency "haml"

  spec.required_ruby_version = ">= 2.0.0"
end
        EOS
        File.write(file, content)
      end
    end
  end
end
