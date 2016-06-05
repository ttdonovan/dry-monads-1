require "../spec_helper"

Spec2.describe Dry::Monads::Either do
  let(upcase) { ->(s : String) { s.upcase } }

  describe Dry::Monads::Either::Right do
    subject { Dry::Monads::Either::Right.new("foo") }

    it "must be right" { expect(subject.right?).to be_true }
    it "must be success" { expect(subject.success?).to be_true }

    it "must not be left" { expect(subject.left?).to be_false }
    it "must be failure" { expect(subject.failure?).to be_false }

    it "must equal Right.new(\"foo\")" { expect(subject).to eq(Dry::Monads::Either::Right.new("foo")) }
    it "must not equal Left.new(\"foo\")" { expect(subject).not_to eq(Dry::Monads::Either::Left.new("foo")) }

    describe "#bind" do
      it "accepts a proc and does not lift the result" do
        expect(subject.bind(upcase)).to eq("FOO")
      end

      it "accepts a block too" do
        expect(subject.bind { |s| s.upcase }).to eq("FOO")
      end
    end

    describe "#fmap" do
      it "accepts a proc and lifts the result to either" do
        expect(subject.fmap(upcase)).to eq(Dry::Monads::Either::Right.new("FOO"))
      end

      it "accepts a block and returns itself" do
        expect(subject.fmap { |s| s.upcase }).to eq(Dry::Monads::Either::Right.new("FOO"))
      end
    end

    describe "#or" do
      it "accepts value as an alternative" do
        expect(subject.or("baz")).to be(subject)
      end

      it "accepts block as an alternative" do
        expect(subject.or { "baz" }).to be(subject)
      end
    end
  end

  describe Dry::Monads::Either::Left do
    subject { Dry::Monads::Either::Left.new("bar") }

    it "must not be right" { expect(subject.right?).to be_false }
    it "must not be success" { expect(subject.success?).to be_false }

    it "must be left" { expect(subject.left?).to be_true }
    it "must be failure" { expect(subject.failure?).to be_true }

    it "must not equal Right.new(\"bar\")" { expect(subject).not_to eq(Dry::Monads::Either::Right.new("bar")) }
    it "must equal Left.new(\"bar\")" { expect(subject).to eq(Dry::Monads::Either::Left.new("bar")) }

    describe "#bind" do
      it "accepts a proc and returns itself" do
        expect(subject.bind(upcase)).to be(subject)
      end

      it "accepts a block and returns itself" do
        expect(subject.bind { |s| s.upcase }).to be(subject)
      end
    end

    describe "#fmap" do
      it "accepts a proc and returns itself" do
        expect(subject.fmap(upcase)).to be(subject)
      end

      it "accepts a block and returns itseld" do
        expect(subject.fmap { |s| s.upcase }).to be(subject)
      end
    end

    describe "#or" do
      it "accepts value as an alternative" do
        expect(subject.or("baz")).to eq("baz")
      end

      it "accepts block as an alternative" do
        expect(subject.or { "baz" }).to eq("baz")
      end
    end
  end
end
