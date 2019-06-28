//
//  ItemModel.swift
//  TestAssignment
//
//  Created by Vinh Pham on 6/28/19.
//  Copyright © 2019 Vinh Pham. All rights reserved.
//

import Foundation

struct ItemModel {
    var name : String?
    var description : String?
    var createdAt : String?
    var license : [String : String]?
    
    init(name: String?, description: String?, createdAt: String?, license: [String : String]?) {
        self.name = name
        self.description = description
        self.createdAt = createdAt
        self.license = license
    }
}

extension ItemModel {
    init(json: [String: Any]) throws {
        var name : String?
        var description : String?
        var createdAt : String?
        var license : [String : String]?
        
        // Extract name
        if let _name = json["name"] as? String {
            name = _name
        }
        
        // Extract description
        if let _description = json["description"] as? String {
            description = _description
        }
        
        // Extract createdAt
        if let _createdAt = json["created_at"] as? String {
            createdAt = _createdAt
        }
        
        // Extract createdAt
        if let _license = json["license"] as? [String : String] {
            license = _license
        }
        
        // Initialize properties
        self.name = name
        self.description = description
        self.createdAt = createdAt
        self.license = license
    }
}
