import UIKit
import SwiftUI

final class CharDetailsViewController: ViewModelController<CharDetailsViewState, CharDetailsViewModel> {
    
    private var swiftUIController: UIHostingController<CharacterView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .white
    }
    
    override func render(state: CharDetailsViewState) {
        super.render(state: state)
        
        switch state {
        case .loading:
            showIndicatorView()
        case .loaded(let data):
            hideIndicatorView()
            configureUI(with: data)
        case .error(let error):
            hideIndicatorView()
            print(error)
        }
    }
    
    private func configureUI(with data: CharDetailsViewState.CharacterDetails) {
        let speciesGender = "\(data.species) • \(data.gender ?? "")"
        let swiftUIView = CharacterView(
            name: data.name,
            speciesGender: speciesGender,
            location: data.location ?? "",
            image: data.image,
            status: data.status
        )
        swiftUIController = UIHostingController(rootView: swiftUIView)
        
        if let swiftUIController = swiftUIController {
            addChild(swiftUIController)
            swiftUIController.view.frame = view.bounds
            view.addSubview(swiftUIController.view)
            swiftUIController.didMove(toParent: self)
        }
    }
}
