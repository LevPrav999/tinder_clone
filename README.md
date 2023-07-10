# Tinder Clone

[Russian Version](https://github.com/LevPrav999/tinder_clone/blob/main/README_RUS.md)

Tinder Clone is a mobile application that replicates the popular dating app Tinder. It allows users to create an account, edit their profile, search for other users, and interact with them through swipe and chat features. The app offers features such as phone number registration, profile customization, user search based on location and age, swipe left/right to block or like users, viewing users who liked you, and a chat interface with messages organized by dates.

## Functionality

1. **Phone Number Registration**: Users can register using their phone number and verify it through SMS. Account information is persisted even if the app is reinstalled.
2. **Profile Editing**: Users can edit their profile information including name, date of birth, gender, city, bio, and preferred gender.
3. **User Search**: The app allows users to search for other people based on specified criteria such as city and similar age range.
   - **Swipe Left**: Users can swipe left on a card to block a user.
   - **Swipe Right**: Users can swipe right on a card to like a user.
4. **Likes and Matches**: Users can view and choose users who liked them.
   - **Swipe Left**: Users can swipe left on a card to block a user.
   - **Swipe Right**: Users can swipe right on a card to start a chat with the user.
5. **Chat Interface**: The app provides a chat functionality where users can exchange messages with each other.
   - Messages are organized by dates for better readability.

## Planned Updates

In future updates, Tinder Clone plans to introduce the following features and improvements:

1. **Expanded Color Palette**: Adding more color options for customizing the interface.
2. **Settings Page**: Implementing a settings page for configuring app-specific preferences.
3. **Tinder Plus**: Introducing premium features such as bookmarking cards, viewing users who blocked or liked you, displaying "crowns" on user cards, and other enhancements.
4. **Localization**: Supporting multiple languages, including Russian.
5. **Code and Architecture Refactoring**: Improving the codebase and app architecture to enhance maintainability and scalability.
6. **Chat Interface Enhancement**: Expanding chat interface functionality with features like image sharing, voice messages, audio/video calls, and more.
7. **Profanity Filtering**: Implementing automatic filtering of profane content in messages.
8. **Message Encryption**: Exploring message encryption capability, considering the need for moderation and positioning the app as a dating platform rather than a fully secure messenger.
9. **Online/Offline Status Display**: Showing online/offline status of users on their cards.
10. **User Interface Improvements**: Continuously refining the user interface and experience based on user feedback and industry best practices.

## Technologies Used

- **firebase_core**: Initialization and setup of Firebase in the app.
- **firebase_auth**: User registration and authentication using phone number.
- **cloud_firestore**: Storage of user profiles, chats, and messages.
- **firebase_storage**: Upload and storage of user profile images.
- **flutter_screenutil**: Adaptation of the interface for various screen sizes and resolutions.
- **flutter_riverpod**: State management and dependency injection.
- **image_picker**: Selection and retrieval of images for user profiles.
- **carousel_slider**: Display of image carousels in user profiles.
- **flutter_card_swiper**: Implementation of left/right swipe for user selection.
- **intl**: Localization of dates and numbers for different regions and languages.
- **uuid**: Generation of unique identifiers for profiles and messages.
- **cached_network_image**: Caching and display of user images from the network.
- **custom_clippers**: Custom clippers for creating interesting shapes for UI elements.
