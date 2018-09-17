//
//  ContainerVC.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 4. 13..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    @IBOutlet weak var sideMenuConstrain: NSLayoutConstraint!
    var SidemenuOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: //NSNotification.Name("ToggleSideMenu"), object: nil)

        // Do any additional setup after loading the view.
    }

  //  @objc func toggleSideMenu() {
    //    if SidemenuOpen {
     //       SidemenuOpen = false
    //        sideMenuConstrain.constant = -240
    //    }else {
    //        SidemenuOpen = true
    //        sideMenuConstrain.constant = 0
   //     }
  //  }
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
