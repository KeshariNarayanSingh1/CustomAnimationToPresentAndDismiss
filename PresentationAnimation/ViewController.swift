//
//  ViewController.swift
//  PresentationAnimation
//
//  Created by Keshari  on 10/07/24.
//

import UIKit

struct AnimationTransitionConfig {
    let presentationDuration: TimeInterval
    let presentationOptions: UIView.AnimationOptions
    let dismissalDuration: TimeInterval
    let dismissalOptions: UIView.AnimationOptions

    init(presentationDuration: TimeInterval = 0.5,
         presentationOptions: UIView.AnimationOptions = .curveEaseIn,
         dismissalDuration: TimeInterval = 0.5,
         dismissalOptions: UIView.AnimationOptions = .curveEaseOut) {
        self.presentationDuration = presentationDuration
        self.presentationOptions = presentationOptions
        self.dismissalDuration = dismissalDuration
        self.dismissalOptions = dismissalOptions
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnAction(_ sender: Any) {
        let animationConfig = AnimationTransitionConfig(presentationDuration: 2, presentationOptions: .curveEaseIn, dismissalDuration: 2, dismissalOptions: .curveEaseInOut)
        let customTransitioningDelegate = CustomAnimationToPresentAndDismissDelegate(config: animationConfig)
        let detailVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVc.onDoneBlock = { isTrue in
            self.dismiss(animated: true)
        }
        detailVc.modalPresentationStyle = .custom
        detailVc.transitioningDelegate = customTransitioningDelegate
        self.present(detailVc, animated: true)
    }
    
}


