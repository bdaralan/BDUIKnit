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
  - [BDModalTextView](#bdmodaltextview)

## Goals

- To collect my personal custom reusable UI and extensions and put them in one place.
- To create custom reusable UI and share them.
- To learn and share what I learnt building these UI & extensions.

## Todo

- [ ] Gotta have a logo. σ(^_^;)
- [x] Add `ButtonTrayView`
- [x] Add `Color` extensions
- [x] Add `ModalTextField`
- [x] Add `ModalTextView`
- [ ] Add more...

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

- [`BDButtonTrayView`][BDButtonTrayView.swift]
- [`BDButtonTrayViewModel`][BDButtonTrayViewModel.swift]
- [`BDButtonTrayItem`][ButtonTrayItem.swift]

For sample code, see [`ButtonTrayViewPreview`][ButtonTrayViewPreview.swift]

### BDModalTextField

A text field view intended to be used as a modal presentation sheet when need to get inputs from user.

![BDModalTextFieldPreview][modal-text-field-preview]

**Quick Start:**

- [`BDModalTextField`][BDModalTextField.swift]
- [`BDModalTextFieldModel`][BDModalTextFieldModel.swift]

For sample code, see [`ModalTextFieldPreview`][ModalTextFieldPreview.swift]

### BDModalTextView

A text view intended to be used as a modal presentation sheet when need to get inputs from user.

![BDModalTextViewPreview][modal-text-view-preview]

**Quick Start:**

- [`BDModalTextView`][BDModalTextView.swift]
- [`BDModalTextViewModel`][BDModalTextViewModel.swift]

For sample code, see [`ModalTextViewPreview`][ModalTextViewPreview.swift]

<!-- BDUIKnit File Link -->

[BDButtonTrayViewModel.swift]: https://github.com/iDara09/BDUIKnit/blob/master/Sources/BDUIKnit/ButtonTray/Model/BDButtonTrayViewModel.swift

[ButtonTrayItem.swift]: https://github.com/iDara09/BDUIKnit/blob/master/Sources/BDUIKnit/ButtonTray/Model/ButtonTrayItem.swift

[BDButtonTrayView.swift]: https://github.com/iDara09/BDUIKnit/blob/master/Sources/BDUIKnit/ButtonTray/View/BDButtonTrayView.swift

[BDModalTextFieldModel.swift]: https://github.com/iDara09/BDUIKnit/blob/master/Sources/BDUIKnit/ModalTextField/Model/BDModalTextFieldModel.swift

[BDModalTextField.swift]: https://github.com/iDara09/BDUIKnit/blob/master/Sources/BDUIKnit/ModalTextField/View/BDModalTextField.swift

[BDModalTextViewModel.swift]: https://github.com/iDara09/BDUIKnit/blob/master/Sources/BDUIKnit/ModalTextView/Model/BDModalTextViewModel.swift

[BDModalTextView.swift]: https://github.com/iDara09/BDUIKnit/blob/master/Sources/BDUIKnit/ModalTextView/View/BDModalTextView.swift

<!-- Preview File Link -->

[ButtonTrayViewPreview.swift]: https://github.com/iDara09/BDProjects/blob/master/BDProjects/BDUIKnit%20Preview/ButtonTrayViewPreview.swift

[ModalTextFieldPreview.swift]: https://github.com/iDara09/BDProjects/blob/master/BDProjects/BDUIKnit%20Preview/ModalTextFieldPreview.swift

[ModalTextViewPreview.swift]: https://github.com/iDara09/BDProjects/blob/master/BDProjects/BDUIKnit%20Preview/ModalTextViewPreview.swift

<!-- Preview Image Link -->

[button-tray-preview]: https://user-images.githubusercontent.com/21166606/79085623-2307dd00-7cee-11ea-8732-b3ef96836f78.png

[button-tray-preview-horizontal]: https://user-images.githubusercontent.com/21166606/79085566-ee942100-7ced-11ea-8d09-10eac91fac7d.png

[modal-text-field-preview]: https://user-images.githubusercontent.com/21166606/79085645-37e47080-7cee-11ea-9d90-b73510e4506d.png

[modal-text-view-preview]: https://user-images.githubusercontent.com/21166606/79294399-efae8500-7e8a-11ea-80f3-1c9dff0eedbf.png
