//
//  MainSectionModel.swift
//  Matule
//
//  Created by  MacBook Air on 11.01.2025.
//

import Foundation

enum HeaderType {
    case search, category, popular, stock
}

struct MainSectionModel {
    let header: String
    var items: [CatalogItemModel]
    let headerType: HeaderType
    
    static func mockData() -> [MainSectionModel] {
        let searchItems: [CatalogItemModel] = [
            CatalogItemModel(),
        ]
        
        let categoryItems: [CatalogItemModel] = [
            CatalogItemModel(category: "Все"),
            CatalogItemModel(category: "Outdoor"),
            CatalogItemModel(category: "Tennis"),
        ]
        
        let popularItems: [CatalogItemModel] = [
        ]
        
        let stockItems: [CatalogItemModel] = [
            CatalogItemModel(image: "Stocks"),
            CatalogItemModel(image: "Stocks"),
        ]
        
        let searchSection: MainSectionModel = .init(header: "Поиск", items: searchItems, headerType: .search)
        let categorySection: MainSectionModel = .init(header: "Категории", items: categoryItems, headerType: .category)
        let popularSection: MainSectionModel = .init(header: "Популярное", items: popularItems, headerType: .popular)
        let stockSection: MainSectionModel = .init(header: "Акции", items: stockItems, headerType: .stock)
        
        return [searchSection, categorySection, popularSection, stockSection]
    }
}
