# uncomment this to have the plugin reloaded for development/debugging
Dependencies.load_once_paths.pop 

# prev_next_section_pages_links liquid filter (see README for usage)
Liquid::Template.register_filter(PagedArticleList::LinkHelpers)
ActionView::Base.send :include, PagedArticleList::LinkHelpers

config.to_prepare do
  MephistoController.send :include, PagedArticleList::MephistoController
end

