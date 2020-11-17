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
    @happiness.between?(0, 90) ? @happiness += rand(5..10) : @happiness = 100
    @smile = '🐾🏀'
    decrease_stat
    time_passed
  end

  def feed
    @reaction = 'OmNomNom, so tasty'
    @fullness.between?(0, 90) ? @fullness += rand(5..10) : @fullness = 100
    @smile = '🍲'
    increase_stat
    time_passed
  end

  def sleep
    @reaction = "SnoooZe 💤💤💤💤💤... #{@name} wakes up and yawned"
    @fullness > 10 ? @fullness -= rand(5..10) : @fullness = 0
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
    @fullness > 20 ? @fullness -= rand(10..20) : @fullness = 0
    @activity > 20 ? @activity -= rand(10..20) : @activity = 0
    @health > 20 ? @health -= rand(10..20) : @health = 0
  end

  def increase_stat
    @activity.between?(0, 90) ? @activity += rand(5..10) : @activity = 100
    @happiness.between?(0, 90) ? @happiness += rand(5..10) : @happiness = 100
    @health.between?(0, 90) ? @health += rand(5..10) : @health = 100
  end

  def time_passed
    @reaction = 'Felt badly, visit a doctor' unless healthy?
    @reaction = 'Your pet poops on the floor' if wants_to_poop?
    @reaction = 'Pet wants to sleep!' if wants_to_sleep?
    @reaction = "#{@name.capitalize} was died 💔" if died?
    @smile = '💀' if died?
  end
end
