//
//  WBTimelineContentView.swift
//  AsyncDrawingKit-Demo
//
//  Created by DSKcpp on 2017/5/27.
//  Copyright © 2017年 DSKcpp. All rights reserved.
//

import UIKit

final class WBTimelineContentView: UIView {
    
    class func height(of timelineItem: WBTimelineItem, contentWidth: CGFloat) -> CGFloat {
        return 0
    }
    
    var timelineItem: WBTimelineItem! {
        didSet  {
            setTimelineItem()
        }
    }
    
    private func setTimelineItem() {
        
    }
}

