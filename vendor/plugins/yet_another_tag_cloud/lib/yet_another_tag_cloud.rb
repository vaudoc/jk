# !!vvv yes, I know it's kind of "dirty". But it'll have to do for now.
class ActiveRecord::Base
	def att
		@attributes
	end
end

module YetAnotherTagCloud

	def yatagcloud(tag, floor = 0.8, ceiling = 2, unit = "em")

		number = ActiveRecord::Base.count_by_sql(
		["SELECT COUNT(*) FROM taggings, 
			tags, contents WHERE 
			tags.name = ? AND taggings.tag_id = tags.id
			AND contents.id = taggings.taggable_id
			AND contents.type = 'Article'
			AND contents.published_at IS NOT NULL", tag])

		tagsc = ActiveRecord::Base.find_by_sql(
			"select count(*) as c from taggings, 
			tags, contents WHERE 
			taggings.tag_id = tags.id
			AND contents.id = taggings.taggable_id
			AND contents.type = 'Article'
			AND contents.published_at IS NOT NULL group by tags.name order by c")

		smallesttc = tagsc[0].att["c"].to_i
		largesttc = tagsc.last.att["c"].to_i

		steps = (largesttc - smallesttc).to_f
		mysize = steps == 0? floor : (number - smallesttc)/steps * (ceiling - floor) + floor

		size = sprintf("%0.2f", mysize)
		"<span style='font-size: #{size}#{unit}'><a title='#{tag} (#{number})' href='/tags/#{tag}'>#{tag_strip(tag)}</a></span>"

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
