require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Gtfs::Source do
  let(:valid_local_source) do
    File.expand_path(File.dirname(__FILE__) + '/../fixtures/valid_gtfs.zip')
  end

  let(:source_missing_required_files) do 
    File.expand_path(File.dirname(__FILE__) + '/../fixtures/missing_files.zip')
  end

  describe '#build' do
    let(:opts) {{}}
    let(:data_source) {valid_local_source}
    subject {Gtfs::Source.build(data_source, opts)}

    context 'with a url as a data root' do
      use_vcr_cassette('valid_gtfs_uri')
      let(:data_source) {'http://dl.dropbox.com/u/416235/work/valid_gtfs.zip'}

      it {should be_instance_of Gtfs::URLSource}
      its(:options) {should == Gtfs::Source::DEFAULT_OPTIONS}
    end

    context 'with a file path as a data root' do
      let(:data_source) {valid_local_source}

      it {should be_instance_of Gtfs::LocalSource}
      its(:options) {should == Gtfs::Source::DEFAULT_OPTIONS}
    end

    context 'with a file object as a data root' do
      let(:data_source) {File.open(valid_local_source)}

      it {should be_instance_of Gtfs::LocalSource}
      its(:options) {should == Gtfs::Source::DEFAULT_OPTIONS}
    end

    context 'with options to disable strict checks' do
      let(:opts) {{strict: false}}

      its(:options) {should == {strict: false}}
    end
  end

  describe '#new(source)' do
    it 'should not allow a base Gtfs::Source to be initialized' do
      lambda {Gtfs::Source.new(valid_local_source)}.should raise_exception
    end
  end

  describe '#agencies' do
    subject {source.agencies}

    context 'when the source has agencies' do
      let(:source) {Gtfs::Source.build(valid_local_source)}

      it {should_not be_empty}
      its(:first) {should be_an_instance_of(Gtfs::Agency)}
    end
  end

  describe '#stops' do
  end

  describe '#routes' do
    context 'when the source is missing routes' do
      let(:source) { Gtfs::Source.build source_missing_required_files }

      it do
        expect { source.routes }.to raise_exception Gtfs::InvalidSourceException
      end
    end
  end

  describe '#trips' do
  end

  describe '#stop_times' do
  end
end
