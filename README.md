
# RMChars

## Description
"RMChars" is a Swift iOS application that displays character information from the "Rick and Morty" API. 
It exemplifies the use of modern iOS development techniques, including custom network layers, multimodal architecture and dependency management with Swift Package Manager.

## Installation

To get started with this project, clone the repository and open it in Xcode:

```bash
git clone https://github.com/SwiftNinjaDev/RMChars.git
```

## Package Dependencies

This project uses Swift Package Manager for dependency management. 
Key dependencies include:
- **SDWebImage**: For efficient image downloading and caching.
- **SnapKit**: For setting up UI constraints programmatically, facilitating a clean and readable codebase.

## Local Packages

- **NetServiceKit**: A generic network layer designed to simplify networking calls across the application.
- **Stateful MVVM**: Provides a robust framework for implementing the MVVM architecture with state management.

## Project Structure

### Scenes
The "Scenes" folder contains all view controllers and views, organized by screen setup, facilitating a modular approach to UI development.

### Architectural Layer
This folder contains essential files that bridge the entire project with the `StatefulMVVM` package, ensuring consistent application of architectural patterns.

### Network Layer
In the "Network Layer" folder, you'll find specific network services like `CharacterService`, which fetches character details from the Rick and Morty API.

## Areas for Improvement

- **Project Generation**: Implement project generation tools like Tuist or XcodeGen to streamline the setup process and improve project config.
- **Design System Package**: Develop a local package to maintain a consistent design system across the app, including custom fonts, colors, and icons.
- **Dynamic Character Statuses**: Replace the hardcoded list of character statuses with a dynamic implementation based on data received from the API (there is no such API as I see, just a general point).
- **Pagination**: The current pagination mechanism provided by the Rick and Morty API is unusual (providing in 'prev' abd 'next' whole URL). Adapting this to more conventional methods seen in other APIs could improve the data handling efficiency.
- **Refactor CharacterView.swift**: Separate big view to smaller parts. 
- **ProgessHUD**: In this project used very basic approach. It can be additionally customized or replaced. 
- **Submodules connection**: Need to connect `StatefulMVVM` and `NetServiceKit` as submodules.
- **Error handling**: Add error handling. As option - by adding custom alerts.
