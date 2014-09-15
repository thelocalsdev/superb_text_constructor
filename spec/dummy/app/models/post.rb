class Post < ActiveRecord::Base
  include SuperbTextConstructor::Concerns::Models::Blockable
end
