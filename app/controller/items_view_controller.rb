class ItemsViewController < UIViewController
        def viewDidLoad
                super

                @feed = nil

                self.navigationItem.title = "きくぽん"
                self.view.backgroundColor = UIColor.greenColor

                @index = 0

                BW::HTTP.get('http://recipe4u.herokuapp.com/search.json?service=rakuten&keyword=tomato') do |response|
                        if response.ok?
                                @feed = BW::JSON.parse(response.body.to_str)
                                @label = UILabel.alloc.initWithFrame(CGRectZero)
                                @label.text = @feed[:recipes][@index][:recipe][:title]
                                @label.sizeToFit
                                @label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 4)
                                self.view.addSubview @label
                                
                                image_data = NSData.dataWithContentsOfURL(NSURL.URLWithString(@feed[:recipes][@index][:recipe][:image]))
                                @image = UIImageView.alloc.initWithImage(UIImage.imageWithData(image_data))
                                @image.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
                                self.view.addSubview @image
                        else
                                App.alert(response.error_message)
                        end
                end
                
                @left_swipe = view.when_swiped do
                        @index = @index + 1
                        if @index < 3
                                @label.removeFromSuperview
                                @image.removeFromSuperview

                                @label = UILabel.alloc.initWithFrame(CGRectZero)
                                @label.text = @feed[:recipes][@index][:recipe][:title]
                                @label.sizeToFit
                                @label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 4)
                                self.view.addSubview @label
                                
                                image_data = NSData.dataWithContentsOfURL(NSURL.URLWithString(@feed[:recipes][@index][:recipe][:image]))
                                @image = UIImageView.alloc.initWithImage(UIImage.imageWithData(image_data))
                                @image.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
                                self.view.addSubview @image
                        else
                                @label.removeFromSuperview
                                @image.removeFromSuperview
                                @label.text = "あなたにおすすめするレシピはもうありません"
                                @label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
                                self.view.addSubview @label
                        end
                end
                @left_swipe.direction = UISwipeGestureRecognizerDirectionLeft
        end
end
