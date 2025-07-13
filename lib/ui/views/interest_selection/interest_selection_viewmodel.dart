import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InterestSelectionViewModel extends BaseViewModel {
  final List<String> interests = [
    'House',
    'Techno',
    'Hip Hop',
    'Wine Tasting',
    'Live Music',
    'Art Shows',
    'EDM',
    'Trap',
    'R&B',
    'Afrobeats',
    'Rock',
    'Jazz',
    'Latin Vibes',
    'Throwback Nights (2000s / 90s)',
    'Food Festivals',
    'Street Food Nights',
    'Fine Dining Experiences',
    'Brunch Parties',
    'Hookah Lounges',
    'Comedy Shows',
    'Trivia Nights',
    'Game Nights',
    'Speed Dating',
    'Singles Mixers',
    'Drag Shows',
    'Karaoke Nights',
    'Costume Parties',
    'Theme Nights (e.g. 90s, Pajama, Neon)',
    'Art Shows / Exhibitions',
    'Fashion Events',
    'Poetry Slams',
    'Film Screenings',
    'Theater / Performance',
    'Yoga',
    'Raves',
    'Pool Parties',
    'Boat Parties',
    'Silent Discos',
    'College Parties',
    'LGBTQ+ Events',
    'Industry Nights',
    'Pet-Friendly Hangouts',
  ];

  final Set<String> selectedInterests = {};

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
    notifyListeners();
  }

  void submitInterests() {
    // Add your submission or navigation logic
    print('User selected: $selectedInterests');
    locator<NavigationService>().navigateToLocationView();
  }
}
