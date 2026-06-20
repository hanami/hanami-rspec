# frozen_string_literal: true

# Reset recorded mail deliveries between examples tagged `:mailers`
#
# In the test env, mail is delivered via a shared test delivery method, so recorded deliveries
# accumulate across examples. Tag any example that sends mail with `:mailers` to start with a clean
# slate:
#
#   RSpec.describe Mailers::Welcome, :mailers do
#     # ...
#   end
RSpec.configure do |config|
  config.prepend_before :each, :mailers do
    Hanami.app.with_slices.each do |slice|
      next unless slice.key?("mailers.delivery_method")

      slice["mailers.delivery_method"].clear
    end
  end
end
