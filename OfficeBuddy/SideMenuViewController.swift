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

// bokovoi kontroller
class SideMenuViewController: UITableViewController {
  
    // ssilka na centralniy kontroller
  var centerViewController: CenterViewController!
  
  override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
    // kolichestvo elementov menu
    return MenuItem.sharedItems.count
  }
  
  override func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
    // zapolnlyaem yacheiku menu
    let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for:indexPath) as UITableViewCell
    // sozdaem ssilku na tekushiy menu item
    let menuItem = MenuItem.sharedItems[indexPath.row]
    // cell cettings
    cell.textLabel?.backgroundColor = UIColor.clear
    cell.textLabel?.textColor = UIColor.white
    cell.textLabel?.font = UIFont(name: "Helvetica", size: 36.0)
    cell.textLabel?.textAlignment = .center
    cell.textLabel?.text = menuItem.symbol
    // vibiraem cvet contentView iz menuItem
    cell.contentView.backgroundColor = menuItem.color
    return cell
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView  {
    // zagolovok sekcii
    return tableView.dequeueReusableCell(withIdentifier: "HeaderCell")!
  }
    
  override func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath) {
    tableView.deselectRow(at: indexPath, animated:true)
    // vstavlyaem v centralniy controller zastavku sootv. vibrannomu menu
    centerViewController.menuItem = MenuItem.sharedItems[indexPath.row]
    // sozdaem ssilku na roditelskiy controller, chto est glavniy
    let containerVC = parent as! ContainerViewController
    // v nem vizivaem funkciyu spryatat bokovoe menu
    containerVC.toggleSideMenu()
  }
  
    // visota stroki v tableView
  override func tableView(_ tableView:UITableView, heightForRowAt indexPath:IndexPath) -> CGFloat {
    return 84.0
  }
  // visota zagolovka sekcii, kazhdaya yacheika menu imeet svoi zagolovok
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 64.0
  }
}
