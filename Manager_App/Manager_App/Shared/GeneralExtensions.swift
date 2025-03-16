//
//  Color_Ext.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 14/03/25.
//

import SwiftUICore
import UIKit

extension Color {
    func toHex() -> String {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return "#000000"
        }
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }


    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}


extension Binding where Value == Double {
    func formattedNumber() -> Binding<String> {
        let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "en_US")
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 10
            formatter.usesGroupingSeparator = false
            return formatter
        }()
        
        return Binding<String>(
            get: {
                if self.wrappedValue == 0.0 {
                    return ""
                } else {
                    return numberFormatter.string(from: NSNumber(value: self.wrappedValue)) ?? ""
                }
            },
            set: { newValue in
                let cleanValue = newValue.replacingOccurrences(of: ",", with: ".")
                if let parsedValue = numberFormatter.number(from: cleanValue) {
                    self.wrappedValue = parsedValue.doubleValue
                }
            }
        )
    }
}
