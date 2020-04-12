# BDUIKnit

BDUIKnit is a collection of SwiftUI custom reusable UI components and extensions packed in Swift Package Manager.

## Project Goals

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

### Install BDUIKnit

- Open your project in Xcode
- Go to `File > Swift Packages > Add Package Dependency...`
- Search for *BDUIKnit* and follow Xcode's installation dialog.

### Quick Introduction

Most of the UI components are following **MVVM** design pattern; so, there will always be **Views** and their corresponding **View Models**. Some view model has UI customization properties. Others are extracted out to a configuration object. Not all view models are `class`, some of them are `struct`. So, use `@ObservedObject`, `@State`, or `@Binding` as needed.

### BDButtonTrayView

A tray-like view that is normally pinned to the bottom-trailing of a scene.

![BDButtonTrayPreview-1][button-tray-preview]

<p class="image-caption-center">Regular Vertical Size Class</p>

![BDButtonTrayPreview-2][button-tray-preview-horizontal]

<p class="image-caption-center">Compact Vertical Size Class</p>

*Get Started:*

- `BDButtonTrayView`
- `BDButtonTrayViewModel`
- `BDButtonTrayConfiguration`
- `BDButtonTrayItem`

For sample code, see [`ButtonTrayViewPreview`][ButtonTrayViewPreview.swift]

### BDModalTextField

A modal text field intended to be used as a presentation sheet when need to get input from user.

![BDModalTextFieldPreview][modal-text-field-preview]

*Get Started:*

- `BDModalTextField`
- `BDModalTextFieldModel`

For sample code, see [`ModalTextFieldPreview`][ModalTextFieldPreview.swift]

<!-- Preview File Link -->

[ButtonTrayViewPreview.swift]: https://github.com/iDara09/BDUIKnitProject/blob/master/BDUIKnitProject/ButtonTrayViewPreview.swift

[ModalTextFieldPreview.swift]: https://github.com/iDara09/BDUIKnitProject/blob/master/BDUIKnitProject/ModalTextFieldPreview.swift

<!-- Preview Image Link -->

[button-tray-preview]: https://drive.google.com/uc?id=1By9KpfGEFXDeb4pjxoIIE82GEnyDDXWg

[button-tray-preview-horizontal]: https://drive.google.com/uc?id=14He_C4QiDxDA7a4YBwrCeXYBPWdGLDjg

[modal-text-field-preview]: https://drive.google.com/uc?id=1sy3BwKuUSNtIKvuuvGwDPXtsavWRVMfr

<!-- CSS -->

<style>

.image-caption-center {
    text-align: center;
    font-size: small;
}

</style>
