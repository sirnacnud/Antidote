//
//  CallBaseController.swift
//  Antidote
//
//  Created by Dmytro Vorobiov on 04.02.16.
//  Copyright © 2016 dvor. All rights reserved.
//

import UIKit
import SnapKit

private struct Constants {
    static let TopContainerHeight = 80.0
    static let CallerLabelTopOffset = 20.0
    static let InfoLabelBottomOffset = -5.0
    static let LabelHorizontalOffset = 20.0
}

class CallBaseController: UIViewController {
    let theme: Theme

    let callerName: String

    var topContainer: UIView!
    var callerLabel: UILabel!
    var infoLabel: UILabel!

    private var topContainerTopConstraint: Constraint!

    init(theme: Theme, callerName: String) {
        self.theme = theme
        self.callerName = callerName

        super.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        loadViewWithBackgroundColor(.clearColor())

        addBlurredBackground()
        createTopViews()
        installConstraints()
    }

    /**
        Prepare for removal by disabling all active views.
     */
    func prepareForRemoval() {
        infoLabel.text = String(localized: "call_ended")
    }

    func toggleTopContainer(hidden hidden: Bool) {
        let offset = hidden ? -topContainer.frame.size.height : 0.0
        topContainerTopConstraint.updateOffset(offset)
    }
}

private extension CallBaseController {
    func addBlurredBackground() {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        effectView.frame = view.bounds

        view.insertSubview(effectView, atIndex: 0)
        effectView.snp_makeConstraints {
            $0.edges.equalTo(view)
        }
    }

    func createTopViews() {
        topContainer = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        view.addSubview(topContainer)

        callerLabel = UILabel()
        callerLabel.text = callerName
        callerLabel.textColor = theme.colorForType(.CallTextColor)
        callerLabel.textAlignment = .Center
        callerLabel.font = UIFont.systemFontOfSize(20.0)
        topContainer.addSubview(callerLabel)

        infoLabel = UILabel()
        infoLabel.textColor = theme.colorForType(.CallTextColor)
        infoLabel.textAlignment = .Center
        infoLabel.font = UIFont.antidoteFontWithSize(18.0, weight: .Light)
        topContainer.addSubview(infoLabel)
    }

    func installConstraints() {
        topContainer.snp_makeConstraints {
            topContainerTopConstraint = $0.top.equalTo(view).constraint
            $0.top.leading.trailing.equalTo(view)
            $0.height.equalTo(Constants.TopContainerHeight)
        }

        callerLabel.snp_makeConstraints {
            $0.top.equalTo(topContainer).offset(Constants.CallerLabelTopOffset)
            $0.leading.equalTo(topContainer).offset(Constants.LabelHorizontalOffset)
            $0.trailing.equalTo(topContainer).offset(-Constants.LabelHorizontalOffset)
        }

        infoLabel.snp_makeConstraints {
            $0.bottom.equalTo(topContainer).offset(Constants.InfoLabelBottomOffset)
            $0.leading.equalTo(topContainer).offset(Constants.LabelHorizontalOffset)
            $0.trailing.equalTo(topContainer).offset(-Constants.LabelHorizontalOffset)
        }
    }
}
