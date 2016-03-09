class Weakness < ActiveRecord::Base
	has_and_belongs_to_many :exercises
	has_and_belongs_to_many :users
end
