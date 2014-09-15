module SuperbWysiwyg
  class Engine < ::Rails::Engine
    isolate_namespace SuperbWysiwyg

    initializer 'superb_wysiwyg.view_helpers' do |app|
      ActionView::Base.send :include, SuperbWysiwyg::ViewHelpers
    end
  end
end
