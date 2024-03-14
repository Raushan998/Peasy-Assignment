require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "assigns @users and @daily_record" do
      user = create(:user)
      daily_record = create(:daily_record)

      get :index

      expect(assigns(:users)).to eq([user])
      expect(assigns(:daily_record)).to eq(daily_record)
    end

    it "renders the index template with user and daily record data" do
      user = create(:user)
      create(:daily_record)

      get :index

      expect(response.body).to include(user.name)
    end
  end

  describe "DELETE #destroy" do
    let(:male_user) { create(:user, gender: 'male', age: 45) }

    it "deletes the user" do
      expect do
        delete :destroy, params: { id: male_user.id }
      end.to change(User, :count).by(0)
    end

    it "redirects to users index after deletion" do
      delete :destroy, params: { id: male_user.id }
      expect(response).to redirect_to(users_path)
    end
  end
end
