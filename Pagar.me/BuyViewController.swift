//
//  BuyViewController.swift
//  Pagar.me
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 9/8/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView


class BuyViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var price: UILabel!
    
    var product:Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyButton.layer.cornerRadius = 10
        buyButton.clipsToBounds = true
        self.imageview.image = product.image
        price.text = "R$\(product.amount/100),00"

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buy(sender: AnyObject) {
    
        //Primeiro passo Informar a URL que será acessada(consumida)
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.pagar.me/1/transactions")!)
        //definir qual método HTTP será utilizado
        request.HTTPMethod = "POST"
        //define o corpo da requisição utilizando UTF-8 como encoding
        //        request.HTTPBody =
        request.HTTPBody = "api_key=ak_test_AAAfFBJDvGNMA6YMEoxRyIrK0PlhLI&amount=\(product.amount)&payment_method=boleto&split_rules[0][recipient_id]=re_cisqrnmoq00y9w86ewom5fu07&split_rules[0][charge_processing_fee]=true&split_rules[0][liable]=true&split_rules[0][percentage]=30&split_rules[1][recipient_id]=re_ciskqb71v05axdm6d0xsfj6ed&split_rules[1][charge_processing_fee]=true&split_rules[1][liable]=false&split_rules[1][percentage]=70".dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: false)
        
        //let alertViewResponder: SCLAlertViewResponder = SCLAlertView().showSuccess("Pedido efetuado", subTitle: "Boleto bancário gerado.")
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("Ok", target: self, selector: #selector(self.ok))
        alert.showSuccess("Pedido efetuado", subTitle: "Boleto bancário gerado.")
        
        Alamofire.request(request).responseJSON(completionHandler: { (response) -> Void in
            
            print(response.description)
            
            if response.result.error != nil
            {
                print(response.result.description)
            }
            else
            {
                print(response.result.error.debugDescription)
            }
            
            
        })
    
        
    }
    
    
    func ok(){
        self.navigationController?.popViewControllerAnimated(true)
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
