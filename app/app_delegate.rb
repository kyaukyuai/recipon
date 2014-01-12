class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds).tap do |w|
            w.makeKeyAndVisible
#            other_controller = UIViewController.new
#            other_controller.view.backgroundColor = UIColor.purpleColor

            nav_controller = UINavigationController.alloc.initWithRootViewController(ItemsViewController.new)

            tab_controller = UITabBarController.new
#            tab_controller.viewControllers = [nav_controller, other_controller]
            tab_controller.viewControllers = [nav_controller]
            w.rootViewController = tab_controller
    end
    true
  end
end
