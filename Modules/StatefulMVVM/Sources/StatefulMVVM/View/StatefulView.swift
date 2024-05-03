//
//  StatefulView.swift
//

import UIKit

public protocol StatefulView: AnyObject, CustomLogDescriptionConvertible {
    
    associatedtype State: ViewStateProtocol
    
    var renderPolicy: RenderPolicy { get }
    
    // Never call it directly. Always call viewModel's `subscribe(from:)`. Some advantages:
    //
    // 1. We have "arrow consistency", always being rendered by viewModel's command, minimizing
    // view logic. View only decides when it's ready to subscribe, depending on its lifecycle.
    //
    // 2. Avoid rendering the view when not appropriate, such as when trying to render in a thread
    // different from the main one, when the view is not yet on the screen or trying to render the
    // very same state.
    func render(state: State)
}

extension StatefulView where Self: UIViewController {
    public var renderPolicy: RenderPolicy {
        return isViewLoaded ? .possible : .notPossible(.viewNotReady)
    }

    public var logDescription: String {
        return title ?? String(describing: type(of: self))
    }
}

extension StatefulView where Self: UIView {
    public var renderPolicy: RenderPolicy {
        return superview != nil ? .possible : .notPossible(.viewNotReady)
    }

    public var logDescription: String {
        return String(describing: type(of: self))
    }
}
