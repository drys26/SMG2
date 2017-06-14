//
//  rootNavPageMenu.swift
//  SocialMediaGame
//
//  Created by Nexusbond on 14/06/2017.
//  Copyright © 2017 Nexusbond. All rights reserved.
//

import UIKit
import PageMenu
import SWRevealViewController

class rootNavPageMenu: UIViewController {

    
    var pageMenu: CAPSPageMenu?
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        var controllerArray: [UIViewController] = []
        
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        firstVC?.title = "HOME"
        
        print(firstVC ?? "")
        
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "NewsViewController")
        secondVC?.title = "NEWS"
        print(secondVC ?? "")
        
        let thirdVC = storyboard?.instantiateViewController(withIdentifier: "ChatViewController")
        thirdVC?.title = "CHAT"
        
        
        controllerArray.append(firstVC!)
        controllerArray.append(secondVC!)
        controllerArray.append(thirdVC!)
        
        // a bunch of random customization
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor(red:0.20, green:0.32, blue:0.59, alpha:1.0)),
            .viewBackgroundColor(UIColor(red:0.20, green:0.32, blue:0.59, alpha:1.0)),
            .selectionIndicatorColor(UIColor.white),
            .bottomMenuHairlineColor(UIColor.clear),
            .menuHeight(40.0),
            .menuItemWidth(100.0),
            .centerMenuItems(true),
            .selectedMenuItemLabelColor(UIColor.white),
            .enableHorizontalBounce(false)
            
            
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        
        self.view.addSubview(pageMenu!.view)
        
        
    }
    
    
    @IBAction func ToogleGoToPost(_ sender: Any) {
        
        performSegue(withIdentifier: "goToPost", sender: nil)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
