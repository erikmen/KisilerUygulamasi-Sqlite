//
//  KisiDetayVC.swift
//  KisilerCoreData
//
//  Created by Kaan Deniz Erikmen on 13.09.2023.
//

import UIKit

class KisiDetayVC: UIViewController {

    @IBOutlet weak var lblkisiAd: UILabel!
    @IBOutlet weak var lblKisiTelefon: UILabel!
    
    var kisi:Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let k = kisi {
            lblkisiAd.text = k.kisi_ad
            lblKisiTelefon.text = k.kisi_tel
        }
        
    }
    



}
