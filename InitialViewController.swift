//
//  InitialViewController.swift
//  Pagar.me
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 9/8/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var administrator: UIButton!
    @IBOutlet weak var user: UIButton!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user.layer.cornerRadius = 10
        user.clipsToBounds = true
        administrator.layer.cornerRadius = 10
        administrator.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AdministratorButtonClick(sender: AnyObject) {
    
        let view = storyboard?.instantiateViewControllerWithIdentifier("admViewController") as! UITabBarController
        self.appDelegate.isAdmin = true
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        self.appDelegate.window?.rootViewController = view
        
    }

    @IBAction func UserButtonClick(sender: AnyObject) {
   
        let view = storyboard?.instantiateViewControllerWithIdentifier("userViewController") as! UITabBarController
        self.appDelegate.isAdmin = false
        UITabBar.appearance().tintColor = UIColor.darkGrayColor()
        self.appDelegate.window?.rootViewController = view
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
