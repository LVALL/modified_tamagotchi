require_relative 'user'
require_relative 'admin'
require_relative 'super_admin'

class Session

  def initialize(login, password)
    @login = login
    @password = password
  end

  def create_session
    if admin?
      Admin.new(@login, @password).log_in
    elsif super_admin?
      SuperAdmin.new(@login, @password).log_in
    else
      User.new(@login, @password).log_in
    end
  end

  def save_pet_data(pet_data)
    data = YAML.load_file 'db/users.yml'
    user = data.detect { |hash| hash[:login] == @login }
    user[:pet_data] = pet_data
    data << user
    File.open('db/users.yml', 'w') { |file| file.write(data.to_yaml) }
  end

  private

  def admin?
    @login == 'admin' && @password == 'admin'
  end

  def super_admin?
    @login == 'superadmin' && @password == 'superadmin'
  end
end
