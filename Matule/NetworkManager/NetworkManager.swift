//
//  NetworkManager.swift
//  Matule
//
//  Created by  MacBook Air on 30.01.2025.
//

import Foundation
import Alamofire

class NetworkManager {
    
    let url = URL(string: "https://pqtoyuhklcrmatorasvb.supabase.co/rest/v1/catalog")!
    let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBxdG95dWhrbGNybWF0b3Jhc3ZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0NTcxNTAsImV4cCI6MjA1MzAzMzE1MH0.8Zs2n2tNqjH3AtgmjcgeWeGfqkXW0zItwK74DRfFwqc"
    
    func sendRequest(count: Int, completion: @escaping ([CatalogItemModel]) -> Void) {
        let headers: HTTPHeaders = ["apiKey": apiKey]
        
        let param: Parameters = [
            "limit" : count.description
        ]
        
        AF.request(url, method: .get, parameters: param, headers: headers).response { result in
            guard result.error == nil else { return }
            
            guard let data = result.data else { return }
            do {
                let result = try JSONDecoder().decode([CatalogItemModel].self, from: data)
                completion(result)
            } catch {
                print(error)
            }
            
        }
        
    }
    
}
