//
//  UIViewController+extension.swift
//  Finish-Sample
//
//  Created by i9400503 on 2019/11/5.
//  Copyright © 2019 BrilleShine. All rights reserved.
//

import UIKit

extension UIViewController{

    final class func fromStoryboard(_ storyboardName : String? = nil) -> UIViewController{

        let name = String(describing: self)
        let storyboardName = storyboardName ?? name

        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: name)
    }
}
