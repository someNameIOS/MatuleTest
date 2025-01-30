//
//  CatalogItemModel.swift
//  Matule
//
//  Created by  MacBook Air on 30.01.2025.
//

import Foundation

struct CatalogItemModel: Codable {
    var id: UUID?
    var name: String?
    var category: String?
    var description: String?
    var price: Double?
    var bestSeller: Bool?
    var image: String?
}
