//
//  ColorExtention.swift
//  growth-log-ios
//
//  Created by shin takeuchi on 2026/01/01.
//

import SwiftUI

extension Color {
    init(hex: String, opacity: Double = 1.0) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(.sRGB, red: r, green: g, blue: b, opacity: opacity)
    }
}
