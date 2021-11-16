# Live Assessment Code Snippets

- [OOP and Why it was Created](#oop-and-Why-it-was-created)

- [Classes and objects](#classes-and-objects)
  - [Objects](#objects)
  - [Classes](#classes)
  - [Object Instantiation](#object-instantiation)
  - [Instance Variables](#instance-variables)
  - [Instance Methods](#instance-methods)
  - [State and Behavior](#state-and-behavior)
  - [Class Variables](#class-variables)
  - [Class Methods](#class-methods)

- [Setters and Getters](#setters-and-getters)
  - [Getter Methods](#getter-methods)
  - [Setter Methods](#setter-methods)
  - [Accessor Methods](#use-attr_*-to-create-setter-and-getter-methods)
  - [Referencing and setting instance variables vs. using getters and setters](#referencing-and-setting-instance-variables-vs-using-getters-and-setters)
  - [Writing custom getter method vs accessor method](#writing-custom-getter-method-vs-accessor-method)

- [Method Access Control](#method-access-control)
  - [Public](#public)
  - [Private](#private)
  - [Protected](#protected)

- [Inheritance](#inheritance)
  - [Class Inheritance](#class-inheritance)
  - [Interface Inheritance](#interface-inheritance)
  - [Method lookup path](#method-lookup-path)
  - [Super](#super)
  - [Object Methods](#object-methods)
  - [Variable Scope with Inheritance](#variable-scope-with-inheritance)

- [Polymorphism and Encapsulation](#polymorphism-and-encapsulation)
  - [Polymorphism](#polymorphism)
    - [Polymorphism Through Inheritance](#polymorphism-through-inheritance)
    - [Polymorphism Through Duck Typing](#polymorphism-through-duck-typing)
  - [Encapsulation](#encapsulation)

  - [Class inheritance, encapsulation, and polymorphism](#class-inheritance-encapsulation-and-polymorphism)

- [Modules](#modules)
  - Mixin Modules
  - Namespacing
  - Module Methods

- [self](#self)
  - Inside Instance Methods
  - Inside Class Methods
  - Inside Class Definitions
  - Inside Mixin Modules
  - Outside Any Class
  - [Calling methods with self](#calling-methods-with-self)
  - [More about self](#more-about-self)

- [Fake operators and equality](#fake-operators-and-equality)
  - Equivalence
    - ==
    - equal? and object_id
    - ===
    - eql?
  - Fake Operators
    - Comparison Methods
    - Right and Left Shift
    - Plus
    - Element Setters and Getters

- [Working with collaborator objects](#working-with-collaborator-objects)

---

## OOP and Why it was Created

OOP was created to deal with the growing complexity of programs and the web of interdependencies that inevitably would develop within procedural programs. These interdependencies made code bases very difficult to maintain and update without causing a ripple effect of bugs to occur.

## Classes and objects

### Classes

**Classes** are the blueprints that determine what an **object** is made of and can do. In Ruby the attributes and behaviors of an object are defined within a class.

To define a new class by using `class` and then the class name, always in CamelCase. The new class definition must be enclosed with `end`.

```ruby
class HumanBeing
end
```

### Object Instantiation

An **object** is an instance of the **class** it was _instantiatied_ from and is comprised of a unique **state** and **behaviors** that are shared by other instances of the class.

To instantiate a new instance of a class the class must be defined and then the `::new` class method must be called on the class. If there is a custom instance method `#initialize` within the class that takes parameters, the appropriate arguments must be passed in.

```ruby
class HumanBeing
end

p HumanBeing.new #<HumanBeing:0x000055562efb7488>
```

When calling the `::new` class method at instantiation the `#initialize` instance method is automatically called, regardless if one has been defined within our custom class. Because this method is invoked at instantiation any code within this method will be executed. We call this a **constructor method**. This is primarily used for initializing instance variables during instantiation of an object.

```ruby
class HumanBeing
  def initialize(name)
    @name = name
    puts "Hi, I'm instantiation a new instance of the HumanBeing class!"
  end
end

p HumanBeing.new('Chris') 
  # Hi, I'm instantiation a new instance of the HumanBeing class!
  # #<HumanBeing:0x000055e8b426d638 @name="Chris">
```

### Instance Variables

An instance variable has the `@` symbol prepending the instance variable name. An instance variable is initialized within an object and will remain there as long as the object exists. It is how we tie data to an object.

Every objects state is unique and instance variables are responsible for keeping track of the data of an objects _state_.

```ruby
class HumanBeing
  def initialize(name, age, height)
    @name = name
    @age = age
    @height = height
  end
end

p HumanBeing.new('Chris', 38, '6 ft 3 inches') 
  #<HumanBeing:0x000055d30a05b2b0 @name="Chris", @age=38, @height="6 ft 3 inches">
```

### Instance Methods

**Instance methods** are methods, or _behaviors_, that an instance of a class has available to them. All instances of a class have access to the same behaviors that have been defined within the class, but because each object has a different state the output may differ. Instance methods are the way in which we access, edit, or alter the state of an object.

An instance method is invoked by referencing the object, using the _method resolution operator_ (`.`) and then the method name, like so `chris.say_hi`

```ruby
class HumanBeing
  def initialize(name, age, height)
    @name = name
    @age = age
    @height = height
  end
  
  def say_hi
    puts "Hello"
  end
  
  def tell_about_self
    puts "I'm #{@name}, I'm #{@age} years old and I'm #{@height}."
  end
end

chris = HumanBeing.new('Chris', 38, '6 ft 3 inches') 
chris.say_hi          # "Hello"
chris.tell_about_self # "I'm Chris, I'm 38 years old and I'm 6 ft 3 inches."

adrienne = HumanBeing.new('Adrienne', 35, '5 ft 4 inches')    
adrienne.say_hi          # "Hello"
adrienne.tell_about_self # "I'm Adrienne, I'm 35 years old and I'm 5 ft 4 inches."
```

### State and Behavior

```ruby
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def say_name
    puts "I'm #{@name}"
  end
  
  def say_age
    puts "I'm #{@age} years old"
  end
end

chris = Person.new("christopher", 38)
adrienne = Person.new('adrienne', 35)

p chris, adrienne
# outputs a string representation an object and it's state

chris.say_name
adrienne.say_name

chris.say_age
adrienne.say_age
# the say_name and say_age methods are behaviors of the instances of the Person class
```

### Class Variables

Just as instance variables capture data of an object, **class variables** capture data for an entire class. Class variables are initialized using `@@` in front of the method name. Because these variables are accessible at the _class level_ all instances of the class share the values held by a class variable. Meaning that if one instance of a class alters teh value of a class variable, that value is altered for every other instance of the class. 

```ruby
class HumanBeing
  @@human_saying = 'Just do it'
  
  def initialize(name)
    @name = name
  end
  
  def human_saying
    @@human_saying
  end
  
  def human_saying=(new_saying)
    @@human_saying = new_saying
  end
end

chris = HumanBeing.new('Chris') 
adrienne = HumanBeing.new("Adrienne")

p chris.human_saying      # "Just do it"
p adrienne.human_saying   # "Just do it"
chris.human_saying = "It's not easy being cheesy"
p chris.human_saying      # "It's not easy being cheesy"
p adrienne.human_saying   # "It's not easy being cheesy"
```

### Class Methods

Like instance methods that can be called on instances of a class, **class methods** can be called upon the class itself. Because these methods are called directly on the class itself they do not require an object to be instantiated.

When defining a class methods we must prepend the `self` reserved word to the method name. This tells Ruby that we're referencing the class with this method definition. Class methods are used when need some sort of functionality that does not pertain to individual objects or their state.

```ruby
class HumanBeing
  @@human_saying = 'Just do it'
  
  def initialize(name)
    @name = name
  end
  
  def self.say_human_thing
    puts @@human_saying
  end
end

HumanBeing.say_human_thing # Just do it 
```

---

## Setters and Getters

### Getter Methods

### Setter Methods

### Use accessor methods to create setter and getter methods

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

---

## Method Access Control

### Public

### Private

### Protected

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

---


## Inheritance

### Class Inheritance

### Interface Inheritance

### Method lookup path

### Super

### Object Methods

### Variable Scope with Inheritance

---

## Polymorphism and Encapsulation

### Polymorphism

  #### Polymorphism Through Inheritance

  #### Polymorphism Through Duck Typing

### Encapsulation

---

## Modules

### Mixin Modules

### Namespacing

### Module Methods

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

---

## self

### Inside Instance Methods

### Inside Class Methods

### Inside Class Definitions

### Inside Mixin Modules

### Outside Any Class

### [Calling methods with self](#calling-methods-with-self)

### [More about self](#more-about-self)

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

---

## Fake operators and equality

### Equivalence

  #### ==

  #### equal? and object_id

  #### ===

  #### eql?

### Fake Operators

  #### Comparison Methods

  #### Right and Left Shift

  #### Plus

  #### Element Setters and Getters

---

## Working with collaborator objects

- A collaborator object is an object (usually a custom object) stored as a state within another object.
- In the code below instances of the `Book` class are collaborator objects of the `Library` class

```ruby
class Library
  attr_reader :books
  
  def initialize(name)
    @name = name
    @books = []
  end
  
  def <<(book)
    books << book
  end
end

class Book
  attr_reader :title, :author
  def initialize(title, author)
    @title = title
    @author = author
  end
  
  def to_s
    <<~HEREDOC
      ===========================
      Title:  #{title}
      Author: #{author}
    HEREDOC
  end
end

lib = Library.new('Portland Public Library')

geek_love = Book.new('Geek Love', "Katherine Dunn")
walk_in_woods = Book.new("A Walk in the Woods", "Bill Bryson")

lib << geek_love
lib << walk_in_woods

puts lib.books
```

---
