module CloudstackClient

	module Volume

		##
    # Lists all volumes.

    def list_volumes(project_id = nil)
      params = {
          'command' => 'listVolumes',
          'listall' => true,
      }
      params['projectid'] = project_id if project_id
      json = send_request(params)
      json['volume'] || []
    end

	end

end