class Post < ActiveRecord::Base
  include SuperbWysiwyg::Concerns::Blockable
end
