class ResetAllBookingCacheCounters < ActiveRecord::Migration[5.2]
  def up

    Client.all.each do |client|
      Client.reset_counters(client.id, :bookings)
    end

  end

  def down

     # no rollback needed

  end
end
