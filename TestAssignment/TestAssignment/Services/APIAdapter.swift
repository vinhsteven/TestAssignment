//
//  APIAdapter.swift
//  TestAssignment
//
//  Created by Vinh Pham on 6/28/19.
//  Copyright © 2019 Vinh Pham. All rights reserved.
//

import Foundation

protocol APIAdapterDelegate {
    func addItems(items: [ItemModel])
}

class APIAdapter {
    static let shared = APIAdapter()
    var delegate : APIAdapterDelegate?
    
    var currentPage = 1
    let totalPage = 10
    
    func loadItemList(user: String, completionHandler:@escaping (([ItemModel]) -> Void)) {
        guard let requestUrl = URL(string: "https://api.github.com/users/\(user)/repos?page=\(currentPage)&per_page=\(totalPage)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: requestUrl) { (responseData, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            let statusCode = httpResponse.statusCode
            
            if statusCode == 200 {
                if error == nil {
                    var itemModels: [ItemModel] = []
                    
                    if let data = responseData,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                        if let array = json {
                            for result in array {
                                let itemModel = try! ItemModel(json: result as? [String : Any] ?? [:])
                                
                                itemModels.append(itemModel)
                            }
                            
                            if array.count == self.totalPage {
                                self.currentPage += 1
                            }
                        }
                        
                        DispatchQueue.main.async {
                            completionHandler(itemModels)
                        }
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
