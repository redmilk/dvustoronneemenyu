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
import QuartzCore

class ContainerViewController: UIViewController {
  // shirina menu
  let menuWidth: CGFloat = 80.0
  // vremya esli nazhemsh na menu
  let animationTime: TimeInterval = 0.5
  //controller menu
  let menuViewController: UIViewController!
  // controller centralniy, kotorim upravlyaet menu
  let centerViewController: UIViewController!
  // otkrivaetsya li seichas
  var isOpening = false
  // v parametri bokovoe menu i centralnoe
  init(sideMenu: UIViewController, center: UIViewController) {
    // sohranyaem ssilki na bokovoe menu i na centralnliy controller
    menuViewController = sideMenu
    centerViewController = center
    // super init
    super.init(nibName: nil, bundle: nil)
  }
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    // super view did load
    super.viewDidLoad()
    view.backgroundColor = UIColor.black
    // obnovit SB posle dobavleniya v ruchnuyu
    setNeedsStatusBarAppearanceUpdate()
    // dobavlyaem k tekushemu controlleru centralniy controller
    addChildViewController(centerViewController)
    // dobavlyaem k tekushei view centralnogo controllera
    view.addSubview(centerViewController.view)
    // did move vizivaetsya posle dobavleniya, vernutsya obratno
    centerViewController.didMove(toParentViewController: self)
    // dobav;yaem k tekushemu controlleru controller menu
    addChildViewController(menuViewController)
    // dobavlyaem k tekushemu view view bokovogo menu
    view.addSubview(menuViewController.view)
    // did move vizivaem posle dobavleniya, vernutsya obratno
    menuViewController.didMove(toParentViewController: self)
    // sozdaem frame bokovomu menu
    menuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
    // sozdaem raspoznavatel peretyagivaniy, vibiraem deistvie handleGesture
    let panGesture = UIPanGestureRecognizer(target:self, action:#selector(ContainerViewController.handleGesture(_:)))
    // dobavlyaem ego k tekyshemu oknu
    view.addGestureRecognizer(panGesture)
  }
  
    // deistvie pri peretyagivanii
  func handleGesture(_ recognizer: UIPanGestureRecognizer) {
    // translation
    let translation = recognizer.translation(in: recognizer.view!.superview!)
    // tekushiy progress peretyagivaniya
    var progress = translation.x / menuWidth * (isOpening ? 1.0 : -1.0)
    // ogranichitel
    progress = min(max(progress, 0.0), 1.0)
    // switch sostoyaniy raspoznavatelya
    switch recognizer.state {
    case .began:
      let isOpen = floor(centerViewController.view.frame.origin.x/menuWidth)
      isOpening = isOpen == 1.0 ? false : true
      
    case .changed:
      self.setToPercent(isOpening ? progress : (1.0 - progress))
      
    case .ended: fallthrough
    case .cancelled: fallthrough
    case .failed:
      // esli otkril na polovinu to otkrit bokovoe menu
      var targetProgress: CGFloat
      if (isOpening) {
        targetProgress = progress < 0.5 ? 0.0 : 1.0
      } else {
        targetProgress = progress < 0.5 ? 1.0 : 0.0
      }
      
      UIView.animate(withDuration: animationTime, animations: {
        self.setToPercent(targetProgress)
        }, completion: {_ in
          
      })
      
    default: break
    }
  }
  
  func toggleSideMenu() {
    let isOpen = floor(centerViewController.view.frame.origin.x/menuWidth)
    let targetProgress: CGFloat = isOpen == 1.0 ? 0.0: 1.0
    
    UIView.animate(withDuration: animationTime, animations: {
      self.setToPercent(targetProgress)
      }, completion: { _ in
        self.menuViewController.view.layer.shouldRasterize = false
    })
  }
  
  func setToPercent(_ percent: CGFloat) {
    centerViewController.view.frame.origin.x = menuWidth * CGFloat(percent)
    menuViewController.view.frame.origin.x = menuWidth * CGFloat(percent) - menuWidth
  }
  
}
