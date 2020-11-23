require_relative 'controllers/session'
require_relative 'pet'
require 'html_maker'

class Game
  def create_pet
    @pet = Pet.new
    puts 'Your pet was born'
    print 'Choose name for it: '
    @pet.name = gets.chomp.to_s
    puts "#{@pet.name.capitalize} likes this name! 💚"
    html
  end

  def login_user
    puts 'Please, enter your login:'
    login = gets.chomp
    puts 'Please, enter your password:'
    password = gets.chomp
    @user = Session.new(login, password)
    user_data = @user.create_session
    puts "Hello #{user_data[:role]}"
  end

  def start_game
    login_user
    create_pet
    help
    MakeHtml.new.open_in_browser

    while @pet.health != 0
      print "\nChoose command (to show info press `5`, than `Enter`): "
      decision = gets.chomp

      case decision
      when '1'
        @pet.play
        html
      when '2'
        @pet.feed
        html
      when '3'
        @pet.sleep
        html
      when '4'
        @pet.heal
        html
      when '5'
        help
      when '6'
        pet_data = pet_info
        @user.save_pet_data(pet_data)
        break
      when ''
        @pet.watch
        html
      else
        puts 'Wrong action'
      end
    end
  end

  def help
    puts "\nWhat would you like to do with #{@pet.name.capitalize}:
      1 - Play 🏀
      2 - Feed 🍪
      3 - Take it sleep 💤
      4 - Visit a doctor 🚑
      6 - Exit game
      Press `Enter` to do nothing"
  end

  private

  def pet_info
    data = [{ name: @pet.name.to_s,
              health: @pet.health.to_s,
              happiness: @pet.happiness.to_s,
              fullness: @pet.fullness.to_s,
              activity: @pet.activity.to_s }]
    data
  end

  def html(filename = 'index.html')
    content = "
    <div style='margin-left: 5em; font-size: xx-large'>
      <p>Health: #{@pet.health}</p>
      <p>Happiness: #{@pet.happiness}</p>
      <p>Fullness: #{@pet.fullness}</p>
      <p>Activity: #{@pet.activity}</p>
    </div>

    <div style='margin-left: 3em; font-size: 3.2em'>
      <p>#{@pet.reaction}</p>
    </div>

    <div style='margin-left: 2em; font-size: 5em'>
      <p>#{@pet.smile}</p>
    </div>"

    MakeHtml.new.make_html(content, true, filename)
  end
end

Game.new.start_game
