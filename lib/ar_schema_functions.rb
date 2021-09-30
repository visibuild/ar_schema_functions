# frozen_string_literal: true

require_relative 'ar_schema_functions/version'
require_relative 'ar_schema_functions/railtie' if defined?(Rails::Railtie) && defined?(ActiveRecord)
