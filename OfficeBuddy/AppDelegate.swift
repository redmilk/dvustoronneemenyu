/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    application.statusBarStyle = UIStatusBarStyle.lightContent
    // ssilka na storyboard
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    // sozdaem ssilku na navigation controller s identifikatorom CenterNav
    let centerNav = storyboard.instantiateViewController(withIdentifier: "CenterNav") as! UINavigationController
    // sozdaem ssilku na controller bokovogo menu s id SideMenu
    let menuVC = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuViewController
    // v menuVC sohranyaem ssilku na Centralniy Controller
    menuVC.centerViewController = centerNav.viewControllers.first as! CenterViewController
    // sozdaem galvniy controller peredaem v parametri centralnoe okno i bokovoe menu
    let containerVC = ContainerViewController(sideMenu: menuVC, center: centerNav)
    // sozdaem okno razmerom s ekran devaisa
    self.window = UIWindow(frame: UIScreen.main.bounds)
    // startoviy controller naznachaem glavniy container
    self.window!.rootViewController = containerVC
    self.window!.backgroundColor = UIColor.black
    // sdelat okno klyuchevim
    self.window!.makeKeyAndVisible()
    
    return true
  }
  
}
