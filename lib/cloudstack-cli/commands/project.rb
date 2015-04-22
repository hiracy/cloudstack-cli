class Project < CloudstackCli::Base

  desc "show NAME", "show detailed infos about a project"
  def show(name)
    unless project = client.list_projects(name: name, listall: true).first
      say "Error: No project with name '#{name}' found.", :red
    else
      table = project.map do |key, value|
        [ set_color("#{key}", :yellow), "#{value}" ]
      end
      print_table table
    end
  end

  desc "list", "list projects"
  def list
    projects = client.list_projects(listall: true)
    if projects.size < 1
      puts "No projects found."
    else
      table = [["Name", "Displaytext", "Domain"]]
      projects.each do |project|
        table << [project['name'], project['displaytext'], project['domain']]
      end
      print_table(table)
      say "Total number of projects: #{projects.count}"
    end
  end

  desc "list_accounts PROJECT_NAME", "show accounts belonging to a project"
  def list_accounts(name)
    unless project = client.list_projects(name: name, listall: true).first
      say "Error: No project with name '#{name}' found.", :red
    else
      accounts = client.list_project_accounts(project_id: project['id'])
      if accounts.size < 1
        say "No project accounts found."
      else
        table = [%w(Account-Name Account-Type Role Domain)]
        accounts.each do |account|
          table << [
            account['account'],
            Account::TYPES[account['accounttype']],
            account['role'],
            account['domain']
          ]
        end
        print_table table
        say "Total number of project accounts: #{accounts.size}"
      end
    end
  end

end
