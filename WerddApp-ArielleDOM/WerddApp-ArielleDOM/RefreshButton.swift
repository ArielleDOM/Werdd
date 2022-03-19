//
//  RefreshButton.swift
//  WerddApp-ArielleDOM
//
//  Created by Arielle Domantay on 3/19/22.
//

import Foundation
import UIKit

class RefreshButton: UIButton {
    
    var completion: (() -> Void)?
    
    init(completion: (() -> Void)?, frame: CGRect = .zero) {
        self.completion = completion
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        tintColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
        let buttonImage = UIImage(systemName: "arrow.triangle.2.circlepath.circle", withConfiguration: config)
        setImage(buttonImage, for: .normal)
        
        addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc func pressed() {
        completion?()
    }
}
