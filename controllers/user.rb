require 'yaml'

class User
  attr_accessor :login, :password, :role, :data

  def initialize(login, password, role = self.class.to_s, data = [])
    @login = login
    @password = password
    @role = role
    @data = data
  end

  def create
    { login: @login, password: @password, role: @role }
  end

  def log_in
    users = db_load
    user = create
    save(users, user) unless present?
    user
  end

  def save(users, user)
    users << user
    File.open('db/users.yml', 'w+') { |file| file.write(users.to_yaml) }
  end

  def db_load
    YAML.load(File.open('db/users.yml', 'r'))
  end

  def present?
    db_load.any? { |u| u[:login] == @login }
  end

  def valid_password?
    db_load.any? { |u| u[:login] == @login && user[:password] == @password }
  end
end
# u = User.new('valera', 'valera')
# puts u.log_in
