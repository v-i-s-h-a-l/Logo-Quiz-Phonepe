//
//  CurrentLogoViewModel.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import Foundation

protocol CurrentLogoDelegate: class {
    func update(currentTry string: [String], hintLetters: [String], isMatched: Bool)
}

protocol AnyCurrentLogoViewModel: class {
    var imageURL: URL { get set }
    var solutionSize: Int { get }
    var originalHintLettersIndexed: [Int: String] { get set }
}

class CurrentLogoViewModel: AnyCurrentLogoViewModel {
    
    weak var delegate: CurrentLogoDelegate?
    
    var imageURL: URL
    var solutionSize: Int { solution.count }
    var originalHintLettersIndexed: [Int: String]

    private var solution: String
    private var currentSelectedIndices: [Int] = []
    
    init(with logo: Logo) {
        self.imageURL = logo.imageURL
        self.solution = logo.name
        originalHintLettersIndexed = logo.name.jumbled
    }

    func appendFromIndex(_ index: Int) {
        // already selected from that index
        guard !currentSelectedIndices.contains(index), currentSelectedIndices.count < solution.count else { return }

        currentSelectedIndices.append(index)
    }

    func removeFromCurrentSelected(_ index: Int) {
        currentSelectedIndices.removeAll { $0 == index }
    }

    private func checkStatus() {
        let currentTry = currentSelectedIndices.compactMap { originalHintLettersIndexed[$0] }
        let hintLetters = originalHintLettersIndexed.map { (index, character) in
            currentSelectedIndices.contains(index) ? " " : character
        }
        let isMatched = currentTry.joined() == solution
        delegate?.update(currentTry: currentTry, hintLetters: hintLetters, isMatched: isMatched)
    }
}
