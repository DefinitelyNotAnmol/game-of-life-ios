//
//  CellView.swift
//  GameOfLife
//
//  Created by Anmol Jain on 09/08/22.
//

import SwiftUI

struct CellView: View {
    let cellSize: CGFloat = 15
    let isAlive: Bool
    
    var body: some View {
        Rectangle()
            .fill(isAlive ? Color.mint : Color.white)
            .frame(width: cellSize, height: cellSize)
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(isAlive: true)
    }
}
