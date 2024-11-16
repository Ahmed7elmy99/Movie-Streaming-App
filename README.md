# **Streamix**

I made this app with Flutter using clean architecture and  bloc as state management.

## Description

Streamix is a sleek movie streaming app offering easy access to popular, top-rated, and trending films. With a clean interface, personalized watchlists, and smooth playback, it’s built for effortless discovery and viewing.

## Badges

| Splash View | Home View | Trending Movies | Top Rated Movies |
| :-----------: | :---------: | :------------: | :--------------: |
| <img src="https://github.com/user-attachments/assets/7833d356-d4b4-4e18-affe-be2237f45515" width="300"/> | <img src="https://github.com/user-attachments/assets/5feac5dd-9b62-4720-9986-bc475bb24ee2" width="300"/> | <img src="https://github.com/user-attachments/assets/f5978f89-dd74-48c7-8ce1-90522030ec6e" width="300"/> | <img src="https://github.com/user-attachments/assets/c1ecfb17-9603-45f0-a075-7a00454c6b04" width="300"/> |


| Movie Details View | Similar View | Movie Search Movies | Favourite Screen |
| :-----------: | :---------: | :------------: | :------------:  
| <img src="https://github.com/user-attachments/assets/aeabc34a-6b3e-47c9-b5e1-2f07dd18ceb1" width="300"/> | <img src="https://github.com/user-attachments/assets/248a65e4-3498-4ef7-832f-d22a98fba7ee" width="300"/> | <img src="https://github.com/user-attachments/assets/f7a696b4-00ec-48a0-9d87-1a8730af6f8f" width="300"/> | <img src="https://github.com/user-attachments/assets/627a4385-8483-4fe1-8fcb-a00365b20f4e" width="300"/> |


| Light Movie View | Arabic Search | Light Settings View | Clear Search History| 
| :-----------: | :---------: | :------------: | :------------: 
<img src="https://github.com/user-attachments/assets/5c5ef69d-4870-4881-ac8a-d2aaa42b2f00" width="300"/> | <img src="https://github.com/user-attachments/assets/a8898400-9e2d-4a32-9ad0-6bf223242bd7" width="300"/> | <img src="https://github.com/user-attachments/assets/402c9d05-9d20-43d0-92de-eddddc848f85" width="300"/> | <img src="https://github.com/user-attachments/assets/157b5162-61b4-44eb-b5d0-998891765ac4" width="300"/> |

## Dependencies
```yaml
  animate_do: ^3.3.4
  cached_network_image: ^3.3.1
  carousel_slider: ^4.2.1
  cupertino_icons: ^1.0.6
  dartz: ^0.10.1
  dio: ^5.4.3+1
  equatable: ^2.0.5
  flutter_controller: ^8.1.6
  get_it: ^7.7.0
  google_fonts: ^6.2.1
  shared_preferences: ^2.2.3
  shimmer: ^3.0.0
```
## Directory Structure for project

```
├───core
│   ├───error
│   ├───global
|   |   ├───resources
|   |   └───theme
│   └───utils
│       ├───custom_widgets
│       ├───entities
│       ├───models
│       ├───network
│       ├───services
│       └───use_cases
└───features
    ├───home
    │   ├───bottom_nav_bar_cubit
    │   └───views
    ├───movie
    │   ├───data
    │   │   ├───data_sources
    │   │   ├───models
    │   │   └───repos
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repos
    │   │   └───use_cases
    │   └───presentation
    │       ├───controller
    │       └───views
    │           |───movie_details_view
    |           └───movie_view
    ├───search
    │   ├───data
    │   │   ├───data_sources
    │   │   ├───models
    │   │   └───repos
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repos
    │   │   └───use_cases
    │   └───presentation
    │       ├───controller
    │       └───views
    |           └───widgets
    ├───settings
    │   └───presentation
    │       └───views
    |            └───widgets  
    ├───splash
    │   └───presentation
    │       └───views
    |            └───widgets  
    └───tvs
        ├───data
        |   ├───data_sources
        |   ├───models
        |   └───repos
        ├───domain
        │   ├───entities
        │   ├───repos
        │   └───use_cases
        └───presentation
            ├───controller
            └───views
                |───tv_details_view
                └───tv_view
    
```


  
