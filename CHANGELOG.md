# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

[Unreleased]: https://github.com/hanami/rspec/compare/v2.3.0...HEAD

## [2.3.1] - 2026-01-23

### Fixed

- Allow command callbacks to run with both Dry CLI 1.3 and 1.4 (1.4 corrects a longstanding bug regarding argument passing to command callbacks, which we had previously worked around here). (@timriley in #41)

## [2.3.0] - 2025-11-12

[2.3.0]: https://github.com/hanami/rspec/compare/v2.3.0.beta2...v2.3.0

## [2.3.0.beta2] - 2025-10-17

### Changed

- Drop support for Ruby 3.1

[2.3.0.beta2]: https://github.com/hanami/rspec/compare/v2.3.0.beta1...v2.3.0.beta2

## [2.3.0.beta1] - 2025-10-03

### Changed

- [Aaron Allen] Change shared context name in generated `spec/support/requests.rb` to avoid a RuboCop RSpec offense (#40)

[2.3.0.beta1]: https://github.com/hanami/rspec/compare/v2.2.1...v2.3.0.beta1

## [2.2.1] - 2024-11-12

### Changed

- [Tim Riley] Modify `Gemfile` via a `before "install"` hook on the `hanami` CLI. This ensures that testing-related gems are installed as part of running `hanami new` (#30)

[2.2.1]: https://github.com/hanami/rspec/compare/v2.2.0...v2.2.1

## [2.2.0] - 2024-11-05

### Changed

- [Paweł Świątkowski, Seb Wilgosz] Only enhance `generate` CLI commands if the relevant gems are bundled (#29)

[2.2.0]: https://github.com/hanami/rspec/compare/v2.2.0.rc1...v2.2.0

## [2.2.0.rc1] - 2024-10-29

### Added

- [Tim Riley] As part of `hanami install`, add `database_cleaner-sequel` to the `Gemfile` and generate DatabaseCleaner configuration in `spec/support/db.rb` and `spec/support/db/cleaning.rb` (#28)

### Changed

- [Seb Wilgosz] Only enhance `generate` CLI commands if the relevant gems are bundled (#26)

[2.2.0.rc1]: https://github.com/hanami/rspec/compare/v2.2.0.beta1...v2.2.0.rc1

## [2.2.0.beta1] - 2024-07-16

### Added

- [Sean Collins] Include `Dry::Monads[:result]` in tests via `support/operations.rb`

### Changed

- Drop support for Ruby 3.0
- [Sean Collins] In generated `spec_helper.rb`, require all files under `spec/support/` in a loop, rather than via manual requires (#24)

[2.2.0.beta1]: https://github.com/hanami/rspec/compare/v2.1.0...v2.2.0.beta1

## [2.1.0] - 2024-02-27

[2.1.0]: https://github.com/hanami/rspec/compare/v2.1.0.rc3...v2.1.0

## [2.1.0.rc3] - 2024-02-16

[2.1.0.rc3]: https://github.com/hanami/rspec/compare/v2.1.0.rc2...v2.1.0.rc3

## [2.1.0.rc2] - 2023-11-08

### Added

- [Tim Riley] Skip generating tests for `hanami generate` when `--skip-tests` CLI option is given
- [Tim Riley] Install Capybara and generate `spec/support/capybara.rb` in `hanami install` hook

### Changed

- [Tim Riley] Add explanatory code comments to `spec/support/rspec.rb` generated in `hanami install` hook

[2.1.0.rc2]: https://github.com/hanami/rspec/compare/v2.1.0.rc1...v2.1.0.rc2

## [2.1.0.rc1] - 2023-11-01

### Added

- [Luca Guidi] Generate spec for `hanami generate part` command

### Changed

- [Luca Guidi] Default request spec to expect 404, now that `hanami new` doesn't generate a default root route anymore

[2.1.0.rc1]: https://github.com/hanami/rspec/compare/v2.1.0.beta1...v2.1.0.rc1

## [2.1.0.beta1] - 2023-06-29

[2.1.0.beta1]: https://github.com/hanami/rspec/compare/v2.0.1...v2.1.0.beta1

## [2.0.1] - 2022-12-25

### Added

- [Luca Guidi] Official support for Ruby 3.2

[2.0.1]: https://github.com/hanami/rspec/compare/v2.0.0...v2.0.1

## [2.0.0] - 2022-11-22

### Added

- [Tim Riley] Use Zeitwerk to autoload the gem
- [Luca Guidi] Support RSpec 3.12

[2.0.0]: https://github.com/hanami/rspec/compare/v2.0.0.rc1...v2.0.0

## [2.0.0.rc1] - 2022-11-08

### Changed

- [Luca Guidi] Follow `hanami` versioning

[2.0.0.rc1]: https://github.com/hanami/rspec/compare/v3.11.0.beta4...v2.0.0.rc1

## [3.11.0.beta4] - 2022-10-24

### Changed

- [Luca Guidi] Generate slice specs under `spec/slices/[slice_name]/` (#9)

[3.11.0.beta4]: https://github.com/hanami/rspec/compare/v3.11.0.beta3...v3.11.0.beta4

## [3.11.0.beta3] - 2022-09-21

### Added

- [Luca Guidi] Hook into `hanami new` and `hanami generate` to respect name pluralization
- [Luca Guidi] Hook into `hanami generate action` to generate action specs

[3.11.0.beta3]: https://github.com/hanami/rspec/compare/v3.11.0.beta2...v3.11.0.beta3

## [3.11.0.beta2] - 2022-08-16

### Added

- [Luca Guidi] Hook into `hanami generate slice` to generate a slice directory in spec/ along with a placeholder base action spec (#5)

[3.11.0.beta2]: https://github.com/hanami/rspec/compare/v3.11.0.beta1...v3.11.0.beta2

## [3.11.0.beta1] - 2022-07-20

### Added

- [Luca Guidi] Hook into `hanami install` to setup RSpec + Rack::Test

[3.11.0.beta1]: https://github.com/hanami/rspec/releases/tag/v3.11.0.beta1
