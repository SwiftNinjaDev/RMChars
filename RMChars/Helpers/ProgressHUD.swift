import UIKit

final class ProgressHUD: UIView {
    static let shared = ProgressHUD()
    
    private var toolbarHUD: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // Initialization
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupHUD()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set up the HUD views
    private func setupHUD() {
        backgroundColor = .clear
        
        addSubview(toolbarHUD)
        NSLayoutConstraint.activate([
            toolbarHUD.centerXAnchor.constraint(equalTo: centerXAnchor),
            toolbarHUD.centerYAnchor.constraint(equalTo: centerYAnchor),
            toolbarHUD.widthAnchor.constraint(equalToConstant: 120),
            toolbarHUD.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        toolbarHUD.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: toolbarHUD.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: toolbarHUD.centerYAnchor),
        ])
        
        toolbarHUD.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 8),
            statusLabel.leftAnchor.constraint(equalTo: toolbarHUD.leftAnchor, constant: 8),
            statusLabel.rightAnchor.constraint(equalTo: toolbarHUD.rightAnchor, constant: -8),
            statusLabel.bottomAnchor.constraint(equalTo: toolbarHUD.bottomAnchor, constant: -8)
        ])
    }
    
    // Show the HUD
    class func show(_ status: String? = nil, interaction: Bool = false) {
        DispatchQueue.main.async {
            guard let scene = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first,
                  let window = scene.windows.first(where: { $0.isKeyWindow }) else {
                return  // Exit if no active window is found
            }
            shared.frame = window.bounds
            window.addSubview(shared)
            shared.isUserInteractionEnabled = !interaction
            shared.statusLabel.text = status
            shared.activityIndicator.startAnimating()
            shared.toolbarHUD.alpha = 1
            shared.alpha = 1
        }
    }
    
    // Dismiss the HUD
    class func dismiss() {
        DispatchQueue.main.async {
            shared.hudHide()
        }
    }
    
    // Hide the HUD with animation
    private func hudHide() {
        if self.alpha == 1 {
            UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
                self.toolbarHUD.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                self.toolbarHUD.alpha = 0
            }, completion: { _ in
                self.removeFromSuperview()
                self.alpha = 0
                self.activityIndicator.stopAnimating()
            })
        }
    }
}
