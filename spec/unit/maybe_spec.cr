require "../spec_helper"

Spec2.describe Dry::Monads::Maybe do
  let(upcase) { ->(s : String) { s.upcase } }

  describe Dry::Monads::Maybe::Some do
    subject { Dry::Monads::Maybe::Some.new("foo") }

    it "must be some" { expect(subject.some?).to be_true }
    it "must not be none" { expect(subject.none?).to be_false }

    it "must equal Some.new(\"foo\")" { expect(subject).to eq(Dry::Monads::Maybe::Some.new("foo")) }
    it "must not equal None.new" { expect(subject).not_to eq(Dry::Monads::Maybe::None.new) }

    describe "#value" do
      it "returns wrapped value" do
        expect(subject.value).to eq("foo")
      end
    end

    describe "#bind" do
      it "accepts a proc and does not lift the result" do
        expect(subject.bind(upcase)).to eq("FOO")
      end

      it "accepts a block too" do
        expect(subject.bind { |s| s.upcase }).to eq("FOO")
      end
    end

    describe "#fmap" do
      it "accepts a proc and does not lift the result to maybe" do
        expect(subject.fmap(upcase)).to eq(Dry::Monads::Maybe::Some.new("FOO"))
      end

      it "accepts a block too" do
        expect(subject.fmap { |s| s.upcase }).to eq(Dry::Monads::Maybe::Some.new("FOO"))
      end
    end

    describe "#or" do
      it "accepts a value as an alternative" do
        expect(subject.or("baz")).to be(subject)
      end

      it "accepts a block as an alternative" do
        expect(subject.or { "baz" }).to be(subject)
      end
    end
  end

  describe Dry::Monads::Maybe::None do
    subject { Dry::Monads::Maybe::None.new }

    it "must not be some" { expect(subject.some?).to be_false }
    it "must be none" { expect(subject.none?).to be_true }

    it "must equal None.new" { expect(subject).to eq(Dry::Monads::Maybe::None.new) }
    it "must not equal Some.new(\"foo\")" { expect(subject).not_to eq(Dry::Monads::Maybe::Some.new("foo")) }

    describe "#value" do
      it "returns wrapped value" do
        expect(subject.value).to be_nil
      end
    end

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

      it "accepts a block and returns itself" do
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
