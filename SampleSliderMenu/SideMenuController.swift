//
//  SideMenuController.swift
//  LaCart_iOSNative
//
//  Created by Pushpam Group on 04/03/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class SideMenuController: UIViewController, UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate{
    
    var btnMenu : UIButton!
    var delegate : SlideMenuDelegate?
    
    var arrayMenuOptions = [Dictionary<String,String>]()
    var bottomMenuOptions  = [Dictionary<String,String>]()
    
    var firstName:String?
    var lastName:String?
    var profileImageUrl: String?
    
    @IBOutlet var sliderMenuTableView: UITableView!
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    @IBOutlet var sideMenuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialUISetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        initialUISetup()
        updateArrayMenuOptions()
        
    }
    func initialUISetup()
    {
        sideMenuButton.addTarget(self, action: #selector(SideMenuController.onCloseMenuClick(_:)), for: UIControlEvents.touchUpInside)
        sliderMenuTableView.tableFooterView = UIView()
        
    }
    func updateArrayMenuOptions(){
        
        arrayMenuOptions.append(["title":"HOME", "icon":"home_icon"])
        arrayMenuOptions.append(["title":"DASHBOARD", "icon":"dashboard_icon"])
        arrayMenuOptions.append(["title":"RECENTLY VISITED", "icon":"mydishes"])
        arrayMenuOptions.append(["title":"ORDER HISTORY", "icon":"order_history"])
        arrayMenuOptions.append(["title":"MESSAGES", "icon":"messages"])
        arrayMenuOptions.append(["title":"WISHLIST", "icon":"order_history"])
        arrayMenuOptions.append(["title":"SETTINGS", "icon":"settings"])
        arrayMenuOptions.append(["title":"DISCUSSIONS", "icon":"discussions"])
        arrayMenuOptions.append(["title":"LOG OUT", "icon":"dashboard_icon"])
        
        
        bottomMenuOptions.append(["title":"LEGAL", "icon":"dashboard_icon"])
        bottomMenuOptions.append(["title":"TERMS & CONDITIONS", "icon":"dashboard_icon"])
        bottomMenuOptions.append(["title":"CAREERS", "icon":"dashboard_icon"])
        bottomMenuOptions.append(["title":"CONTACT", "icon":"dashboard_icon"])
        bottomMenuOptions.append(["title":"INVITE FRIENDS", "icon":"dashboard_icon"])
        
        //sliderMenuTableView.reloadData()
        
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }
    
    //SideMenu Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section
        {
        case 0:
            return 1
        case 1:
            return arrayMenuOptions.count
        default:
            return 2
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame =  CGRect(x: 0,y: 0,width: self.view.frame.size.width ,height: 1)
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section
        {
        case 0:
            return CGFloat(0)
        case 1:
            return CGFloat(0)
            
        default:
            return CGFloat(1)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section
        {
        case 0:
            return 150
        case 1:
            return 50
            
        default:
            return 2
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let verticalIndicator: UIImageView = (scrollView.subviews[(scrollView.subviews.count - 1)] as! UIImageView)
        verticalIndicator.backgroundColor = UIColor.red
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuProfileTableCell") as! SideMenuProfileTableCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "sliderMenuCell") as! SideMenuTableCell
            cell.menuItemImage.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
            cell.menuItemTitle.text = arrayMenuOptions[indexPath.row]["title"]!
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        
        self.onCloseMenuClick(btn)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
