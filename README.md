<!-- omit in toc -->
# BDUIKnit

BDUIKnit is a collection of SwiftUI custom reusable UI components and extensions packed in a Swift Package Manager.

- [Goals](#goals)
- [Todo](#todo)
- [Get Started](#get-started)
  - [Installation](#installation)
  - [Quick Introduction](#quick-introduction)
  - [BDButtonTrayView](#bdbuttontrayview)
  - [BDModalTextField](#bdmodaltextfield)

## Goals

- To collect my personal custom reusable UI and extensions and put them in one place.
- To create custom reusable UI and share them.
- To learn and share what I learnt building these UI & extensions.

## Todo

- [ ] Gotta have a logo. σ(^_^;)
- [ ] Add screenshots for every UI components.
- [ ] Add a quick how-to for all of them.
- [x] Add `ButtonTrayView`
- [x] Add `Color` extensions
- [x] Add `ModalTextField`
- [ ] Add `ModalTextView`

## Get Started

### Installation

To add BDUIKnit to your project:

- Open your project in Xcode
- Go to `File > Swift Packages > Add Package Dependency...`
- Search for BDUIKnit and follow Xcode's installation dialog.

### Quick Introduction

BDUIKnit follows **MVVM** design pattern; therefore, most **Views** will have their corresponding **View Models**. View models are either `class` or `struct`, so use the appropriate `@ObservedObject`, `@State`, or `@Binding` as needed.

### BDButtonTrayView

A tray-like view that is normally pinned to the bottom-trailing of a scene.

![BDButtonTrayPreview-1][button-tray-preview]

<small>Regular Vertical Size Class</small>

![BDButtonTrayPreview-2][button-tray-preview-horizontal]

<small>Compact Vertical Size Class</small>

**Quick Start:**

- `BDButtonTrayView`
- `BDButtonTrayViewModel`
- `BDButtonTrayItem`

For sample code, see [`ButtonTrayViewPreview`][ButtonTrayViewPreview.swift]

### BDModalTextField

A text field view intended to be used as a modal presentation sheet when need to get inputs from user.

![BDModalTextFieldPreview][modal-text-field-preview]

**Quick Start:**

- `BDModalTextField`
- `BDModalTextFieldModel`

For sample code, see [`ModalTextFieldPreview`][ModalTextFieldPreview.swift]

<!-- Preview File Link -->

[ButtonTrayViewPreview.swift]: https://github.com/iDara09/BDUIKnitProject/blob/master/BDUIKnitProject/ButtonTrayViewPreview.swift

[ModalTextFieldPreview.swift]: https://github.com/iDara09/BDUIKnitProject/blob/master/BDUIKnitProject/ModalTextFieldPreview.swift

<!-- Preview Image Link -->

[button-tray-preview]: https://user-images.githubusercontent.com/21166606/79085623-2307dd00-7cee-11ea-8732-b3ef96836f78.png

[button-tray-preview-horizontal]: https://user-images.githubusercontent.com/21166606/79085566-ee942100-7ced-11ea-8d09-10eac91fac7d.png

[modal-text-field-preview]: https://user-images.githubusercontent.com/21166606/79085645-37e47080-7cee-11ea-9d90-b73510e4506d.png
