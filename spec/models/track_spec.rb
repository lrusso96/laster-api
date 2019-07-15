# spec/models/track_spec.rb
require 'rails_helper'

# Test suite for the Track model
RSpec.describe Track, type: :model do
  # Validation tests
  # ensure column title is present before saving
  it { should validate_presence_of(:title) }
end
