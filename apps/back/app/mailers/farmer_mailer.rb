class FarmerMailer < ApplicationMailer
  def welcome
    @farmer = params[:farmer]

    mail(to: "#{@farmer.full_name} <#{@farmer.user.email}>", subject: '🌻 Bienvenue chez AgriVillage ! Dépêchez-vous de déposer votre annonce à la ferme🌻') do |format|
      format.text
      format.mjml
    end
  end

  def offer_deposit
    @farmer = params[:farmer]
    @offer = params[:offer]

    mail(to: "#{@farmer.full_name} <#{@farmer.user.email}>", subject: '🤠 Bravo ! Vous venez de déposer une annonce à la ferme  ! 🤠') do |format|
      format.text
      format.mjml
    end
  end

  def offer_available
    @farmer = params[:farmer]
    @offer = params[:offer]

    mail(to: "#{@farmer.full_name} <#{@farmer.user.email}>", subject: ' Félicitations votre annonce est publiée !') do |format|
      format.text
      format.mjml
    end
  end
end
