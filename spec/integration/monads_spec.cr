require "../spec_helper"

Spec2.describe "Integration: Dry::Monads" do
  let(m) { Dry::Monads }

  describe "maybe monad" do
    describe ".maybe" do
      describe "lifting to Some" do
        subject { m.some(5) }

        it "must be a Some" { expect(subject).to eq(Dry::Monads::Maybe::Some.new(5)) }
      end

      describe "lifting to None" do
        subject { m.maybe(nil) }

        it "must be a None" { expect(subject).to eq(Dry::Monads::Maybe::None.new) }
      end
    end

    describe ".some" do
      subject { m.some(10) }

      it "must be a Some" { expect(subject).to eq(Dry::Monads::Maybe::Some.new(10)) }

      # TODO: look into how to properly test `expect_raises`
      # it "must raise error when lifting a nil" do
      #   m.some(nil)
      # end
    end

    describe ".none" do
      subject { m.none }

      it "must be a None" { expect(subject).to eq(Dry::Monads::Maybe::None.new) }
    end
  end

  describe "either monad" do
    describe ".right" do
      subject { m.right("everything went right") }

      it "must be an Either::Right" { expect(subject).to eq(Dry::Monads::Either::Right.new("everything went right")) }
    end

    describe ".left" do
      subject { m.left("something has gone wrong") }

      it "must be an Either::Left" { expect(subject).to eq(Dry::Monads::Either::Left.new("something has gone wrong")) }
    end
  end
end
