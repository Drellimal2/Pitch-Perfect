//
//  Utils.swift
//  Pitch Perfect
//
//  Created by Dane Miller on 6/11/17.
//  Copyright © 2017 Dane Miller. All rights reserved.
//

import Foundation
import UIKit

struct SegueIdentifiers{
    static let playback = "showPlayback"
    
}

func basicAlert(title : String, message : String, context : UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

    context.present(alert, animated: true, completion: nil)
}
