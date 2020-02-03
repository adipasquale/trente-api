class AdminMailer < ApplicationMailer
  default from: 'adrien@outofscreen.com'
  default to: "adrien@dipasquale.fr"

  def new_guest
    @guest = params[:guest]

    mail subject: '30 ans - nouvelle inscription'
  end

  def guest_cancelled
    @guest = params[:guest]

    mail subject: '30 ans - désinscription'
  end
end
