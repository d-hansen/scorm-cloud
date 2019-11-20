module ScormCloud
	class RegistrationService < BaseService

		not_implemented :reset_global_objectives, :test_registration_post_url

		def create_registration(course_id, reg_id, first_name, last_name, learner_id, options = {})
			xml = connection.call("rustici.registration.createRegistration",
                                              options.merge({:courseid => course_id, :regid => reg_id,
				                             :fname => first_name, :lname => last_name,
				                             :learnerid => learner_id}))
			!xml.elements["/rsp/success"].nil?
		end

		def delete_registration(reg_id)
			xml = connection.call("rustici.registration.deleteRegistration", {:regid => reg_id})
			!xml.elements["/rsp/success"].nil?
		end

		def reset_registration(reg_id)
			xml = connection.call("rustici.registration.resetRegistration", {:regid => reg_id })
			!xml.elements["/rsp/success"].nil?
		end

 		def get_registration_list(options = {})
			xml = connection.call("rustici.registration.getRegistrationList", options)
			xml.elements["/rsp/registrationlist"].map { |e| Registration.from_xml(e) }
		end

		def get_registration_detail(reg_id, options = {})
			xml = connection.call("rustici.registration.getRegistrationDetail",
			                      options.merge({:regid => reg_id}))
                        xml.elements["/rsp/registration"]
		end

		def get_registration_result(reg_id, format = "course", options = {})
			raise "Illegal format argument: #{format}" unless ["course","activity","full"].include?(format)
			connection.call("rustici.registration.getRegistrationResult",
			                options.merge({:regid => reg_id, :resultsformat => format}))
		end

		def get_registration_list_results(options = {})
                        format = options[:resultsformat]
			raise "Illegal format argument: #{format}" if format && !["course","activity","full"].include?(format)
			connection.call("rustici.registration.getRegistrationListResults", options)
		end

		def launch(reg_id, redirect_url = 'message', options = {})
			raise "Missing registration ID" if reg_id.nil?
			raise "Invalid Redirect URL" unless ['closer','blank','message'].include?(redirect_url) || \
                              redirect_url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
			connection.launch_url("rustici.registration.launch",
			                      options.merge({:regid => reg_id, :redirecturl => redirect_url }))
		end

		def get_launch_history(reg_id, options = {})
			connection.call("rustici.registration.getLaunchHistory", options.merge({:regid => reg_id}))
		end

		def get_launch_info(launch_id, options = {})
			connection.call("rustici.registration.getLaunchInfo", options.merge({:launchid => launch_id}))
		end

		def update_learner_info(learner_id, fname, lname, options = {})
			xml = connection.call("rustici.registration.updateLearnerInfo",
                                        options.merge({:learnerid => learner_id, :fname => fname, :lname => lname}))
			!xml.elements["/rsp/success"].nil?
		end
	end
end
