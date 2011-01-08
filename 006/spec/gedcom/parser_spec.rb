require 'spec_helper'
require 'stringio'

module Gedcom
  describe Parser do
    describe '.parse' do
      it 'should handle lines with content' do
        doc = Parser.parse(StringIO.new(<<'GEDCOM'))
0 NAME Edward_VII  /Wettin/
GEDCOM

        doc.should == <<XML
<?xml version="1.0"?>
<gedcom>
  <name>Edward_VII  /Wettin/</name>
</gedcom>
XML
      end

      it 'should handle lines with ids' do
        doc = Parser.parse(StringIO.new(<<'GEDCOM'))
0 @I1@ INDI
GEDCOM

        doc.should == <<XML
<?xml version="1.0"?>
<gedcom>
  <indi id="@I1@"/>
</gedcom>
XML
      end

      it 'should handle lines with content and ids' do
        doc = Parser.parse(StringIO.new(<<'GEDCOM'))
0 @N1@ NOTE content
GEDCOM

        doc.should == <<XML
<?xml version="1.0"?>
<gedcom>
  <note id="@N1@">content</note>
</gedcom>
XML
      end

      it 'should handle nesting' do
        doc = Parser.parse(StringIO.new(<<'GEDCOM'))
0 @I39@ INDI
1   NAME Fredericka Ann /Duhrrson/
1   SEX F
GEDCOM

        doc.should == <<XML
<?xml version="1.0"?>
<gedcom>
  <indi id="@I39@">
    <name>Fredericka Ann /Duhrrson/</name>
    <sex>F</sex>
  </indi>
</gedcom>
XML
      end

      it 'should handle CONC lines' do
        doc = Parser.parse(StringIO.new(<<'GEDCOM'))
0 NOTE ha
1   CONC ha
GEDCOM

        doc.should == <<XML
<?xml version="1.0"?>
<gedcom>
  <note>haha</note>
</gedcom>
XML
      end

      it 'should handle CONT lines' do
        doc = Parser.parse(StringIO.new(<<'GEDCOM'))
0 NOTE Line 1
1   CONT Line 2
GEDCOM

        doc.should == <<XML
<?xml version="1.0"?>
<gedcom>
  <note>Line 1
Line 2</note>
</gedcom>
XML
      end
    end
  end
end
