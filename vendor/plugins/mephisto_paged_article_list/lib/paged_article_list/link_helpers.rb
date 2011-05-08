module PagedArticleList  

  # these are registered as liquid template filters
  module LinkHelpers
    include ActionView::Helpers::TagHelper
  
    def prev_next_section_page_links(section, pages, sep = nil)      
      links = [['prev', 'newer posts &raquo;'], ['next', '&laquo; older posts']].inject([]) do |links, c|
        dir, text = *c
        link = eval("link_to_#{dir}_section_page(section, pages, text)") 
        links << link unless link.nil?
        links
      end
      links.insert(1, sep) unless links.size < 2 || sep.nil?
      links.reverse.join ' '      
    end
  
    def link_to_prev_section_page(section, pages, text = 'previous')
      return if pages[:current] == 1
      link_for_page(section, pages[:current] - 1, pages[:tags], text, 'prev')
    end

    def link_to_next_section_page(section, pages, text = 'next')
      return if pages[:current] == pages[:count]
      link_for_page(section, pages[:current] + 1, pages[:tags], text, 'next') 
    end
    
    def link_for_page(section, page, tags, text, css_class)
      path = section.nil? ? '' : section[:path]
      content_tag :a, text, :href => path_for(path, page, tags), :class => css_class
    end                             
    
    def path_for(section_path, page, tags = nil)      
      path = []
      path <<  section_path  unless section_path.blank?
      path << 'tags' << tags unless tags.blank?
      path << 'page' << page unless page == 1
      '/' + path.join('/')
    end
  end
end