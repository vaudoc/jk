#require 'comment_email_observer'
require 'emailer/plugin'
ActiveRecord::Base.observers << :comment_email_observer
