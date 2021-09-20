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

- [Questions](#questions)

---

## Part 1: The Object Model

### Why OOP?

OOP was developed to help deal with growing codebases and their complexity. Previous to the OOP programming paradigm when changes needed to be made to large codebases it would result in a ripple effect of bugs throughout the program due to dependencies. OOP provides a way of creating containers for data so that it could be used and changed without effecting the entire program. OOP programs would operate as the interaction of many small parts.

#### A Few Defintitions

- **Encapsulation**: is a form of data protection making it so that data cannot be manipulated without obvious intent. Encapsulation is how Ruby creates and defines boundaries by utilizing objects, and exposing interfaces (ie. methods) to interact with those objects. Another benefit of OOP is that it allows developers to think of objects as real-world nouns, making development friendlier to the developer, basically abstracting the logic one degree further.

- **Polymorphism**: stands for 'many forms' and allows for different types of data to respond to a common interface. If a argument passed to a method is expecting the argument to have a `#move` method passed to it, the argument can be any object that has a `#move` method built into its class.

- **Inheritance**: is the concept of a class inheriting the behavior of a parent class, referred to as a **superclass**. For example, a String object has behaviors/methods built into it's class (`String#chomp`, `String#count`, ...), but you can also call methods from the Object class (`Object#object_is`, `Object#to_s`, ...) on a String object, since the String class inherits from the Objects class.

- **Module**: allows us to group reusable code into one place. We use modules in our classes by using the include method invocation, followed by the module name. Modules are also used as a namespace, where a number of classes can be defined within a module to categorize them.

### What are Objects?

### Classes Define Objects

#### Classes

#### Instantiation

### Modules

### Method Lookup

---

## Part 2: Classes and Objects I

### States and Behaviors

- **States** track attributes for indivbidual behaviors
- **Behaviors** are what objects are capable of doing

We use **instance variables** to store and track information (name, age, id number, etc.) of an instance of a class. Instance variables are scoped at the object (instance) level, and are how we keep track of an objects **state**.

### Initializing a New Behavior

- Initialize
- Instance Variables

### Instance Methods

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
  - What does the `super` keyword dogit status
  
