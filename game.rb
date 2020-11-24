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
    super_admin_control if user_data[:role] == 'SuperAdmin'
    admin_control if user_data[:role] == 'Admin'
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
      when 'change'
        @pet.name = gets.chomp
      when 'kill'
        @pet.health = 0
      when 'change_name'
        @pet.name = gets.chomp
      when 'change_health'
        @pet.health = gets.chomp
      when 'change_happiness'
        @pet.happiness = gets.chomp
      when 'change_fullness'
        @pet.fullness = gets.chomp
      when 'change_activity'
        @pet.activity = gets.chomp
      when 'reset'
        @pet.reset_data
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

  def admin_control
    puts "\nAdmin panel:
      To change pet name enter `change`
      Than enter new name"
  end

  def super_admin_control
    puts "\nSuperAdmin panel:
      To change pet name enter `change_name`
      Than enter new name\n
      To change pet health enter `change_health`
      Than enter new health\n
      To change pet happiness enter `change_happiness`
      Than enter new happiness\n
      To change pet fullness enter `change_fullness`
      Than enter new fullness\n
      To change pet activity enter `change_activity`
      Than enter new activity\n
      To reset pet stat enter `reset`\n
      To kill pet enter `kill`
      Than enter new activity\n
      "
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
