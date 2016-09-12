//
//  ViewController.swift
//  Pagar.me
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 9/1/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tabela: UITableView!
    var transactions_array:NSMutableArray? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh), forControlEvents:.ValueChanged)
        self.tabela.addSubview(refreshControl)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.update_table), name: "update", object: nil)
        
        self.title = "Transações"
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.pagar.me/1/transactions?api_key=ak_test_AAAfFBJDvGNMA6YMEoxRyIrK0PlhLI")!)
        Alamofire.request(request).responseArray(completionHandler: {
            (response: Response<[Transaction], NSError>) in
            
            let transactionArray = response.result.value
            self.transactions_array = NSMutableArray()
            
            if let transactionArray = transactionArray {
                for transaction in transactionArray {
                    self.transactions_array?.addObject(transaction)
                }
            }
            
            self.tabela.reloadData()
            
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if transactions_array != nil
        {
            return (transactions_array?.count)!
        }
        else
        {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel?.text = "Transação Nº \(String((transactions_array![indexPath.row] as! Transaction).id))"
        cell.accessoryType = .DisclosureIndicator
        if (transactions_array![indexPath.row] as! Transaction).status == "waiting_payment"
        {
            cell.imageView?.image = UIImage(named: "yellow")
        }
        else if (transactions_array![indexPath.row] as! Transaction).status == "refused"
        {
            cell.imageView?.image = UIImage(named: "red")
        }
        else
        {
            cell.imageView?.image = UIImage(named: "green")
        }
        
        return cell
    }
    
    func refresh(refreshControl:UIRefreshControl){
        
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.pagar.me/1/transactions?api_key=ak_test_AAAfFBJDvGNMA6YMEoxRyIrK0PlhLI")!)
        Alamofire.request(request).responseArray(completionHandler: {
            (response: Response<[Transaction], NSError>) in
            
            self.transactions_array?.removeAllObjects()
            let transactionArray = response.result.value
            self.transactions_array = NSMutableArray()
            
            if let transactionArray = transactionArray {
                for transaction in transactionArray {
                    self.transactions_array?.addObject(transaction)
                }
            }
            
            refreshControl.endRefreshing()
            self.tabela.reloadData()
            
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailView = storyboard?.instantiateViewControllerWithIdentifier("detailTransactionViewController") as! DetailTransactionViewController
        detailView.hidesBottomBarWhenPushed = true
        detailView.transaction = transactions_array?.objectAtIndex(indexPath.row) as! Transaction
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func update_table(){
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.pagar.me/1/transactions?api_key=ak_test_AAAfFBJDvGNMA6YMEoxRyIrK0PlhLI")!)
        Alamofire.request(request).responseArray(completionHandler: {
            (response: Response<[Transaction], NSError>) in
            
            self.transactions_array?.removeAllObjects()
            let transactionArray = response.result.value
            self.transactions_array = NSMutableArray()
            
            if let transactionArray = transactionArray {
                for transaction in transactionArray {
                    self.transactions_array?.addObject(transaction)
                }
            }
            self.tabela.reloadData()
            
        })
    }
    

}

