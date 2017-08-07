shared_examples "unauthorized action request" do |action|
  context "unauthorized #{action}" do
    log_out
    it "redirects to the 'login page' if user not authorized and flash alert" do
      request_exec
      expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
