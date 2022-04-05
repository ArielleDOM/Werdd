//
//  File.swift
//  WerddApp-ArielleDOM
//
//  Created by Arielle Domantay on 3/28/22.
//

import Foundation
import UIKit


class WerddTableView: UITableView {
    
    var words: [Word] = MainWordView.words
    
    override init(frame: CGRect = .zero, style: UITableView.Style = .plain){
        super.init(frame: frame, style: style)
        
        layer.cornerRadius = 10
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WerddTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = words[indexPath.row].name
        content.secondaryText = words[indexPath.row].definition
        
        cell.contentConfiguration = content
        
        return cell
    }
}

class wordTableCell: UITableViewCell {
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(hexString: "#3B7349")
        layer.cornerRadius = 10
        layer.borderWidth = 8
        layer.borderColor = UIColor(hexString: "#93532D").cgColor
        
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

        NSLayoutConstraint.activate([
            wordTitleAndTypeStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15),
            wordTitleAndTypeStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),

            wordDefinition.topAnchor.constraint(equalTo: wordTitleAndTypeStackView.bottomAnchor, constant: 10),
            wordDefinition.leadingAnchor.constraint(equalTo: wordTitleAndTypeStackView.leadingAnchor),
            wordDefinition.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -15),
        ])
    }
}
