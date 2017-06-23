require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  # Association tests

  describe "session_token" do
    context "#generate_seesion_token" do
      it "should be 16 characters long"
    end

    context "#reset_session_token!" do
      it "should reset the users session token"
    end

    context "#ensure_session_token" do
      it "should set session token if not set"
      it "should return same session token if set"
    end
  end

  describe "password" do
    it "doesn't store the plaintext password in the user"

    context "#password=" do
      it "set the password digest for the user"
    end

    context "#is_password?" do
      it "should check the password matches the digest"
    end
  end

  describe "#find_by_credentials" do
    context "with valid credentials" do
      it "should return the user"
    end

    context "with invalid credentials" do
      it "should return nil"
    end
  end
end
