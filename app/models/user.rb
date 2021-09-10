class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :omniauthable, omniauth_providers: [:facebook]

  # Смонтируем загрузчик (указываем подответственное поле таблицы и класс загрузчика )
  mount_uploader :avatar, AvatarUploader

  has_many :events
  has_many :comments, dependent: :destroy
  has_many :subscriptions

  validates :name, presence: true, length: { maximum: 35 }

  after_commit :link_subscriptions, on: :create

  def self.find_for_provider_oauth(access_token)

    email = access_token.info.email

    # Ищем юзера по емэйлу, который достали из токена
    user = where(email: email).first

    # Возвращаем, если нашёлся
    return user if user.present?

    # Если не нашёлся, достаём провайдера и id, монтируем url
    provider = access_token.provider
    id = access_token.extra.raw_info.id

    case provider
    when 'facebook'
      url = "https://facebook.com/#{id}"
    when 'vkontakte'
      url = "https://vk.com/id#{id}"
    end

    # Теперь ищем в базе запись по провайдеру и урлу
    # Если есть, то вернётся, если нет, то будет создана новая
    where(url: url, provider: provider).first_or_create! do |user|

      # Если создаём новую запись, прописываем имя, email, пароль
      user.name = access_token.info.name
      user.email = email
      user.password = Devise.friendly_token.first(16)
    end
  end

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email)
                .update_all(user_id: id)
  end
end
