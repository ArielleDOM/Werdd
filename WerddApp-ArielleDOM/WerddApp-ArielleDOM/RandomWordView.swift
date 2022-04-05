//
//  HomeView.swift
//  WerddApp-ArielleDOM
//
//  Created by Arielle Domantay on 3/15/22.
//

import Foundation
import UIKit

import UIKit

class MainWordView: UIView {
    static let words = [
        Word(name: "Antelope Chipmunk", definition: "small ground squirrel of western United States", type: "noun"),
        Word(name: "Auricular Artery", definition: "artery that supplies blood to the ear", type: "noun"),
        Word(name: "Electric Circuit", definition: "an electrical device that provides a path for electrical current to flow", type: "noun"),
        Word(name: "Punic", definition: "of or relating to or characteristic of ancient Carthage or its people or their language", type: "adjective"),
        Word(name: "Glib", definition: "artfully persuasive in speech", type: "adjective"),
        Word(name: "Appetite", definition: "a feeling of craving something", type: "noun"),
        Word(name: "Authoritatively", definition: "in an authoritative and magisterial manner", type: "adverb"),
        Word(name: "Golf Links", definition: "a golf course that is built on sandy ground near a shore", type: "noun"),
        Word(name: "Unsay", definition: "take back what one has said", type: "verb"),
        Word(name: "Unbarreled", definition: "not in a barrel", type: "adjective")
    ]
    
    var wordTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = ""
        label.font = UIFont(name: "Chalkduster", size: 20)
        return label
    }()
    
    var wordType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .white
        label.font = UIFont(name: "Chalkduster", size: 10)

        return label
    }()
    
    var wordDefinition: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Chalkduster", size: 15)

        return label
    }()
    
    let eraserView: UIView = {
        let view = UIView(frame: CGRect(x: 25, y: 15, width: 50, height: 90))
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        return view
    }()
    
    lazy var refreshButton: RefreshButton = {
        let button = RefreshButton{ [weak self] in
            self?.changeMainWord()
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hexString: "#3B7349")
        layer.cornerRadius = 10
        layer.borderWidth = 8
        layer.borderColor = UIColor(hexString: "#93532D").cgColor
        
        staterWord()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        let wordTitleAndTypeStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false

            stackView.addArrangedSubview(wordTitle)
            stackView.addArrangedSubview(wordType)

            stackView.setCustomSpacing(10, after: wordTitle)
            stackView.axis = .vertical

            return stackView
        }()
        
        wordType.addUnderline()
        eraserView.layer.opacity = 0
        
        addSubview(wordTitleAndTypeStackView)
        addSubview(wordDefinition)
        addSubview(eraserView)
        addSubview(refreshButton)

        NSLayoutConstraint.activate([
            wordTitleAndTypeStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15),
            wordTitleAndTypeStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),

            wordDefinition.topAnchor.constraint(equalTo: wordTitleAndTypeStackView.bottomAnchor, constant: 10),
            wordDefinition.leadingAnchor.constraint(equalTo: wordTitleAndTypeStackView.leadingAnchor),
            wordDefinition.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -15),
            
            refreshButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -5),
            refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}

extension MainWordView {
    func chooseRandomWord() -> Word{
        let word: Word = MainWordView.words.randomElement()!
        return word
    }
    
    func staterWord() {
        let newWord = chooseRandomWord()
        
        wordTitle.text = newWord.name
        wordType.text = newWord.type
        wordDefinition.text = newWord.definition
    }

    func changeMainWord() {
        let newWord = chooseRandomWord()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { [self] in
            refreshButton.isEnabled = false
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { [self] in
                eraserView.layer.opacity = 1
            }, completion: {[self] _ in
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: { [self] in
                    wordTitle.layer.opacity = 0
                    wordType.layer.opacity = 0
                    wordDefinition.layer.opacity = 0
                })
            })
            
        }, completion: {[self] _ in
            
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: { [self] in
                eraserView.transform = CGAffineTransform(translationX: (frame.maxX-125), y: 0)
            }, completion: {[self] _ in
                
                UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseIn, animations: {
                    self.wordTitle.text = newWord.name
                    self.wordType.text = newWord.type
                    self.wordDefinition.text = newWord.definition
                    
                    wordTitle.layer.opacity = 1
                    wordType.layer.opacity = 1
                    wordDefinition.layer.opacity = 1
                    eraserView.layer.opacity = 0
                }, completion: {[self] _ in
                    eraserView.transform = CGAffineTransform(translationX: 0, y: 0)
                    refreshButton.isEnabled = true
                })
            })
            
        })
    }
}

extension UILabel {
    func addUnderline() {
        self.attributedText = NSAttributedString(string: self.text!,
                   attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}


