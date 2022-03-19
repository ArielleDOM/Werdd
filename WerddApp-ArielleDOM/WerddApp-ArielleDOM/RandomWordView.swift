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
    let words = [
        Word(name: "Antelope Chipmunk", definition: "small ground squirrel of western United States", partOfSpeech: "noun"),
        Word(name: "Auricular Artery", definition: "artery that supplies blood to the ear", partOfSpeech: "noun"),
        Word(name: "Electric Circuit", definition: "an electrical device that provides a path for electrical current to flow", partOfSpeech: "noun"),
        Word(name: "Punic", definition: "of or relating to or characteristic of ancient Carthage or its people or their language", partOfSpeech: "adjective"),
        Word(name: "Glib", definition: "artfully persuasive in speech", partOfSpeech: "adjective"),
        Word(name: "Appetite", definition: "a feeling of craving something", partOfSpeech: "noun"),
        Word(name: "Authoritatively", definition: "in an authoritative and magisterial manner", partOfSpeech: "adverb"),
        Word(name: "Golf Links", definition: "a golf course that is built on sandy ground near a shore", partOfSpeech: "noun"),
        Word(name: "Unsay", definition: "take back what one has said", partOfSpeech: "verb"),
        Word(name: "Unbarreled", definition: "not in a barrel", partOfSpeech: "adjective")
    ]
    
    var title: String = ""
    var type: String = ""
    var definition: String = ""
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hexString: "#3B7349")
        layer.cornerRadius = 10
        layer.borderWidth = 8
        layer.borderColor = UIColor(hexString: "#93532D").cgColor
        
        changeMainWord()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        let wordTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.text = title
            label.font = UIFont(name: "Chalkduster", size: 24)
            return label
        }()

        let wordType: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = type
            label.addUnderline()
            label.textColor = .white
            label.font = UIFont(name: "Chalkduster", size: 15)

            return label
        }()

        let wordDefinition: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = definition
            label.textColor = .white
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = UIFont(name: "Chalkduster", size: 18)

            return label
        }()

        let wordTitleAndTypeStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false

            stackView.addArrangedSubview(wordTitle)
            stackView.addArrangedSubview(wordType)

            stackView.setCustomSpacing(35, after: wordTitle)
            stackView.axis = .horizontal

            return stackView
        }()
        
        lazy var refreshButton: RefreshButton = {
            let button = RefreshButton{ [weak self] in
                self?.changeMainWord()
            }
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }()
        
        addSubview(wordTitleAndTypeStackView)
//        addSubview(wordTitle)
//        addSubview(wordType)
        addSubview(wordDefinition)
        addSubview(refreshButton)

        NSLayoutConstraint.activate([
            wordTitleAndTypeStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15),
            wordTitleAndTypeStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),
            
//            wordTitle.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 20),
//            wordTitle.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),
//            wordTitle.trailingAnchor.constraint(lessThanOrEqualTo: wordType.leadingAnchor),
//            
//            wordType.topAnchor.constraint(equalTo: wordTitle.layoutMarginsGuide.topAnchor, constant: -2),
//            wordType.leadingAnchor.constraint(equalTo: wordTitle.layoutMarginsGuide.trailingAnchor, constant: 25),
//            wordType.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor, constant: -10),

            wordDefinition.topAnchor.constraint(equalTo: wordTitle.bottomAnchor, constant: 10),
            wordDefinition.leadingAnchor.constraint(equalTo: wordTitle.leadingAnchor),
            wordDefinition.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -15),
            
            refreshButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            refreshButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            refreshButton.widthAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}

extension MainWordView {
    func chooseRandomWord() -> Word{
        let word: Word = words.randomElement()!
        return word
    }

    func changeMainWord() {
        let newWord = chooseRandomWord()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { [self] in
            title = ""
            type = ""
            definition = ""
        }, completion: {[self] _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.title = newWord.name
                self.type = newWord.partOfSpeech
                self.definition = newWord.definition
                setUpViews()
            })
        })
        
        setNeedsLayout()
    }
}


