class VideoContent
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily.hour_of_day(20) }

  def perform
    puts 'Load Video Content'
    Channel.where(provider: "youtube").each do |chan|
			chan.store_channel_video
		end
		puts 'Finished loading Video Content'
  end
end