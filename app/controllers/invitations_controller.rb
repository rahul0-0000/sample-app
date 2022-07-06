class InvitationsController < Devise::InvitationsController
  respond_to :json
  def update
    User.accept_invitation!(
      invitation_token: params[:invitation_token], 
      password: params[:password]
    )
    render :json => { :message => "User Invitation Accepted" }
  end
end
