//
//  PlayGameViewController.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import UIKit

class PlayGameViewController: UIViewController {
    
    private var viewModel: AnyPlayGameViewModel!
    
    @IBOutlet weak var logoImageVIew: UIImageView!
    @IBOutlet weak var currentTryLabel: UILabel!
    @IBOutlet weak var hintLettersCollectionView: UICollectionView! {
        didSet {
            hintLettersCollectionView.delegate = self
            hintLettersCollectionView.dataSource = self
            hintLettersCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "identifier")
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init(with viewModel: AnyPlayGameViewModel) {
        self.viewModel = viewModel

        super.init(nibName: String(describing: Self.self), bundle: .main)
        viewModel.viewDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.nextLogo()
    }
}

extension PlayGameViewController: PlayGameViewDelegate {
    func updateCurrentLogo(_ viewModel: AnyCurrentLogoViewModel) {
        logoImageVIew.load(url: viewModel.imageURL)
        currentTryLabel.text = ""
        hintLettersCollectionView.reloadData()
//        viewModel.originalHintLettersIndexed
        // collection view reload with hint letters
    }
    
    func update(currentTry string: [String], hintLetters: [String], isMatched: Bool) {
        currentTryLabel.text = string.joined()
        // update collection view according to hiint letters
    }
}

extension PlayGameViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentLogoViewModel?.originalHintLettersIndexed.keys.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath)
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 24, height: 24)))
        cell.addSubview(label)
        
        label.text = viewModel.currentLogoViewModel?.originalHintLettersIndexed[indexPath.item]
        return cell
    }

}
