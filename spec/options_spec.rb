module TildeConfig
  RSpec.describe Options do
    it 'can parse empty options with correct defaults' do
      options = Options.new.parse([])
      expect(options.interactive).to be_truthy
      expect(options.system).to be_nil
      expect(options.packages).to be_falsey
      expect(options.skip_dependencies).to be_falsey
      expect(options.config_file).to be_nil
      expect(options.should_ignore_errors).to be_falsey
      expect(options.directory_merge_strategy).to eq(:merge)
      expect(options.should_override).to be_truthy
    end

    it 'can turn off interactivity' do
      options = Options.new.parse(%w[-n])
      expect(options.interactive).to be_falsey
      options = Options.new.parse(%w[--non-interactive])
      expect(options.interactive).to be_falsey
    end

    it 'can successfully set the system' do
      options = Options.new.parse(%w[-s ubuntu])
      expect(options.system).to eq(:ubuntu)
      options = Options.new.parse(%w[--system ubuntu])
      expect(options.system).to eq(:ubuntu)
    end

    it 'should successfully validate valid options' do
      Configuration.with_standard_library do
        Options.new.parse(%w[-n --system ubuntu]).validate
      end
    end

    it 'should detect when --packages is given without --system' do
      options = Options.new.parse(%w[--packages])
      expect { options.validate }.to raise_error(OptionsError)
    end

    it 'validate should detect invalid systems' do
      options = Options.new.parse(%w[--system fake-system])
      expect { options.validate }.to raise_error(OptionsError)
    end

    it 'validate should ensure --directory-merge-strategy is only called ' \
        'with valid options' do
      options = Options.new.parse(%w[--directory-merge-strategy invalid])
      expect { options.validate }.to raise_error(OptionsError)
    end
  end
end
