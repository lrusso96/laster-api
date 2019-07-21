# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Track model
RSpec.describe Image, type: :model do
  # Validation tests
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:size) }
  it { should belong_to(:album) }
end
