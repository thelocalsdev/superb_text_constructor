RSpec.describe SuperbWysiwyg do
  it 'has a version' do
    expect(SuperbWysiwyg::VERSION).not_to be_nil
  end

  describe '.blocks, .namespaces, .fields' do
    before { SuperbWysiwyg.instance_variable_set(:@blocks, nil) }
    before { @old_configs_path = SuperbWysiwyg.configs_path }
    after { SuperbWysiwyg.configs_path = @old_configs_path }
    after { SuperbWysiwyg.instance_variable_set(:@blocks, nil) }

    shared_examples_for 'any' do
      it 'loads correct config' do
        expect(SuperbWysiwyg.blocks).to eq(expected_blocks)
      end

      it 'returns correct namespaces' do
        expect(SuperbWysiwyg.namespaces).to eq(expected_namespaces)
      end

      it 'returns correct fields' do
        expect(SuperbWysiwyg.fields).to eq(expected_fields)
      end

      it 'returns correct templates' do
        expect(SuperbWysiwyg.templates).to eq(expected_templates)
      end
    end

    context 'single file' do
      let(:expected_blocks) { YAML.load_file("#{SuperbWysiwyg::Engine.root}/spec/fixtures/test_config_1.yml") }
      let(:expected_namespaces) { ['default'] }
      let(:expected_fields) { ['text'] }
      let(:expected_templates) { ['text'] }
      before { SuperbWysiwyg.configs_path = "#{SuperbWysiwyg::Engine.root}/spec/fixtures/test_config_1.yml" }
      it_behaves_like 'any'
    end

    context 'multiple files' do
      let(:expected_blocks) { YAML.load_file("#{SuperbWysiwyg::Engine.root}/spec/fixtures/merged_config.yml") }
      let(:expected_namespaces) { ['default', 'blog'] }
      let(:expected_fields) { ['text'] }
      let(:expected_templates) { ['text', 'quote'] }
      before do
        SuperbWysiwyg.configs_path = ["#{SuperbWysiwyg::Engine.root}/spec/fixtures/test_config_1.yml",
                                      "#{SuperbWysiwyg::Engine.root}/spec/fixtures/test_config_2.yml"]
      end
      it_behaves_like 'any'
    end
  end
end
