class Post < ActiveRecord::Base
  attr_accessible :body, :end_date, :start_date, :title, :user_id
end
