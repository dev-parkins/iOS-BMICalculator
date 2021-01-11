//
//  BmiModel.swift
//  Christopher_Parkins_BMI Calculator Project
//
//  Created by Testing Lab on 11/15/20.
//

import Foundation

struct BmiModel: Decodable {
    let bmi: Float?;
    let more: [URL];
    let risk: String?;
}
