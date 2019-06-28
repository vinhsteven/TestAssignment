//
//  ViewController.swift
//  TestAssignment
//
//  Created by Vinh Pham on 6/28/19.
//  Copyright © 2019 Vinh Pham. All rights reserved.
//

import UIKit

let CellIdentifier = "CellIdentifier"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var itemsArray : [ItemViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        
        let itemWidth = UIScreen.main.bounds.width
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWidth, height: 200)
        
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    func loadItems() {
        //reset all data
        self.clearData()
        
        guard let text = self.txtUser.text else {
            return
        }
        APIAdapter.shared.loadItemList(user: text) { [unowned self] (itemModels) in
            self.addItems(items: itemModels)
        }
    }
    
    func clearData() {
        self.itemsArray.removeAll()
        self.collectionView.reloadData()
        
        APIAdapter.shared.currentPage = 1
    }
    
    @IBAction func handleTapAction(_ sender : Any) {
        self.loadItems()
    }
    
    //MARK: UICollectionViewDelegate and DataSource
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.itemsArray.count - 1 {
            guard let text = self.txtUser.text else {
                return
            }
            
            APIAdapter.shared.loadItemList(user: text) { [unowned self] (itemModels) in
                self.addItems(items: itemModels)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath as IndexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let itemVM = self.itemsArray[indexPath.row]
        cell.configureCell(viewModel: itemVM)
        
        if indexPath.row % 2 == 0 {
            cell.containerView.backgroundColor = UIColor.lightGray
        }
        else {
            cell.containerView.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = collectionView.bounds.width
        
        return CGSize(width: itemWidth, height: 200)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loadItems()
        
        return true
    }
    
    //MARK: APIAdapterDelegate
    func addItems(items: [ItemModel]) {
        var lastIndex = self.itemsArray.count
        
        var indexPaths : [IndexPath] = []
        
        for item in items {
            let itemVM = ItemViewModel(name: item.name, description: item.description, createdAt: item.createdAt, license: item.license)
            self.itemsArray.append(itemVM)
            
            let indexPath = IndexPath(row: lastIndex, section: 0)
            indexPaths.append(indexPath)
            
            lastIndex = self.itemsArray.count
        }
        
        if !indexPaths.isEmpty {
            self.collectionView.insertItems(at: indexPaths)
        }
    }
    
    //MARK: -OrientationChange
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let itemWidth = UIScreen.main.bounds.width
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: itemWidth, height: 200)
            
            flowLayout.invalidateLayout()
        }
    }
}

