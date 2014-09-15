# Adds gem-specific mappings to the router
# @param resource_name [Symbol] blockable resource name
def superb_text_constructor_for(resource_name)
  resources resource_name, only: [] do
    mount SuperbTextConstructor::Engine => '/wysiwyg/:namespace'
  end  
end
