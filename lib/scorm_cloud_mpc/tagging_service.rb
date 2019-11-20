module ScormCloud
	class TaggingService < BaseService
		not_implemented :get_course_tags, :set_course_tags, :add_course_tag,
				:remove_course_tag, :get_registration_tags, :set_registration_tags,
				:add_registration_tag, :remove_registration_tag

		def get_learner_tags(learner_id)
			xml = connection.call("rustici.tagging.getLearnerTags", {:learnerid => learner_id})
                        tags = []
                        xml.elements["/rsp/tags"].elements.each('tag') { |tag| tags << tag.text }
                        tags
		end

		def set_learner_tags(learner_id, tags)
			xml = connection.call("rustici.tagging.setLearnerTags", {:regid => reg_id, :tags => tags})
			!xml.elements["/rsp/success"].nil?
		end

		def add_learner_tag(learner_id, tag)
			xml = connection.call("rustici.tagging.addLearnerTag", {:regid => reg_id, :tag => tag})
			!xml.elements["/rsp/success"].nil?
		end

		def remove_learner_tag(learner_id, tag)
			xml = connection.call("rustici.tagging.removeLearnerTag", {:regid => reg_id, :tag => tag})
			!xml.elements["/rsp/success"].nil?
		end
	end
end

