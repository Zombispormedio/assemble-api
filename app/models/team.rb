class Team < ActiveRecord::Base

  has_many :memberships
  has_many :members, :through => :memberships

  belongs_to :admin, :class_name => 'User'

  has_many :meetings

  has_many :messages, :class_name => 'TeamMessage'

end