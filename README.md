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

### Setup model

Add WYSIWYG blocks support to any of your models by including `SuperbTextConstructor::Concerns::Blockable` mixin:

      class Post < ActiveRecord::Base
        include SuperbTextConstructor::Concerns::Blockable
      end

### Setup routes

Then add the following line to the `config/routes.rb`:

    superb_text_constructor_for :posts

It adds URL helpers for WYSIWYG editor. To open it use the following one:

    = link_to 'Edit', post_superb_text_constructor_path(@post, namespace: :blog)

Used namespace should be specified in YAML config.

### Setup views

SuperbTextConstructor has few built-in blocks. Of course, you will add more in your YAML config. So, you have to provide partials for them. All partials should be placed in `app/views/superb_text_constructor/blocks` directory.

The easiest case is when all your blocks have the same markup in all namespaces. Assume, that default namespace is called `default`. Then your directories tree will look like:

    app
      views
        superb_text_constructor
          blocks
            default
              _text.html.erb
              _quote.html.erb
              _button.html.erb
              _big_red_button.html.erb

It is not necessary to add built-in blocks here. The only reason to add these blocks is to override them.

So, we have added partials for all the blocks in default namespace. But what if they should look different in blog (assuming, that `blog` is one of the namespaces)? In this case add new partials like that:

    app
      views
        superb_text_constructor
          blocks
            default
              _text.html.erb
              ...
            blog
              _h2.html.erb
              _h3.html.erb
              _text.html.erb
              ...

To render the resulting page use this helper:

    = render_blocks @post.blocks

It will render post's blocks using partials from default namespace. Or you can specify the namespace:

    = render_blocks @post.blocks, namespace: :blog