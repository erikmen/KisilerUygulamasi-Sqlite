//
//  KisiEkleVC.swift
//  KisilerCoreData
//
//  Created by Kaan Deniz Erikmen on 13.09.2023.
//

import UIKit

class KisiEkleVC: UIViewController {

    @IBOutlet weak var txtFKisiTelefon: UITextField!
    @IBOutlet weak var txtFKisiAd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func btnEkle(_ sender: Any) {
        if let ad = txtFKisiAd.text, let tel = txtFKisiTelefon.text{
            Kisilerdao().KisiEkle(kisi_ad: ad, kisi_tel: tel)
        }
        txtFKisiAd.text = ""
        txtFKisiTelefon.text = ""
    }
    
}
