//
//  ItemsInfoController.swift
//  PryanikyTest
//
//  Created by Ирина Кольчугина on 10.03.2021.
//

import UIKit
import SDWebImage

class ItemsInfoController: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var textLable: UILabel!
    @IBOutlet weak var textFromSelector: UILabel!
    @IBOutlet weak var selectorControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dataIndex != nil {
            self.title = DataJson.shared[dataIndex!].name
            
            if DataJson.shared[dataIndex!].textFromData != nil {
                textLable.isHidden = false
                textLable.text = DataJson.shared[dataIndex!].textFromData
            }
            
            if DataJson.shared[dataIndex!].url != nil {
                itemImageView.isHidden = false
                let url = URL(string: DataJson.shared[dataIndex!].url!)
                itemImageView.sd_setImage(with: url, completed: nil)
            }
            
            if DataJson.shared[dataIndex!].selectedId != nil {
                selectorControl.isHidden = false
                textFromSelector.isHidden = false
                textFromSelector.text = ""
                let variants = DataJson.shared[dataIndex!].variants
                selectorControl.removeAllSegments()
                for item in (0..<variants!.count) {
                    selectorControl.insertSegment(withTitle: "\(variants![item].id)", at: item, animated: true)
                }
                selectorControl.addTarget(self, action: #selector(variantsDidChange(_:)), for: .valueChanged)
            }
            
        }
    }
    
    @objc func variantsDidChange(_ segmentControl: UISegmentedControl) {
        let variants = DataJson.shared[dataIndex!].variants
        textFromSelector.text = variants![selectorControl.selectedSegmentIndex].textFromVariants
    }
    
    
}
