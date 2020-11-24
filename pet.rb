class Pet
  attr_accessor :name, :health, :happiness, :fullness, :activity, :smile, :reaction

  def initialize(health = 100, happiness = 100, fullness = 100, activity = 100, name = 'nn', smile = '🐒', reaction = '')
    @health = health
    @happiness = happiness
    @fullness = fullness
    @activity = activity
    @name = name
    @smile = smile
    @reaction = reaction
  end

  def play
    @reaction = 'Funny!) that`s so funny'
    @happiness = change(@happiness, true)
    @smile = '🐾🏀'
    decrease_stat
    time_passed
  end

  def feed
    @reaction = 'OmNomNom, so tasty'
    @fullness = change(@fullness, true)
    @smile = '🍲'
    increase_stat
    time_passed
  end

  def sleep
    @reaction = "SnoooZe 💤💤💤💤💤... #{@name} wakes up and yawned"
    @fullness = change(@fullness, false)
    increase_stat
    time_passed
    @smile = '🙈💤'
  end

  def heal
    @health = 100
    @happiness = 100
    @reaction = "#{@name} happy and healthy again, so you can play with it"
    time_passed
    @smile = '🍼💊'
  end

  def watch
    time_passed
    @smile = '🕜'
  end

  def reset_data
    @health = 100
    @happiness = 100
    @fullness = 100
    @activity = 100
    @smile = '🐒'
  end

  private

  def hungry?
    @fullness < 30
  end

  def happy?
    @happiness > 60
  end

  def healthy?
    @health > 50
  end

  def died?
    @health == 0
  end

  def wants_to_sleep?
    @activity < 30
  end

  def angry?
    @fullness < 30 && @happiness < 40
  end

  def wants_to_poop?
    @fullness >= 90
  end

  def decrease_stat
    @fullness = change(@fullness, false)
    @activity = change(@activity, false)
    @health = change(@health, false)
  end

  def increase_stat
    @activity = change(@activity, true)
    @happiness = change(@happiness, true)
    @health = change(@health, true)
  end

  def change(param, increase)
    if increase
      param.between?(0, 90) ? param + rand(5..10) : 100
    else
      param > 10 ? param - rand(5..10) : 0
    end
  end

  def time_passed
    @reaction = 'Felt badly, visit a doctor' unless healthy?
    @reaction = 'Your pet poops on the floor' if wants_to_poop?
    @reaction = 'Pet wants to sleep!' if wants_to_sleep?
    @reaction = "#{@name.capitalize} was died 💔" if died?
    @smile = '💀' if died?
  end
end
