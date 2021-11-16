# Live Assessment Code Snippets

- [Classes and objects](#classes-and-objects)
- [Use accessor methods to create setter and getter methods](#use-attr_*-to-create-setter-and-getter-methods)
- [How to call setters and getters](#how-to-call-setters-and-getters)
- [Instance methods vs. class methods](#instance-methods-vs-class-methods)
- [Method Access Control](#method-access-control)
- [Referencing and setting instance variables vs. using getters and setters](#referencing-and-setting-instance-variables-vs-using-getters-and-setters)
- [Writing custom getter method vs accessor method](#writing-custom-getter-method-vs-accessor-method)
- [Class inheritance, encapsulation, and polymorphism](#class-inheritance-encapsulation-and-polymorphism)
- [Modules](#modules)
- [Method lookup path](#method-lookup-path)
- [self](#self)
- [Calling methods with self](#calling-methods-with-self)
- [More about self](#more-about-self)
- [Reading OO code](#reading-oo-code)
- [Fake operators and equality](#fake-operators-and-equality)
- [Truthiness](#truthiness)
- [Working with collaborator objects](#working-with-collaborator-objects)

## Classes and objects

## Use accessor methods to create setter and getter methods

Accessors methods are built in short-cuts in Ruby that allow us to define getter methods, setter methods, or both using the **accessor methods**: `attr_reader`, `attr_writer` , and `attr_accessor`. 

```ruby
class Person
  
  # attr_accessor :name, :age
  # attr_writer :name, :age
  attr_reader :name
  
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def adult?
    age >= 18
  end
  
#   def name
#     @name
#   end
  
#   def name=(new_name)
#     @name = new_name
#   end
  
#   def age
#     @age
#   end
  
#   def age=(new_age)
#     @age = new_age
#   end
  
  private

  attr_reader :age
  
end

chris = Person.new('Chris', 38)
p chris.name
p chris.adult?

# p chris.name = "Christopher"
# p chris.age = 21
```

## How to call setters and getters

## Instance methods vs class methods

## Method Access Control

- By default all methods in a class are **public**.
- **Private methods** are not accessible in the public interface, but can be accessed through a public instance method _only by the calling object_.
- **Protected methods** are not accessible in the public interface, but can be accessed through a public instance method _by the calling object or another instance of the class_.

```ruby
class Person
  
  attr_reader :name
  
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def adult?
    age >= 18
  end
  
  
  def >(other_person)
    age > other_person.age
  end
  
  # private
  protected
  
  attr_reader :age
  
end

chris = Person.new('Chris', 38)
dan = Person.new('Daniel', 22)

p chris > dan
```

## Referencing and setting instance variables vs using getters and setters

Using getter and setter methods is preferred to referencing/setting instance variables because:

Getter:

- Allows for formatting and protecting of data.
- Makes code easier to maintain.

```ruby
# Cleaner and more maintainable 
# Allows us to format data

class Person
  attr_accessor :name, :age
  
  def initialize(ssn)
    @ssn = ssn
  end
  
  def  personal_info
    puts "My ssn is XXX-XXX-#{@ssn.split('-').last}."
      # unnecessary code interpolated into string
    
    puts "My ssn is #{ssn}."
      # much cleaner, easier to read, and maintainable
  end

  def ssn 
    "XXX-XXX-" + @ssn.split('-').last
  end
end

chris = Person.new('555-555-5555')
chris.personal_info
```

Setters:

- A misspelled instance variable will initialize a new instance variable but a misspelled setter method will throw an error. Makes debugging easier.

```ruby
# safer because misspellings of a method throw an error but instance variables do not

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def update_name=(new_name)
    if new_name.size > 0 
      @naem = new_name 
        # initialize new instance variable, doesn't throw an error

      self.naem = new_name 
        # throws error when setter method is misspelled
    end
  end

  private
  
  attr_writer :name
  
end

chris = Person.new('christopher')
chris.name
p chris.update_name = 'Cris'
p chris
```

## Writing custom getter method vs accessor method

```ruby
class Person
  def initialize(ssn)
    @ssn = ssn
  end
  
  def ssn
    'XXX-XXX-' + @ssn.split('-').last
  end
end

p Person.new('555-555-5555').ssn
```

## Class inheritance encapsulation and polymorphism

## Modules

There are 3 main uses of a module:

- **Interface Inheritance via Mixins**
- **Namespacing**
- **Module Methods**

```ruby
# Interface inheritance / Mixins

module Swimable
  def swim
    puts "I can swim"
  end
end

class Mammal; end

class Chimpanzee < Mammal; end

class Human < Mammal
  include Swimable
end

Human.new.swim

# namespacing

module WestCoast
  class BaseballTeam; end
  
  class FootballTeam; end
  
  class HockeyTeam; end
end

module EastCoast
  class BaseballTeam; end
  
  class FootballTeam; end
  
  class HockeyTeam; end
end

p WestCoast::BaseballTeam.new 
p EastCoast::BaseballTeam.new

# module methods

module BigNumber
  def self.times_99(num)
    num * 99
  end
end

p BigNumber.times_99(10001)
```

## Method lookup path

## self

Within an **instance method** it refers to the _calling object_.
Within a **class method** definition or in a **class body** it refers to the _class_.
Within a **module method definition** or in a **module body**it refers to the _module_. 

```ruby
module Greetable
  def self.module_hello
  # self referencing the module
    puts "Hi from the #{self} module"
  end
end

class Person
  include Greetable

  def self.class_hello
    # self referencing the class
    puts "Hi from the #{self} class"
  end
  
  def instance_hello
    #self referencing the object
    puts "Hi from an instance of the #{self.class}, here's self: #{self}"
  end
end

Person.class_hello
Person.new.instance_hello
Greetable.module_hello
```

## Calling methods with self

## More about self

## Reading OO code

## Fake operators and equality

## Truthiness

## Working with collaborator objects

