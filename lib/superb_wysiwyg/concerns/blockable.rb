module SuperbWysiwyg
  module Concerns
    module Blockable
      extend ActiveSupport::Concern

      included do
        has_many :blocks, as: :blockable, dependent: :destroy, inverse_of: :blockable
      end

    end
  end
end
