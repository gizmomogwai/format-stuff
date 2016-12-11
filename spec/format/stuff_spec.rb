require "spec_helper"

describe Format::Stuff do
  include Format::Stuff
  it "has a version number" do
    expect(Format::Stuff::VERSION).not_to be nil
  end

  it "formats simple strings" do
    output = StringIO.new
    run_format("test {\ntest\n}\n", output, "  ")
    expect(output.string).to eq("test {\n  test\n}\n")
  end

  it 'the bin wrapper should work' do
    output = `bin/format-stuff spec/testdata/format.txt -`
    expect(output).to eq("test {\n\n  test2\n}\n")
  end

  it 'should close the output resource' do
    output = StringIO.new
    run_format("test", output, "    ")
    expect(output.closed?).to be true
  end

  it "should not indent empty lines" do
    output = StringIO.new
    run_format("test {\n\n}", output, "    ")
    expect(output.string).to eq("test {\n\n}\n")

    output = StringIO.new
    run_format("test {\n\n}", output, "\t")
    expect(output.string).to eq("test {\n\n}\n")
  end


end
