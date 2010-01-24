module Remarkable
  module Paperclip
    module Matchers
      class HaveAttachedFileMatcher < Remarkable::ActiveRecord::Base
        arguments :attribute
        
        optional :styles
        
        assertion :has_attached_file?
        
        def has_attached_file?
          model_class = @subject.class
          styles = @options[:styles]
          styles.each do |key, value|
            instance_styles = model_class.attachment_definitions[@attribute][:styles]
            return false if instance_styles.nil?
            style = instance_styles[key]
            return false unless (style.instance_of?(Hash) ? style[:geometry] : style).eql? value
          end unless styles.nil?
          model_class.respond_to? "before_#{@attribute}_post_process_callback_chain"
        end
      end

      def have_attached_file(*args)
        HaveAttachedFileMatcher.new(*args).spec(self)
      end

    end
  end
end
