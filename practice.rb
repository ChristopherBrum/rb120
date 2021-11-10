# This exercise asks you to come up with a class design for a Role-playing Game.

# The application has information about every player. They all have a name, health, strength and intelligence.

# When each player is created, it gets:

# a health value of 100
# a random strength value (between 2 and 12, inclusive)
# a random intelligence value (between 2 and 12 inclusive)
# The random values are determined by a call to a #roll_dice method that cannot be accessed outside of the class.

# You can set and change the strength and intelligence in the constructors. However, once an object is constructed, the values may not change.

# Health can only be changed by the methods #heal and #hurt. Each method accepts one argument, the amount of change to the health. The #heal increases the health value by the indicated amount, while the #hurt decreases the value.

# A player can be a warrior, a paladin, a magician, or a bard.

# Warriors receive an additional 2 points of strength when they're created. The resulting strength range is thus between 4 and 14, inclusive.

# Magicians receive an additional 2 points of intelligence when they're created. The resulting intelligence range is thus between 4 and 14, inclusive.

# Warriors and paladins have the ability to wear armor. They need access to 2 additional methods: #attach_armor and #remove_armor.

# Paladins, magicians and bards can cast spells. They need access to a #cast_spell method, that accepts one argument, spell.

# Bards are a special type of magician that can also create potions. They have a #create_potion method.

# If you pass a player instance to #puts, it should print information about the player in this format:

# Copy Code
# Name: John
# Class: Warrior
# Health: 100
# Strength: 7
# Inteligence: 5
# Create a set of classes based on the description of the role-playing application. Your classes should show any inheritance relationships, module inclusions, and methods necessary to meet the requirements.

# This exercise is about designing class relationships, and how you organize your classes, behaviors, and state. Your methods should provide the details needed to fulfill the requirements. In some cases, you may be able to omit the method body entirely. Don't include any functionality that we don't describe above.

=begin

Player
-name
-health=100
-strength=(2-12) -> roll_dice
-intelligence(2-12) -> roll_dice
-roll_dice

=end
module ArmorWearable
  def attach_armor
    puts "I'm attaching my armor. I feel tough."
  end
  
  def remove_armor
    puts "I'm removing my armor. I'm scared."
  end
end

module SpellCastable
  def cast_spell(spell)
    puts "Adios muchachos, here comes my #{spell}!"
  end
end

class Player
  def initialize(name, str_bonus=0, int_bonus=0)
    @name = name
    @health = 100
    @strength = roll_dice(str_bonus)
    @inteligence = roll_dice(int_bonus)
  end
  
  def heal(amount)
    @health += amount
  end
  
  def hurt(amount)
    @health -= amount
  end
  
  def to_s
    puts "Name: #{name.capitalize}"
    puts "Class: #{self.class}"
    puts "Health: #{health}"
    puts "Strength: #{strength}"
    "Inteligence: #{inteligence}"
  end
    
  private
  
  attr_reader :name, :health, :strength, :inteligence
  
  def roll_dice(bonus=0)
    (2..12).to_a.sample + bonus
  end
end

class Warrior < Player
  include ArmorWearable
  
  def initialize(name)
    super(name, 2)
  end
end

class Magician < Player
  include SpellCastable
  
  def initialize(name)
    super(name, 0, 2)
  end
end

class Paladin < Player
  include ArmorWearable
  include SpellCastable
  
end

class Bard < Player
  include SpellCastable
  
  def create_potion
    puts "Huzzah, I've created a potion!"
  end
end

conan = Warrior.new('Conan')
conan.attach_armor
conan.remove_armor
# puts conan
# conan.heal(10)
# puts conan
# conan.hurt(25)
puts conan

gandolf = Magician.new('Gandolf')

marge = Paladin.new('Marge')

buelah = Bard.new('Beulah')