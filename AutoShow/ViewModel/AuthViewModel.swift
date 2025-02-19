//
//  AuthViewModel.swift
//  AutoShow
//
//  Created by Timofey Sinitsyn on 19.02.2025.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @AppStorage("isAuthenticated") var isAuthenticated = false

    func login(username: String, password: String) {
        guard let url = URL(string: "http://127.0.0.1:5000/api/login") else {
            print("Ошибка: Неверный URL")
            return
        }
        
        let body: [String: String] = ["username": username, "password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("Отправляем запрос на: \(url)")
        print("Тело запроса: \(body)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка сети:", error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Ошибка: нет HTTP-ответа")
                return
            }
            
            print("Ответ от сервера: статус код \(httpResponse.statusCode)")
            
            if httpResponse.statusCode != 200 {
                print("Ошибка: код ответа \(httpResponse.statusCode)")
                return
            }
            
            guard let data = data else {
                print("Ошибка: нет данных в ответе")
                return
            }
            
            do {
                let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                print("Успешная аутентификация, полученный токен: \(tokenResponse.token)")
                
                DispatchQueue.main.async {
                    KeychainHelper.shared.save(tokenResponse.token, service: "jwt", account: "user")
                    
                    // ВАЖНО: Обновляем состояние авторизации
                    self.isAuthenticated = true
                    print("isAuthenticated теперь: \(self.isAuthenticated)")
                }
            } catch {
                print("Ошибка декодирования JSON:", error.localizedDescription)
            }
        }.resume()
    }
}


