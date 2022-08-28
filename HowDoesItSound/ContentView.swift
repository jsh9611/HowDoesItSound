//
//  ContentView.swift
//  HowDoesItSound
//
//  Created by SeongHoon Jang on 2022/08/26.
//

import SwiftUI

/// Source
/// CoreML: https://github.com/martinmitrevski/MusicInstruments
/// MicrophoneMonitor: https://github.com/bbaars/SwiftUI-Sound-Visualizer
/// PlayButton: https://www.youtube.com/watch?v=tywgjLMbd6I

struct ContentView: View {
    
    @ObservedObject var observer: AudioStreamObserver
    @ObservedObject var monitor: MicrophoneMonitor
    
    private var streamManager: AudioStreamManager
    
    init() {
        observer = AudioStreamObserver()
        monitor = MicrophoneMonitor(numberOfSamples: 1)
        streamManager = AudioStreamManager()
        streamManager.resultObservation(with: observer)
        

    }
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text(observer.currentSound)
                Text("\(observer.topResults.first?.confidence ?? 0)")
            }.padding()
            
                ChartView(observer: observer)
            
            Spacer()
            
            HStack {
                ListenButton(monitor: monitor, streamManager: streamManager)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
