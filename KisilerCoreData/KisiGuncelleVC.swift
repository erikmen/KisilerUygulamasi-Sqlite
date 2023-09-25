//
//  KisiGuncelleVC.swift
//  KisilerCoreData
//
//  Created by Kaan Deniz Erikmen on 13.09.2023.
//

import UIKit

class KisiGuncelleVC: UIViewController {

    @IBOutlet weak var txtFKisiTelefon: UITextField!
    @IBOutlet weak var txtFKisiAd: UITextField!
    
    var kisi:Kisiler?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let k = kisi{
            txtFKisiAd.text = k.kisi_ad
            txtFKisiTelefon.text = k.kisi_tel
            
        }
        
    }
    

    

    @IBAction func btnGuncelle(_ sender: Any) {
        
        if let k = kisi, let ad = txtFKisiAd.text, let tel = txtFKisiTelefon.text{
            Kisilerdao().KisiGuncelle(kisi_id: k.kisi_id!, kisi_ad: ad, kisi_tel: tel)
        }
    }
}
