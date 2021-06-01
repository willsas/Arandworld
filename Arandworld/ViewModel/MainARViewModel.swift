//
//  MainARViewModel.swift
//  Arandworld
//
//  Created by Willa on 02/06/21.
//

import Foundation

class MainARViewModel {
    
    func checkLogin(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completion()
        }
    }
}
