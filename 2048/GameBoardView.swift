//
//  BackgroundGridView.swift
//  2048
//
//  Created by on 2022/8/21.
//

import SwiftUI

struct GameBoardView: View {
    var length: CGFloat
    var tileRatio = 0.21
    var tileLength: CGFloat {
        length * tileRatio
    }
    var spacing: CGFloat {
        length*(1-4*tileRatio)/5
    }
    
    var tiles: [Tile]
    
    var body: some View {
        ZStack {
            // the big white square
            RoundedRectangle(cornerRadius: length * 0.03)
                .frame(width: length, height: length)
                .foregroundColor(.white)
                .shadow(radius: 5)
            // the gray grids
            VStack(spacing: spacing) {
                ForEach(0..<4, id: \.self) { _ in
                    HStack(spacing: spacing) {
                        ForEach(0..<4, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: tileLength, height: tileLength)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            // the tiles
            ForEach(tiles) { tile in
                TileView(tile: tile, length: tileLength)
                    .offset(x: (tileLength + spacing) * (CGFloat(tile.x) - 1.5), y: (tileLength + spacing) * (CGFloat(tile.y) - 1.5))
            }
        }
    }
}

struct BackgroundGridView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray
                .opacity(0.2)
                .ignoresSafeArea()
            GameBoardView(length: 350, tiles: Game().tiles)
        }
    }
}
