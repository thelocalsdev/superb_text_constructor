require 'superb_text_constructor/engine'
require 'superb_text_constructor/view_helpers/render_blocks_helper'
require 'superb_text_constructor/view_helpers/sanitize_block_helper'
require 'superb_text_constructor/route_mappings'

module SuperbTextConstructor
  mattr_accessor :configs_path
  mattr_accessor :default_namespace
  mattr_accessor :additional_permitted_attributes

  self.default_namespace = 'default'
  self.additional_permitted_attributes = nil

  # @return [Hash] all available blocks in all namespaces
  def self.blocks
    config['blocks'] || {}
  end

  # @return [Array<Hash>] list of available namespaces
  def self.namespaces
    config['namespaces'] || {}
  end

  # @return [Array<String] list of available fields for all blocks
  def self.fields
    blocks.map { |block, options| (options || {}).fetch('fields', {}).keys }.flatten.uniq
  end

  # @return [Array<String] list of available block names
  def self.templates
    blocks.keys
  end

  private

    def self.config
      @config ||= read_config
    end

    # Reads all config files and merges them to one Hash
    # @return [Hash] merged configs
    def self.read_config
      result = {}
      [configs_path].flatten.each do |file_path|
        result.deep_merge!(YAML.load_file(file_path))
      end
      result
    end

end
