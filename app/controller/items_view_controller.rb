class ItemsViewController < UITableViewController
        def viewDidLoad
                super

                @feed = nil

                self.navigationItem.title = "Test Reader"
                self.view.backgroundColor = UIColor.whiteColor

                BW::HTTP.get('http://recipe4u.herokuapp.com/search.json?service=rakuten&keyword=tomato') do |response|
                        if response.ok?
                                @feed = BW::JSON.parse(response.body.to_str)
                                view.reloadData
                        else
                                App.alert(response.error_message)
                        end
                end
        end
        
        def tableView(tableView, numberOfRowsInSection:section)
                if @feed.nil?
                        return 0
                else
                        @feed[:recipes].size
                end
        end

        def tableView(tableView, cellForRowAtIndexPath:indexPath)
#                cell = tableView.dequeueReusableCellWithIdentifier('cell') ||
#                        UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:'cell')

#                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
                @reuseIdentifier ||= "CELL_IDENTIFIER"
                cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || 
                        begin
                                UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
                        end

                cell.textLabel.font = UIFont.boldSystemFontOfSize(14)
                cell.textLabel.text = @feed[:recipes][indexPath.row][:recipe][:title]
                cell
        end

        def tableView(taleView, didSelectRowAtIndexPath:indexPath)
                WebViewController.new.tap do |c|
                        c.recipe = @feed[:recipes][indexPath.row][:recipe]
                        navigationController.pushViewController(c, animated:true)
                end
        end
end
