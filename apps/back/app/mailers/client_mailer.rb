class ClientMailer < ApplicationMailer
    def welcome
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: '😎 Bienvenue chez AgriVillage, de beaux séjours à la ferme vous attendent ! 😎') do |format|
        format.text
        format.mjml
      end
    end

  end
