//
//  PlayGameViewModel.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import Foundation

protocol PlayGameViewDelegate: class {
    func updateCurrentLogo(_ viewModel: AnyCurrentLogoViewModel)
    func update(currentTry string: [String], hintLetters: [String], isMatched: Bool)
}

protocol AnyPlayGameViewModel: class {
    var currentLogoViewModel: CurrentLogoViewModel? { get set }
    var viewDelegate: PlayGameViewDelegate? { get set }
    func reset()
    func nextLogo()
}

class PlayGameViewModel: AnyPlayGameViewModel {
    
    var viewDelegate: PlayGameViewDelegate?

    private let logoLoader: AnyLogoLoader
    private var allLogos: [Logo] = []
    
    var currentLogoViewModel: CurrentLogoViewModel?

    init(with logoLoader: AnyLogoLoader) {
        self.logoLoader = logoLoader
        logoLoader.fetchLogoGroup(.all) { self.allLogos = $0 }
    }

    func reset() {
        logoLoader.fetchLogoGroup(.all) { self.allLogos = $0 }
    }

    func nextLogo() {
        let randomLogo = allLogos.remove(at: Int.random(in: 0..<allLogos.count))
        currentLogoViewModel = CurrentLogoViewModel(with: randomLogo)
        currentLogoViewModel?.delegate = self
        viewDelegate?.updateCurrentLogo(currentLogoViewModel!)
    }
}

extension PlayGameViewModel: CurrentLogoDelegate {

    func update(currentTry string: [String], hintLetters: [String], isMatched: Bool) {
        viewDelegate?.update(currentTry: string, hintLetters: hintLetters, isMatched: isMatched)
    }
}
