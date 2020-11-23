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
    find = data.select { |hash| hash[:login] == @login }
    find[0][:pet_data] = pet_data
    data << find
    File.open('db/users.yml', 'w') { |f| YAML.dump(data, f) }
  end

  private

  def admin?
    @login == 'admin' && @password == 'admin'
  end

  def super_admin?
    @login == 'superadmin' && @password == 'superadmin'
  end
end
