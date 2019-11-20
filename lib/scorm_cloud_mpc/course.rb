module ScormCloud
	class Course < ScormCloud::BaseObject

		attr_accessor :id, :versions, :registrations, :title, :size, :tags

		def self.from_xml(element)
			c = Course.new
			c.set_attributes(element.attributes)
                        c.tags = []
                        tags_elem = element.elements['tags']
                        tags_elem.elements.each('tag') { |tag| c.tags << tag.text }
			c
		end

	end
end
