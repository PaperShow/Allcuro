/// Which side of the ALLCURO Partner app the signed-in user is using.
/// Set once at login/onboarding (see `role_select_screen.dart`) and then
/// threaded through the app to pick the right shell tabs and home screen.
enum ProviderRole { nurse, centre }
