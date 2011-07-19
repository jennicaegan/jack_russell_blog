class Comment < ActiveRecord::Base
  attr_accessible :content
  attr_readonly   :user_id
  
  belongs_to  :user
  
  belongs_to  :commentable, :polymorphic => true
  has_many    :comments,    :as => :commentable
  
  def post
    return @post if defined?(@post)
    @post = commentable.is_a?(Post) ? commentable : commentable.post
  end
end
