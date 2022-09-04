//
//  ChartView.swift
//  HowDoesItSound
//
//  Created by SeongHoon Jang on 2022/08/26.
//

import SwiftUI

struct ChartView: View {
    @ObservedObject var observer: AudioStreamObserver

    var body: some View {
    
        VStack(alignment: .leading) {
            // 상단 구분 bar
            RoundedRectangle(cornerRadius: 2.0)
                .foregroundColor(.clear)
                .frame(width: 250, height: 1)
            // 하단 바 차트
            ForEach(0..<observer.topResults.count, id: \.self) { index in
                HStack {
                    // 차트 바의 왼쪽에 감정을 출력
                    Text(emotionalSoundToEmoji(_: observer.topResults[index].description))
                        .frame(width: UIScreen.main.bounds.width / 4)
                        .lineLimit(1)
                    
                    let confidence = observer.topResults[index].confidence
                    // 차트의 왼편
                    RoundedRectangle(cornerRadius: 2.0)
                        .frame(width: 250 * confidence, height: 20, alignment: .center)
                        .animation(.linear, value: observer.topResults[index].confidence)
                    // 차트의 오른편
                    RoundedRectangle(cornerRadius: 2.0)
                        .fill(.gray)
                        .frame(width: 250 * (1 - confidence), height: 20, alignment: .center)
                        .animation(.linear, value: observer.topResults[index].confidence)
                        
                    Spacer()

                }
            }
            
        }
        .padding()
    }
}

extension View {
    func emotionalSoundToEmoji(_ currentSound: String) -> String {
        let emotion: String
        
        if currentSound.contains("neutral") {
            emotion = "Neutral"//"보통이에요"
        } else if currentSound.contains("angry") {
            emotion = "Angry"//"화났어요"
        } else if currentSound.contains("boredom") {
            emotion = "Boredom"//"지루해요"
        } else if currentSound.contains("disappointmen") {
            emotion = "Disappointment"//"실망스러워요"
        }  else if currentSound.contains("disgust") {
            emotion = "Disgust"//"싫어요"
        }  else if currentSound.contains("excited") {
            emotion = "Excited"//"신나요"
        }  else if currentSound.contains("fearful") {
            emotion = "Fearful"//"지루해요"
        }  else if currentSound.contains("happy") {
            emotion = "Happy"//"행복해요"
        }  else if currentSound.contains("pain") {
            emotion = "Pain"//"아파요"
        }  else if currentSound.contains("pleasure") {
            emotion = "Pleasure"//"기뻐요"
        }  else if currentSound.contains("sad") {
            emotion = "Sad"//"슬퍼요"
        }  else if currentSound.contains("surprised") {
            emotion = "Surprised"//"놀랐어요"
        } else {
            emotion = currentSound
        }
        
        return emotion
    }
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(observer: AudioStreamObserver())
    }
}
