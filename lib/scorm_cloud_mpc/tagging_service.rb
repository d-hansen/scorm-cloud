module ScormCloud
	class TaggingService < BaseService

		def get_course_tags(course_id)
			xml = connection.call("rustici.tagging.getCourseTags", {:courseid => course_id})
                        tags = []
                        xml.elements["/rsp/tags"].elements.each('tag') { |tag| tags << tag.text }
                        tags
		end

		def set_course_tags(course_id, tags)
			xml = connection.call("rustici.tagging.setCourseTags", {:courseid => course_id, :tags => tags})
			!xml.elements["/rsp/success"].nil?
		end

		def add_course_tag(course_id, tag)
			xml = connection.call("rustici.tagging.addCourseTag", {:courseid => course_id, :tag => tag})
			!xml.elements["/rsp/success"].nil?
		end

		def remove_course_tag(course_id, tag)
			xml = connection.call("rustici.tagging.removeCourseTag", {:courseid => course_id, :tag => tag})
			!xml.elements["/rsp/success"].nil?
		end

		def get_learner_tags(learner_id)
			xml = connection.call("rustici.tagging.getLearnerTags", {:learnerid => learner_id})
                        tags = []
                        xml.elements["/rsp/tags"].elements.each('tag') { |tag| tags << tag.text }
                        tags
		end

		def set_learner_tags(learner_id, tags)
			xml = connection.call("rustici.tagging.setLearnerTags", {:learnerid => learner_id, :tags => tags})
			!xml.elements["/rsp/success"].nil?
		end

		def add_learner_tag(learner_id, tag)
			xml = connection.call("rustici.tagging.addLearnerTag", {:learnerid => learner_id, :tag => tag})
			!xml.elements["/rsp/success"].nil?
		end

		def remove_learner_tag(learner_id, tag)
			xml = connection.call("rustici.tagging.removeLearnerTag", {:learnerid => learner_id, :tag => tag})
			!xml.elements["/rsp/success"].nil?
		end

		def get_registration_tags(reg_id)
			xml = connection.call("rustici.tagging.getRegistrationTags", {:regid => reg_id})
                        tags = []
                        xml.elements["/rsp/tags"].elements.each('tag') { |tag| tags << tag.text }
                        tags
		end

		def set_registration_tags(reg_id, tags)
			xml = connection.call("rustici.tagging.setRegistrationTags", {:regid => reg_id, :tags => tags})
			!xml.elements["/rsp/success"].nil?
		end

		def add_registration_tag(reg_id, tag)
			xml = connection.call("rustici.tagging.addRegistrationTag", {:regid => reg_id, :tag => tag})
			!xml.elements["/rsp/success"].nil?
		end

		def remove_registration_tag(reg_id, tag)
			xml = connection.call("rustici.tagging.removeRegistrationTag", {:regid => reg_id, :tag => tag})
			!xml.elements["/rsp/success"].nil?
		end
	end
end

