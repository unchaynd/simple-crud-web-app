require 'sqlite3'

require_relative 'safe-string'

DB = SQLite3::Database.new "#{__dir__}/../database.db"

class << DB
	def table_names = execute('SELECT "name" FROM "[tables]";').map(&:first)

	def create_table(name, columns)
		execute 'CREATE TABLE "%1$s" (%2$s);' % [ name,  columns.map { '"%{name}" TEXT' % _1 }.join(', ') ]

		execute(
			'INSERT INTO "[tables]" ("name", "columns") VALUES("%1$s", "%2$s");' %
			[ name, columns.map{ '%{name}:%{type}' % _1 }.join(' ') ]
		)
		nil
	end

	def read_table(...) = { columns: read_table_columns(...), rows: read_table_rows(...) }

	def read_table_rows(table_name) = execute 'SELECT * FROM "%s";' % table_name

	def read_table_columns(table_name)
		execute('SELECT "columns" FROM "[tables]" WHERE "name" = "%s";' % table_name).flatten.first.
		split(' ').map { _1.match(/\A(?<name>.*):(?<type>.*)\z/).named_captures(symbolize_names: true) }
	end

	def destroy_table(table_name)
		execute 'DELETE FROM "[tables]" WHERE "name" = "%s";' % table_name
		execute 'DROP TABLE "%s";' % table_name
	end

	def create_row(table_name, row_data)
		execute(
			'INSERT INTO "%1$s" (%2$s) VALUES(%3$s);' % [
				table_name,
				## TODO: Ewww, repetition! *resists the urge to create a lambda abstraction*
				## It might be a good idea to add a serialization instance method to Array eventually though. I see that
				## I'm using this `<array>.map { <string format> }.join(<delimiter>)` pattern in a number of places.
				row_data.keys.map { '"%s"' % _1 }.join(', '),
				row_data.values.map { '"%s"' % _1 }.join(', ')
			]
		)
	end

end

