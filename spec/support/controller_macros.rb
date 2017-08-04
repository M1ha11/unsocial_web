module ControllerMacros
  # def login_admin
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:admin]
  #     sign_in FactoryGirl.create(:user, :admin)
  #   end
  #   let(:current_user) { subject.current_user }
  # end

  def login_user(factory_name = :user, *params)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(factory_name, *params)
    end
    let(:current_user) { subject.current_user }
  end

  def log_out
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_out current_user
    end
    let(:current_user) { subject.current_user || FactoryGirl.create(:user) }
  end
end
