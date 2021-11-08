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

## What is an instance method?

Instance methods are methods defined within a class that comprise the behaviors that instances of the class have at their disposal. While instance variables make up the state of an object, and each instances state is unique, the instance methods defined by a class are available to each instance of the class. The values that instance variables contain are available throughout a class, including within all instance method definitions. Because of this, the value returned or output by an instance method _may_ be different when invoked by different instances of the same class. 

```ruby
class Person                      
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def tell_about_self
    puts "Hi, I'm #{@name} and I'm #{@age} years old."
  end
  
  def greeting
    puts "Nice, to see you!"
  end
end

chris = Person.new("Christopher", 38)
adrienne = Person.new('Adrienne', 35)

chris.tell_about_self      # Hi, I'm Christopher and I'm 38 years old.
adrienne.tell_about_self   # Hi, I'm Adrienne and I'm 35 years old.

chris.greeting      # Nice, to see you!
adrienne.greeting   # Nice, to see you!
```


