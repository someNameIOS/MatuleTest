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
    
//    func sendReq(count: Int) {
//        
//        //1. create url
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "pqtoyuhklcrmatorasvb.supabase.co"
//        urlComponents.path = "/rest/v1/catalog"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "limit", value: count.description)
//        ]
//        
//        guard let url = urlComponents.url else { return }
//        
//        //2. create request
//        var request = URLRequest(url: url)
//        request.allHTTPHeaderFields = [
//            "apiKey" : apiKey,
//        ]
//        
//        //3. send request
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard error == nil else {
//                print(error!)
//                return
//            }
//            
//            guard let data else { return }
//            
//            do {
//                let result = try JSONDecoder().decode(CatalogItemModel.self, from: data)
//            } catch {
//                print(error)
//            }
//            
//        }.resume()
//        
//    }
    
}
