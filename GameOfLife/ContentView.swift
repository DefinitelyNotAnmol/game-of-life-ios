//
//  ContentView.swift
//  GameOfLife
//
//  Created by Anmol Jain on 09/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isPlaying: Bool = false
    @StateObject private var gameOfLife: GameOfLifeViewModal = GameOfLifeViewModal()

    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            VStack {
                GridView().environmentObject(gameOfLife)
            }
            .navigationTitle(Text("Life"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        gameOfLife.nextGen()
                    }) {
                        Text("Next")
                    }
                    
                    Button(action: {
                        isPlaying.toggle()
                        if isPlaying { startGenerating() }
                        else { stopGenerating() }
                    }) {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        gameOfLife.clear()
                    }) {
                        Text("Clear")
                    }
                }
            }
            .onAppear {
                stopGenerating()
            }
            .onReceive(timer) { _ in
                gameOfLife.nextGen()
            }
        }
    }
    
    func stopGenerating() {
        self.timer.upstream.connect().cancel()
    }
    
    func startGenerating() {
        self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().accentColor(.mint)
    }
}
