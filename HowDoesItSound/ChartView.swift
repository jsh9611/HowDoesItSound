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
                    // 라벨의 첫번째만 출력
                    let firstLabel = observer.topResults[index].description.split(separator: ",")
                    Text(String(firstLabel[0].split(separator: " ")[0]))
                        .frame(width: UIScreen.main.bounds.width / 5.5)
                        .lineLimit(1)
                    
                    RoundedRectangle(cornerRadius: 2.0)
                        .frame(width: 250 * observer.topResults[index].confidence, height: 20, alignment: .center)
                        .animation(.linear, value: observer.topResults[index].confidence)
                    RoundedRectangle(cornerRadius: 2.0)
                        .fill(.gray)
                        .frame(width: 250 * (1 - observer.topResults[index].confidence), height: 20, alignment: .center)
                        .animation(.linear, value: observer.topResults[index].confidence)
                        
                    Spacer()

                }
            }
            
        }
        .padding()
    }
}



struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(observer: AudioStreamObserver())
    }
}
