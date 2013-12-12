require 'spec_helper'
require 'pathname'
require 'stringio'

describe SinatraWebsocketTemplate::CLI do
  before(:each) do
    @tmp_path = File.join(Dir.pwd, "tmp")
    @project_name = "project_a"
    @project = Pathname.new(File.join @tmp_path, @project_name)
    $stdout = StringIO.new
  end

  after(:each) do
    FileUtils.rm_r(@tmp_path)
    $stdout = STDOUT
  end

  describe '#new' do
    context 'without bundler gem options' do
      it 'creates a skelton project' do
        described_class.start(['new', @project_name, '--dir', @tmp_path])
        expect(@project.join("Procfile")).to exist

        configru = @project.join("config.ru")
        expect(configru).to exist
        expect(configru.read).to match /project_a\/backend.*ProjectA::App/m

        apprb = @project.join("lib", "app.rb")
        expect(apprb).to exist
        expect(apprb.read).to match /module ProjectA/

        indexhaml = @project.join("lib", "views", "index.haml")
        expect(indexhaml).to exist
        expect(indexhaml.read).to match /%title ProjectA/

        expect(@project.join("lib", "public", "css", "main.css")).to exist
        expect(@project.join("lib", "public", "js", "application.js")).to exist
        expect(@project.join("lib", "project_a", "backend.rb")).to exist

        # created by 'bundle gem command'
        expect(@project.join("Gemfile")).to exist
        expect(@project.join("lib", "project_a.rb")).to exist

        gemspec = @project.join("project_a.gemspec")
        expect(gemspec).to exist
        expect(gemspec.read).to match /spec\.add_dependency.*faye-websocket.*puma.*sinatra.*haml/m
      end
    end

    context 'with bundler gem options' do
      it 'create a skelton with a binary and spec files' do
        described_class.start(['new', @project_name, '--dir', @tmp_path, '-bt'])
        expect(@project.join("bin", "project_a")).to exist
        expect(@project.join("spec", "project_a_spec.rb")).to exist
      end

      it 'create a skelton with minitest' do
        described_class.start(['new', @project_name, '--dir', @tmp_path, '--test=minitest'])
        expect(@project.join("test", "test_project_a.rb")).to exist
      end
    end

  end
end
