class Class # :nodoc:
  def class_inheritable_option(sym, default_value=nil)

    self.define_attributes({ sym => default_value })
    self.send("#{sym}=",default_value)
    # write_inheritable_attribute sym, default_value

    class_eval <<-EOS
      def self.#{sym}(value=nil)
        if !value.nil?
          self.send("#{sym}=",value)
        else
          self.send(:#{sym})
        end
      end
      
      def self.#{sym}=(value)
        self.send("#{sym}=",value)
      end

      def #{sym}
        self.class.#{sym}
      end

      def #{sym}=(value)
        self.class.#{sym} = value
      end
    EOS
  end
end
