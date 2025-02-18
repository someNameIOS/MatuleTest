//
//  FavoriteManager.swift
//  Matule
//
//  Created by  MacBook Air on 16.02.2025.
//

import Foundation

class FavoriteManager {
    static let shared = FavoriteManager()
    private var favoriteItems: [CatalogItemModel] = [] // Храним избранные товары в массиве

    private init() {}

    // Получение списка избранных товаров
    func getFavoriteItems() -> [CatalogItemModel] {
        return favoriteItems
    }

    // Проверка, есть ли товар в избранном
    func isFavorite(product: CatalogItemModel) -> Bool {
        return favoriteItems.contains { $0.id == product.id }
    }

    // Добавление / удаление товара
    func toggleFavorite(product: CatalogItemModel) {
        if let index = favoriteItems.firstIndex(where: { $0.id == product.id }) {
            favoriteItems.remove(at: index) // Если товар уже есть – удаляем
        } else {
            favoriteItems.append(product) // Если товара нет – добавляем
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("FavoritesUpdated"), object: nil) // Обновляем UI
    }
}
