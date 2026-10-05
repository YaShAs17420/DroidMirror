# Repository Guidelines

## Project Goal & Core Requirements

DroidMirror is an interactive Android remote-control and mirroring application for Windows and Fedora Linux, not a display-only mirroring tool. Android is the source device. PC mouse clicks, drags, and keyboard input must control Android touch, gesture, and text/key input, with Back, Home, and Recent Apps navigation. Low-latency streaming and a polished phone-shaped desktop presentation are primary requirements. Screen-off operation is required where technically possible. Locked-device behavior must be experimentally validated; never assume it works universally. USB is the first transport and Wi-Fi is a later one. Windows and Fedora should ultimately provide equivalent functionality. iPhone is a future phase and must not shape the current Android architecture.

## Architecture Direction

Flutter is the planned desktop UI layer; Rust is the proposed native/core engine; ADB is the initial Android connection mechanism. Investigate a temporary Android-side server for the initial USB workflow instead of requiring a permanent companion app. Keep transport abstractions independent of USB so Wi-Fi can follow, and keep presentation separate from device and transport logic. Treat these as direction, not silently finalized decisions: explain and discuss architecture changes before making them.

## Project Structure & Module Organization

The repository is organized by component: `android/` for Android-specific code, `desktop/` for desktop application code, `core/` for shared functionality, `tests/` for automated tests, and `docs/` for contributor and user documentation. Keep platform-specific implementation in its component directory and reusable logic in `core/`. Preserve this separation as the scaffold grows.

## Build, Test, and Development Commands

No build or test configuration is present yet. Do not invent commands; document them when project manifests or scripts are added. Build, test, and verify each milestone before proceeding to the next. Prefer simple, maintainable designs and add dependencies only for a clear reason.

## Coding Style & Naming Conventions

Follow the formatter and lint rules configured for the language or component you change. Keep names descriptive and consistent with neighboring code, using language conventions (for example, `PascalCase` for Kotlin classes and `camelCase` for functions). Avoid conflicting tools or rules.

## Testing Guidelines

No test framework or coverage threshold is configured yet. Add behavior-focused tests under `tests/` or a component-local test directory as the ecosystem requires, and document how to run them when configured. The developer currently has no Android phone: use mocks or stubs for host-side work where practical, and do not claim device functionality is verified until tested on a physical Android device. Validate locked-device and screen-off behavior on hardware before making claims about them.

## Development Workflow

Work milestone by milestone; do not generate the whole project at once. Identify the exact cause when debugging before changing code. Before substantial changes, inspect relevant files and explain the intended change. Preserve working code unless a change is justified. Use Git for every meaningful milestone and keep GitHub as the source of truth. Do not have multiple coding agents modify the same task simultaneously: assign one primary implementer and use others only for review or second opinions.

## Commit & Pull Request Guidelines

No project history is available yet to establish a commit convention. Use short, imperative subjects that identify the area changed, such as `Add core device discovery`. Pull requests should describe the change, summarize validation, link related issues when applicable, and include screenshots for visual changes.

## Security & Configuration

Never commit secrets, credentials, signing keys, local machine configuration, generated build output, or device-specific private data. Keep secrets in local environment configuration and use safe example values in documentation.
