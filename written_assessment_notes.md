# WA Study Guide

## Why was OOP created and what purpose does it serve?

OOP is a programming paradigm that was developed in order to deal with the growing complexity of programs and the interdependencies they inevitably created, which made updating and maintaining programs difficult, often resulting in a ripple effect of bugs and errors when making a small change within a program.

By encapsulating data into classes, objects, and modules, OOP significantly reduced the dependencies within a program. This also allowed programmers to expose only the data/functionality that they needed to and hide the the implementation details within their respected containers, adding better data protection and security.

The ability to encapsulate data and behavior into the containers like the 'building blocks' of a program, allowed programmers to think about their programs at a different level of abstraction, i.e. in a more fundamentally human-friendly way.

---

## What is an object?

If a class is a blueprint of what an objects state and behaviors will represent, an object is an instance of that blueprint. Each instance of a class will share the behaviors defined by the class, but the state of each instance is unique.

---

## How do you instantiate a new object?

To instantiate a new instance of a class the class method `::new` must be called on the class itself. This method will then invoke a constructor method, `#initialize`, which can be defined to initialize an object in a specific way and/or to encapsulate a specific state. 

```ruby
class Person           # the Person class is defined here

end

chris = Person.new     # a new instance of the Person class is instantiated
p chris                # outputs --> #<Person:0x000055af30fedb18>
```

The `::new` class method is called on the `Person` class. The`Person` object being instantiated will be initialized to the local variable `chris`. The last line outputs a string representation of the newly created object. 

---

## What is a class and what is it's relationship with an object?

A class is a blueprint for an object. It defines the behaviors(methods) that all instances(objects) of the class's public interface as well as the private methods that are used for implementation purposes. It also outlines the attributes that instances of the class will have by defining instance variables, but these instance variables will not be initialized until instantiation. 

---

## What is an instance variable and how are they related to objects?

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

## What is an instance method and how are they related to objects?

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

## How can you find the instance variables that an object encapsulates?

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

## What's the difference between state and behavior?

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

This example demonstrates how state(instance variables and their values) is actualized at the instantiation of a new object and unique to each object, while behavior is defined within the class and all instances of an object share the same behavior. Two new `Person` objwects are instantiated and saved to `chris` and `adrienne`. The values saved tpo their respective states is unique to each object. The behaviors available to each object are the same (`#tell_about_self` and `#greet`), but the outputs can be unique when each objects unique state is included in the output, like we see when `chris` and `adrienne` invoke the same method `#tell_about_self` but receive different outputs.

---

## What is a class method and how do you define one?

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

Here we have defined a class method named `::say_something` and it outputs a string. By prepending the method name with `self` we are telling ruby that we are referencing the class itself, therefore within the method body `self` no longer references an instance of the `Person` class, insetad the `Person` class. 

---

## What is a collaborator object and their purpose?

