module SuperbWysiwyg
  
  module ViewHelpers

    # View helper for notifications rendering.
    # @param blocks [Array<Block>] list of blocks to be rendered
    # @return [ActiveSupport::SafeBuffer] rendered HTML code
    # @return [nil] if empty array was passed
    def render_blocks(blocks)
      return nil if blocks.empty?
      blocks.map { |block| render_block(block) }.join.html_safe
    end

    # View helper for block rendering
    # @param block [Block] single block to be rendered
    # @return [ActiveSupport::SafeBuffer] rendered HTML code
    def render_block(block)
      if lookup_context.template_exists?("superb_wysiwyg/blocks/#{block.namespace}/#{block.template}", nil, true)
        render partial: "superb_wysiwyg/blocks/#{block.namespace}/#{block.template}", object: block, as: :block
      else
        render partial: "superb_wysiwyg/blocks/#{SuperbWysiwyg.default_namespace}/#{block.template}", object: block, as: :block
      end
    end

  end
  
end
