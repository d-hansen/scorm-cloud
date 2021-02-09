module ScormCloud
	class CourseService < BaseService

		not_implemented :import_cours_async, :get_async_import_result, :properties, :delete_files

		# TODO: Handle Warnings
		def import_course(course_id, path)
			xml = connection.call("rustici.course.importCourse", :courseid => course_id, :path => path)
			if xml.elements['//rsp/importresult'].attributes["successful"] == "true"
				title = xml.elements['//rsp/importresult/title'].text	
				{ :title => title, :warnings => [] }
			else
				nil
			end
		end

		def exists(course_id)
			connection.call_raw("rustici.course.exists", :courseid => course_id).include?("<result>true</result>")
		end

		def get_attributes(course_id, version_id = nil)
		 	options = {:courseid => course_id}
		 	options[:versionid] = version_id unless version_id.nil?
			xml = connection.call("rustici.course.getAttributes", options)
			xml_to_attributes(xml)
		end

		def delete_course(course_id)
			connection.call("rustici.course.deleteCourse", :courseid => course_id)
			true
		end

		def get_manifest(course_id, version_id = nil)
		 	options = {:courseid => course_id}
		 	options[:versionid] = version_id unless version_id.nil?
		 	connection.call_raw("rustici.course.getManifest", options)
		end

		def get_course_list(options = {})
			xml = connection.call("rustici.course.getCourseList", options)
			xml.elements["//rsp/courselist"].map { |e| Course.from_xml(e) }
		end

		def get_course_detail(course_id)
		 	xml = connection.call("rustici.course.getCourseDetail", :courseid => course_id)
			xml.elements["//rsp/course"]
		end

		def preview(course_id, redirect_url)
			connection.launch_url("rustici.course.preview", :courseid => course_id, :redirecturl => redirect_url)
		end

		def update_attributes(course_id, attributes)
			xml = connection.call("rustici.course.updateAttributes", attributes.merge({:courseid => course_id}))
			xml_to_attributes(xml)
		end

		def get_assets(course_id, path = nil, options = {})
			CourseService.validate_options(options, [:versionid])
			params = options.merge({:courseid => course_id})
			params[:path] = path unless path.nil?
			connection.call_raw("rustici.course.getAssets", params)
		end

		def update_assets(course_id, path = nil, options = {})
			CourseService.validate_options(options, [:versionid])
			xml = connection.post("rustici.course.updateAssets", path, options.merge({:courseid => course_id}))
			xml.elements['//rsp/success']
		end

                def delete_files(course_id, paths, options = {})
			CourseService.validate_options(options, [:versionid])
			params = options.merge({:courseid => course_id})
			params[:path] = paths
			xml = connection.call("rustici.course.deleteFiles", params)
			xml.elements["//rsp/results"]
                end

		def get_file_structure(course_id, options = {})
			CourseService.validate_options(options, [:versionid])
			xml = connection.call("rustici.course.getFileStructure", options.merge({:courseid => course_id}))
			xml.elements["//rsp/dir"]
		end

		def get_metadata(course_id, options = {})
			CourseService.validate_options(options, [:scope, :mdformat])
			CourseService.validate_option_value(options, :scope, ['course', 'activity'])
			CourseService.validate_option_value(options, :mdformat, ['summary', 'detail'])
			xml = connection.call("rustici.course.getMetadata", options.merge({:courseid => course_id}))
			xml.elements["//rsp/package"]
		end

	private
		def self.validate_options(options, keys)
			options.each_key do |key|
				raise ArgumentError.new("Illegal argument: #{key}") unless keys.include?(key)
			end
		end
		def self.validate_option_value(options_hash, option_key, allowed_values)
			value = options_hash[option_key]
			raise ArgumentError.new("Illegal #{option_key} argument: #{value}") if value && !allowed_values.include?(value)
		end
	end
end

