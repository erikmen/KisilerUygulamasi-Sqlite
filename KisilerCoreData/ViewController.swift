//
//  ViewController.swift
//  KisilerCoreData
//
//  Created by Kaan Deniz Erikmen on 13.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var kisilerTableView: UITableView!
    
    var aramaYapiliyorMu = true
    var aramaKelimesi:String?
    
    
    
    var liste = [Kisiler]()
    override func viewDidLoad() {
        super.viewDidLoad()
        veritabaniKopyala()
    
        if aramaYapiliyorMu {
            liste = Kisilerdao().AramaYap(kisi_ad: aramaKelimesi!)
        }else{
            liste = Kisilerdao().TumKisileriAl()
        }
                
                
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        
        

        searchBar.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        liste = Kisilerdao().TumKisileriAl()
        kisilerTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if segue.identifier == "toDetay"{
            let gidilecekVC = segue.destination as! KisiDetayVC
            gidilecekVC.kisi = liste[indeks!]
        }
        
        if segue.identifier == "toGuncelle"{
            let gidilecekVC = segue.destination as! KisiGuncelleVC
            
            gidilecekVC.kisi = liste[indeks!]
        }
    }
    func veritabaniKopyala() {
        let bundleYolu = Bundle.main.path(forResource: "kisiler", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("kisiler.sqlite")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten Var")
        }else{
            do {
                try  fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            } catch  {
                print(error)
            }
        }
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liste.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisicell = self.liste[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! kisiHucreTableViewCell
        cell.lblKisiAlan.text = "\(kisicell.kisi_ad!) - \(kisicell.kisi_tel!)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){
            (contextualAction,view,boolValue) in
            let kisisil = self.liste[indexPath.row]
            Kisilerdao().KisiSil(kisi_id: kisisil.kisi_id!)
            if self.aramaYapiliyorMu {
                self.liste = Kisilerdao().AramaYap(kisi_ad: self.aramaKelimesi!)
            }else{
                self.liste = Kisilerdao().TumKisileriAl()
            }
            
            
            self.kisilerTableView.reloadData()
        }
        
        let guncelleAction = UIContextualAction(style: .normal, title: "Güncelle"){(contextualAction,view,boolValue) in
            
            
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
            
            
        }
        return UISwipeActionsConfiguration(actions: [silAction,guncelleAction])
    }
    
}

extension ViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama Sonuç = \(searchText)")
        
        aramaKelimesi = searchText
        if searchText == " " {
            aramaYapiliyorMu = false
        }else{
            aramaYapiliyorMu = true
        }
        self.liste = Kisilerdao().AramaYap(kisi_ad: aramaKelimesi!)
        
        kisilerTableView.reloadData()
    }
    
}
