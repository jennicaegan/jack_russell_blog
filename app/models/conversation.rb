# == Schema Information
# Schema version: 20110705203428
#
# Table name: conversations
#
#  id          :integer         not null, primary key
#  speaker_id  :integer
#  listener_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Conversation < ActiveRecord::Base
  attr_accessible :listener_id
  
  belongs_to :speaker,  :class_name => "Post"
  belongs_to :listener, :class_name => "Post"
  
  validates :speaker_id,  :presence => true
  validates :listener_id, :presence => true
end
