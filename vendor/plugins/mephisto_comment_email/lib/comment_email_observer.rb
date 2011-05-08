require 'comment_notifier'
require 'thread'

class CommentEmailObserver < ActiveRecord::Observer 
  observe Comment

  def after_save( comment )

    Thread.new( comment ) do |cmt|
      CommentNotifier::deliver_comment_added( cmt )
    end
  rescue
    # ignore?, comment notification shouldn't crash the blog
  end
end
