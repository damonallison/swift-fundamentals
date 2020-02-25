//
//  StackViewTableViewCell.swift
//  SwiftFundamentals-iOS
//
//  Created by Damon Allison on 2/24/20.
//  Copyright © 2020 Damon Allison. All rights reserved.
//

import UIKit

struct ConfigData {
    let rows: Int
    let text: String
}
class StackViewTableViewCell : UITableViewCell {

    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    func configure(config: ConfigData) {

        label.text = config.text
        
        //
        // Dynamically add
        for i in 0..<config.rows {
            
            
            //
            // Start a new row
            
            let sv = UIStackView()
            sv.axis = .horizontal
            sv.alignment = .leading
            sv.distribution = .fill
            sv.spacing = 20.0
            
            
            let lbl = UILabel()
            lbl.text = "This is row \(i)"
            sv.addArrangedSubview(lbl)
            // self.stackView.addArrangedSubview(lbl)
            
            // Let's center the button
            let btn = UIButton(type: .close)
            btn.setTitle("X", for: .normal)
            btn.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            btn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
            btn.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
            sv.addArrangedSubview(btn)

            self.stackView.addArrangedSubview(sv)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Remove *all* views from the UIStackViewπ
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("button tapped \(sender!)")
    }
    
}
