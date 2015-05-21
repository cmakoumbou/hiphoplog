class SongContent
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  SOUNDCLOUD_CLIENT_ID = "c26a11a448231c63650b5319453f2285"

  recurrence { daily.hour_of_day(20) }

  def perform
    puts 'Load Song Content'
    client = Soundcloud.new(:client_id => SOUNDCLOUD_CLIENT_ID)
		Channel.where(provider: "soundcloud").each do |chan|
			chan.store_channel_song(client)
		end
		puts 'Finished loading Song Content'
  end
end