RSpec.describe SuperbTextConstructor do
  it 'has a version' do
    expect(SuperbTextConstructor::VERSION).not_to be_nil
  end

  describe '.blocks, .namespaces, .fields' do
    before { SuperbTextConstructor.instance_variable_set(:@blocks, nil) }
    before { @old_configs_path = SuperbTextConstructor.configs_path }
    after { SuperbTextConstructor.configs_path = @old_configs_path }
    after { SuperbTextConstructor.instance_variable_set(:@blocks, nil) }

    shared_examples_for 'any' do
      it 'loads correct config' do
        expect(SuperbTextConstructor.blocks).to eq(expected_blocks)
      end

      it 'returns correct namespaces' do
        expect(SuperbTextConstructor.namespaces).to eq(expected_namespaces)
      end

      it 'returns correct fields' do
        expect(SuperbTextConstructor.fields).to eq(expected_fields)
      end

      it 'returns correct templates' do
        expect(SuperbTextConstructor.templates).to eq(expected_templates)
      end
    end

    context 'single file' do
      let(:expected_blocks) { YAML.load_file("#{SuperbTextConstructor::Engine.root}/spec/fixtures/test_config_1.yml") }
      let(:expected_namespaces) { ['default'] }
      let(:expected_fields) { ['text'] }
      let(:expected_templates) { ['text'] }
      before { SuperbTextConstructor.configs_path = "#{SuperbTextConstructor::Engine.root}/spec/fixtures/test_config_1.yml" }
      it_behaves_like 'any'
    end

    context 'multiple files' do
      let(:expected_blocks) { YAML.load_file("#{SuperbTextConstructor::Engine.root}/spec/fixtures/merged_config.yml") }
      let(:expected_namespaces) { ['default', 'blog'] }
      let(:expected_fields) { ['text'] }
      let(:expected_templates) { ['text', 'quote'] }
      before do
        SuperbTextConstructor.configs_path = ["#{SuperbTextConstructor::Engine.root}/spec/fixtures/test_config_1.yml",
                                      "#{SuperbTextConstructor::Engine.root}/spec/fixtures/test_config_2.yml"]
      end
      it_behaves_like 'any'
    end
  end
end
