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
import PagarMe



class BuyViewController: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var buyWithCard: UIButton!
    
    
    var product:Product!
    
    let appearance = SCLAlertView.SCLAppearance(
        kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
        kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
        kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
        showCloseButton: false
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyButton.layer.cornerRadius = 10
        buyButton.clipsToBounds = true
        buyWithCard.layer.cornerRadius = 10
        buyWithCard.clipsToBounds = true
        self.imageview.image = product.image
        price.text = "R$\(product.amount/100),00"

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buy(sender: AnyObject) {
    
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.pagar.me/1/transactions")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = "api_key=ak_test_AAAfFBJDvGNMA6YMEoxRyIrK0PlhLI&amount=\(product.amount)&payment_method=boleto&split_rules[0][recipient_id]=re_cisqrnmoq00y9w86ewom5fu07&split_rules[0][charge_processing_fee]=true&split_rules[0][liable]=true&split_rules[0][percentage]=30&split_rules[1][recipient_id]=re_ciskqb71v05axdm6d0xsfj6ed&split_rules[1][charge_processing_fee]=true&split_rules[1][liable]=false&split_rules[1][percentage]=70".dataUsingEncoding(NSUTF8StringEncoding,allowLossyConversion: false)
        

        
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
    
    @IBAction func buyWithCard(sender: UIButton) {
    
        PagarMe.sharedInstance().encryptionKey = "ek_test_D8fnTNOqaPBQx46QBiDprUzeophI7q"
        let creditCard = PagarMeCreditCard(cardNumber: "4111111111111111", cardHolderName: "Test Card", cardExpirationMonth: "10", cardExpirationYear: "20", cardCvv: "623")
        
        if creditCard.hasErrorCardCVV(){
            print("erro no CVV")
        }else if creditCard.hasErrorCardNumber(){
            print("Erro no numero do cartão")
        }else if creditCard.hasErrorCardHolderName(){
            print("Erro no nome do cartão")
        }else if creditCard.hasErrorCardExpirationYear(){
            print("Erro no ano de expiração")
        }else if creditCard.hasErrorCardExpirationMonth(){
            print("Erro no mês de expiração")
        }else{
            creditCard.generateHash({ (error, cardHash) -> Void in
                if (error != nil) {
                    print("erro = \(error.debugDescription)")
                }
                else
                {
                    let request = NSMutableURLRequest(URL: NSURL(string: "https://api.pagar.me/1/transactions")!)
                    request.HTTPBody = "api_key=ak_test_AAAfFBJDvGNMA6YMEoxRyIrK0PlhLI&amount=1000&card_hash=\(cardHash)&split_rules[0][recipient_id]=re_cisqrnmoq00y9w86ewom5fu07&split_rules[0][charge_processing_fee]=true&split_rules[0][liable]=true&split_rules[0][percentage]=30&split_rules[1][recipient_id]=re_ciskqb71v05axdm6d0xsfj6ed&split_rules[1][charge_processing_fee]=true&split_rules[1][liable]=false&split_rules[1][percentage]=70".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                    request.HTTPMethod = "POST"
                    Alamofire.request(request).responseJSON(completionHandler:{ (response) -> Void in
                        
                        let alert = SCLAlertView(appearance: self.appearance)
                        alert.addButton("Ok", target: self, selector: #selector(self.ok))
                        alert.showSuccess("Sucesso", subTitle: "Pagamento efetuado")
                    })
                }
            })
        }
    }
    
    func ok(){
        self.navigationController?.popViewControllerAnimated(true)
    }
}
