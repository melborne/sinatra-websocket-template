require 'thor'

module SinatraWebsocketTemplate
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.join(__dir__, 'templates')
    end

    desc "new PROJECT", "Creates a skelton for creating a project"
    option :dir, aliases:"-d", default:Dir.pwd
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
      template("project/lib/project/backend.rb.tt", File.join(lib_path, "projectA", "backend.rb"))
    end
  end
end