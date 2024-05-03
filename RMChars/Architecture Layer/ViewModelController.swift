//
//  ViewModelController.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 01.05.2024.
//

import StatefulMVVM
import UIKit
import SnapKit

open class ViewModelController<State: ViewState, VM: ViewModel<State>>: UIViewController, StatefulView {
    public let viewModel: VM
    
    /// state property only for unit tests
    public private(set) var state: State

    // MARK: - Init

    public init(
        nibName nibNameOrNil: String? = nil,
        bundle nibBundleOrNil: Bundle? = nil,
        viewModel: VM
    ) {
        self.viewModel = viewModel
        self.state = viewModel.state
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public init(viewModel: VM) {
        self.viewModel = viewModel
        self.state = viewModel.state
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.subscribe(view: self)
    }

    open func setupUI() {
        // override this method in child class
    }

    /// override this method in child class
    open func render(state: State) {
        self.state = state
    }
}

public extension UIViewController {

    func showIndicatorView() {
        ProgressHUD.show()
    }
    
    func hideIndicatorView() {
        ProgressHUD.dismiss()
    }
}
