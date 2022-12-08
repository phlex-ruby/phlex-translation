# frozen_string_literal: true

module Phlex
	module Translation
		def self.included(view)
			view.extend(ClassMethods)
		end

		module ClassMethods
			attr_writer :translation_path

			def translation_path
        @translation_path ||= name&.dup.tap do |n|
          n.gsub!("::", ".")
          n.gsub!(/([a-z])([A-Z])/, '\1_\2')
          n.downcase!
        end
      end

		end

		def translate(key, **options)
			key = "#{self.class.translation_path}#{key}" if key.start_with?(".")

			::I18n.translate(key, **options)
		end
	end
end
