//
//  ViewController.swift
//  Christopher_Parkins_BMI Calculator Project
//
//  Created by Testing Lab on 11/15/20.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    @IBOutlet weak var riskMessage: UILabel!
    @IBOutlet weak var bmiMessage: UILabel!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var heightText: UITextField!
    @IBAction func executeCallBmiAPI(_sender: UIButton){
        let height = heightText!.text!;
        let weight = weightText!.text!;
        
        if height == "" || weight == ""{
            DispatchQueue.main.async {
                self.riskMessage.textColor = UIColor.red
                self.riskMessage.text = "Missing height or weight, try again."
                self.bmiMessage.text = String()
            }
        } else {
            let urlString:String = "http://webstrar99.fulton.asu.edu/page3/Service1.svc/calculateBMI?height=\(height)&weight=\(weight)";
            let apiUrl:URL = URL(string: urlString)!;
            let request:URLRequest! = URLRequest(url: apiUrl);
            
            let urlSession = URLSession.shared;
            
            let jsonQuery = urlSession.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
                if error != nil{
                    DispatchQueue.main.async {
                        self.riskMessage.textColor = UIColor.red;
                        self.riskMessage.text = "API Service is unavailable";
                    }
                } else {
                    let decoder = JSONDecoder();
                    
                    let model = try! decoder.decode(BmiModel.self, from: data!);
                    let result = BmiModel(bmi: model.bmi, more: model.more, risk: model.risk)
                    
                    DispatchQueue.main.async {
                        self.bmiMessage.text = String(Float(result.bmi!));
                        self.riskMessage.text = result.risk;
                        
                        if(result.bmi! < 18 ) {
                            self.riskMessage.textColor = UIColor.blue
                        } else if(result.bmi! < 25) {
                            self.riskMessage.textColor = UIColor.yellow
                        } else if(result.bmi! <= 30) {
                            self.riskMessage.textColor = UIColor.purple
                        } else {
                            self.riskMessage.textColor = UIColor.red
                        }
                    }
                }
            });
            
            jsonQuery.resume();
        }
    };
    
    @IBAction func executeEducateMe(_sender: UIButton){
        let urlString:String = "http://webstrar99.fulton.asu.edu/page3/Service1.svc/calculateBMI?height=50&weight=180";
        let apiUrl:URL = URL(string: urlString)!;
        let request:URLRequest! = URLRequest(url: apiUrl);
        
        let urlSession = URLSession.shared;
        
        let jsonQuery = urlSession.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if error != nil{
                DispatchQueue.main.async {
                    self.riskMessage.textColor = UIColor.red;
                    self.riskMessage.text = "API Service is unavailable";
                }
            } else {
                let decoder = JSONDecoder();
                
                let model = try! decoder.decode(BmiModel.self, from: data!);
                let result = BmiModel(bmi: model.bmi, more: model.more, risk: model.risk)
                
                DispatchQueue.main.async {
                    if let url = URL(string: result.more[0].absoluteString) {
                        let vc = SFSafariViewController(url: url);
                        vc.delegate = self;
                        self.present(vc, animated: true, completion: nil);
                    }
                }
            }
        });
        
        jsonQuery.resume();
    }
    
    func safariViewController(_controller: SFSafariViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func safariViewController(_controller: SFSafariViewController, didCompleteInitialLoad: Bool, didLoadSuccessfully: Bool){
        if didLoadSuccessfully == false {
            print("Page didn't load")
            _controller.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heightText.addDoneButtonKeyBoard();
        weightText.addDoneButtonKeyBoard();
    }
}

