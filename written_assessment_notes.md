# WA Study Guide

- OOP and Objects
  - [Why was OOP created and what purpose does it serve?](#why-was-oop-created-and-what-purpose-does-it-serve)
  - [What is an object?](#what-is-an-object)
  - [How do you instantiate a new object?]()
  - [What is a class and what is it's relationship with an object?]()
  - [What is an instance variable and how are they related to objects?]()
  - [What is an instance method and how are they related to objects?]()
  - [How can you find the instance variables that an object encapsulates?]()
  - [What's the difference between state and behavior?]()
  - [What is a class method and how do you define one?]()
  - [What is a collaborator object and their purpose?]()
  - [What is encapsulation and how does it relate to the public interface of a class?]()
  - [How do objects encapsulate state?]()
- Method Access Control
  - [What is a private method call used for?]()
  - [What is a protected method call used for?]()
  - [What is polymorphism?]()
  - [Explain two different ways to implement polymorphism.]()
  - [What is duck typing? How does it relate to polymorphism - what problem does it solve?]()

## Why was OOP created and what purpose does it serve

OOP is a programming paradigm that was developed in order to deal with the growing complexity of programs and the interdependencies they inevitably created, which made updating and maintaining programs difficult, often resulting in a ripple effect of bugs and errors when making a small change within a program.

By encapsulating data into classes, objects, and modules, OOP significantly reduced the dependencies within a program. This also allowed programmers to expose only the data/functionality that they needed to and hide the the implementation details within their respected containers, adding better data protection and security.

The ability to encapsulate data and behavior into the containers like the 'building blocks' of a program, allowed programmers to think about their programs at a different level of abstraction, i.e. in a more fundamentally human-friendly way.

---

## What is an object

If a class is a blueprint of what an objects state and behaviors will represent, an object is an instance of that blueprint. Each instance of a class will share the behaviors defined by the class, but the state of each instance is unique.

---

## How do you instantiate a new object

To instantiate a new instance of a class the class method `::new` must be called on the class itself. This method will then invoke a constructor method, `#initialize`, which can be defined to initialize an object in a specific way and/or to encapsulate a specific state.

```ruby
class Person           # the Person class is defined here

end

chris = Person.new     # a new instance of the Person class is instantiated
p chris                # outputs --> #<Person:0x000055af30fedb18>
```

The `::new` class method is called on the `Person` class. The`Person` object being instantiated will be initialized to the local variable `chris`. The last line outputs a string representation of the newly created object.

---

## What is a class and what is it's relationship with an object

A class is a blueprint for an object. It defines the behaviors(methods) that all instances(objects) of the class's public interface as well as the private methods that are used for implementation purposes. It also outlines the attributes that instances of the class will have by defining instance variables, but these instance variables will not be initialized until instantiation.

---

## What is an instance variable and how are they related to objects

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

## What is an instance method and how are they related to objects

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

## How can you find the instance variables that an object encapsulates

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

## What's the difference between state and behavior

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

## What is a class method and how do you define one

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

## What is a collaborator object and their purpose

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

## What is encapsulation and how does it relate to the public interface of a class

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

## How do objects encapsulate state

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

## What is a private method call used for

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

## What is a protected method call used for

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

## What is polymorphism

Polymorphism is when objects of different types have the ability to respond to the same method call. Regardless of whether the implementation details of the method call is different for different object types, they all still respond to a common interface(the same method call).

## Explain two different ways to implement polymorphism

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

## What is duck typing? How does it relate to polymorphism - what problem does it solve?


