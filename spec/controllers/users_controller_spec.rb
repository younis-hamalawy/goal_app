require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  subject(:user) { User.create(username: "Adam", password: "password") }

  describe "GET #new" do
    it "renders the new user page" do
      get :new
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid information" do
      it "creates a new user" do
        post :create, params: { user: { username: "Tom", password: "password" } }
        expect(response).to redirect_to(user_url(User.find_by_username("Tom")))
        expect(response).to have_http_status(:redirect)
      end
    end

    context "with no password" do
      it "should stay on the new user page and show error" do
        post :create, params: { user: { username: "Tom", password: "" } }
        expect(response).to render_template("new")
        expect(response).to have_http_status(422)
        # expect(page).to have_content("Password can't be blank")
      end
    end

    context "with no username" do
      it "should stay on the new user page and show error" do
        post :create, params: { user: { username: "", password: "password" } }
        expect(response).to render_template("new")
        expect(response).to have_http_status(422)
        # expect(page).to have_content("Username can't be blank")
      end
    end
  end

  describe "GET #edit" do
    it "renders the edit page" do
      get :edit, params: { id: user.id }
      expect(response).to render_template("edit")
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH #update" do
    context "with valid information" do
      it "updates the users information" do
        patch :update, params: { id: user.id, user: { username: "Tom", password: "password" } }
        expect(response).to redirect_to(user_url(User.find(user.id)))
        expect(response).to have_http_status(:redirect)
      end
    end

    context "with invalid information" do
      it "stays on edit page and shows error" do
        patch :update, params: { id: user.id, user: { username: "Tom", password: "" } }
        expect(response).to render_template("edit")
        expect(response).to have_http_status(422)
        # expect(page).to have_content("Password can't be blank")
      end
    end
  end

  # describe "GET #index" do
  #   it "renders the user index page"
  # end

  describe "GET #show" do
    it "renders the user page" do
      get :show, params: { id: user.id }
      expect(response).to render_template("show")
      expect(response).to have_http_status(200)
      # expect(page).to have_content(user.username)
    end
  end

  # describe "DELETE #destroy" do
  #   it "deletes the user"
  # end

end
