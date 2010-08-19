# encoding: utf-8
module Watir
  class ElementCollection
    include Enumerable

    def initialize(parent, default_selector, element_class)
      @parent           = parent
      @default_selector = default_selector
      @element_class    = element_class
    end

    #
    # @yieldparam [Watir::Element] element Iterate through the elements in this collection.
    #

    def each(&blk)
      to_a.each(&blk)
    end

    #
    # @return [Fixnum] The number of elements in this collection.
    #

    def length
      elements.length
    end
    alias_method :size, :length

    #
    # Get the element at the given index.
    # Note that this is 0-indexed and not compatible with older Watir implementations.
    #
    # Also note that because of Watir's lazy loading, this will return an Element
    # instance even if the index is out of bounds.
    #
    # @param [Fixnum] n Index of wanted element, 0-indexed
    # @return [Watir::Element] Returns an instance of a Watir::Element subclass
    #


    def [](idx)
      to_a[idx] || @element_class.new(@parent, :index, idx)
    end

    #
    # First element of this collection
    #
    # @return [Watir::Element] Returns an instance of a Watir::Element subclass
    #

    def first
      to_a[0] || @element_class.new(@parent, :index, 0)
    end

    #
    # Last element of the collection
    #
    # @return [Watir::Element] Returns an instance of a Watir::Element subclass
    #

    def last
      to_a[-1] || @element_class.new(@parent, :index, -1)
    end

    #
    # This collection as an Array
    #
    # @return [Array<Watir::Element>]
    #

    def to_a
      # TODO: optimize - lazily @element_class instance
      @to_a ||= elements.map { |e| @element_class.new(@parent, :element, e) }
    end

    private

    def elements
      @elements ||= ElementLocator.new(
        @parent.wd,
        @default_selector,
        @element_class.attribute_list
      ).locate_all
    end

  end # ElementCollection
end # Watir
