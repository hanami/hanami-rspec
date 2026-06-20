# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Break Versioning](https://www.taoensso.com/break-versioning).

## [Unreleased]

### Added

- Generate `spec/support/mailers.rb` to reset recorded mail deliveries between examples tagged `:mailers`. Use this tag for the generated mailer tests. (@timriley in #49)

### Changed

### Deprecated

### Removed

### Fixed

### Security

[Unreleased]: https://github.com/hanami/rspec/compare/v3.0.0.rc1...HEAD

## [v3.0.0.rc1] - 2026-06-16

### Added

- Activate Dry Monads' RSpec extension in `spec/support/operations.rb`. (@timriley)
- Generate a starter spec when running `hanami generate operation`. (@timriley)
- Generate a starter spec when running `hanami generate mailer`. (@timriley)

### Changed

- Use `prepend_before` for the generated DatabaseCleaner `:db` hook, so it runs before any other `before` hooks that might touch the database. This prevents factory calls in spec-level `before` blocks from running before the test transaction starts and leaking records across tests. (@timriley in #47)
- Check for presence of hanami-action gem rather than hanami-controller (now retired). (@cllns in #44)
- Require Ruby 3.3 or newer.

[v3.0.0.rc1]: https://github.com/hanami/rspec/compare/v2.3.1...v3.0.0.rc1

## [2.3.1] - 2026-01-23

### Fixed

- Allow command callbacks to run with both Dry CLI 1.3 and 1.4 (1.4 corrects a longstanding bug regarding argument passing to command callbacks, which we had previously worked around here). (Tim Riley in #41)

[2.3.1]: https://github.com/hanami/rspec/compare/v2.3.0...v2.3.1

## [2.3.0] - 2025-11-12

[2.3.0]: https://github.com/hanami/rspec/compare/v2.3.0.beta2...v2.3.0

## [2.3.0.beta2] - 2025-10-17

### Changed

- Drop support for Ruby 3.1.

[2.3.0.beta2]: https://github.com/hanami/rspec/compare/v2.3.0.beta1...v2.3.0.beta2

## [2.3.0.beta1] - 2025-10-03

### Changed

- Change shared context name in generated `spec/support/requests.rb` to avoid a RuboCop RSpec offense. (Aaron Allen in #40)

[2.3.0.beta1]: https://github.com/hanami/rspec/compare/v2.2.1...v2.3.0.beta1

## [2.2.1] - 2024-11-12

### Changed

- Modify `Gemfile` via a `before "install"` hook on the `hanami` CLI. This ensures that testing-related gems are installed as part of running `hanami new`. (Tim Riley in #30)

[2.2.1]: https://github.com/hanami/rspec/compare/v2.2.0...v2.2.1

## [2.2.0] - 2024-11-05

### Changed

- Only enhance `generate` CLI commands if the relevant gems are bundled. (Paweł Świątkowski, Seb Wilgosz in #29)

[2.2.0]: https://github.com/hanami/rspec/compare/v2.2.0.rc1...v2.2.0

## [2.2.0.rc1] - 2024-10-29

### Added

- As part of `hanami install`, add `database_cleaner-sequel` to the `Gemfile` and generate DatabaseCleaner configuration in `spec/support/db.rb` and `spec/support/db/cleaning.rb`. (Tim Riley in #28)

### Changed

- Only enhance `generate` CLI commands if the relevant gems are bundled. (Seb Wilgosz in #26)

[2.2.0.rc1]: https://github.com/hanami/rspec/compare/v2.2.0.beta1...v2.2.0.rc1

## [2.2.0.beta1] - 2024-07-16

### Added

- Include `Dry::Monads[:result]` in tests via `support/operations.rb`. (Sean Collins)

### Changed

- Drop support for Ruby 3.0
- In generated `spec_helper.rb`, require all files under `spec/support/` in a loop, rather than via manual requires. (Sean Collins in #24)

[2.2.0.beta1]: https://github.com/hanami/rspec/compare/v2.1.0...v2.2.0.beta1

## [2.1.0] - 2024-02-27

[2.1.0]: https://github.com/hanami/rspec/compare/v2.1.0.rc3...v2.1.0

## [2.1.0.rc3] - 2024-02-16

[2.1.0.rc3]: https://github.com/hanami/rspec/compare/v2.1.0.rc2...v2.1.0.rc3

## [2.1.0.rc2] - 2023-11-08

### Added

- Skip generating tests for `hanami generate` when `--skip-tests` CLI option is given. (Tim Riley)
- Install Capybara and generate `spec/support/capybara.rb` in `hanami install` hook. (Tim Riley)

### Changed

- Add explanatory code comments to `spec/support/rspec.rb` generated in `hanami install` hook. (Tim Riley)

[2.1.0.rc2]: https://github.com/hanami/rspec/compare/v2.1.0.rc1...v2.1.0.rc2

## [2.1.0.rc1] - 2023-11-01

### Added

- Generate spec for `hanami generate part` command. (Luca Guidi)

### Changed

- Default request spec to expect 404, now that `hanami new` doesn't generate a default root route anymore. (Luca Guidi)

[2.1.0.rc1]: https://github.com/hanami/rspec/compare/v2.1.0.beta1...v2.1.0.rc1

## [2.1.0.beta1] - 2023-06-29

[2.1.0.beta1]: https://github.com/hanami/rspec/compare/v2.0.1...v2.1.0.beta1

## [2.0.1] - 2022-12-25

### Added

- Official support for Ruby 3.2. (Luca Guidi)

[2.0.1]: https://github.com/hanami/rspec/compare/v2.0.0...v2.0.1

## [2.0.0] - 2022-11-22

### Added

- Use Zeitwerk to autoload the gem. (Tim Riley)
- Support RSpec 3.12. (Luca Guidi)

[2.0.0]: https://github.com/hanami/rspec/compare/v2.0.0.rc1...v2.0.0

## [2.0.0.rc1] - 2022-11-08

### Changed

- Follow `hanami` versioning. (Luca Guidi)

[2.0.0.rc1]: https://github.com/hanami/rspec/compare/v3.11.0.beta4...v2.0.0.rc1

## [3.11.0.beta4] - 2022-10-24

### Changed

- Generate slice specs under `spec/slices/[slice_name]/`. (Luca Guidi in #9)

[3.11.0.beta4]: https://github.com/hanami/rspec/compare/v3.11.0.beta3...v3.11.0.beta4

## [3.11.0.beta3] - 2022-09-21

### Added

- Hook into `hanami new` and `hanami generate` to respect name pluralization. (Luca Guidi)
- Hook into `hanami generate action` to generate action specs. (Luca Guidi)

[3.11.0.beta3]: https://github.com/hanami/rspec/compare/v3.11.0.beta2...v3.11.0.beta3

## [3.11.0.beta2] - 2022-08-16

### Added

- Hook into `hanami generate slice` to generate a slice directory in spec/ along with a placeholder base action spec. (Luca Guidi in #5)

[3.11.0.beta2]: https://github.com/hanami/rspec/compare/v3.11.0.beta1...v3.11.0.beta2

## [3.11.0.beta1] - 2022-07-20

### Added

- Hook into `hanami install` to setup RSpec + Rack::Test. (Luca Guidi)

[3.11.0.beta1]: https://github.com/hanami/rspec/releases/tag/v3.11.0.beta1
