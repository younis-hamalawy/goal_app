require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  # Association tests
  subject(:user) { User.create(username: "Adam", password: "password") }

  describe "session_token" do
    context "::generate_session_token" do
      it "should be 22 characters long" do
        expect(User::generate_session_token.length).to eq(22)
      end
    end

    context "#reset_session_token!" do
      it "should reset the users session token" do
        old_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).not_to eq(old_token)
      end
    end

    context "#ensure_session_token" do
      it "should set session token if not set" do
        user.session_token = nil
        user.ensure_session_token
        expect(user.session_token).not_to be_nil
      end

      it "should return same session token if set" do
        old_token = user.session_token
        user.ensure_session_token
        expect(user.session_token).to eq(old_token)
      end
    end
  end

  describe "password" do
    context "#password=" do
      it "set the password digest for the user" do
        old_password_digest = user.password_digest
        user.password = "otherpassword"
        expect(user.password_digest).not_to eq(old_password_digest)
      end
    end

    context "#is_password?" do
      it "should check the password matches the digest" do
        expect(user.is_password?("password")).to be true
        expect(user.is_password?("notpassword")).to be false
      end
    end
  end

  # describe "#find_by_credentials" do
  #   context "with valid credentials" do
  #     it "should return the user" do
  #       expect(User.find_by_credentials("Adam", "password")).to eq(user)
  #     end
  #   end
  #
  #   context "with invalid credentials" do
  #     it "should return nil" do
  #       expect(User.find_by_credentials("Adam", "notpassword")).to be_nil
  #       expect(User.find_by_credentials("not_Adam", "password")).to be_nil
  #     end
  #   end
  # end
end
