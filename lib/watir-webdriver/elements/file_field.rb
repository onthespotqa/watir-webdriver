# encoding: utf-8
module Watir
  class FileField < Input
    def initialize(parent, default_selector, *selectors)
      default_selector.merge! :type => "file"
    end

    container_method  :file_field
    collection_method :file_fields

    #
    # Set the file field to the given path
    #
    # @param [String] a value
    #

    def set(value)
      assert_exists
      value.gsub!(File::SEPARATOR, File::ALT_SEPARATOR) if File::ALT_SEPARATOR
      @element.send_keys value
    end

    #
    # Return the value of this field
    #
    # @return [String]
    #

    def value
      # since 'value' is an attribute on input fields, we override this here
      assert_exists
      @element.value
    end
  end
end
