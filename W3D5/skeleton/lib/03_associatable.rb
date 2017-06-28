require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    @class_name.constantize
  end

  def table_name
    # ...
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    if options.include?(:primary_key)
      @primary_key = options[:primary_key]
    else
      @primary_key = :id
    end
    if options.include?(:foreign_key)
      @foreign_key = options[:foreign_key]
    else
      @foreign_key = "#{name}_id".to_sym
    end
    if options.include?(:class_name)
      @class_name = options[:class_name]
    else
      @class_name = "#{name}".capitalize
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    if options.include?(:primary_key)
      @primary_key = options[:primary_key]
    else
      @primary_key = :id
    end
    if options.include?(:foreign_key)
      @foreign_key = options[:foreign_key]
    else
      self_class_name_str = self_class_name.to_s.downcase
      @foreign_key = "#{self_class_name_str}_id".to_sym
    end
    if options.include?(:class_name)
      @class_name = options[:class_name]
    else
      class_name = name.to_s.chomp('s')
      @class_name = class_name.capitalize
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
    define_method(name) do
      new_belongsto = BelongsToOptions.new(name,options={})
      p new_belongsto
      model_class = new_belongsto.model_class
      primary_key = new_belongsto.primary_key
      p primary_key
      foreign_key = []
      model_class.all.each do |class_object|
        foreign_key << class_object.attributes[primary_key]
      end
      p foreign_key
      where_conds = {}
      where_conds[primary_key] = foreign_key.first
      p where_conds
      self.class.where(where_conds).first
    end
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
