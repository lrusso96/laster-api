# frozen_string_literal: true

module Laster
  module Errors
    class Simple < StandardError
      attr_reader :code
      def initialize(msg:, code: 0)
        @code = code
        super(msg)
      end
    end
  end
end
