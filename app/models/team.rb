class Team < ActiveRecord::Base

  has_and_belongs_to_many :users

  belongs_to :admin, :class_name => 'User'


  has_many :meetings

end