class User < ApplicationRecord
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:site_admin], multiple: false)                                      ##
  ############################################################################################


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name

  def first_name
    self.name.split.first
  end

  def last_name
    self.name.split.last
  end
end


##example of when and why you would use a rescue block.  Getting info from a site API like facebook and for some reason their site might go down for 1 minute, but your site would give an error, but it would not be because of OUR site, but because of FACEBOOK's site.

#def get_facebook_messages
#  begin
#    contacts_fb
#    @messages = retrieves_messages
#  rescue => e
#    flash[:error] = "Error occured; contacting Facebook: #{e}"
#  end
#end

#there are still better ways to handle errors. For instance, there is no way to detect a syntax error using above set-up
