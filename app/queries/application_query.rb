# frozen_string_literal: true

class ApplicationQuery
  DEFAULT_LIMIT = 20.freeze
  attr_accessor :resources

  def initialize(resources)
    @resources = resources
  end
end
