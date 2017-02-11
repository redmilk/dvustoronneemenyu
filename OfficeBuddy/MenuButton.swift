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

class MenuButton: UIView {
  // kartinka znachok menu
  var imageView: UIImageView!
  // obrabotchik kasaniya
  var tapHandler: (()->())?
  // kogda view pomenyala superview
  override func didMoveToSuperview() {
    // sozdaem shirinu i visotu
    frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
    // sozdaem kartinku knopke
    imageView = UIImageView(image:UIImage(named:"menu.png"))
    // aktivirovat interaction
    imageView.isUserInteractionEnabled = true
    // dobavit raspoznavatel kasaniy
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MenuButton.didTap)))
    // prikrepit k sebe
    addSubview(imageView)
  }
  
    // interfeis obrabotki kasaniya
  func didTap() {
    // obrabotchik kasaniya 
    tapHandler?()
  }
}
