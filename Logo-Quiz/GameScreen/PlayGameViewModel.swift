//
//  PlayGameViewModel.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import Foundation

protocol PlayGameViewDelegate {
    
}

protocol AnyPlayGameViewModel {
    
}

class PlayGameViewModel: AnyPlayGameViewModel {
    
    private let logoLoader: AnyLogoLoader
    
    private var logos: [Logo] = []

    init(with logoLoader: AnyLogoLoader) {
        self.logoLoader = logoLoader
        logoLoader.fetchLogoGroup(.all) { self.logos = $0 }
    }
}
