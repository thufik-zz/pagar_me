//
//  Transaction.swift
//  Pagar.me
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 9/6/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import ObjectMapper

class Transaction: Mappable {
    
    var status:String!
    var id:Int!
    var amount:Int!
    var ip:String!
    var payment_method:String!
    var cost:Int!
    var creation_date:NSDate!
    var split_rules:[SplitRule]?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        id <- map["id"]
        amount <- map["amount"]
        ip <- map["ip"]
        payment_method <- map["payment_method"]
        cost <- map["cost"]
        creation_date <- (map["date_created"],DateTransform())
        split_rules <- map["split_rules"]
    }
}
