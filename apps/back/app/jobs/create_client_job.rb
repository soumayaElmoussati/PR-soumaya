class CreateClientJob < ApplicationJob
  queue_as :default

  def perform(client)

    puts "Calling Mailchimp API for #{client.user.email}"

    if Rails.env != "development"

      Gibbon::Request.new(api_key: "d158c8f7d0d548603670c8d45421d5b6-us20")
      .lists("0dda707543")
      .members
      .create(body: {
        email_address: client.user.email,
        status: "subscribed",
        merge_fields: {
          FNAME: client.user.first_name,
          LNAME: client.user.last_name,
          TCLIENT: client.user.cellphone
        }
      })

      Gibbon::Request.new(api_key: "d158c8f7d0d548603670c8d45421d5b6-us20")
      .lists("0dda707543")
      .members(Digest::MD5.hexdigest(client.user.email))
      .tags
      .create(
        body: {
          tags: [{name:"Compte agrivillage", status:"active"}]
        }
      )
    end

    sleep 2

    puts "Done ! Client subscribed to list"

  end
end
