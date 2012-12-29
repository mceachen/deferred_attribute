require "minitest_helper"

describe DeferredAttribute do

  before :each do
    Target.call_count = 0
  end

  class Target
    include DeferredAttribute
    deferred_attribute :thing

    class << self
      attr_accessor :call_count
    end

    def get_thing
      "thing#{self.class.call_count += 1}"
    end
  end

  it "doesn't call get_ on initialize" do
    Target.new
    Target.call_count.must_equal 0
  end

  it "proxies to get_" do
    Target.new.thing.must_equal "thing1"
  end

  it "memoizes first get_ result" do
    t = Target.new
    t.get_thing.must_equal "thing1"
    t.thing.must_equal "thing2"
    t.get_thing.must_equal "thing3"
    t.thing.must_equal "thing2"
  end

  it "doesn't pollute other instances" do
    targets = 3.times.collect { Target.new }
    targets.collect { |ea| ea.thing }.must_equal %w(thing1 thing2 thing3)
    Target.new.thing.must_equal "thing4"
    targets.collect { |ea| ea.thing }.must_equal %w(thing1 thing2 thing3)
  end

  class Target2
    include DeferredAttribute
    deferred_attribute :fish, :with => :go_fish # I'm so clever.

    def go_fish
      "tuna"
    end
  end

  it "respects the prefix option" do
    Target2.new.fish.must_equal "tuna"
  end
end