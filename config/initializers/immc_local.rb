##########################################################################################
# Setup plugin mephisto_comment_email

# Load email configuration
require 'load_email_configuration'

# Configure notifier
CommentNotifier.mail_prefix = "[IMMC new comment]"
CommentNotifier.mail_from_name = "IMMC website"
