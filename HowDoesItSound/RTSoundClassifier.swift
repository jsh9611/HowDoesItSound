//
//  RTSoundClassifier.swift
//  HowDoesItSound
//
//  Created by SeongHoon Jang on 2022/08/26.
//

import Foundation
import CoreML


class RTSoundClassifier {
    private var model: HowDoesItSound?
    init() {
        // Try to load the environment sound classifier
        model = try? HowDoesItSound()
    }
    
    
}
