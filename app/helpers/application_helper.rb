module ApplicationHelper
  RECAPTCHA_V3_API_KEY = Rails.application.credentials.google_recaptcha[:api_key]

  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-success'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def bootstrap_flash(_opts = {})
    flash.each do |msg_type, message|
      concat(tag.div(message, class: "alert #{bootstrap_class_for(msg_type)}", role: 'alert') do
        concat tag.button('×', class: 'close', data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  # Возвращает путь к аватарке данного юзера
  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_pack_path('media/images/user1.png')
    end
  end

  # Возвращает адрес рандомной фотки события, если есть хотя бы одна
  # Или ссылку на картинку по умолчанию
  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_pack_path('media/images/bbq_boat.jpg')
    end
  end

  # Возвращает миниатюрную версию фотки
  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path('event_thumb.jpg')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_pack_path('media/images/user1.png')
    end
  end

  def fa_icon(icon_class)
    tag.span('', class: "fa fa-#{icon_class}")
  end

  def include_recaptcha_js
    raw %Q{ <script src="https://www.google.com/recaptcha/api.js?render=#{RECAPTCHA_V3_API_KEY}"></script> }
  end

  def recaptcha_execute(action)
    id = "recaptcha_token_#{SecureRandom.hex(10)}"

    raw %Q{
      <input name="recaptcha_token" type="hidden" id="#{id}"/>
      <script>
        grecaptcha.ready(function() {
          grecaptcha.execute('#{RECAPTCHA_V3_API_KEY}', {action: '#{action}'}).then(function(token) {
            document.getElementById("#{id}").value = token;
          });
        });
      </script>
    }
  end
end
