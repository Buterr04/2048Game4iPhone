//
//  Color-TileColors.swift
//  2048
//
//  Created by 苏柏闻 on 2022/8/21.
//

import SwiftUI

extension Color {
    init(r: Int, g: Int, b: Int) {
        self = Color(red: Double(r)/255.0, green: Double(g)/255.0, blue: Double(b)/255.0)
    }
}
