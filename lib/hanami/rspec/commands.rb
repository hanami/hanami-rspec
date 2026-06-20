# frozen_string_literal: true

require "shellwords"

module Hanami
  module RSpec
    # @api private
    module Commands
      class Install < Hanami::CLI::Command
        def call(*, **)
          append_gemfile
          append_gitignore
          copy_dotrspec
          copy_spec_helper
          copy_support_rspec
          copy_support_db
          copy_support_features
          copy_support_operations
          copy_support_mailers
          copy_support_requests

          generate_request_spec
        end

        private

        def append_gemfile
          gemfile_template = Hanami.bundled?("hanami-db") ? "gemfile_db" : "gemfile"

          fs.append(
            fs.expand_path("Gemfile"),
            fs.read(fs.expand_path(fs.join("generators", gemfile_template), __dir__))
          )
        end

        def append_gitignore
          fs.append(
            fs.expand_path(".gitignore"),
            fs.read(fs.expand_path(fs.join("generators", "gitignore"), __dir__))
          )
        end

        def copy_dotrspec
          fs.cp(
            fs.expand_path(fs.join("generators", "dotrspec"), __dir__),
            fs.expand_path(fs.join(".rspec"))
          )
        end

        def copy_spec_helper
          fs.cp(
            fs.expand_path(fs.join("generators", "helper.rb"), __dir__),
            fs.expand_path(fs.join("spec", "spec_helper.rb"))
          )
        end

        def copy_support_rspec
          fs.cp(
            fs.expand_path(fs.join("generators", "support_rspec.rb"), __dir__),
            fs.expand_path(fs.join("spec", "support", "rspec.rb"))
          )
        end

        def copy_support_db
          return unless Hanami.bundled?("hanami-db")

          fs.cp(
            fs.expand_path(fs.join("generators/support_db.rb"), __dir__),
            fs.expand_path(fs.join("spec", "support", "db.rb"))
          )

          fs.cp(
            fs.expand_path(fs.join("generators/support_db_cleaning.rb"), __dir__),
            fs.expand_path(fs.join("spec", "support", "db", "cleaning.rb"))
          )
        end

        def copy_support_features
          fs.cp(
            fs.expand_path(fs.join("generators", "support_features.rb"), __dir__),
            fs.expand_path(fs.join("spec", "support", "features.rb"))
          )
        end

        def copy_support_operations
          fs.cp(
            fs.expand_path(fs.join("generators", "support_operations.rb"), __dir__),
            fs.expand_path(fs.join("spec", "support", "operations.rb"))
          )
        end

        def copy_support_mailers
          return unless Hanami.bundled?("hanami-mailer")

          fs.cp(
            fs.expand_path(fs.join("generators", "support_mailers.rb"), __dir__),
            fs.expand_path(fs.join("spec", "support", "mailers.rb"))
          )
        end

        def copy_support_requests
          fs.cp(
            fs.expand_path(fs.join("generators", "support_requests.rb"), __dir__),
            fs.expand_path(fs.join("spec", "support", "requests.rb"))
          )
        end

        def generate_request_spec
          fs.cp(
            fs.expand_path(fs.join("generators", "request.rb"), __dir__),
            fs.expand_path(fs.join("spec", "requests", "root_spec.rb"))
          )
        end
      end

      module Generate
        class Slice < Hanami::CLI::Command
          def call(name: nil, **)
            slice = inflector.underscore(Shellwords.shellescape(name))

            generator = Generators::Slice.new(fs: fs, inflector: inflector)
            generator.call(slice)
          end
        end

        class Action < Hanami::CLI::Commands::App::Command
          def call(name: nil, slice: nil, skip_tests: false, **)
            return if skip_tests

            slice = inflector.underscore(Shellwords.shellescape(slice)) if slice
            key = inflector.underscore(Shellwords.shellescape(name))

            namespace = slice ? inflector.camelize(slice) : app.namespace
            base_path = slice ? "spec/slices/#{slice}" : "spec"

            generator = Generators::Action.new(fs:, inflector:)
            generator.call(key:, namespace:, base_path:)
          end
        end

        class Part < Hanami::CLI::Commands::App::Command
          def call(name: nil, slice: nil, skip_tests: false, **)
            return if skip_tests

            slice = inflector.underscore(Shellwords.shellescape(slice)) if slice
            name = inflector.underscore(Shellwords.shellescape(name))

            generator = Generators::Part.new(fs: fs, inflector: inflector)
            generator.call(app.namespace, slice, name)
          end
        end

        class Operation < Hanami::CLI::Commands::App::Command
          def call(name: nil, slice: nil, skip_tests: false, **)
            return if skip_tests

            slice = inflector.underscore(Shellwords.shellescape(slice)) if slice
            key = inflector.underscore(Shellwords.shellescape(name))

            namespace = slice ? inflector.camelize(slice) : app.namespace
            base_path = slice ? "spec/slices/#{slice}" : "spec"

            generator = Generators::Operation.new(fs:, inflector:)
            generator.call(key:, namespace:, base_path:)
          end
        end

        class Mailer < Hanami::CLI::Commands::App::Command
          def call(name: nil, slice: nil, skip_tests: false, **)
            return if skip_tests

            slice = inflector.underscore(Shellwords.shellescape(slice)) if slice
            key = inflector.underscore(Shellwords.shellescape(name))

            namespace = slice ? inflector.camelize(slice) : app.namespace
            base_path = slice ? "spec/slices/#{slice}" : "spec"

            generator = Generators::Mailer.new(fs:, inflector:)
            generator.call(key:, namespace:, base_path:)
          end
        end
      end
    end
  end
end
