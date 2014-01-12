class ItemsViewController < UIViewController
        def viewDidLoad
                super

                @feed  = nil
                @index = 0

                self.navigationItem.title = "きくぽん"
                self.view.backgroundColor = UIColor.whiteColor

                BW::HTTP.get('http://recipe4u.herokuapp.com/search.json?service=rakuten&keyword=tomato') do |response|
                        if response.ok?
                                @feed = BW::JSON.parse(response.body.to_str)
                                self.display_view
                        else
                                App.alert(response.error_message)
                        end
                end
                
                @left_swipe = view.when_swiped do
                        @index = @index + 1
                        @label.removeFromSuperview
                        @image.removeFromSuperview
                        if @index < 3
                                self.display_view
                        else
                                alert = UIAlertView.new
                                alert.message = "あなたにおすすめするレシピは\nもうありません"
                                alert.show
                        end
                end
                @left_swipe.direction = UISwipeGestureRecognizerDirectionLeft
        end
        
        def display_view
                @label = UILabel.alloc.initWithFrame(CGRectZero)
                @label.text = @feed[:recipes][@index][:recipe][:title]
                @label.sizeToFit
                @label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 4)
                self.view.addSubview @label
                
                image_data = NSData.dataWithContentsOfURL(NSURL.URLWithString(@feed[:recipes][@index][:recipe][:image]))
                @image = UIImageView.alloc.initWithImage(UIImage.imageWithData(image_data))
                @image.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
                self.view.addSubview @image
        end
end
