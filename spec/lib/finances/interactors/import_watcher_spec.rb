require 'spec_helper'
include ImportFiles

describe ImportWatcher do

  before(:all) do
    FileUtils.mkdir_p 'import/archive'
    latch = CountDownLatch.new 1
    @action = ImportWatcher.new nil
    @action.run import_path: 'import'
    @action.callback = lambda do |modified, added, removed| 
      @added = added
      latch.countdown!
    end
    FileUtils.touch 'import/test.csv'
    FileUtils.touch 'import/test.ofx'
    FileUtils.touch 'import/test.qif'
    FileUtils.touch 'import/test.qfx'
    FileUtils.touch 'import/archive/archive.csv'
    latch.wait 2

    @added.map! { |f| Pathname.new(f).basename.to_s }
  end

  after(:all) do
    @action.stop
    FileUtils.rm_rf 'import'
  end

  it "notices csv" do
    @added.should include 'test.csv'
  end

  it "notices ofx" do
    @added.should include 'test.ofx'
  end

  it "doesn't notice other types" do
    @added.should_not include 'test.qif'
    @added.should_not include 'test.qfx'
  end

  it "ignores archived files" do
    @added.should_not include 'archive.csv'
  end
end
