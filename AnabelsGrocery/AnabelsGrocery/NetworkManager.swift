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

    var url = URL(string: "http://34.150.230.197/inventories/")!

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
                    //print(error.localizedDescription)
                }
            }
        }
        task.resume()

    }
    
    func getAllMenus(completion: @escaping ([Menu]) -> Void) {
        let menuGetURL = URL(string: "http://127.0.0.1:8002/menus/")!
        var request = URLRequest(url: menuGetURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MenuResponse.self, from: data)
                    completion(response.menus)
                }
                catch (let error) {
                    //print(error.localizedDescription)
                }
            }
        }
        task.resume()

    }
    
    func createMenu(name: String, image: UIImage, description: String, completion: @escaping (Menu) -> Void) {
        let menuPostURL = URL(string: "http://127.0.0.1:8002/menus/")!
        var request = URLRequest(url: menuPostURL)
        request.httpMethod = "POST"
        //let boundary = UUID().uuidString
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let imageData = image.pngData()!.base64EncodedString()
//        let body: [String: Any] = [
//            "name": name,
//            "description": description,
//            "image_data": imageData,
//            "inventories": [],
//            "instruction": ""
//        ]
        let body: [String: Any] = [
            "name": name,
            "description": description,
            "instruction": "abc",
            "inventories": [1,2,3],
            "image_data": imageData
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
                    //print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func createOrder(total_price: Float, inventories: [[String:Int]], completion: @escaping (OrderResponse) -> Void) {
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
                        let response = try decoder.decode(OrderResponse.self, from: data)
                        completion(response)
                    }
                    catch (let error) {
                        //print(error.localizedDescription)

                    }
    
                }
            }
            task.resume()
        }
}
