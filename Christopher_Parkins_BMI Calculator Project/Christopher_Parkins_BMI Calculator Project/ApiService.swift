//
//  ApiService.swift
//  Christopher_Parkins_BMI Calculator Project
//
//  Created by Testing Lab on 11/15/20.
//

import Foundation

class ApiService {
    
    func callWebService(height:String, weight:String) -> BmiModel {
        let urlString:String = "http://webstrar99.fulton.asu.edu/page3/Service1.svc/calculateBMI?height=\(height)&weight=\(weight)";
        let apiUrl:URL = URL(string: urlString)!;
        let request:URLRequest! = URLRequest(url: apiUrl);
        
        var result:BmiModel = BmiModel(bmi: 0, more: [], risk: "");
        let urlSession = URLSession.shared;
        
        let jsonQuery = urlSession.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            let decoder = JSONDecoder();
            
            let model = try! decoder.decode(BmiModel.self, from: data!);
            result = BmiModel(bmi: model.bmi, more: model.more, risk: model.risk)
            
        });
        
        jsonQuery.resume();
        
        return result;
    }
}
