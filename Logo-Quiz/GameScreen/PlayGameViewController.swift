//
//  PlayGameViewController.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import UIKit

class PlayGameViewController: UIViewController {
    
    private var viewModel: AnyPlayGameViewModel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var logoImageVIew: UIImageView!
    @IBOutlet weak var currentTryLabel: UILabel!
    @IBOutlet weak var hintLettersCollectionView: UICollectionView! {
        didSet {
            hintLettersCollectionView.delegate = self
            hintLettersCollectionView.dataSource = self
            hintLettersCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "identifier")
            hintLettersCollectionView.allowsSelection = true
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
    
    @IBAction func deleteButtonTapped(_ sender: AnyObject) {
        viewModel.currentLogoViewModel?.removeFromCurrentSelected(nil)
    }
}

extension PlayGameViewController: PlayGameViewDelegate {
    
    func updateCurrentLogo(_ viewModel: AnyCurrentLogoViewModel) {
        logoImageVIew.image = nil
        logoImageVIew.load(url: viewModel.imageURL)
        currentTryLabel.text = ""
        hintLettersCollectionView.reloadData()
//        viewModel.originalHintLettersIndexed
        // collection view reload with hint letters
    }
    
    func update(currentTry string: String) {
        currentTryLabel.text = string
        hintLettersCollectionView.reloadData()
        // update collection view according to hiint letters
    }
    
    func updateScore(_ score: String) {
        scoreLabel.text = score
    }
}

extension PlayGameViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.hintLetters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath)
        if let existingLabel = cell.subviews.first(where: { $0.isKind(of: UILabel.self) }) as? UILabel {
            existingLabel.text = viewModel.hintLetters[indexPath.item]
        } else {
            let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 24, height: 24)))
            cell.addSubview(label)
            label.text = viewModel.hintLetters[indexPath.item]
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.currentLogoViewModel?.appendFromIndex(indexPath.item)
    }
}
