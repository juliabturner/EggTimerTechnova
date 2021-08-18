//
//  ContentView.swift
//  eggTimer
//
//  Created by Julia Turner on 2021-08-16.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var player: AVAudioPlayer!
    @State var totalTime = -1
    @State var secondsPassed = 0
    @State var currentHardness = ""
    @State var Hardness = ""
    @State var progressValue = 0.0
    @State var currentTitle = ""
    
    var body: some View {
        VStack {
            Text("Current Egg Timer:")
            Text(currentTitle)
                .onReceive(timer) { _ in
                    if secondsPassed < totalTime {
                        secondsPassed += 1
                        progressValue = Double(Float(secondsPassed) / Float(totalTime))
                        print(Float(secondsPassed) / Float(totalTime))
                    } else if (secondsPassed == totalTime) {
                        currentTitle = "DONE!"
                        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                                    player = try! AVAudioPlayer(contentsOf: url!)
                                    player.play()
                        totalTime = -1
                    }
                }
        HStack {
            Button("Soft") {
                hardnessSelected(hardness: "Soft")
            }
            Button("Medium") {
                hardnessSelected(hardness: "Medium")
            }
            Button("Hard") {
                hardnessSelected(hardness: "Hard")
            }
        }
        ProgressView(value: progressValue)
        }
    }
    
   func hardnessSelected(hardness: String) {
    
        totalTime = eggTimes[hardness]!

        progressValue = 0.0
        secondsPassed = 0
        currentTitle = hardness

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
