//
//  MainViewController.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 6. 5..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit
import Firebase


class MainViewController: UIViewController {
  var timer: Timer?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
      

        // Do any additional setup after loading the view.
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func viewDidAppear(_ animated: Bool) {
        if CheckNetwork.Connection() {
            
//            DispatchQueue.main.async {
//                self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
//                    print(timer)
//                    let storyboard: UIStoryboard = self.storyboard!
//                    let nextView = storyboard.instantiateViewController(withIdentifier: "MainFirst")
//                    self.present(nextView, animated: true, completion: nil)
//
//                }
//            }
           
           
        }
        else {
            self.Alert(messanger: "Your Device is not connected the Internet")
        }
    }
    
    func Alert(messanger : String) {
        let alert = UIAlertController(title: "Alert", message: messanger, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
           action in exit(0)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func gotoMain(_ sender: Any) {
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
