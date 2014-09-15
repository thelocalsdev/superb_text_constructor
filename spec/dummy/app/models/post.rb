class Post < ActiveRecord::Base
  include SuperbTextConstructor::Concerns::Blockable
end
