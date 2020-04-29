//
//  StartViewController.swift
//  dropy
//
//  Created by hannan parvez on 27/03/20.
//  Copyright © 2020 hannan parvez. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet var continueoption: UIButton!
    @IBOutlet var highscore: UILabel!
    var tablevisible=true
    @IBOutlet var levelbtn: UIButton!
    @IBOutlet var dropdowntable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dropdowntable.delegate=self
        dropdowntable.dataSource=self
        dropdowntable.isHidden=true
        if let a=UserDefaults.standard.object(forKey: "beginnerhighscore") as? Int{
            highscore.text=a.description
        }
        else{
            highscore.text=0.description
        }
        
        

        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "pendinggame"){
            continueoption.isHidden=false
        }
        else{
            continueoption.isHidden=true
        }
        switch  levelbtn.title(for: .normal){
        case "Beginner":
            if let a=UserDefaults.standard.object(forKey: "beginnerhighscore") as? Int{
                highscore.text=a.description
            }
            else{
                highscore.text=0.description
            }
        case "Intermediate":
            if let a=UserDefaults.standard.object(forKey: "intermediatehighscore") as? Int{
                highscore.text=a.description
            }
            else{
                highscore.text=0.description
            }
        case "Expert":
            if let a=UserDefaults.standard.object(forKey: "experthighscore") as? Int{
                highscore.text=a.description
            }
            else{
                highscore.text=0.description
            }
        default:
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="continue"{
            let vc = segue.destination as! ViewController
            vc.totalscore=UserDefaults.standard.integer(forKey: "pendinggamescore")
            if UserDefaults.standard.string(forKey: "pendinggamelevel") == "beginner"{
                vc.howdificult=difficulty.beginner
            }
            else if UserDefaults.standard.string(forKey: "pendinggamelevel")=="intermediate"{
                vc.howdificult=difficulty.intermediate
            }
            else if UserDefaults.standard.string(forKey: "pendinggamelevel")=="expert" {
                vc.howdificult=difficulty.expert
            }
            else{
                
            }
        }
        if segue.identifier=="newgame"{
            UserDefaults.standard.set(false, forKey: "pendinggame")
            let vc = segue.destination as! ViewController
            if levelbtn.title(for: .normal)=="Beginner"{
                vc.howdificult=difficulty.beginner
            }
            else if levelbtn.title(for: .normal)=="Intermediate"{
                vc.howdificult=difficulty.intermediate
            }
            else{
                vc.howdificult=difficulty.expert
            }
            
        }
    }
    
    @IBAction func chooselevel(_ sender: Any) {
        
        if tablevisible{
            dropdowntable.isHidden=false
            tablevisible=false
        }
        else{
            dropdowntable.isHidden=true
            tablevisible=true
        }
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
extension StartViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! dropdowncell
        if indexPath.row==0{
            
            cell.dropdownlabel.text="Beginner"
        }
        else if indexPath.row==1{
            cell.dropdownlabel.text="Intermediate"
        }
        else{
            cell.dropdownlabel.text="Expert"
        }
        dropdowntable.sizeToFit()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isHidden=true
        tablevisible=true
            switch indexPath.row{
            case 0:
                levelbtn.setTitle("Beginner", for: .normal)
                            if let a=UserDefaults.standard.object(forKey: "beginnerhighscore") as? Int{
                                highscore.text=a.description
                            }
                            else{
                                highscore.text=0.description
                            }
                
            case 1:
                levelbtn.setTitle("Intermediate", for: .normal)
                             
                             if let a = UserDefaults.standard.object(forKey: "intermediatehighscore") as? Int{
                                 highscore.text=a.description
                             }
                             else{
                                 highscore.text=0.description
                             }
                
            case 2:
                levelbtn.setTitle("Expert", for: .normal)
                              
                              if let a=UserDefaults.standard.object(forKey: "experthighscore") as? Int{
                                  highscore.text=a.description
                              }
                              else{
                                  highscore.text=0.description
                              }
            default:
                return
        }
                
                
            }
            
    
}

class dropdowncell:UITableViewCell{
    
    @IBOutlet var dropdownlabel: UILabel!
}
enum difficulty {
    case beginner
    case intermediate
    case expert
}
