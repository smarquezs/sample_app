FactoryGirl.define do
	factory :user do
		name 'Foo Bar'
		email 'foobar@baz.cl'
		password 'foobar'
		password_confirmation 'foobar'
	end
end