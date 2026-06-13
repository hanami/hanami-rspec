# frozen_string_literal: true

require "hanami"
require "securerandom"

RSpec.describe Hanami::RSpec::Commands::Generate::Operation do
  describe "#call" do
    subject { described_class.new(fs: fs) }

    let(:fs) { Dry::Files.new }

    let(:app_name) { "Bookshelf" }

    let(:operation_name) { "books.add" }

    context "app" do
      it "generates spec file" do
        within_app_dir do
          subject.call(name: operation_name)

          operation_spec = <<~EXPECTED
            # frozen_string_literal: true

            RSpec.describe #{app_name}::Books::Add do
              subject(:operation) { described_class.new }

              # Use `be_success` and `be_failure` (from spec/support/operations.rb) to set expectations on an
              # operation's result:
              #
              # expect(result).to be_success(expected_value)
              # expect(result).to be_failure(:some_error)

              xit "succeeds" do
                result = operation.call

                expect(result).to be_success
              end
            end
          EXPECTED
          expect(fs.read("spec/books/add_spec.rb")).to eq(operation_spec)
        end
      end

      context "top-level operation name" do
        let(:operation_name) { "add" }

        it "generates spec file" do
          within_app_dir do
            subject.call(name: operation_name)

            expect(fs.read("spec/add_spec.rb")).to include("RSpec.describe #{app_name}::Add do")
          end
        end
      end

      context "skip_tests given" do
        it "does not generate a spec file" do
          within_app_dir do
            subject.call(name: operation_name, skip_tests: true)

            expect(fs.exist?("spec/books/add_spec.rb")).to be false
          end
        end
      end
    end

    context "slice" do
      let(:slice) { "main" }
      let(:slice_name) { "Main" }

      it "generates spec file" do
        within_app_dir do
          subject.call(slice: slice, name: operation_name)

          expect(fs.read("spec/slices/#{slice}/books/add_spec.rb"))
            .to include("RSpec.describe #{slice_name}::Books::Add do")
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
