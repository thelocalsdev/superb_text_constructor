require 'superb_text_constructor/engine'
require 'superb_text_constructor/view_helpers'

module SuperbTextConstructor
  mattr_accessor :configs_path
  mattr_accessor :default_namespace

  self.default_namespace = 'default'

  # @return [Hash] all available blocks in all namespaces
  def self.blocks
    @blocks ||= read_blocks_config
  end

  # @params namespace [String] namespace
  # @return [Hash] blocks for the passed namespace or default if nothing was found
  def self.blocks_for(namespace)
    blocks[namespace] || blocks[default_namespace]
  end

  # @return [Array<String>] list of available namespaces
  def self.namespaces
    blocks.keys
  end

  # @return [Array<String] list of available fields for all blocks
  def self.fields
    blocks.map do |namespace, blocks|
      blocks.map { |block, options| (options || {}).fetch('fields', {}).keys }
    end.flatten.uniq
  end

  # @return [Array<String] list of available block names
  def self.templates
    blocks.map do |namespace, blocks|
      blocks.keys
    end.flatten.uniq
  end

  private

    # Reads all config files and merges them to one Hash
    # @return [Hash] merged configs
    def self.read_blocks_config
      result = {}
      [configs_path].flatten.each do |file_path|
        result.deep_merge!(YAML.load_file(file_path))
      end
      result = add_default_blocks_to_all_namespaces(result)
      result
    end

    def self.add_default_blocks_to_all_namespaces(blocks)
      default_blocks = blocks[default_namespace]
      return blocks unless default_blocks
      blocks.each do |namespace, blocks|
        default_blocks.each do |default_block, options|
          blocks[default_block] = options unless blocks[default_block]
        end
      end
      blocks
    end
end
