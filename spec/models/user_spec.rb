require 'rails_helper'

RSpec.describe User, type: :model do
	before { @user = User.new(name: "Evgeniy Azarov",
														email: "azarov91@mail.ru") }

	subject { @user }

	it { should respond_to(:name) } #respond_to принимает символ и возвращает true, если объект отвечает на данный метод, иначе false(проверяет в объекте наличие такой переменной)
	it { should respond_to(:email) }

	it { should be_valid } #проверка что объект @user изначально валиден

	describe "when name is not present" do
		before { @user.name = " " } #присваивает невалидное имя, затем проверяет что @user невалиден
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
										 foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@fb.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end

end