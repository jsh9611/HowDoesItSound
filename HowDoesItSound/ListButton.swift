//
//  ListButton.swift
//  HowDoesItSound
//
//  Created by SeongHoon Jang on 2022/08/26.
//

import SwiftUI

// MARK: - ListenButton
struct ListenButton: View {
    @ObservedObject var monitor: MicrophoneMonitor
    @State var isActive: Bool = false
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var animatedValue: CGFloat = 0
    @State var maxWidth = UIScreen.main.bounds.width / 2.2

    var streamManager: AudioStreamManager
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    // 소리가 커질때 바깥 쪽 원
                    Circle()
                        .fill(Color.black.opacity(0.05))
                    // 소리가 커질때 안쪽 원
                    Circle()
                        .fill(Color.black.opacity(0.08))
                        .frame(width: animatedValue/2, height: animatedValue/2)
                }
                .frame(width: animatedValue, height: animatedValue)
                
                // Record Button
                Circle()
                    .frame(width: 55, height: 55)
                    .foregroundColor(isActive ? .red : .gray)
                    .onTapGesture {
                        isActive.toggle()
                        isActive ? streamManager.installTap() : streamManager.removeTap()
                    }
                .shadow(radius: 5.0)
            }
            .frame(width: maxWidth, height: maxWidth)
            .padding(.top, 25)
//            Spacer(minLength: 0)
        }
        .onReceive(timer, perform: {_ in
            startAnimation()
        })
    }
    
    // MARK: - ListenButton Animation
    func startAnimation() {
        if isActive {
            // value: between 0.004 and 1
            let value = (max(0.2, monitor.soundSamples[0] + 50)) / 2 / 25
            let animated = CGFloat(value) * (maxWidth) + 50
            withAnimation(Animation.linear(duration: 0.5)) {
                self.animatedValue = animated
            }
        }
    }
    
}

struct ListenButton_Previews: PreviewProvider {
    static var manager = AudioStreamManager()
    static var monitor = MicrophoneMonitor(numberOfSamples: 1)
    static var previews: some View {
        ListenButton(monitor: monitor, streamManager: manager)
    }
}
