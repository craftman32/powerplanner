class VariationType < ActiveRecord::Base
	has_many :variations, dependent: :destroy
end
