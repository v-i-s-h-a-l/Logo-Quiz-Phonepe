//
//  PlayGameViewModel.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import Foundation

protocol PlayGameViewDelegate: class {
    func updateCurrentLogo(_ viewModel: AnyCurrentLogoViewModel)
    func update(currentTry string: String)
    func updateScore(_ score: String)
}

protocol AnyPlayGameViewModel: class {
    var currentLogoViewModel: CurrentLogoViewModel? { get set }
    var viewDelegate: PlayGameViewDelegate? { get set }
    var hintLetters: [String] { get set }
    func reset()
    func nextLogo()
}

class PlayGameViewModel: AnyPlayGameViewModel {
    
    var viewDelegate: PlayGameViewDelegate?
    
    var hintLetters: [String] = []

    private let logoLoader: AnyLogoLoader
    private var allLogos: [Logo] = []
    private var score: Int = 0

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
        currentLogoViewModel?.removeFromCurrentSelected(0)
        viewDelegate?.updateCurrentLogo(currentLogoViewModel!)
    }
}

extension PlayGameViewModel: CurrentLogoDelegate {

    func update(currentTry string: [String], hintLetters: [String], isMatched: Bool) {
        self.hintLetters = hintLetters
        viewDelegate?.update(currentTry: string.joined())
        if isMatched {
            // increment score
            //
            score += 10
            if allLogos.isEmpty {
                reset()
            }
            nextLogo()
        }
        viewDelegate?.updateScore("Score:\n\(score)")
    }
}
