# frozen_string_literal: true

require_relative 'extensions'

module ArSchemaFunctions
  class Railtie < Rails::Railtie
    initializer 'ar_schema_functions.active_record' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::SchemaDumper.prepend(ArSchemaFunctions::Extensions::SchemaDumper)
        ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(ArSchemaFunctions::Extensions::AbstractAdapter)

        if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter)
          ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.prepend(ArSchemaFunctions::Extensions::PostgreSQLAdapter)
          ActiveRecord::ConnectionAdapters::PostgreSQL::SchemaDumper
            .prepend(ArSchemaFunctions::Extensions::PostgreSQLSchemaDumper)
        end
      end
    end
  end
end
