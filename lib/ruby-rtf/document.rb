module RubyRTF
  # Represents the entire RTF document
  class Document
    # @return [Array] The font table
    attr_reader :font_table

    # @return [Array] The colour table
    attr_reader :colour_table
    alias :color_table :colour_table

    # @return [Integer] The default font number for the document
    attr_accessor :default_font

    # @return [String] The characgter set for the document (:ansi, :pc, :pca, :mac)
    attr_accessor :character_set

    # @return [Array] The different formatted sections of the document
    attr_accessor :sections

    # Creates a new document
    #
    # @return [RubyRTF::Document] The new document
    def initialize
      @font_table = []
      @colour_table = []
      @character_set = :ansi
      @default_font = 0

      @sections = [{:text => '', :modifiers => {}}]
    end

    def add_section!
      return if current_section[:text].empty?

      mods = {}
      current_section[:modifiers].each_pair { |k, v| mods[k] = v } if current_section

      @sections << {:text => '', :modifiers => mods}
    end

    def reset_section!
      current_section[:modifiers] = {}
    end

    def current_section
      @sections.last
    end

    # Convert RubyRTF::Document to a string
    #
    # @return [String] String version of the document
    def to_s
      str = "RTF Document:\n" +
            "  Font Table:\n"

      font_table.each_with_index do |font, idx|
        next if font.nil?
        str << "    #{idx}: #{font}\n"
      end

      str << "  Colour Table:\n"
      colour_table.each_with_index do |colour, idx|
        str << "    #{idx}: #{colour}\n"
      end

      str << "  Body:\n\n"
      sections.each do |section|
        str << "#{section[:text]}\n"
      end

      str
    end
  end
end