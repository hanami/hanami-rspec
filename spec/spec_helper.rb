# frozen_string_literal: true

require "hanami/rspec"
require "fileutils"
require "pathname"

SPEC_ROOT = Pathname(__FILE__).dirname
TMP = File.join(Dir.pwd, "tmp")

require_relative "support/rspec"
SPEC_ROOT.glob("support/**/*.rb").each { |f| require(f) }
