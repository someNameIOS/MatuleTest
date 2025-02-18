//
//  Autentification.swift
//  Matule
//
//  Created by  MacBook Air on 18.02.2025.
//

import Foundation
import Supabase


class Authentification {
    
    static let shared = Authentification()
    
    private let client = SupabaseClient(supabaseURL: URL(string: "https://pqtoyuhklcrmatorasvb.supabase.co")!,
                                        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBxdG95dWhrbGNybWF0b3Jhc3ZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0NTcxNTAsImV4cCI6MjA1MzAzMzE1MH0.8Zs2n2tNqjH3AtgmjcgeWeGfqkXW0zItwK74DRfFwqc")
    
    func signIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            do {
                // Здесь вызываем signIn и получаем объект session
                let session = try await client.auth.signIn(email: email, password: password)
                
                // Теперь проверяем, есть ли accessToken
                if session.accessToken != "" {
                    completion(.success(session.accessToken))
                } else {
                    completion(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Access token not found"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}




