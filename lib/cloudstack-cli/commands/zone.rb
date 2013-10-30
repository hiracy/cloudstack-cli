class Zone < CloudstackCli::Base

  desc "zone list", "list zones"
  def list
    zones = client.list_zones
    if zones.size < 1
      puts "No projects found"
    else
      table = [["Name", "Description"]]
      zones.each do |zone|
        table << [zone['name'] ,zone['description']]
      end
    end
    print_table(table)
  end

end