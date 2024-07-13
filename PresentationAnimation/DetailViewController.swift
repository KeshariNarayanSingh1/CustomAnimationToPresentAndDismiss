//
//  DetailViewController.swift
//  PresentationAnimation
//
//  Created by Keshari  on 10/07/24.
//

import UIKit

class DetailViewController: UIViewController {
    var onDoneBlock : ((Bool) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnAction(_ sender: Any) {
        let animationConfig = AnimationTransitionConfig(presentationDuration: 2, presentationOptions: .curveEaseIn, dismissalDuration: 2, dismissalOptions: .curveEaseInOut)
        let customTransitioningDelegate = CustomAnimationToPresentAndDismissDelegate(config: animationConfig)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = customTransitioningDelegate
        onDoneBlock?(true)

    }
}
