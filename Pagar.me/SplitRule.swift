//
//  SplitRule.swift
//  Pagar.me
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 9/8/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import ObjectMapper

class SplitRule: Mappable {

    var id:String!
    var recipient_id:String!
    var charge_processing_fee:Bool!
    var liable:Bool!
    var percentage:Int!
    
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        recipient_id <- map["recipient_id"]
        charge_processing_fee <- map["charge_processing_fee"]
        liable <- map["liable"]
        percentage <- map["percentage"]
    }
    
    
}
