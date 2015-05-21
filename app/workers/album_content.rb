class AlbumContent
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  
  recurrence { daily.hour_of_day(20) }

  def perform
    puts 'Load Album Content'
    Channel.where(provider: "spotify").each do |chan|
			chan.store_channel_album
		end
		puts 'Finished loading Album Content'
  end
end