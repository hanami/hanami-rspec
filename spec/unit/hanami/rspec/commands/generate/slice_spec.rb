# frozen_string_literal: true

require "hanami"
require "securerandom"

RSpec.describe Hanami::RSpec::Commands::Generate::Slice do
  describe "#call" do
    subject { described_class.new(fs: fs) }

    let(:fs) { Dry::Files.new }

    let(:app_name) { "Bookshelf" }

    let(:slice) { "main" }

    it "generates spec files" do
      within_app_dir do
        subject.call(name: slice)

        # spec/<slice>/action_spec.rb
        action_spec = <<~EXPECTED
          # frozen_string_literal: true

          RSpec.describe Main::Action do
            xit "works"
          end
        EXPECTED
        expect(fs.read("spec/slices/#{slice}/action_spec.rb")).to eq(action_spec)

        # # spec/<slice>/view_spec.rb
        # view_spec = <<~EXPECTED
        #   # frozen_string_literal: true
        #
        #   require "slices/#{slice}/view"
        #
        #   RSpec.describe Main::View do
        #   end
        # EXPECTED
        # expect(fs.read("spec/slices/#{slice}/view_spec.rb")).to eq(view_spec)

        # # spec/<slice>/repository_spec.rb
        # repository_spec = <<~EXPECTED
        #   # frozen_string_literal: true
        #
        #   require "slices/#{slice}/repository"
        #
        #   RSpec.describe Main::Repository do
        #   end
        # EXPECTED
        # expect(fs.read("spec/slices/#{slice}/repository_spec.rb")).to eq(repository_spec)

        # Keep file
        keep = <<~EXPECTED
        EXPECTED

        # spec/<slice>/actions/.keep
        expect(fs.read("spec/slices/#{slice}/actions/.keep")).to eq(keep)
        #
        # # spec/<slice>/views/.keep
        # expect(fs.read("spec/slices/#{slice}/views/.keep")).to eq(keep)
        #
        # # spec/<slice>/templates/.keep
        # expect(fs.read("spec/slices/#{slice}/templates/.keep")).to eq(keep)
        #
        # # spec/<slice>/templates/layouts/.keep
        # expect(fs.read("spec/slices/#{slice}/templates/layouts/.keep")).to eq(keep)
        #
        # # spec/<slice>/entities/.keep
        # expect(fs.read("spec/slices/#{slice}/entities/.keep")).to eq(keep)
        #
        # # spec/<slice>/repositories/.keep
        # expect(fs.read("spec/slices/#{slice}/repositories/.keep")).to eq(keep)
      end
    end
  end

  private

  def within_app_dir(app: app_name)
    root = fs.join(TMP, SecureRandom.uuid)
    dir = fs.join(root, app)

    fs.mkdir(dir)
    fs.chdir(dir) do
      app_code = <<~CODE
        # frozen_string_literal: true

        require "hanami"

        module #{app}
          class App < Hanami::App
          end
        end
      CODE
      fs.write("config/app.rb", app_code)

      routes = <<~CODE
        # frozen_string_literal: true

        require "hanami/routes"

        module #{app}
          class Routes < Hanami::Routes
            define do
              root { "Hello from Hanami" }
            end
          end
        end
      CODE
      fs.write("config/routes.rb", routes)

      yield
    end
  ensure
    fs.delete_directory(root)
  end
end
