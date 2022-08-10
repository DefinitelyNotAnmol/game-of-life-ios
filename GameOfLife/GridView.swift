//
//  GridView.swift
//  GameOfLife
//
//  Created by Anmol Jain on 09/08/22.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject var gameOfLife: GameOfLifeViewModal
    @State private var rowSize = 0
    @State private var columnSize = 0
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomTrailing) {
                grid
                Text("\(gameOfLife.generationCount)")
                    .font(.caption2)
                    .padding(3)
            }
            .onAppear {
//                rowSize = Int(floor(geo.size.width / 15)) - 1
//                columnSize = Int(floor(geo.size.height / 15)) - 3
                resetGrid()
            }
        }
    }
    
    private var grid: some View {
        LazyVStack(spacing: 1) {
            ForEach(0..<gameOfLife.grid.count, id: \.self) { row in
                LazyHStack(spacing: 1) {
                    ForEach(0..<gameOfLife.grid[row].count, id: \.self) { column in
                        CellView(isAlive: gameOfLife.grid[row][column])
                            .onTapGesture {
                                gameOfLife.grid[row][column].toggle()
                            }
                        
                    }
                }
            }
        }
        .padding(.all, 1)
        .background { Color.gray.opacity(0.5) }
    }
    
    private func resetGrid() {
        gameOfLife.reset(rowSize: 47, columnSize: 27)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView().environmentObject(GameOfLifeViewModal())
    }
}
