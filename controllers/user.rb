require 'yaml'
require_relative '../pet'

class User
  attr_accessor :login, :password, :role, :data

  def initialize(login, password, role = self.class.to_s, data = [])
    @login = login
    @password = password
    @role = role
    @data = data
  end

  def create
    { login: @login, password: @password, role: @role, pet_data: @data }
  end

  def log_in
    users = db_load
    user = create
    save(users, user) unless present?(@login)
    user
  end

  def save(users, user)
    users << user
    File.open('db/users.yml', 'w+') { |file| file.write(users.to_yaml) }
  end

  # def save_pet_data(pet_data)
  #   data = YAML.load_file 'db/users.yml'
  #   find = data.detect { |hash| hash[:login] == @login }
  #   find[:pet_data] = pet_data
  #
  #   data << find
  #   # data.delete(find)
  #   puts '000000000000000000000000000000000000000000000000000'
  #   # puts data
  #   puts data
  #   # File.open('db/users.yml', 'w') { |f| YAML.dump(data, f) }
  #   File.open('db/users.yml', 'w') { |file| file.write(data.to_yaml) }
  # end

  def db_load
    YAML.load(File.open('db/users.yml', 'r'))
  end

  def present?(login)
    db_load.any? { |u| u[:login] == login }
  end

  def valid_password?(login, password)
    db_load.any? { |u| u[:login] == login && user[:password] == password }
  end
end

# u = User.new('user', 'user')
# u.save_pet_data('dsds')
