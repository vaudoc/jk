module MephistoImmc # :nodoc:

  module LiquidModels # :nodoc:

    def self.reloadable?; false end
  end
  
  module LiquidSectionDrop # :nodoc:

    # return a sorted array of tags for the section
    def tags(cat)
      # @source.articles.map{|article| article.tags}.flatten.uniq.sort {|x,y| x.name <=> y.name } 
      @source.tags(cat)
    end
  end
  
  module LiquidFilters # :nodoc:

    # return sorted array of tags by importance
    def weight_tags(tags, max = 20)
      
      tagsweight = []
      tags.each do |tag|
        
        tagsweight << [ tag,
          @context['site'].source.articles.find(:all, :include => :tags, 
            :conditions => ['tags.name = (?)', tag], 
            :order => 'contents.created_at desc').size]
      end
      # (1) sort by weight, (2) choose first max, (3) sort by name
      tagsweight.sort{|x,y| x[1] <=> y[1] }.reverse[0..[tagsweight.size, max-1].min].sort{|x,y| x[0] <=> y[0] }
    end
  
    # return a sorted array of tags for the section - select by regular exp, e.g. /Projekt:/ 
    def section_tags(section, cat = nil)

      taglist = section.articles.map{|article| article.tags}.flatten.uniq.sort
      
      if cat != nil
        re = Regexp.new(cat)
        returnlist = []
        taglist.each do |tag|
           if tag =~ re
             returnlist << tag
           end
        end
      else
        returnlist = taglist
      end
      returnlist
    end

    # return a string to the tag in a section
    def section_tag_url(tag)
      "/tags/#{tag}"
    end

    # strip off leading tag categorizations such as "Projekt", "Branche", etc.
    def tag_strip(tag)
      if tag =~ /:/
        return $'
      else
        return tag
      end 
    end

  end
  
  module Section # :nodoc:

    # return a sorted array of tags for the section - select by regular exp, e.g. /Projekt:/ 
    def tags(cat = nil)

      taglist = articles.map{|article| article.tags}.flatten.uniq.sort {|x,y| x.name <=> y.name } 

      if cat != nil
        returnlist = []
        taglist.each do |tag|
           if tag.name =~ cat
             returnlist << tag
           end
        end
      else
        returnlist = taglist
      end
      returnlist
    end
    
  end
end