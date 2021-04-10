//
//  LogoLoader.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import Foundation

enum LogoGroup {

    case all
    
    var fileName: String {
        switch self {
        case .all: return "Logos.json"
        }
    }
}

protocol AnyLogoLoader {
    func fetchLogoGroup(_ group: LogoGroup, completion: @escaping ([Logo]) -> Void)
}

struct LogoLoader: AnyLogoLoader {

    func fetchLogoGroup(_ group: LogoGroup, completion: @escaping ([Logo]) -> Void) {
        let logos = Bundle.main.decode([Logo].self, from: group.fileName)
        completion(logos)
    }
}
