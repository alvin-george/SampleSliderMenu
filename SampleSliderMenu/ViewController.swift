//
//  ViewController.swift
//  SampleSliderMenu
//
//  Created by apple on 16/06/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SlideMenuDelegate {
    
    @IBOutlet weak var sideMenuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        initialUISetup()
    }
    func initialUISetup()
    {
        hideTopStatusBarView()
        self.automaticallyAdjustsScrollViewInsets = false
        sideMenuButton.addTarget(self, action: #selector(ViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        
    }
    func hideTopStatusBarView()
    {
        UIApplication.shared.setStatusBarHidden(true, with: .none)
    }
    
    func onSlideMenuButtonPressed(_ sender : UIButton){
        
        if (sender.tag == 10)        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : SideMenuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideMenuViewController") as! SideMenuController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
        
    }
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
       // let topViewController : UIViewController = self.navigationController!.topViewController!
       // print("View Controller is : \(topViewController) \n", terminator: "")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

