# Object-Oriented Programming(OOP) Book: Notes

- [The Object Model](#part-1-the-object-model)
  - [Why OOP?](#why-oop)
    - [A few Defintions](#a-few-definitions)
  - [What are Objects?](#what-are-objects)
  - [Classes Define Objects](#classes-define-objects)
    - [Classes](#classes)
    - [Instantiation](#instantiation)
  - [Modules](#modules)
  - [Method Lookup](#method-lookup)
- [Part 2: Classes & Objects I](#part-2-classes-and-objects-i)
  - [States and Behaviors](#states-and-behaviors)
  - [Initializing a New Object](#initializing-a-new-behavior)
  - [Instance Methods](#instance-methods)
  - [Accessor Methods](#accessor-methods)
  - [Calling Methods with Self](#calling-methods-with-self)
- [Part 3: Classes & Objects II](#part-3-classes-and-objects-ii)
  - [Class Methods](#class-methods)
  - [Constants](#constants)
  - [The to_s Instance Method](#the-to-string-instance-method)
  - [More About Self](#more-about-self)
- [Part 4: Inheritance](#part-4-inheritance)
  - [Class Inheritance](#class-inheritance)
  - [Super](#super)
  - [Mixing in Modules](#mixing-in-modules)
  - [Inheritance vs Modules](#inheritance-vs-modules)
  - [Method Lookup Path](#method-lookup-path)
  - [Private Protected and Public](#private-protected-and-public)

- [Questions](#questions)

---

## Part 1: The Object Model

### Why OOP?

OOP was developed to help deal with growing codebases and their complexity. Previous to the OOP programming paradigm when changes needed to be made to large codebases it would result in a ripple effect of bugs throughout the program due to dependencies. OOP provides a way of creating containers for data so that it could be used and changed without effecting the entire program. OOP programs would operate as the interaction of many small parts.

#### A Few Definitions

- **Encapsulation**: is the idea of hiding certain data and functionality from the rest of a codebase. This builds boundaries within a codebase and serves to protect the data within it. With classes, the public interface of an object will dictate how the data inside of an object will interact with the rest of the program. This means that by defining specific methods that are allowed to interact with data contained within an object we can separate the interface, the public methods accessible by an instance of a method, and its implementation, the code those methods execute. Only giving access to data and behavior of an instance of an object that a user needs, while separating data and behavior only needed for implementation, we create the public interface of an object.

- **Polymorphism**: Polymorphism is when objects of different types have the ability to respond to the same method call. Regardless of whether the implementation details of the method call is different for different object types, they all still respond to a common interface(the same method call).

- **Inheritance**: is how a class gains state and/or behavior from a superclass or a module. Inheritance allows us to write superclasses that contain broad states and behaviors, as well as subclasses, which can contain more fine-tuned and specific states and behaviors. Inheritance between classes is done when there is a clear hierarchy between the classes.

- **Module**: these containers allow you to group methods, classes, and constants through interface inheritance. Methods that do not have a hierarchal relationship, as we'd see in class inheritance, can be grouped into a module and shared with any number of classes that we like. Modules are primarily used for grouping related methods together and for namespacing. Modules can not instantiate an object.

---

### Classes Define Objects

#### Classes

A class is a blueprint for an object. It defines the behaviors(methods) that all instances(objects) of the class's public interface as well as the private methods that are used for implementation purposes. It also outlines the attributes that instances of the class will have by defining instance variables, but these instance variables will not be initialized until instantiation.

#### Instantiation

To instantiate a new instance of a class the class method `::new` must be called on the class itself. This method will then invoke a constructor method, `#initialize`, which can be defined to initialize an object in a specific way and/or to encapsulate a specific state.

```ruby
class Person           # the Person class is defined here

end

chris = Person.new     # a new instance of the Person class is instantiated
p chris                # outputs --> #<Person:0x000055af30fedb18>
```

The `::new` class method is called on the `Person` class. The`Person` object being instantiated will be initialized to the local variable `chris`. The last line outputs a string representation of the newly created object.

---

### What are Objects?

If a class is a blueprint of what an objects state and behaviors will represent, an object is an completed instance of that blueprint. Each instance of a class will share the behaviors defined by the class, but the state of each instance is unique.

---

### Modules

Modules are containers that allow you to group methods, classes, and constants through interface inheritance. Methods that do not have a hierarchal relationship, as we'd see in class inheritance, can be grouped into a module and shared with any number of classes that we like. Modules are primarily used for grouping related methods together and for namespacing. Modules can not instantiate an object.

### What is a mixin

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

Human.new.read # I can read books!
```

### What is namespacing

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

### Method Lookup

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

---

## Part 2: Classes and Objects I

### States and Behaviors

- **States** track attributes for indivbidual behaviors
- **Behaviors** are what objects are capable of doing

We use **instance variables** to store and track information (name, age, id number, etc.) of an instance of a class. Instance variables are scoped at the object (instance) level, and are how we keep track of an objects **state**.

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

### Initializing a New Behavior (???)

#### Initialize

The `#initialize` method can be defined within a class to initialize instance variables upon instantiation of a new instance of an object. If no `#initialize` method is defined within a class the `::new` class method will still invoked an `#initialize` method but ot custom attributes will be set. Typically instance variables will be initialized within the `#initialize` method at instantiation in order to set the state of a new instance of a class. 

```ruby
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
end

chris = Person.new('Christopher', 38)
p chris # <Person:0x000055a2ec26de98 @name="Christopher", @age=38>
```

#### Instance Variables

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

### Instance Methods

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

### Accessor Methods

#### Calling Methods with Self

## Part 3: Classes and Objects II

### Class Methods

### Constants

### The to string Instance Method

### More About Self

## Part 4: Inheritance

### Class Inheritance

### Super

### Mixing in Modules

### Inheritance vs Modules

### Method Lookup Path

### Private Protected and Public

---

## Questions

- Part 1: The Object Model
  - Why was OOP created and what purpose does it serve?
  - What is encapsulation?
  - What is polymorphism?
  - What does inherotance mean when referring to OOP?
  - What are modules?
  - What can be considered an Object in Ruby?
  - What defines an object in Ruby?
  - What is instantiation?
  - When naming classes and class files what is the proper format?
  - What are modules used for?
  - How do we add behaviors defined by a module to a custom class?
  - what does method lookup refer to?
- Part 2: Classes and Objects I
  - What is state and how to we track it?
  - What is behavior and how do we define it?
  - How do we create a new instance of a class?
  - What method is called when you create a new method, besides the `BasicObject#new` method, and why?
  - What is an instance variable and why do we need them?
  - Do objects of the same class have the same states and behaviors?
  - When dealing with getter and setter methods how does Ruby's syntactical sugar help us?
  - What naming convention should we keep in mind when dealing with getter and setter methods?
  - What do setter methods always return?
  - What built in accessors methods does Ruby provide and what do they take in as arguments?
  - Instead of directly calling an instance variable from within an instance method, what is a preferable way of referencing the state of an object and why?
  - What do we need to add to a setter method within an instance variable to update the state and why?
  - When should we use the self keyword within an instance method?
- Part 3: Classes and Objects II
  - What is a class method and how do you define one?
  - How do you call a class method vs. calling an instance method?
  - Why would we need a class method?
  - When does the initialize method get called?
  - Why would we use a constant when we have class variables?
  - In what circumstance would we not need to define instance variables within the initialize instance method?
  - When calling the `puts` method, what other method is also called, and is it called always?
  - What are the similarities and differences of the `puts` and the `p` methods?
  - In what other circumstance is the `to_s` method automatically called?
  - How can we use the `to_s` method within our own custom classes?
  - Even though it's not always necessary, why is prepending getter and setter methods with `self` important?
  - What are 2 clear things that we can `self` for?
  - What are the boundaries of `self` within a class when determining whether oyu're referencing the class or an instance of the class?
- Part 4: Inheritance
  - How does inheritance effect behavoir and what are the associated objects referred to?
  - What do we use to signify that a class is inheriting form another?
  - How can a subclass override the behavior of a superclass and how does this work?
  - What does the `super` keyword do?
  - How can we be more specific about what `super` passes or doesn't pass as an argument?
  - What happens if you use `super` when the sublass method has arguments passed in and the superclass method doesn't, or vice-versa?
  - What's a good example of where using class inheritance makes sense?
  - Why do we need modules if we can inherit from other classes?
  - What is a design principle that OOP helps us achieve?
  - What is the difference between class inheritance and interface inheritance?
  - What are the 3 main things to think about when determining whether class inheritance or a mixin is more appropriate for a situation?
  - What are 3 ways that we use modules?
  - What is important to keep in mind regarding the order in which mixins are added to a class?
  - What is the advantage of namespacing?
  - What do we use to reference a class or class method that is namespaced within a module?
  - When using a module as a container how would call a method contained within it?
  - When would we want to use a private method?
  - How is the `self` keyword affected when using a private method?
  - How is a private method scoped?
  - How do protected methods differ from private methods?
  - Is `initialize` a public, private or protected method?
  - What are the 3 types of method access control?
  - What are the 4 core programming concepts of OOP?
  - What does a constructor method return?
  - How many classes can a class inherit from?
  - How many modules can be mizxed into a class?

---

The major OOp concepts you should understand are:

- relationship between a class and an object
- idea that a class groups behaviors (ie, methods)

Object level

- objects do not share state between other objects, but do share behaviors
- put another way, the values in the objects' instance variables (states) are different, but they can call the same instance methods (behaviors) defined in the class

Class level

- classes also have behaviors not for objects (class methods)

Inheritance

- sub-classing from parent class. Can only sub-class from 1 parent; used to model hierarchical relationships
- mixing in modules. Can mix in as many modules as needed; Ruby's way of implementing multiple inheritance
- understand how sub-classing or mixing in modules affects the method lookup path
