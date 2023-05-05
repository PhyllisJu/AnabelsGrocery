//
//  NetworkManager.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/4.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()

    var url = URL(string: "http://127.0.0.1:8002/inventories/")!

    func getAllProducts(completion: @escaping ([Product]) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ProductResponse.self, from: data)
                    completion(response.inventories)
                }
                catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()

    }

//    func createMenu(body: String, sender: String, completion: @escaping (Menu) -> Void) {
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let body: [String: Any] = [
//            "message": body,
//            "sender": sender
//        ]
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, err in
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    let response = try decoder.decode(Message.self, from: data)
//                    completion(response)
//                }
//                catch (let error) {
//                    print(error.localizedDescription)
//                }
//
//            }
//        }
//
//        task.resume()
//
//
//    }

}
