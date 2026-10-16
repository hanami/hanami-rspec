# frozen_string_literal: true

require "hanami/cli"
require "zeitwerk"

# @see Hanami::RSpec
# @since 2.0.0
module Hanami
  # RSpec and testing support for Hanami applications.
  #
  # @since 2.0.0
  # @api private
  module RSpec
    # @since 2.0.0
    # @api private
    def self.gem_loader
      @gem_loader ||= Zeitwerk::Loader.new.tap do |loader|
        root = File.expand_path("..", __dir__)
        loader.tag = "hanami-rspec"
        loader.inflector = Zeitwerk::GemInflector.new("#{root}/hanami-rspec.rb")
        loader.push_dir(root)
        loader.ignore(
          "#{root}/hanami-rspec.rb",
          "#{root}/hanami/rspec/{rake_tasks,version}.rb"
        )
        loader.inflector.inflect("rspec" => "RSpec")
      end
    end

    gem_loader.setup
    require_relative "rspec/version"
    require_relative "rspec/rake_tasks"

    if Hanami::CLI.within_hanami_app?
      Hanami::CLI.before "install", Commands::Install
      Hanami::CLI.after "generate slice", Commands::Generate::Slice

      if Hanami.bundled?("dry-operation")
        Hanami::CLI.after "generate operation", Commands::Generate::Operation
        Hanami::CLI.option "generate operation", :skip_tests,
          required: false, type: :flag, default: false, desc: "Skip test generation"
      end

      if Hanami.bundled?("hanami-action")
        Hanami::CLI.after "generate action", Commands::Generate::Action
        Hanami::CLI.option "generate action", :skip_tests,
          required: false, type: :flag, default: false, desc: "Skip test generation"
      end

      if Hanami.bundled?("hanami-view")
        Hanami::CLI.after "generate part", Commands::Generate::Part
        Hanami::CLI.option "generate part", :skip_tests,
          required: false, type: :flag, default: false, desc: "Skip test generation"
      end

      if Hanami.bundled?("hanami-mailer")
        Hanami::CLI.after "generate mailer", Commands::Generate::Mailer
        Hanami::CLI.option "generate mailer", :skip_tests,
          required: false, type: :flag, default: false, desc: "Skip test generation"
      end
    end
  end
end
