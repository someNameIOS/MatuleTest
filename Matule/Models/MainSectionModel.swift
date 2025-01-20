//
//  MainSectionModel.swift
//  Matule
//
//  Created by  MacBook Air on 11.01.2025.
//

import Foundation

enum HeaderType {
    case category, popular, stock
}

struct MainSectionModel {
    let header: String
    let items: [MainItemModel]
    let headerType: HeaderType
    
    static func mockData() -> [MainSectionModel] {
        let categoryItems: [MainItemModel] = [
            MainItemModel(categoryName: "Все"),
            MainItemModel(categoryName: "Outdoor"),
            MainItemModel(categoryName: "Tennis"),
        ]
        
        let popularItems: [MainItemModel] = [
            MainItemModel(shoeImage: "Sneakers", description: "BEST SELLER", shoeName: "Nike Air Max", price: "₽752.00"),
            MainItemModel(shoeImage: "Sneakers", description: "BEST SELLER", shoeName: "Nike Air Max", price: "₽752.00"),
        ]
        
        let stockItems: [MainItemModel] = [
            MainItemModel(stocksImage: "Stocks"),
            MainItemModel(stocksImage: "Stocks"),
        ]
        
        let categorySection: MainSectionModel = .init(header: "Категории", items: categoryItems, headerType: .category)
        let popularSection: MainSectionModel = .init(header: "Популярное", items: popularItems, headerType: .popular)
        let stockSection: MainSectionModel = .init(header: "Акции", items: stockItems, headerType: .stock)
        
        return [categorySection, popularSection, stockSection]
    }
}
