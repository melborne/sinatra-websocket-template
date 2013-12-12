require 'thor'

module SinatraWebsocketTemplate
  class Builder < Thor
    include Thor::Actions

    def self.run(project_name, opts)
      new(project_name, opts).run
    end

    def self.source_root
      Dir.pwd
    end

    def initialize(project_name, opts={})
      @project_name = project_name
      @opts = opts
    end

    def run
      # system('bundle gem', @project_name)
      target = File.join(Dir.pwd, @project_name)
      template("templates/project/Procfile.tt", File.join(@project_name, "Procfile"))
    rescue => e
      puts "Error: #{e.message}: #{e.backtrace}"
    end
    
  end
end