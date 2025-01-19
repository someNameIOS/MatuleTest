//
//  OnboardModel.swift
//  Matule
//
//  Created by  MacBook Air on 16.12.2024.
//

import Foundation

struct OnboardModel {
    let title: String
    let description: String
    let imageName: String
    
    static let mockData: [OnboardModel] = [
        OnboardModel(title: "ДОБРО \nПОЖАЛОВАТЬ", description: "", imageName: "image1"),
        OnboardModel(title: "Начнем путешествие", description: "Умная, великолепная и модная коллекция Изучите сейчас", imageName: "image2"),
        OnboardModel(title: "У Вас Есть Сила, Чтобы", description: "В вашей комнате много красивых и привлекательных растений", imageName: "image3")
    ]
}
