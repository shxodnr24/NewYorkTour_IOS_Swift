//
//  ExpandibleHeader.swift
//  NewYorkTour
//
//  Created by Taewook Noh on 2018. 4. 3..
//  Copyright © 2018년 taewook. All rights reserved.
//

import UIKit

protocol ExpandibleHeaderDelegate {
    func togglesection(header :ExpandibleHeader, section: Int )
}

class ExpandibleHeader: UITableViewHeaderFooterView {
    var delegate: ExpandibleHeaderDelegate?
    var section: Int!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func selectHeaderAction(GestureRecognizer: UITapGestureRecognizer) {
        let cell = GestureRecognizer.view as! ExpandibleHeader
        delegate?.togglesection(header: self, section: cell.section )
    }
    func customInit(title: String, section: Int, delegate:ExpandibleHeaderDelegate)
    {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.darkGray
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
