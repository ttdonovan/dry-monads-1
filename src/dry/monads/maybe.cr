module Dry::Monads
  class Maybe
    getter value

    def self.lift(value : T)
      if value.nil?
        None.instance
      else
        Some.new(value)
      end
    end

    def ==(other)
      other.is_a?(Maybe) && value == other.value
    end

    def some?
      is_a? Some
    end

    def none?
      is_a? None
    end

    class Some(T) < Maybe
      def initialize(@value : T)
        raise "nil cannot be some" if value.nil?
      end

      def bind(proc : Proc)
        proc.call(@value)
      end

      def bind(&block)
        yield(@value)
      end

      def fmap(proc : Proc)
        Some.lift(bind(proc))
      end

      def fmap(&block)
        Some.lift(yield(@value))
      end

      def or(val : T)
        self
      end

      def or(&block)
        self
      end
    end

    class None < Maybe
      @value : Nil

      def self.instance
        @@instance ||= new
      end

      def bind(proc : Proc)
        self
      end

      def bind(&block)
        self
      end

      def fmap(proc : Proc)
        self
      end

      def fmap(&block)
        self
      end

      def or(val : T)
        val
      end

      def or(&block)
        yield(@value)
      end
    end
  end
end
