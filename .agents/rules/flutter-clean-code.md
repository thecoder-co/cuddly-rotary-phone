---
trigger: glob
globs: lib/**/*.dart
---

Project Rules & Architecture Guidelines
🏗 Architectural Pattern: MVC + Riverpod

This project follows a strict Model-View-Controller (MVC) pattern, where Riverpod Providers and Notifiers act as the Controller layer.
1. Separation of Concerns

    Models: Data classes, serialization (JSON), and domain logic. No UI or framework dependencies.

    Views: Declarative UI components. They should be "dumb" and only reflect the state provided by controllers.

    Controllers (Providers/Notifiers): Business logic, state management, and interaction with Services/Repositories.

    Services/Repositories: Data fetching (API, Firebase, Local DB).

📂 Directory Structure

Maintain a feature-first or layer-first approach, but always isolate providers:
Plaintext

lib/
├── features/
│   └── feature_name/
│       ├── models/          # Data structures
│       ├── views/           # UI Widgets & Screens
│       ├── providers/       # Logic & State (Riverpod)
│       └── repositories/    # Data sources

🛠 Riverpod Rules

    [!IMPORTANT]
    Providers must always reside in a separate file within the providers/ directory. Never declare a provider in the same file as a View or Model.

Provider Naming & Implementation

    File Naming: Use *_provider.dart suffix (e.g., auth_provider.dart).

    Class Names: Use Notifier, AsyncNotifier or other riverpod classes for complex state.

    Single Responsibility: One provider file per logical state unit.


🎨 View Guidelines (Clean UI)

    Widget Selection: Use ConsumerWidget for stateless screens and ConsumerStatefulWidget only when local lifecycle (like TabController) is required.

    No Logic in Views: If you see an if/else or a try/catch inside a build method, move it to the Provider.

    Direct Access: Access state via ref.watch(). Use ref.read() only inside callbacks (e.g., onPressed).

🧹 Clean Code Standards

    Immutability: All Models must be immutable (use freezed or copywith).

    Explicit Imports: Avoid barrel files (index.dart) if they cause circular dependencies.

    Error Handling: Use AsyncValue for all UI-bound data fetching to handle Loading and Error states gracefully.

    Dry Principle: Extract reusable UI components into a global shared/widgets directory.

🤖 Agent Instructions

    When creating a new feature, generate the Model first, then the Provider, and finally the View.

    If asked to add logic to a Widget, automatically suggest moving it to a new or existing Provider file.

    Always ensure ref is used correctly to maintain reactivity.