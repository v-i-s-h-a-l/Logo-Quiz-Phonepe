//
//  PlayGameViewController.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import UIKit

class PlayGameViewController: UIViewController {
    
    private var viewModel: AnyPlayGameViewModel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init(with viewModel: AnyPlayGameViewModel) {
        self.viewModel = viewModel

        super.init(nibName: String(describing: Self.self), bundle: .main)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
