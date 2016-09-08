//
//  DetailTransactionViewController.swift
//  Pagar.me
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 9/8/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit

class DetailTransactionViewController: UITableViewController {
    
    var transaction:Transaction!
    var split:Bool! = false
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.estimatedRowHeight = 200
        table.rowHeight = UITableViewAutomaticDimension
        
        if transaction.split_rules != nil
        {
            split = true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if split == false
        {
            return 1
        }
        else
        {
            return 3
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if split == false
        {
            return 6
        }else{
            if section == 0{
                return 6
            }
            else
            {
                return 5
            }
            
        }
        
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "ID da transação"
                cell.detailTextLabel?.text  = "\(transaction.id)"
                break
            case 1:
                cell.textLabel?.text = "Status"
                if transaction.status == "waiting_payment"{
                    cell.detailTextLabel?.text = "Aguardando pagamento"
                }
                else
                {
                    cell.detailTextLabel?.text = "Pago"
                }
                break
            case 2:
                cell.textLabel?.text = "Quantia"
                cell.detailTextLabel?.text  = "\(transaction.amount) centavos"
                break
            case 3:
                cell.textLabel?.text = "Méotodo de pagamento"
                cell.detailTextLabel?.text  = transaction.payment_method
                break
            case 4:
                cell.textLabel?.text = "IP"
                cell.detailTextLabel?.text  = transaction.ip
                break
            case 5:
                cell.textLabel?.text = "Custo"
                cell.detailTextLabel?.text  = "\(transaction.cost) centavos"
                break
            default:
                break
            }
        default:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "ID da regra"
                cell.detailTextLabel?.numberOfLines = 0
                cell.detailTextLabel?.text  = "\(transaction.split_rules![indexPath.section - 1].id)"
                break
            case 1:
                cell.textLabel?.text = "ID do recebedor \(indexPath.section)"
                cell.detailTextLabel?.numberOfLines = 0
                cell.detailTextLabel?.text = transaction.split_rules![indexPath.section - 1].recipient_id
                break
            case 2:
                cell.textLabel?.text = "Sujeito a taxa"
                
                if transaction.split_rules![indexPath.section - 1].charge_processing_fee == true
                {
                    cell.detailTextLabel?.text = "Sim"
                }
                else
                {
                    cell.detailTextLabel?.text = "Não"
                }
                break
            case 3:
                cell.textLabel?.text = "Sujeito a risco de transação"
                if transaction.split_rules![indexPath.section - 1].liable == true
                {
                    cell.detailTextLabel?.text = "Sim"
                }
                else
                {
                    cell.detailTextLabel?.text = "Não"
                }
                break
            case 4:
                cell.textLabel?.text = "Porcentagem da transação"
                cell.detailTextLabel?.text  = "\(transaction.split_rules![indexPath.section - 1].percentage) %"
                break
            default:
                break
            }
        }
        

        
        
        
        
        return cell
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
