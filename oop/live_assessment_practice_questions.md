# LA Practice Questions

1. What is encapsulation in Ruby, and why does it matter? Demonstrate with code.
2. What is polymorphism in Ruby? How do we implement it in code?
3. How do we control access to methods in Ruby?
4. How does inheritance work in Ruby? When would inheritance be appropriate?
5. What are getter and setter methods in Ruby? How do we create them?
6. What is the difference between instance methods and class methods?
7. What is `self`? Demonstrate how it is used.
8. What are modules? When is it appropriate to use them?
9. What is the `attr_accessor` method, and why wouldn't we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.
10. How is Method Access Control implemented in Ruby? Provide examples of when we would use public, protected, and private access modifiers.
11. Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to set an instance variable within the class? Give an example.
12. Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.
13. What is the difference between states and behaviors?
14. What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.
15. How and why would we implement a fake operator in a custom class? Give an example.
16. What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? Provide examples.
17. How do class inheritance and mixing in modules affect instance variable scope? Give an example.
18. How does encapsulation relate to the public interface of a class?
19. When does accidental method overriding occur, and why? Give an example.
20. How is Method Access Control implemented in Ruby? Provide examples of when we would use public, protected, and private access modifiers.
21. Describe the distinction between modules and classes.
22. What is Object Oriented Programming, and why was it created? What are the benefits of OOP, and examples of problems it solves?
23. What is the relationship between classes and objects in Ruby?
24. When should we use class inheritance vs. interface inheritance?
25. What is OOP and why is it important?

```ruby
class Person
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def intro
  end
end

class Steve < Person
  def introduce_mate
  end  
end

class Dave < Person
end

# create and instance from the Steve class and call the introduce_mate method on it.

# Output should be:
# Hi, I'm Steve. This is Dave.
# Hi, I'm Dave. Steve's best mate.

# You can change the following methods and nothing else: intro and introduce_mate
# All of the names in the output should be interpolated.

# ================================
```

```ruby
# list of problems for the live assessment
# Problem by Natalie Thompson
class Person
  def initialize(name, job)
      @name = name
  end 
end

roger = Person.new("Roger", "Carpenter")
puts roger

# Add 1 line of code for the person class
# and 1 line of code in the initalize method. 


#Other than that don't change Person.

# Output:
# "My name is Roger and I am a Carpenter"

# ================================================================
```

```ruby
class Human # Problem received from Raul Romero
    attr_reader :name

  def initialize(name="Dylan")
    @name = name
  end
  
end

puts Human.new("Jo").hair_colour("blonde")  
# Should output "Hi, my name is Jo and I have blonde hair."

puts Human.hair_colour("")              
# Should "Hi, my name is Dylan and I have blonde hair."

# ================================================================
```

```ruby
class Human  # Problem received from Raul Romero
  attr_reader :name 
  
  def initialize(name)
  end
 
end

gilles = Human.new("gilles") 
anna = Human.new("gilles") 

puts anna.equal?(gilles) #should output true # 
puts anna + gilles # should output annagilles 

# ================================================================
```

```ruby
#describe what the code below outputs and why from Joseph Ochoa

module Attackable
  def attack
    "attacks!"
  end
end

class Characters
  attr_accessor :name, :characters 
  
  def initialize(name) 
    #
    self.name 
    @characters = [] 
  end
  
  def display
    name
  end
  
  protected 
  attr_reader :name
  attr_writer :name
end

class Monster < Characters
  include Attackable
  
  def initialize(name)
    super
  end
end

class Barbarian < Characters
  def ==(other)
    if(super.self == super.self) # 
      super.self == super.self
    end
  end
end

conan = Barbarian.new('barb') 
rob = Monster.new('monst')
conan.characters << rob
p conan.display

# ================================================================
```

```ruby
# From Joseph Ochoa
# give class Barbarian the functionality of the Monster instance attack method:
  # If you used class inheritance, not try doing it without class inheritance directly.
  # If you used modules, now try not using modules
  # If you used duck typing, now don't use duck typing 

class Monster
  def attack
    "attacks!"
  end
end

class Barbarian
  
end
    
# ================================================================
```

```ruby
# Without adding any methods below, implement a solution; originally by Natalie Thompson, this version by Oscar Cortes
class ClassA 
  attr_reader :field1, :field2
  
  def initialize(num)
    @field1 = "xyz"
    @field2 = num
  end
end

class ClassB 
  attr_reader :field1

  def initialize
    @field1 = "abc"
  end
end


obj1 = ClassA.new(50)
obj2 = ClassA.new(25)
obj3 = ClassB.new


p obj1 > obj2
p obj2 > obj3

# ================================================================
```

```ruby
# Unknown
class BenjaminButton 
  
  def initialize
  end
  
  def get_older
  end
  
  def look_younger
  end
  
  def die
  end
end

class BenjaminButton
end


benjamin = BenjaminButton.new
p benjamin.actual_age # => 0
p benjamin.appearance_age # => 100

benjamin.actual_age = 1
p benjamin.actual_age

benjamin.get_older
p benjamin.actual_age # => 2
p benjamin.appearance_age # => 99

benjamin.die
p benjamin.actual_age # => 100
p benjamin.appearance_age # => 0

# ========================================================================
```

```ruby
# Originally by Natalie Thompson, this version by James Wilson
class Wizard
  attr_reader :name, :hitpoints
  
  def initialize(name, hitpoints)
    @name = name
    @hitpoints = hitpoints
  end  
  
  def fireball
    "casts Fireball for 500 damage!"
  end
  
end

class Summoner < Wizard
  attr_reader :souls
  
  def initialize(name, hitpoints)
    # only add one line here
    @souls = []
  end
  
  def soul_steal(character)
    @souls << character
  end
end

gandolf = Summoner.new("Gandolf", 100)
p gandolf.name # => "Gandolf"

valdimar = Wizard.new("Valdimar", 200)
p valdimar.fireball #=> "casts fireball for 500 damage!"

p gandolf.hitpoints #=> 100

p gandolf.soul_steal(valdimar) #=> [#<Wizard:0x000055d782470810 @name="Valdimar", @hitpoints=200>]

p gandolf.souls[0].fireball #=> "casts fireball for 500 damage!"
# ========================================================================
```