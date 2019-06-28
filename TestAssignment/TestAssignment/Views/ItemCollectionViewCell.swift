//
//  ItemCollectionViewCell.swift
//  TestAssignment
//
//  Created by Vinh Pham on 6/28/19.
//  Copyright © 2019 Vinh Pham. All rights reserved.
//

import Foundation
import UIKit

class ItemCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbCreatedAt: UILabel!
    @IBOutlet weak var lbLicense: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    func configureCell(viewModel : ItemViewModel) {
        //name
        guard let name = viewModel.name else {
            return
        }
        self.lbName.text = name
        
        //description
        guard let description = viewModel.myDescription else {
            return
        }
        self.lbDescription.text = description
        
        //createdAt
        guard let createdAt = viewModel.createdAt else {
            return
        }
        self.lbCreatedAt.text = createdAt
        
        //license
        guard let license = viewModel.license else {
            return
        }
        self.lbLicense.text = license["name"]
    }
}
