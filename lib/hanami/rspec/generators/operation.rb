# frozen_string_literal: true

require "hanami/cli/generators/app/ruby_class_file"

module Hanami
  module RSpec
    module Generators
      # @api private
      class Operation
        attr_reader :fs, :inflector

        def initialize(fs:, inflector:)
          @fs = fs
          @inflector = inflector
        end

        def call(key:, namespace:, base_path:)
          operation_class_file = operation_class_file(key:, namespace:, base_path:)
          spec_file_path = operation_class_file.path.gsub(/\.rb$/, "_spec.rb")
          operation_class_name = operation_class_file.fully_qualified_name

          fs.write(spec_file_path, spec_content(operation_class_name))
        end

        private

        def operation_class_file(key:, namespace:, base_path:)
          Hanami::CLI::Generators::App::RubyClassFile.new(
            fs:, inflector:, namespace:,
            key: inflector.underscore(key),
            base_path: base_path
          )
        end

        def spec_content(class_name)
          <<~RUBY
            # frozen_string_literal: true

            RSpec.describe #{class_name} do
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
          RUBY
        end
      end
    end
  end
end
