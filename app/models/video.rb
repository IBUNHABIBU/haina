# app/models/video.rb
class Video < ApplicationRecord
  has_one_attached :video_file
  
  validates :title, presence: true
  validates :video_file, presence: true
  
  # Optional: Validate video file type and size
  validates :video_file, content_type: ['video/mp4', 'video/quicktime', 'video/x-msvideo', 'video/webm'],
                         size: { less_than: 500.megabytes, message: 'is too large (max 500MB)' }
end