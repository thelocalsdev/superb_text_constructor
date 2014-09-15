# SuperbTextConstructor

Mountable WYSIWYG editor for your Rails applications

## Installation

Add this line to your application's Gemfile:

    gem 'superb_text_constructor'

And then execute:

    $ bundle

@todo Create generators and write full installation guide

## Configuration

SuperbTextConstructor is configured by YAML files.

First of all you have to configure path to them in `config/initializer/superb_text_constructor.rb` file:

    # If all your configs are in the single file
    SuperbTextConstructor.configs_path = "#{Rails.root}/config/superb_text_constructor.yml"

    # If yor prefer to split config to separate files
    SuperbTextConstructor.configs_path = [
      "#{Rails.root}/config/superb_text_constructor_blocks.yml",
      "#{Rails.root}/config/superb_text_constructor_namespaces.yml"
    ]

Another available option here is `default_namespace`. It is `default` by default, but you can override it:

    SuperbTextConstructor.default_namespace = 'blog'

As you can see, YAML config consists of 2 parts: blocks and namespaces.

### Blocks

Blocks part contains description of all blocks available in your application. For example:

    blocks:
      text:
        fields:
          text:
            type: string
            required: true

### Namespaces

Namespaces part contains options for different WYSIWYG editors. For example, you need editors for blog and emails:

    namespaces:
      blog:
        headers:
            - h2
            - h3
        no_group:
            - text

      emails:
        no_group:
          - text
          - image

There will be different sets of buttons in WYSIWYG editors depending on the configs above.

## Usage

  Add WYSIWYG blocks support to any of your models by including `SuperbTextConstructor::Concerns::Blockable` mixin:

      class Post < ActiveRecord::Base
        include SuperbTextConstructor::Concerns::Blockable
      end

  Then add the following line to the `config/routes.rb`:

    superb_text_constructor_for :posts

  It adds URL helpers for WYSIWYG editor. To open it use the following one:

    = link_to 'Edit', post_superb_text_constructor_path(@post, namespace: :blog)

  Used namespace should be specified in YAML config.

  To render the resulting page use this helper:

    = render_blocks @post.blocks

  It will render post's blocks in default namespace (that was set in initializer or :default). Or you can specify it:

    = render_blocks @post.blocks, namespace: :blog