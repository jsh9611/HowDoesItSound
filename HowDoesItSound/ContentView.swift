//
//  ContentView.swift
//  HowDoesItSound
//
//  Created by SeongHoon Jang on 2022/08/26.
//
/* 참고자료
 Data:
 https://www.kaggle.com/datasets/dejolilandry/asvpesdspeech-nonspeech-emotional-utterances
 CoreML:
 https://github.com/simgio99/envsoundclassifier/tree/main/envsoundclassifier
 https://github.com/martinmitrevski/MusicInstruments
 MicrophoneMonitor:
 https://github.com/bbaars/SwiftUI-Sound-Visualizer
 PlayButton:
 https://www.youtube.com/watch?v=tywgjLMbd6I
 **/

import SwiftUI

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
                Text(emotionalSoundToEmoji(_:observer.currentSound))
                    .font(.title)
            }.padding()
            
            ChartView(observer: observer)
                .padding(.bottom, 60)
            
            ListenButton(monitor: monitor, streamManager: streamManager)
                .padding(.bottom, 50)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
