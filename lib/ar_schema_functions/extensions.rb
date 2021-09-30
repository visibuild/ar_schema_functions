# frozen_string_literal: true

module ArSchemaFunctions
  module Extensions
    module SchemaDumper
      def dump(stream)
        header(stream)
        extensions(stream)
        functions(stream)
        tables(stream)
        trailer(stream)
        stream
      end

      # Defined by SQL engine specific adapters (if supported)
      def functions(stream); end
    end

    module PostgreSQLSchemaDumper
      def functions(stream)
        functions = @connection.functions

        return unless functions.any?

        functions.each do |function|
          indented_function = function.lines.map { |line| "    #{line}" }.join
          stream.puts "  connection.execute(<<~SQL)\n#{indented_function}  SQL"
          stream.puts
        end
      end
    end

    module AbstractAdapter
      # Defined by SQL engine specific adapters (if supported)
      def functions
        []
      end
    end

    module PostgreSQLAdapter
      def functions
        # From https://dataedo.com/kb/query/postgresql/list-user-defined-functions
        exec_query(<<~SQL.squish, 'SCHEMA').cast_values
          select case when l.lanname = 'internal' then p.prosrc
                      else pg_get_functiondef(p.oid)
                      end as definition
          from pg_proc p
          left join pg_namespace n on p.pronamespace = n.oid
          left join pg_language l on p.prolang = l.oid
          where n.nspname not in ('pg_catalog', 'information_schema')#{' '}
            and l.lanname != 'c'
          order by definition;
        SQL
      end
    end
  end
end
