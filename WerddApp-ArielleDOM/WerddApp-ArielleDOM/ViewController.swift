//
//  ViewController.swift
//  WerddApp-ArielleDOM
//
//  Created by Arielle Domantay on 3/15/22.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    var mainWordView: MainWordView
    
    init(){
        self.mainWordView = MainWordView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        view.backgroundColor = UIColor(hexString: "#4D504B")
        
    }
    
    func setupViews(){
        let mainViewAppTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Werdd."
            label.textColor = .white
            label.font = UIFont(name: "Chalkduster", size: 40)

            return label
        }()
        
        mainWordView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainViewAppTitle)
        view.addSubview(mainWordView)
        
        NSLayoutConstraint.activate([
            mainViewAppTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainViewAppTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainViewAppTitle.trailingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            
            mainWordView.topAnchor.constraint(equalTo: mainViewAppTitle.bottomAnchor, constant: 50),
            mainWordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainWordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainWordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
        ])
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

extension UILabel {
    func addUnderline() {
        self.attributedText = NSAttributedString(string: self.text!,
                   attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}

