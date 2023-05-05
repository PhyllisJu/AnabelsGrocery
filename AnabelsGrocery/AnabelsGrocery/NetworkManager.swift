//
//  NetworkManager.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/4.
//

import Foundation
import UIKit

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
    
    func createMenu(name: String, image: UIImage, description: String, completion: @escaping (Menu) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = image.pngData()!
        let body: [String: Any] = [
            "name": name,
            "description": description,
            "image_data": imageData,
            "inventories": [],
            "instruction": ""
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Menu.self, from: data)
                    completion(response)
                }
                catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func createOrder(total_price: Float, inventories: [[String:Int]], completion: @escaping (Order) -> Void) {
        let orderPostURL = URL(string: "http://127.0.0.1:8002/orders/")!
            var request = URLRequest(url: orderPostURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
            let body: [String: Any] = [
                "total_price": total_price,
                "inventories": inventories
            ]
    
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
            let task = URLSession.shared.dataTask(with: request) { data, response, err in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Order.self, from: data)
                        completion(response)
                    }
                    catch (let error) {
                        print(error.localizedDescription)
                    }
    
                }
            }
            task.resume()
        }
}
