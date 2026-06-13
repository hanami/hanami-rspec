# frozen_string_literal: true

require "hanami"
require "securerandom"

RSpec.describe Hanami::RSpec::Commands::Generate::Mailer do
  describe "#call" do
    subject { described_class.new(fs: fs) }

    let(:fs) { Dry::Files.new }

    let(:app_name) { "Bookshelf" }

    let(:mailer_name) { "welcome" }

    context "app" do
      it "generates spec file" do
        within_app_dir do
          subject.call(name: mailer_name)

          mailer_spec = <<~EXPECTED
            # frozen_string_literal: true

            RSpec.describe #{app_name}::Mailers::Welcome do
              subject(:mailer) { described_class.new }

              # Inspect the delivered message to set expectations on its contents:
              #
              # expect(result.message.to).to eq(["recipient@example.com"])
              # expect(result.message.subject).to eq("Welcome")
              # expect(result.message.html_body).to include("...")

              xit "delivers" do
                result = mailer.deliver

                expect(result).to be_success
              end
            end
          EXPECTED
          expect(fs.read("spec/mailers/welcome_spec.rb")).to eq(mailer_spec)
        end
      end

      context "with nested mailer name" do
        let(:mailer_name) { "notifications.welcome" }

        it "generates spec file" do
          within_app_dir do
            subject.call(name: mailer_name)

            expect(fs.read("spec/mailers/notifications/welcome_spec.rb"))
              .to include("RSpec.describe #{app_name}::Mailers::Notifications::Welcome do")
          end
        end
      end

      context "skip_tests given" do
        it "does not generate a spec file" do
          within_app_dir do
            subject.call(name: mailer_name, skip_tests: true)

            expect(fs.exist?("spec/mailers/welcome_spec.rb")).to be false
          end
        end
      end
    end

    context "slice" do
      let(:slice) { "main" }
      let(:slice_name) { "Main" }

      it "generates spec file" do
        within_app_dir do
          subject.call(slice: slice, name: mailer_name)

          expect(fs.read("spec/slices/#{slice}/mailers/welcome_spec.rb"))
            .to include("RSpec.describe #{slice_name}::Mailers::Welcome do")
        end
      end
    end
  end

  private

  def within_app_dir(app: app_name)
    dir = fs.join(TMP, SecureRandom.uuid, app)

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
  end
end
