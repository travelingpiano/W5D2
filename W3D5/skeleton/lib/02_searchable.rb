require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # ...
    columns = ""
    values = []
    params.each do |col_name,val|
      columns += "#{col_name} = ? AND "
      values << val
    end
    columns = columns.chomp('AND ')
    answers = DBConnection.execute(<<-SQL,*values)
      SELECT
        *
      FROM
        #{@table_name}
      WHERE
        #{columns}
    SQL
    to_return = []
    answers.each do |class_object|
      to_return << self.new(class_object)
    end
    to_return
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
