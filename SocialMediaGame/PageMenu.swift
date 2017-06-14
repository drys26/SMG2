//
//  PageMenu.swift
//  SocialMediaGame
//
//  Created by Nexusbond on 13/06/2017.
//  Copyright © 2017 Nexusbond. All rights reserved.
//

import UIKit
import PageMenu
class PageMenu: UIViewController {

    var pagemenu: CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var controllerArray: [UIViewController] = []
        
        var controller: UIViewController = UIViewController(nibName: "controllerNibName", bundle: nil)
        controller.title = "Sample Title"
        controllerArray.append(controller)
        
        
        var parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        
        pagemenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview((pagemenu?.view)!)
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
