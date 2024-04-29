//
//  Game.swift
//  2048
//
//  Created by on 2022/8/21.
//

import Foundation

class Game: ObservableObject {
    @Published var tiles: [Tile]
    @Published var recallTiles: [Tile]
    @Published var score = 0
    @Published var gameStatus: GameStatus

    enum GameError: Error {
        case tilesDidntMove
        case iamNotAnError
    }
    
    enum GameStatus {
        case won, lost, inGame
    }
    
    init() {
        self.tiles = [Tile]()
        self.recallTiles = [Tile]()
        self.gameStatus = .inGame
        generateTiles(tileCount: 3)
        self.recallTiles = self.tiles
    }
    
    func tileExists(_ tile: Tile) -> Bool {
        for oldTile in tiles {
            if oldTile == tile {
                return true
            }
        }
        return false
    }
    
    func generateTiles(tileCount: Int) {
        var i = 1
        while i <= tileCount {
            let power = Double(Int.random(in: 1...2))
            let newTile = Tile(x: Int.random(in: 0...3), y: Int.random(in: 0...3), value: Int(pow(Double(2.0), power)))
            if tileExists(newTile) {
                continue
            } else {
                tiles.append(newTile)
                i += 1
            }

        }
    }
    
    func recall() {
        tiles = recallTiles
    }
    
    func restart() {
        score = 0
        tiles = []
        generateTiles(tileCount: 3)
        recallTiles = tiles
        
    }
    
    func lossCheck() throws {
        if tiles.count >= 16 {
            gameStatus = .lost
            throw GameError.iamNotAnError
        }
    }
    
    func winCheck() throws {
        for tile in tiles {
            if tile.value >= 2048 {
                gameStatus = .won
                throw GameError.iamNotAnError
            }
        }
    }
    
    func moveTilesLeftwards() {
        var newTiles = [Tile]()
        for y in (0...3) {
            var row = [Tile]()
            for x in (0...3) {
                for aTile in tiles {
                    if aTile.y == y && aTile.x == x{
                        row.append(aTile)
                    }
                }
            }
            var rowII = [Tile]()
            for tile in row {
                if tile == row.first {
                    rowII.append(Tile(x: 0, y: tile.y, value: tile.value, id: tile.id))
                } else if let lastTile = rowII.last {
                    if lastTile.value == tile.value {
                        rowII.removeLast()
                        let newValue = 2 * tile.value
                        rowII.append(Tile(x: lastTile.x, y: lastTile.y, value: newValue, id: tile.id))
                    } else {
                        let newXCoordinate = lastTile.x + 1
                        rowII.append(Tile(x: newXCoordinate, y: tile.y, value: tile.value, id: tile.id))
                    }
                }
            }
            newTiles.append(contentsOf: rowII)
        }
        recallTiles = tiles
        tiles = newTiles
        score = 0
        for tile in tiles {
            score += tile.value
        }
    }

    func moveTilesRightwards() {
        var newTiles = [Tile]()
        for y in (0...3) {
            var row = [Tile]()
            for x in (0...3).reversed() {
                for aTile in tiles {
                    if aTile.y == y && aTile.x == x{
                        row.append(aTile)
                    }
                }
            }
            var rowII = [Tile]()
            for tile in row {
                if tile == row.first {
                    rowII.append(Tile(x: 3, y: tile.y, value: tile.value, id: tile.id))
                } else if let lastTile = rowII.last {
                    if lastTile.value == tile.value {
                        rowII.removeLast()
                        let newValue = 2 * tile.value
                        rowII.append(Tile(x: lastTile.x, y: lastTile.y, value: newValue, id: tile.id))
                    } else {
                        let newXCoordinate = lastTile.x - 1
                        rowII.append(Tile(x: newXCoordinate, y: tile.y, value: tile.value, id: tile.id))
                    }
                }
            }
            newTiles.append(contentsOf: rowII)
        }
        recallTiles = tiles
        tiles = newTiles
        
        
        score = 0
        for tile in tiles {
            score += tile.value
        }
//        if recallTiles == tiles {
//            throw GameError.tilesDidntMove
//        }
    }

    func moveTilesUpwards() {
        var newTiles = [Tile]()
        for x in (0...3) {
            var row = [Tile]()
            for y in (0...3) {
                for aTile in tiles {
                    if aTile.y == y && aTile.x == x{
                        row.append(aTile)
                    }
                }
            }
            var rowII = [Tile]()
            for tile in row {
                if tile == row.first {
                    rowII.append(Tile(x: tile.x, y: 0, value: tile.value, id: tile.id))
                } else if let lastTile = rowII.last {
                    if lastTile.value == tile.value {
                        rowII.removeLast()
                        let newValue = 2 * tile.value
                        rowII.append(Tile(x: lastTile.x, y: lastTile.y, value: newValue, id: tile.id))
                    } else {
                        let newYCoordinate = lastTile.y + 1
                        rowII.append(Tile(x: tile.x, y: newYCoordinate, value: tile.value, id: tile.id))
                    }
                }
            }
            newTiles.append(contentsOf: rowII)
        }
        recallTiles = tiles
        tiles = newTiles
        score = 0
        for tile in tiles {
            score += tile.value
        }
    }
    
    func moveTilesDownwards() {
        var newTiles = [Tile]()
        for x in (0...3) {
            var row = [Tile]()
            for y in (0...3).reversed() {
                for aTile in tiles {
                    if aTile.y == y && aTile.x == x{
                        row.append(aTile)
                    }
                }
            }
            var rowII = [Tile]()
            for tile in row {
                if tile == row.first {
                    rowII.append(Tile(x: tile.x, y: 3, value: tile.value, id: tile.id))
                } else if let lastTile = rowII.last {
                    if lastTile.value == tile.value {
                        rowII.removeLast()
                        let newValue = 2 * tile.value
                        rowII.append(Tile(x: lastTile.x, y: lastTile.y, value: newValue, id: tile.id))
                    } else {
                        let newYCoordinate = lastTile.y - 1
                        rowII.append(Tile(x: tile.x, y: newYCoordinate, value: tile.value, id: tile.id))
                    }
                }
            }
            newTiles.append(contentsOf: rowII)
        }
        recallTiles = tiles
        tiles = newTiles
        score = 0
        for tile in tiles {
            score += tile.value
        }
    }




    
}
