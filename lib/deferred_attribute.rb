require "deferred_attribute/version"

module DeferredAttribute
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def deferred_attribute(name, options = {})
      getter_method_name = options[:with] || "get_#{name}"
      class_eval <<-RUBY
        def #{name}
          defined?(@#{name}) ? @#{name} : @#{name} = #{getter_method_name}
        end
      RUBY
    end
  end
end