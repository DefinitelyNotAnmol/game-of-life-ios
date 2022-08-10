//
//  GameOfLifeViewModal.swift
//  GameOfLife
//
//  Created by Anmol Jain on 10/08/22.
//

import SwiftUI

class GameOfLifeViewModal: ObservableObject {
    @Published var grid: [Array<Bool>]
    @Published var generationCount: Int
    
    var rowSize: Int = 0
    var columnSize: Int = 0
    
    init() {
        grid = Array(repeating: Array(repeating: false, count: 0), count: 0)
        generationCount = 0
    }
    
    func reset(rowSize: Int = 0, columnSize: Int = 0) {
        grid = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
        self.rowSize = rowSize
        self.columnSize = columnSize
    }
    
    func clear() {
        grid = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)
        generationCount = 0
    }
    
    func nextGen() {
        guard rowSize > 1 && columnSize > 1 else { return }
        
        var nextGenGrid = Array(repeating: Array(repeating: false, count: columnSize), count: rowSize)

        for i in 0..<rowSize {
            for j in 0..<columnSize {
                let neighbourCount = neighbourCount(row: i, column: j)
                
                //is alive
                if neighbourState(row: i, column: j) {
                    //dies of under-population
                    if neighbourCount < 2 || neighbourCount > 3 {
                        nextGenGrid[i][j] = false
                    } else {
                        nextGenGrid[i][j] = true
                    }
                } else {
                    //born by reproduction
                    if neighbourCount == 3 {
                        nextGenGrid[i][j] = true
                    }
                }
            }
        }
        
        generationCount += 1
        grid = nextGenGrid
    }
    
    func neighbourCount(row: Int, column: Int) -> Int {
        var counter: Int = 0
        
        for i in -1...1 {
            for j in -1...1 {
                counter += neighbourState(row: row + i, column: column + j) ? 1 : 0
            }
        }
        
        counter -= grid[row][column] ? 1 : 0
        return counter
    }
    
    private func neighbourState(row: Int, column: Int) -> Bool {
        guard row >= 0 && column >= 0 && row < rowSize && column < columnSize else { return false }
        return grid[row][column]
    }
}
