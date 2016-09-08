//
//  Product.swift
//  Pagar.me
//
//  Created by Fellipe Thufik Costa Gomes Hoashi on 9/8/16.
//  Copyright © 2016 Fellipe Thufik Costa Gomes Hoashi. All rights reserved.
//

import UIKit
import ObjectMapper

class Product: NSObject {

    var name:String!
    var amount:Int!
    var image:UIImage!

    
    init(name:String,amount:Int, image:UIImage) {
        
        self.name = name
        self.amount = amount
        self.image = image
    }
    
}

