require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    if @columns
      return @columns
    else
      @table_name ||= self.to_s.tableize
      results = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{@table_name}
      SQL
      @columns = []
      results[0].each do |col_name|
        @columns << col_name.to_sym
      end
      @columns
    end
  end

  def self.finalize!
    @columns = self.columns
    @columns.each do |col_name|
      define_method("#{col_name}") do
        if @attributes
          @attributes[col_name]
        else
          instance_variable_get("@#{col_name}")
        end
      end
      define_method("#{col_name}=") do |arg|
        @attributes = attributes
        @attributes[col_name] = arg
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    if @table_name
      return @table_name
    else
      @table_name = self.to_s.tableize
    end
  end

  def self.all
    # ...
    cats = DBConnection.execute2(<<-SQL)
      SELECT
        #{@table_name}.*
      FROM
        #{@table_name}
    SQL
    self.parse_all(cats[1..-1])
  end

  def self.parse_all(results)
    # ...
    ans = []
    #if there are multiple objects
    if results.is_a? Array
      results.each do |object|
        ans << self.new(object)
      end
    #if just one object
    else
      ans = self.new(results)
    end
    ans
  end

  def self.find(id)
    # ...
    @table_name ||= self.to_s.tableize
    result =[]
    result += DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{@table_name}
      WHERE
        id = #{id}
    SQL
    return nil if result.length == 1
    self.parse_all(result[-1])
  end

  def initialize(params = {})
    # ...
    self.class.finalize!
    @columns = self.class.columns
    params.each do |key,value|
      raise "unknown attribute '#{key}'" unless @columns.include?(key.to_sym)
      send("#{key}=",value)
    end
  end

  def attributes
    # ...
    if @attributes
      @attributes
    else
      @attributes = {}
    end
  end

  def attribute_values
    # ...
    @attributes.values
  end

  def insert
    # ...
    @table_name ||= self.class.to_s.tableize
    columns = self.class.columns.drop(1)
    col_names = columns.join(', ')
    question_marks = (['?']*columns.length).join(', ')
    valuez = attribute_values
    DBConnection.execute(<<-SQL,*valuez)
      INSERT INTO
        #{@table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    send("id=",DBConnection.instance.last_insert_row_id)
  end

  def update
    # ...
    if self.class == Human
      @table_name = "humans"
    else
      @table_name = self.class.table_name
    end
    columns = self.class.columns
    sql_values = attribute_values
    id = sql_values.shift
    sql_values.push(id)
    set_row = ""
    (1...columns.length-1).each do |indx|
      set_row += "#{columns[indx]} = ?, "
    end
    set_row += "#{columns[columns.length-1]} = ?"
    DBConnection.execute(<<-SQL,*sql_values)
      UPDATE
        #{@table_name}
      SET
        #{set_row}
      WHERE
        id = ?
    SQL
  end

  def save
    # ...
    if send("id").nil?
      insert
    else
      update
    end
  end
end
