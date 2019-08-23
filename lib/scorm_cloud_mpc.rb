require 'rexml/document'
require 'digest/md5'
require 'net/http'
require 'net/http/post/multipart'
require 'uri'
require 'scorm_cloud_mpc/base'

require 'scorm_cloud_mpc/base_object'
require 'scorm_cloud_mpc/course'
require 'scorm_cloud_mpc/registration'

require 'scorm_cloud_mpc/base_service'
require 'scorm_cloud_mpc/debug_service'
require 'scorm_cloud_mpc/upload_service'
require 'scorm_cloud_mpc/course_service'
require 'scorm_cloud_mpc/registration_service'
require 'scorm_cloud_mpc/tagging_service'
require 'scorm_cloud_mpc/reporting_service'
require 'scorm_cloud_mpc/dispatch_service'
require 'scorm_cloud_mpc/export_service'

# Rails 3 Integration
require 'scorm_cloud_mpc/railtie' if defined?(Rails::Railtie)

module ScormCloud
	class ScormCloud < Base
		add_service :debug => DebugService
		add_service :upload => UploadService
		add_service :course => CourseService
		add_service :registration => RegistrationService
		add_service :tagging => TaggingService
		add_service :reporting => ReportingService
		add_service :dispatch => DispatchService
		add_service :export => ExportService
	end
end
