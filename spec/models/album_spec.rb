# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Album model
RSpec.describe Album, type: :model do
  # Validation tests
  # ensure column name is present before saving
  it { should validate_presence_of(:title) }
  it { should belong_to(:artist) }
end
