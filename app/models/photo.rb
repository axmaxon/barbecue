class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :photo, presence: true

  # Добавляем uploader, чтобы заработал carrierwave
  mount_uploader :photo, PhotoUploader

  # Scope нужен, чтобы отделить реальные фотки от болванки,
  # которую мы прописали в контроллере событий
  scope :persisted, -> { where.not(id: nil) }
end
