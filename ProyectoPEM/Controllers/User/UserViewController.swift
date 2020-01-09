//
//  UserViewController.swift
//  ProyectoPEM
//
//  Created by Jose Daniel on 23/12/2019.
//  Copyright © 2019 Jose Daniel. All rights reserved.
//

import UIKit
import WebKit


class UserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    
    
    var data: TableData?
    
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var sample: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    //List of obj
    var objList: [Obj] = []
    
    //Filtered list
    var objFilteredList: [Obj] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        id.text = (data?.getUserId())! + (data?.getIdSearch())!
               
        sample.text = (data?.getIdSample())!
               
        loadURL()
        
        makeSearchBar()
        
        fillObjList()
               
        objFilteredList = objList
        
        
        
        navigationItem.title = "User Viewer"

        // Do any additional setup after loading the view.
    }
    
    func fillObjList(){
        var i  = 0
        while i<(data?.cell_lineList.count)!{
            objList.append(Obj(name: (data?.getCellLineList()[i])!, gi50: (data?.getGi50List()[i])!, idexp: (data?.getIdExpList()[i])!))
            i += 1
        }
    }
    
    func makeSearchBar() {
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    /*
    Method to hide the keyboard
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func loadURL()->Void{

        let myURL = URL(string:"https://cactus.nci.nih.gov/chemical/structure/" + (data?.getSmiles())! + "/image")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objFilteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userResultsCell", for: indexPath) as! UserTableViewCell
        
       
        cell.cellLine.text = objFilteredList[indexPath.row].getName()
        
        cell.gi50.text = objFilteredList[indexPath.row].getGi50()
        
        
        
        return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let message = "Cell line: \t \(objFilteredList[indexPath.row].getName()) \n" +
                        "GI50: \t \(objFilteredList[indexPath.row].getGi50()) \n" +
                        "ID Exp: \t \(objFilteredList[indexPath.row].getIdexp()) \n" +
                        "Notes: \t \((data?.notes)!) \n" +
                        "Soluble: \t \((data?.soluble)!)"
        
        let alertController = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
            )
        alertController.addAction(UIAlertAction(title: "Ok",style: .cancel))

        self.present(alertController, animated: true, completion: nil)
        
    }
    
   // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var nameList: [String]!
        var i = 0
        
        //print("Pasa por aqui 1")
        nameList = searchText.isEmpty ? data?.cell_lineList : data?.cell_lineList.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
        //   print("Pasa por aqui 2")
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
           }
        objFilteredList = objList
        // print("pasa por aqui 3")
           
        while i<nameList.count{
            if nameList[i] != objFilteredList[i].getName(){
                objFilteredList.remove(at: i)
                //  print(nameList.count)
               }
               i+=1
           }
        let x = nameList.count
        while x != objFilteredList.count{
            objFilteredList.removeLast()
            //print(objFilteredList.count)
           }
           
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
