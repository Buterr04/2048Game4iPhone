//
//  TileView.swift
//  2048
//
//  Created by on 2022/8/21.
//

import SwiftUI

struct TileView: View {
    var tile: Tile
    var length: CGFloat
    var color: Color {
        switch tile.value {
        case 2: return Color(r: 236, g: 155, b: 242)
        case 4: return Color(r: 188, g: 162, b: 242)
        case 8: return Color(r: 167, g: 182, b: 242)
        case 16: return Color(r: 170, g: 218, b: 242)
        case 32: return Color(r: 170, g: 242, b: 237)
        case 64: return Color(r: 172, g: 242, b: 190)
        case 128: return Color(r: 240, g: 242, b: 179)
        case 256: return Color(r: 242, g: 213, b: 176)
        case 512: return Color(r: 242, g: 211, b: 86)
        case 1024: return Color(r: 242, g: 153, b: 58)
        case 2048: return Color(r: 242, g: 80, b: 36)
        default: return Color(r: 242, g: 80, b: 36)
        }
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: length * 0.12)
                .frame(width: length, height: length)
                .foregroundColor(color)
            Text(String(tile.value))
                .foregroundColor(.white)
                .font(.system(size: length * 0.6))
                .opacity(0.5)
//            Text("x: \(tile.x), y: \(tile.y)")
//                .font(.system(size: length * 0.3))
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var tile = Tile(x: 1, y: 1, value: 2)
    
    static var previews: some View {
        TileView(tile: tile, length: 100)
    }
}
