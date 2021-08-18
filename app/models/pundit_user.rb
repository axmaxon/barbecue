# Класс для расширения контекста используемого для авторизации (понадобились cookies для
# доступа в события с пин-кодом).
class PunditUser
  attr_reader :user, :cookies

  def initialize(user, cookies)
    @user = user
    @cookies = cookies
  end
end
