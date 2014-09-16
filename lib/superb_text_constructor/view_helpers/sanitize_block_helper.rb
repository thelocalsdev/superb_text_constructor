module SuperbTextConstructor
  module ViewHelpers
    module SanitizeBlockHelper

      # Adds HTML markup to plain text with paragraphs separated by new lines and removes forbidden tags.
      # @param text [String] original text
      # @return [ActiveSupport::SafeBuffer] HTML safe text splitted by <p> tags
      def sanitize_block(text)
        text = sanitize(text, tags: %w(a b i img), attributes: %w(id class style src href target))
        paragraphs = text.split("\r\n\r\n").map(&:strip).select(&:present?)
        paragraphs.map{|p| "<p>#{p}</p>"}.join("\r\n").html_safe
      end

    end
  end
end
