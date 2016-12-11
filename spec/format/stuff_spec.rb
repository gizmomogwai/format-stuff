require "spec_helper"
include Format::Stuff

describe Format::Stuff do
  it "should apply tmp_indents" do
    expect(count_tmp_indent(".test", [/^\./])).to eq(1)
  end

  it "should indent 0 if no tmp_indents" do
    expect(count_tmp_indent(".test", [])).to eq(0)
  end

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

#describe "Format::Stuff::Ruby" do
#  it "should format ruby files" do
#    output = StringIO.new
#    run_format("def test()\ntest()\nend\n", output, "  ", ["def", "begin", "(", "[", "{"], ["end", ")", "]", "}"])
#    expect(output.string).to eq("def test()\n  test()\nend\n")
#  end
#
#  it "should format chains of method calls nicely" do
#    output = StringIO.new
#    run_format("def test()\nhello.there\n[1,2,3]\n.map()\n.map()\nend\n", output, "  ", ruby_open, ruby_close, ruby_tmp_indent)
#    expect(output.string).to eq("def test()\n  hello.there\n  [1,2,3]\n    .map()\n    .map()\nend\n")
#  end
#
#  it "should be possible to format multiline || nicely" do
#    output = StringIO.new
#    run_format("def test()\nif a\n||b\n&&c\nend\n", output, "  ", ruby_open, ruby_close, ruby_tmp_indent)
#    expect(output.string).to eq("def test()\n  if a\n    ||b\n    &&c\nend\n")
#  end
#
#  it "should format if elsif ends nicely" do
#    output = StringIO.new
#  end
#end

describe "Format::Stuff::Gradle" do
  it "should format build.gradle files" do
    output = StringIO.new
    run_format("apply plugin: 'java'\nrepositories {\njcenter()\n}\n", output, "    ", gradle_open, gradle_close)
    expect(output.string).to eq("apply plugin: 'java'\nrepositories {\n    jcenter()\n}\n")
  end
end
