//
//  ExitViewController.swift
//  Pagar.me
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 9/8/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit

class ExitViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if self.appDelegate.isAdmin == true
        {
            self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        }
        else
        {
            self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
        }
        exitButton.clipsToBounds = true
        exitButton.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exit(sender: AnyObject) {
    
        let initialView = storyboard?.instantiateViewControllerWithIdentifier("initialViewController") as! InitialViewController
        self.appDelegate.window?.rootViewController = initialView
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
