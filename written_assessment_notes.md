# WA Study Guide

## OOP and Objects

- [Why was OOP created and what purpose does it serve?](#why-was-oop-created-and-what-purpose-does-it-serve)
- [What is an object?](#what-is-an-object)
- [How do you instantiate a new object?](#how-do-you-instantiate-a-new-object)
- [What is a class and what is it's relationship with an object?](#what-is-a-class-and-what-is-it's-relationship-with-an-object)
- [What is an instance variable and how are they related to objects?](#what-is-an-instance-variable-and-how-are-they-related-to-objects)
- [What is an instance method and how are they related to objects?](#what-is-an-instance-method-and-how-are-they-related-to-objects)
- [How can you find the instance variables that an object encapsulates?](#how-can-you-find-the-instance-variables-that-an-object-encapsulates)
- [What's the difference between state and behavior?](#what's-the-difference-between-state-and-behavior)
- [What is a class method and how do you define one?](#what-is-a-class-method-and-how-do-you-define-one)
- [What is a collaborator object and their purpose?](#what-is-a-collaborator-object-and-their-purpose)
- [What is encapsulation and how does it relate to the public interface of a class?](#what-is-encapsulation-and-how-does-it-relate-to-the-public-interface-of-a-class)
- [How do objects encapsulate state?](#how-do-objects-encapsulate-state-?)

## Method Access Control

- [What is a private method call used for?]()
- [What is a protected method call used for?]()
- [What is polymorphism?]()
- [Explain two different ways to implement polymorphism.]()
- [What is duck typing? How does it relate to polymorphism - what problem does it solve?]()

## Inheritance

- [What is inheritance?]()
- [When is it good to use inheritance?]()

## Modules

- [What is a module?]()
- [What is a mixin?]()
- [What is namespacing?]()

## Method Lookup Path

- [What is the method lookup path?]()
- [How can we reference a constant initialized within a different class?]()
- [How are constants used in inheritance?]()

### Why was oop created and what purpose does it serve

OOP is a programming paradigm that was developed in order to deal with the growing complexity of programs and the interdependencies they inevitably created, which made updating and maintaining programs difficult, often resulting in a ripple effect of bugs and errors when making a small change within a program.

By encapsulating data into classes, objects, and modules, OOP significantly reduced the dependencies within a program. This also allowed programmers to expose only the data/functionality that they needed to and hide the the implementation details within their respected containers, adding better data protection and security.

The ability to encapsulate data and behavior into the containers like the 'building blocks' of a program, allowed programmers to think about their programs at a different level of abstraction, i.e. in a more fundamentally human-friendly way.

---

### What is an object

If a class is a blueprint of what an objects state and behaviors will represent, an object is an instance of that blueprint. Each instance of a class will share the behaviors defined by the class, but the state of each instance is unique.

---

### How do you instantiate a new object

To instantiate a new instance of a class the class method `::new` must be called on the class itself. This method will then invoke a constructor method, `#initialize`, which can be defined to initialize an object in a specific way and/or to encapsulate a specific state.

```ruby
class Person           # the Person class is defined here

end

chris = Person.new     # a new instance of the Person class is instantiated
p chris                # outputs --> #<Person:0x000055af30fedb18>
```

The `::new` class method is called on the `Person` class. The`Person` object being instantiated will be initialized to the local variable `chris`. The last line outputs a string representation of the newly created object.

---

### What is a class and what is it's relationship with an object

A class is a blueprint for an object. It defines the behaviors(methods) that all instances(objects) of the class's public interface as well as the private methods that are used for implementation purposes. It also outlines the attributes that instances of the class will have by defining instance variables, but these instance variables will not be initialized until instantiation.

---

### What is an instance variable and how are they related to objects

Instance variables are a type of variable scoped at the object level, meaning it is only available through an object using getter and setter methods. An instance variable, or a collection of them, comprise the state of an object, or the data that is contained within an object, that's unique to the object.

```ruby
class Person                      
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def say_name
    puts "Hi, I'm #{@name}"
  end
end

chris = Person.new("Christopher", 38)
adrienne = Person.new('Adrienne', 35)

p chris     # outputs --> #<Person:0x000055e31dbd61a8 @name="Christopher", @age=38>
p adrienne  # outputs --> #<Person:0x000055ad4981d408 @name="Adrienne", @age=35>

chris.say_name    # outputs --> Hi, I'm Christopher
adrienne.say_name # outputs --> Hi, I'm Adrienne
```

Above, we have instantiated two new instances of the `Person` class and saved them to `chris` and `adrienne`. Two arguments are passed in with each new `Person` object and initialized to the instance variables in the `#initialize` instance method. For `chris`, `@name` points to `"Christopher"` and `@age` points to `38`. For `adrienne`, `@name` points to `"Adrienne"` and `@age` points to `35`. These attributes are displayed in a string interpretation of their objects when we output `chris` and `adrienne`, and when the `#say_name` instance method is called on them their respective instance variables are accessible.

This demonstrates that instance variables are accessible anywhere within the class. The values, or state, of an object is unique to that particular instance of the class while instance methods are shared amongst all instances of the class.

---

### What is an instance method and how are they related to objects

Instance methods are methods defined within a class that comprise the behaviors that instances of the class have at their disposal. While instance variables make up the state of an object, and each instances state is unique, the instance methods defined by a class are shared by instance of the class. The values that instance variables contain are available throughout a class, including within all instance method definitions and because of this the value returned or output by an instance method _may_ be different when invoked by different instances of the same class.

```ruby
class Person                      
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def tell_about_self
    puts "Hi, I'm #{@name} and I'm #{@age} years old."
  end
  
  def greet
    puts "Nice, to see you!"
  end
end

chris = Person.new("Christopher", 38)
adrienne = Person.new('Adrienne', 35)

chris.tell_about_self      # Hi, I'm Christopher and I'm 38 years old.
adrienne.tell_about_self   # Hi, I'm Adrienne and I'm 35 years old.

chris.greet      # Nice, to see you!
adrienne.greet   # Nice, to see you!
```

Again we've created two instances of the `Person` class `chris` and `adrienne`. Within the `Person` class we have defined two instance methods `#tell_about_self` and `#greet`. Within `#tell_about_self` we've interpolated instance variables into a string object which will output a unique message for each instance of the `Person` class that invokes the method. The `#greet` instance method will output the same string for every instance of the `Person` class that invokes it. This demonstrates that the instance methods defined within the `Person` class  are available for all `Person` objects to invoke.

---

### How can you find the instance variables that an object encapsulates

There are two ways to find the instances variables contained within a object. One is to the method `Object#instance_variable` on an object, which will output an array of the objects instance variables as symbols. This is less frequently used and less convenient than just inspecting a string representation of an object, which will output the class name, an encoding and any instance variables and their values encapsulated within the object.

```ruby
class Person                      
  def initialize(name, age)
    @name = name
    @age = age
  end
end

chris = Person.new("Christopher", 38)
adrienne = Person.new('Adrienne', 35)

p chris.instance_variables      # [:@name, :@age]
p adrienne.instance_variables   # [:@name, :@age]

p chris      #<Person:0x000056518ee464a8 @name="Christopher", @age=38>
p adrienne   #<Person:0x000056518ee46458 @name="Adrienne", @age=35>
```

---

### What's the difference between state and behavior

State and behavior are both defined by a class. The big difference is that an objects state is unique for each instance of a class whereas the behaviors of a class are shared across all instances of the class. State is comprised of the attributes defined by the class but not actualized until instantiation of a object, whereas behavior is comprised of all instance methods defined within a class that every object can invoke.

```ruby
class Person                      
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def tell_about_self
    puts "Hi, I'm #{@name} and I'm #{@age} years old."
  end
  
  def greet
    puts "Nice, to see you!"
  end
end

chris = Person.new("Christopher", 38)
adrienne = Person.new('Adrienne', 35)

chris.tell_about_self      # Hi, I'm Christopher and I'm 38 years old.
adrienne.tell_about_self   # Hi, I'm Adrienne and I'm 35 years old.

chris.greet      # Nice, to see you!
adrienne.greet   # Nice, to see you!
```

This example demonstrates how state(instance variables and their values) is actualized at the instantiation of a new object and unique to each object, while behavior is defined within the class and all instances of an object share the same behavior. Two new `Person` objects are instantiated and saved to `chris` and `adrienne`. The values saved tpo their respective states is unique to each object. The behaviors available to each object are the same (`#tell_about_self` and `#greet`), but the outputs can be unique when each objects unique state is included in the output, like we see when `chris` and `adrienne` invoke the same method `#tell_about_self` but receive different outputs.

---

### What is a class method and how do you define one

A class method is a method that we call directly on the class itself. Because it's being called on the class we do not need to instantiate a new object to invoke, just make sure that the class and class method are defined. To define a class method the keywords `def...end` are used to define the method and the keyword `self` must prepend the method name. This ensures that Ruby knows we're referencing the class itself. Class methods can be useful for keeping track of data on the class level instead of the object level.

```ruby
class Person                      
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def self.say_something    # must prepend the method name with `self` to refer to the class
    puts "This is the #{self} class invoking a class method"
  end
end

Person.say_something # outputs --> This is the Person class invoking a class method
```

Here we have defined a class method named `::say_something` and it outputs a string. By prepending the method name with `self` we are telling ruby that we are referencing the class itself, therefore within the method body `self` no longer references an instance of the `Person` class, instead the `Person` class.

---

### What is a collaborator object and their purpose

Collaborator objects are objects that are part of the state of another object, by being assigned to an instance variable. A collaborator can be of any data type (e.g. String, Integer, Array, etc.) but we typically think of a collaborator object as a custom object or objects that are part of another custom objects state. The way in which we assign objects to be collaborators of other objects defines the relationship between them.

```ruby
class Playlist
  attr_reader :name 
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def add_song(song)
    @songs << song
  end
  
  def play
    puts "Now playing #{name}..."
    @songs.each { |song| puts song }
  end
end

class Song
  attr_reader :title, :artist
  
  def initialize(title, artist)
    @title = title
    @artist = artist
  end
  
  def to_s
    "Playing #{title} by #{artist}"
  end
end

rock_mix = Playlist.new('Rock Mix') 
# Above we have created a new playlist object

free_bird = Song.new('Free Bird', 'Lynryd Skynyrd')
teen_spirit = Song.new('Smells Like Teen Spirit', 'Nirvana')
telephone = Song.new('Hanging on the Telephone', 'The Nerves')
# Above we have created 3 new song objects

rock_mix.add_song(free_bird)
rock_mix.add_song(teen_spirit)
rock_mix.add_song(telephone)
# Above we add the 3 song objects to the state of the playlist object

rock_mix.play   # outputs -->  Now playing Rock Mix...
                #              Playing Free Bird by Lynryd Skynyrd
                #              Playing Smells Like Teen Spirit by Nirvana
                #              Playing Hanging on the Telephone by The Nerves
```

Above, we have a `Playlist` class and a `Song` class. In this situation objects of the `Song` class will be considered collaborators of the `Playlist` class because the two classes have separate interfaces and we are adding objects of one class as attributes to an object of the other class, while still allowing the different objects to interact in a meaningful way.

---

### What is encapsulation and how does it relate to the public interface of a class

Encapsulation is the idea of hiding certain data and functionality from the rest of a codebase. This builds boundaries within a codebase and serves to protect the data within it. With classes, the public interface of an object will dictate how the data inside of an object will interact with the rest of the program. This means that by defining specific methods that are allowed to interact with data contained within an object we can separate the interface, the public methods accessible by an instance of a method, and its implementation, the code those methods execute. Only giving access to data and behavior of an instance of an object that a user needs, while separating data and behavior only needed for implementation, we create the public interface of an object.

```ruby
class Person                      
  def initialize(name, age, phone_number)
    @name = name
    @age = age
    @phone_number = phone_number
  end
  
  def tell_about_self
    # calls private getter methods to access @name and @age
    puts "Hi, I'm #{name} and I'm #{age} years old."
  end
  
  def formatted_phone_number
    # calls private getter method for @phone_number but formats for privacy
    puts "XXX-XXX-" + phone_number.split('-').last
  end
  
  def update_phone_number(new_number)
    # calls private setter method to update @phone_number
    self.phone_number = new_number
  end
  
  private
  
  attr_reader :name, :age
  attr_accessor :phone_number
  
end

chris = Person.new("Christopher", 38, '123-456-7890')

chris.tell_about_self                      # Hi, I'm Christopher and I'm 38 years old.
chris.formatted_phone_number               # XXX-XXX-7890
chris.update_phone_number('555-555-5555')  
chris.formatted_phone_number               # XXX-XXX-5555
```

In the code above we have a `Person` class and have instantiated a new person object and saved it to `chris`. The `person` class does not allow direct access to the instance variables `@name`, `@age`, `@phone_number` choosing to define their getter and setter methods as private. But it does provide instance methods to access the data contained within these instance variables in an appropriate way.

---

### How do objects encapsulate state

An objects state is comprised of various attributes, which are instance variables and the value that they point to. This value can be a built in Ruby object type or a instance of a custom class. These attributes are only accessible outside of the object by way of getter and setter methods that have been defined within the class. These attributes are _encapsulated_ within the object because there is no way to directly access them from outside of an object, which allows us to set control over who and how the state of an object is accessed and modified.

```ruby
class Person                      
  def initialize(name, age, phone_number)
    @name = name
    @age = age
    @phone_number = phone_number
  end
  
  def say_name
    # calls private getter methods to access @name and formats it for consistency
    puts name.capitalize
  end
  
  def say_phone_number
    # calls private getter method for @phone_number but formats for privacy
    puts "XXX-XXX-" + phone_number.split('-').last
  end
  
  def update_phone_number(new_number)
    # calls private setter method to update @phone_number
    self.phone_number = new_number
  end
  
  def is_adult?
    # calls private getter method for @age but does not reveal @age
    # returns a boolean value for whether the person is a legal adult 
    puts age >= 18
  end
  
  private
  
  attr_reader :name, :age
  attr_accessor :phone_number
  
end

chris = Person.new("christopher", 38, '123-456-7890')

chris.say_name           # Christopher
chris.say_phone_number   # XXX-XXX-7890
chris.is_adult?          # true
```

---

### What is a private method call used for

`private` ia an access modifier and we use to hide implementation details that do not want accessed outside of the class. Any methods defined after a `private` method call will not be accessible outside of the class, including other instances of the same class. `private` methods can be called by other methods within the class, regardless of whether they are `private` or `public`. 

```ruby
class Person                      
  def initialize(name, age, phone_number)
    @name = name
    @age = age
    @phone_number = phone_number
  end
  
  def say_name
    # calls private getter methods to access @name and formats it for consistency
    puts name.capitalize
  end
  
  def say_phone_number
    # calls private getter method for @phone_number but formats for privacy
    puts "XXX-XXX-" + phone_number.split('-').last
  end
  
  def update_phone_number(new_number)
    # calls private setter method to update @phone_number
    self.phone_number = new_number
  end
  
  def is_adult?
    # calls private getter method for @age but does not reveal @age
    # returns a boolean value for whether the person is a legal adult 
    puts age >= 18
  end
  
  private
  
  attr_reader :name, :age
  attr_accessor :phone_number
  
end

chris = Person.new("christopher", 38, '123-456-7890')

chris.say_name           # Christopher
chris.say_phone_number   # XXX-XXX-7890
chris.is_adult?          # true
```

---

### What is a protected method call used for

`protected` is an access modifier that we use to hide implementation details we don't want accessed outside of a class, but differs from `private` in that `protected` method is accessible to other objects that are instances of the same class. `protected` methods are most frequently used when overriding methods of comparison or equivalence.

```ruby
class Person                      
  
  attr_reader :name
  
  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)
    # we can access the attribute @age of another instance of the Person class
    age > other_person.age
  end
  
  protected
  
  attr_reader :age
  
end

chris = Person.new("christopher", 38)
adrienne = Person.new('Adrienne', 35)

p chris > adrienne    # true
p adrienne > chris    # false
```

---

### What is polymorphism

Polymorphism is when objects of different types have the ability to respond to the same method call. Regardless of whether the implementation details of the method call is different for different object types, they all still respond to a common interface(the same method call).

### Explain two different ways to implement polymorphism

Polymorphism is achieved through inheritance or through duck-typing.

Polymorphism through inheritance is achieved when an instance of a subclass inherits a method or behavior from its superclass, or when a subclass overrides a method defined within the superclass. Because instances of both the subclass and the superclass can respond to the same method invocation, regardless of it's implementation, we have achieved polymorphism through inheritance.

```ruby
class Mammal
  def moves
    puts "I move on 4 legs"
  end
end

class Primate < Mammal
  def moves
    puts "I move on 2 legs"
  end
end

class Human < Primate
  def moves
    puts "I move in my prius"
  end
end

mammals = [Mammal.new,Primate.new, Human.new]

mammals.each do |mammal|
  mammal.moves
end

# Outputs...
# I move on 4 legs
# I move on 2 legs
# I move in my prius
```

Polymorphism through duck-typing is when objects of completely unrelated classes can respond to a common method call. When multiple objects of different types share a common interface even though there is no relationship between class or module we have achieved polymorphism through duck-typing.

```ruby
class Band
  attr_reader :members
  
  def initialize
    @members = [Drummer.new, Guitarist.new, Singer.new]
  end
  
  def play_song
    members.each { |member| member.play }  
  end
end

class Drummer
  def play
    puts "Boo, boom, tat! Boom, boom, tat!"
  end
end

class Guitarist
  def play
    puts "Squeedily, squeedily, SQUEEEEEE!"
  end
end

class Singer
  def play
    puts "Ohh yyeeaaaaaaahhhh!"
  end
end

Band.new.play_song

# outputs...
# Boo, boom, tat! Boom, boom, tat!
# Squeedily, squeedily, SQUEEEEEE!
# Ohh yyeeaaaaaaahhhh!
```

---

### What is duck typing? How does it relate to polymorphism - what problem does it solve?

Duck typing is a form of polymorphism where unrelated objects can respond to a common interface. The objects won't have any connection via inheritance or module mixins and can all respond to the same method call even though the implementation of the method call is different for each object type. Duck typing focusing on what an object can do and not an object is.

\_see above for code sample_

---

### What is inheritance?

Inheritance is how a class gains state and/or behavior from a superclass or a module. Inheritance allows us to write superclasses that contain broad states and behaviors, as well as subclasses, which can contain more fine-tuned and specific states and behaviors. Inheritance between classes is done when there is a clear hierarchy between the classes. 

---

### When is it good to use inheritance?

When there is an 'is-a' (e.g. human is-a primate, which is-a mammal) relationship between two classes it makes sense to implement _class inheritance_. Class inheritance generally models a hierarchal relationship.

```ruby
class Mammal
  def state_fact
    puts "I'm warm-blooded."
  end
end

class Primate < Mammal; end

class Human < Primate; end

mammal = Mammal.new.state_fact      # I'm warm-blooded.
primate = Primate.new.state_fact    # I'm warm-blooded.
human = Human.new.state_fact        # I'm warm-blooded.
```

Above we have instantiated an instance of the `Mammal` class, the `Primate` class, and the `Human` class and invoked the `Mammal#state_fact` instance method defined within the `Mammal` class and inherited by the `Primate` and `Human` classes.

In situations when there is a 'has-a' (e.g. human has-a ability to read) relationship we want to use _interface inheritance_. When there is no hierarchal relationship at work this is the best way to share behaviors with a class. This can help keep your code DRY by allowing us to add specific behaviors to a class or classes when there is no relationship between them, by mixing in a module to a class. 

```ruby
module Readable
  def read
    puts "I can read books!"
  end
  # any class with Readable mixed in has access to the methods here
end

class Mammal
  def state_fact
    puts "I'm warm-blooded."
  end
end

class Primate < Mammal; end

class Human < Primate
  include Readable
  # Readable module is mixed in with the include method
end

Mammal.new.read       # NoMethodError
Primate.new.read      # NoMethodError
Human.new.read        # I can read books!
```

---

### What is a module?

Modules are containers that allow you to group methods, classes, and constants through interface inheritance. Methods that do not have a hierarchal relationship, as we'd see in class inheritance, can be grouped into a module and shared with any number of classes that we like. Modules are primarily used for grouping related methods together and for namespacing. Modules can not instantiate an object. 

See below for code sample.

---

### What is a mixin?

A mixin is a module containing methods that we 'mixin' to a class by the use of the `#include` method. By mixing a module into a class, instances of that class, and any class inheriting from it, have access to the methods defined within the module. This is done when a 'has-a' relationship (e.g. human has-a ability to read) exists and there is no hierarchal relationship present. Grouping behaviors into a module in this fashion helps keep our code DRY.

```ruby
module Readable
  def read
    puts "I can read books!"
  end
  # any class with Readable mixed in has access to the methods here
end

class Human < Primate
  include Readable
  # Readable module is mixed in with the include method
end

Human.new.read        # I can read books!
```

---

### What is namespacing?

Namespacing is a way of organizing classes together that may be related in some way and can aide in making our code easier to understand. This also allows us to create classes of the same name but nested within different modules which can keep code organized and easy to undersatnd in complex codebases. Any class defined within a module can only be referenced by prepending the module name to and the namespace resolution operator(`::`) before the class name. 

```ruby
module Walmart
  module Location503
    class Manager
      def manage
        puts "I manage Walmart at location 503"
      end
    end
  end
end

module Target
  module Location27
    class Manager
      def manage
        puts "I manage Target at location 27"
      end
    end
  end
end

Walmart::Location503::Manager.new.manage   # I manage Walmart at location 503
Target::Location27::Manager.new.manage      # I manage Target at location 27
```

---

### What is the method lookup path?

The method lookup path is the order of the classes and modules that Ruby looks through when a method has been invoked for the methods definition. Ruby will start by looking in the class of the calling object, if not definition is found there it will search for any modules included within the class, and then works it's way up the inheritance chain until it finds the method definition its looking for. If no method definition is found it will throw a `NoMethodError`. 

```ruby
module Readable
  def read
    puts "I can read!"
  end
end

module Climbable
  def climb
    puts "I can climb!"
  end
end

class Mammal
  def moves
    puts "I move on 4 legs"
  end
end

class Primate < Mammal
  include Climbable
  
  def moves
    puts "I move on 2 legs"
  end
end

class Human < Primate
  include Readable
  include Climbable
  
  def moves
    puts "I move in my prius"
  end
end


p Mammal.ancestors  # [Mammal, Object, PP::ObjectMixin, Kernel, BasicObject]
p Primate.ancestors # [Primate, Climbable, Mammal, Object, PP::ObjectMixin, Kernel, BasicObject]
p Human.ancestors   # [Human, Readable, Primate, Climbable, Mammal, Object, PP::ObjectMixin, Kernel, BasicObject]
```

Above the `::ancestors` class method has been called on our three classes `Mammal`, `Primate` and `Human`, and return an array of the method lookup path of each class. It starts in the class of the calling object, checks any modules included mixed in, then checks the next class in the hierarchy chain, and on and on until the method is found. A `NoMethodError` is thrown if the method definiton is not found. 

---

### How can we reference a constant initialized within a different class?

In order to reference a constant within a different class, the class name it is initialized within must be referenced, then the namespace resolution operator (`::`), and then constant name, like this: `ClassName::CONSTANT`.

---

### How are constants used in inheritance?

Because constants have lexical scope Ruby looks first in the class or module that they were referenced, then through the hierarchy chain. This why we should utilize the syntax where the calling object is then referenced with the namespace resolution operator and the constant name. Constants initialized in a superclass will be inherited by the subclass. 