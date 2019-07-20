# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Artist model
RSpec.describe Artist, type: :model do
  # Validation tests
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
