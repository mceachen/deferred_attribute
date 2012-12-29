# DeferredAttribute

The common ruby idiom for [lazy initialization](http://en.wikipedia.org/wiki/Lazy_initialization)
looks like this:

``` ruby
class Example
  def field
    @field ||= some_expensive_task()
  end
end
```

If ```some_expensive_task``` can return a "falsy" value (like ```nil``` or ```false```), this
doesn't work correctly—the prior [memoized](http://en.wikipedia.org/wiki/Memoization) value of
```some_expensive_task``` will be ignored, and every subsequent call to ```field``` will also call
```some_expensive_task```.

<em>DeferredAttribute aims to usurp your misbegotten love of ```||=```.</em>


## Usage

Add the DeferredAttribute module to your class, and prefix your getter method to ```get_```, without
the ivar setting with ||=.

``` ruby
class Example
  include DeferredAttribute
  deferred_attribute :field
  def get_field
    some_expensive_task()
  end
end
```

Calling ```Example.new.field``` will delegate and memoize the result of ```some_expensive_task```.

### Options

You can customize the name of the expensive operation method by using the ```:with``` option:

class Example2
  include DeferredAttribute
  deferred_attribute :field, :with => :some_expensive_task
  def some_expensive_task
  end
end

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'deferred_attribute'
```

And then execute:

    $ bundle

## Changelog

### 0.0.1

Fly, be free!

