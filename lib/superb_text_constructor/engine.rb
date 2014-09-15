module SuperbTextConstructor
  class Engine < ::Rails::Engine
    isolate_namespace SuperbTextConstructor

    initializer 'superb_text_constructor.view_helpers' do |app|
      ActionView::Base.send :include, SuperbTextConstructor::ViewHelpers
    end
  end
end
