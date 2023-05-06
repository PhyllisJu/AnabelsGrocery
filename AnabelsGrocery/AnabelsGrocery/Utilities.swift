//
//  Utilities.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 5/4/23.
//

import Foundation
import UIKit

class Utilities {
    static func hexStringToUIColor(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    static func updateProductsFromUserDefaults(newProducts: [[Product]]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newProducts)
            UserDefaults.standard.set(data, forKey: "products")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    static func updateReservationFromUserDefaults(newArray: [Product]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newArray)
            UserDefaults.standard.set(data, forKey: "reservation")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }

    static func getProductsFromUserDefaults() -> [[Product]] {
        var products: [[Product]] = [[]]
        if let data = UserDefaults.standard.data(forKey: "products") {
            do {
                let decoder = JSONDecoder()
                products = try decoder.decode([[Product]].self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return products
    }
    
    static func getReservationFromUserDefaults() -> [Product] {
        var reservation: [Product] = []
        if let data = UserDefaults.standard.data(forKey: "reservation") {
            do {
                let decoder = JSONDecoder()
                reservation = try decoder.decode([Product].self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return reservation
    }

}
