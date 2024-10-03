# Image Gallery

This project displays a grid of images fetched from a remote API and allows users to view details of each image. The project consists of two main views:

## ImageGridView: 
A grid-based gallery that shows image thumbnails.

![App Screenshot](https://github.com/user-attachments/assets/6e8de6cf-3ce5-4869-90cd-1109895cdd4d)

## ImageDetailView: 
A detailed view for individual images when selected from the grid that shows original image.

![App Screenshot](https://github.com/user-attachments/assets/fb601548-8194-49bb-93f4-032d5a6b33fa)

## Features
1. Image Grid View (ImageGridView)
Displays a scrollable grid of images using LazyVGrid.
Fetches images from a remote API using an ImageGridViewModel.
Supports pagination: Loads more images when scrolling down (Pull to refresh).
Handles loading state using a ProgressView.
Displays error messages if the image fetch fails.
Uses NavigationLink to navigate to the ImageDetailView for a selected image.
Reverses the order of images so the latest images are shown at the top.
2. Image Detail View (ImageDetailView)
Shows a detailed view of a selected image.
Displays the image in full size along with additional feature - user can scroll left/ right to see prev/ next image details.
Allows navigation back to the grid view.
3. File Manager (ImageFileManager)
Downloaded images are stored in File Manager, it prevents api request for same image again and again.
Images are store with Unique Key, Example - for thumbnail Key is "1502cfeD", for image key is "6002cfeD".

# How It Works
## Loading Images:

ImageGridViewModel fetches images from a remote API (such as https://jsonplaceholder.typicode.com/photos).
Images are displayed in the ImageGridView as a grid of thumbnail images.
The grid supports pagination, meaning that more images are loaded as the user scrolls down.
Handling Errors:

If an error occurs during the image fetch (e.g., network failure), an error message is displayed in red.
Navigating to Detail View:

When a user taps on an image in the grid, the app navigates to ImageDetailView, where the selected image is displayed in full size.
The ImageDetailView also provides additional information like image title.

# Setup and Installation
## Prerequisites:
Xcode 12+
iOS 14+ (because it uses SwiftUI features like LazyVGrid and @StateObject)
## Installation:
### Clone the repository:

```bash
git clone https://github.com/yourusername/ImageGallery.git
```
### Open the project in Xcode:
```bash
cd ImageGallery
open ImageGallery.xcodeproj
```
Run the app on the simulator or a physical device by selecting a target and pressing Cmd + R.
