//
//  UiView+RoundCorners.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 23/12/2021.
//

import Foundation
import UIKit
import SwiftUI

class RoundView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
    }
}

class RoundImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
    }
}
