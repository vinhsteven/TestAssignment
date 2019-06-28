//
//  ItemViewModel.swift
//  TestAssignment
//
//  Created by Vinh Pham on 6/28/19.
//  Copyright © 2019 Vinh Pham. All rights reserved.
//

import Foundation

class ItemViewModel : NSObject {
    var name : String?
    var myDescription : String?
    var createdAt : String?
    var license : [String : String]?
    
    init(name: String?, description: String?, createdAt: String?, license: [String : String]?) {
        self.name = name
        self.myDescription = description
        self.createdAt = createdAt
        self.license = license
        
        super.init()
    }
}
