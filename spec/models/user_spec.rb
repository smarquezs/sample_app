require 'spec_helper'

describe User do

  before { @user = User.new(name: "Example User", email: "user@example.com", password: 'foobar', password_confirmation: 'foobar') }
  subject { @user }
  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :authenticate }
  it { should respond_to :remember_token }

  describe "When name is not present" do
  	before { @user.name = ''}
  	it { should_not be_valid }
  end

  describe "When email is not present" do
  	before { @user.name = ''}
  	it { should_not be_valid }
  end

  describe "When add user with an existing email" do
  	before do
  		user_duplicate = @user.dup
  		user_duplicate.email = @user.email.upcase	
  		user_duplicate.save
  	end
  	it { should_not be_valid }
  end

  describe "When de name is too long" do
    before { @user.name = 'a' * 51}
    it { should_not be_valid }
  end

  describe "When email format is invalid" do
    it "Shoud be invalid" do
    	email_address =  %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
    	email_address.each do |email|
    		@user.email = email
    		expect(@user).to be_invalid
    	end
    end
  end

  describe "When email format is valid" do
  	it "does something" do
  		 email_address = %w[SERGIO@gmail.com smarquezs@gmail.com lilox.diego@gmail.com dpvasquezi@gmail.com]
  		 email_address.each do |email|
  		 	@user.email = email
  		 	expect(@user).to be_valid
  		 end
  	end
  end

  describe "when password is not present" do
	  before do
	    @user = User.new(name: "Example User", email: "user@example.com",
	                     password: " ", password_confirmation: " ")
	  end
	  it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
	  before { @user.password_confirmation = "mismatch" }
	  it { should_not be_valid }
	end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all down-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank  }

    # its(:remember_token) { should_not be_blank  }    
    # it equivalent to
    # it { expect(@user.remember_token).not_to be_blank }
  end

end
