//
//  Tile.swift
//  2048
//
//  Created by on 2022/8/21.
//

import Foundation

struct Tile: Identifiable{
    var x: Int
    var y: Int
    var value: Int
    var id = UUID()
    
}

extension Tile: Equatable {
    static func ==(a: Tile, b: Tile) -> Bool {
        a.x == b.x && a.y == b.y
    }
}
