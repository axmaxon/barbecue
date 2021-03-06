Веб-приложение "Barbecue" 
===

Приложение для организации совместного отдыха с друзьями, или любых иных мероприятий, для 
которых возможно определить место и время. 

Каждый участник системы может создавать событие - открытое или приватное. С указанием
адреса и времени его начала. Каждый участник может присоединиться к открытому событию, и , 
при наличии у него пин-кода - к приватному.

Помимо этого пользователю доступны:
- точка сбора (по aдресу события) отображается на карте;
- добавление аватара в личный профиль;
- добавление фотографий и комментариев к событиям; 
- получение информации по электронной почте об обновлении событий (комментарии, фотографии,
подписки);

## Технологии:

- `Ruby 2.7.2`
- `Ruby on Rails 6.1.3`
- `Webpacker 5.3.0`, `Bootstrap 4.6.0` 
- Аутентификация, авторизация: `Devise`, `Pundit`
- Отправка писем и уведомлений: `Mailjet`
- Файлы: `carrierwave`, `rmagic`, `Amazon web services S3`
- СУБД в продакшн-окружении: `PostgresQL`
- Локализация: `rails-I18n`
- Приложение [развернуто](https://bbq-tomorrow.ru) на vps (`Ubuntu 20.04`,
`nginx`,`Phusion Passenger`, через `Capistrano`)

### Для локального запуска:

1. Клонировать репозиторий:

```
$ git clone git@github.com:axmaxon/barbecue.git
```

2. Установить любым удобным способом `ruby 2.7.2`, если отсутствует
3. Установить необходимые гемы и зависимости:

```
$ bundle
```
4. В приложении используются сервисы, для которых следует получить ключи и указать
их и другие необходимые переменные в `Rails credentials`

**mailjet:**
- api_key
- secret_key
- sender

**yandex:**
- api_key

**aws:**
- s3_access_key_id 
- s3_secret_access_key 
- s3_bucket_name 

Для этого воспользоваться командой:

```
EDITOR='XXXX --wait' bin/rails credentials:edit
```
*где **XXXX** - удобный для вас редактор кода, например `vi` - для открытия
в Vim или `subl` для открытия в Sublime

5. Применить миграции:

```
$ bundle exec rails db:migrate
```

6. Запустить сервер:

```
$ bundle exec rails s
```

7. В адресной строке веб-браузера указать:

```
http://localhost:3000/
```
