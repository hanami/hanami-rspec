# frozen_string_literal: true

require "hanami/cli/generators/app/ruby_class_file"

module Hanami
  module RSpec
    module Generators
      # @api private
      class Mailer
        attr_reader :fs, :inflector

        def initialize(fs:, inflector:)
          @fs = fs
          @inflector = inflector
        end

        def call(key:, namespace:, base_path:)
          mailer_class_file = mailer_class_file(key:, namespace:, base_path:)
          spec_file_path = mailer_class_file.path.gsub(/\.rb$/, "_spec.rb")
          mailer_class_name = mailer_class_file.fully_qualified_name

          fs.write(spec_file_path, spec_content(mailer_class_name))
        end

        private

        def mailer_class_file(key:, namespace:, base_path:)
          Hanami::CLI::Generators::App::RubyClassFile.new(
            fs:, inflector:, namespace:,
            key: inflector.underscore(key),
            base_path: base_path,
            extra_namespace: "Mailers"
          )
        end

        def spec_content(class_name)
          <<~RUBY
            # frozen_string_literal: true

            RSpec.describe #{class_name} do
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
          RUBY
        end
      end
    end
  end
end
