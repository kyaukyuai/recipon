class WebViewController < UIViewController
        attr_accessor :recipe

        def viewDidLoad
                super

                @label = UILabel.alloc.initWithFrame(CGRectZero)
                @label.text = recipe[:title]
                @label.sizeToFit
                @label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 4)
                view.addSubview @label
                
                image_data = NSData.dataWithContentsOfURL(NSURL.URLWithString(recipe[:image]))
                @image = UIImageView.alloc.initWithImage(UIImage.imageWithData(image_data))
                @image.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
                view.addSubview @image
        end
end
