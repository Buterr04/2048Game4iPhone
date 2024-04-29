//
//  ContentView.swift
//  2048
//
//  Created by on 2022/8/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = Game()
    @State var showingBruh = false
    @State var hasWon = false
    @State var hasLost = false
    let animation = Animation.interactiveSpring(response: 0.2, dampingFraction: 0.6, blendDuration: 0.1)
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // the background gray
                Color.gray
                    .opacity(0.2)
                    .ignoresSafeArea()
                VStack {
                    // the score
                    HStack {
                        Spacer()
                        Text("Score: \(game.score)")
                            .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.1))
                    }
                    .padding()
                    
                    // the game
                    GameBoardView(length: min(geometry.size.width, geometry.size.height) * 0.9, tiles: game.tiles)

                    // the two buttons
                    HStack {
                        Spacer()
                        Button("recall") {
                            game.recall()
                        }
                            .buttonStyle(.borderedProminent)
                        Spacer()
                        Button("restart") {
                            game.restart()
                        }
                            .buttonStyle(.borderedProminent)
                        Spacer()
                    }.padding(.top)
                    
                    // the movement buttons
                    
            
                    ZStack {
                        Button {
                            // right
                            withAnimation(animation) {
                                game.moveTilesRightwards()
                                do {
                                    try game.lossCheck()
                                } catch {
                                    hasLost.toggle()
                                }
                                do {
                                    try game.winCheck()
                                } catch {
                                    hasWon.toggle()
                                }
                                game.generateTiles(tileCount: hasLost||hasWon ? 0 : 1)
                            }
                        } label: {
                            Image(systemName: "arrow.right.square")
                        }
                            .font(.largeTitle)
                            .offset(x: min(geometry.size.width, geometry.size.height) * 0.15)
                        Button {
                            // left
                            withAnimation(animation) {
                                game.moveTilesLeftwards()
                                do {
                                    try game.lossCheck()
                                } catch {
                                    hasLost.toggle()
                                }
                                do {
                                    try game.winCheck()
                                } catch {
                                    hasWon.toggle()
                                }
                                game.generateTiles(tileCount: hasLost||hasWon ? 0 : 1)
                            }
                        } label: {
                            Image(systemName: "arrow.left.square")
                        }
                            .font(.largeTitle)
                            .offset(x: -min(geometry.size.width, geometry.size.height) * 0.15)
                        Button {
                            // down
                            withAnimation(animation) {
                                game.moveTilesDownwards()
                                do {
                                    try game.lossCheck()
                                } catch {
                                    hasLost.toggle()
                                }
                                do {
                                    try game.winCheck()
                                } catch {
                                    hasWon.toggle()
                                }
                                game.generateTiles(tileCount: hasLost||hasWon ? 0 : 1)
                            }
                        } label: {
                            Image(systemName: "arrow.down.square")
                        }
                            .font(.largeTitle)
                            .offset(y: min(geometry.size.width, geometry.size.height) * 0.15)
                        Button {
                            // up
                            withAnimation(animation) {
                                game.moveTilesUpwards()
                                do {
                                    try game.lossCheck()
                                } catch {
                                    hasLost.toggle()
                                }
                                do {
                                    try game.winCheck()
                                } catch {
                                    hasWon.toggle()
                                }
                                game.generateTiles(tileCount: hasLost||hasWon ? 0 : 1)
                            }
                        }  label: {
                            Image(systemName: "arrow.up.square")
                        }
                            .font(.largeTitle)
                            .offset(y: -min(geometry.size.width, geometry.size.height) * 0.15)
                    }
                    .padding(.vertical, min(geometry.size.width, geometry.size.height) * 0.15)
                    .alert("You have lost... :(", isPresented: $hasLost) {
                        Button("try again") {
                            game.restart()
                        }
                    } message: {
                        Text("your final score is \(game.score)")
                    }
                    .alert("You have won! ;)", isPresented: $hasWon) {
                        Button("gg ez, again!") {
                            game.restart()
                        }
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
