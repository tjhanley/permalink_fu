module PermalinkFu
    module Automate
      class Tasks
        class << self
          def make_slugs(klass, options = {})
            klass = parse_class_name(klass)
            options = {:limit => 100, :conditions => "#{klass.permalink_field} IS NULL"}.merge(options) 
            while records = klass.find(:all, options) do
              break if records.size == 0
              records.each do |r|
                begin
                  r.save
                  yield(r) if block_given?
                rescue
                   raise Exception
                end
              end
            end
          end
      
          def parse_class_name(class_name)
            return class_name if class_name.class == Class
            if (class_name.split('::').size > 1)
              class_name.split('::').inject(Kernel) {|scope, const_name| scope.const_get(const_name)}
            else
              Object.const_get(class_name)
            end
          end
        end
      end
    end
end