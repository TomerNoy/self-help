import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/models/app_user.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_providers/user_provider.dart';
import 'package:self_help/services/logger_service.dart';
import 'package:self_help/services/services.dart';

class Profile extends HookConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).value;

    final localizations = AppLocalizations.of(context)!;
    final title = localizations.profile;

    final appbarNotifier = ref.read(animatedAppBarProvider.notifier);

    void updateAppBar() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => appbarNotifier.updateState(
          appBarType: AppBarType.collapsed,
          appBarTitle: title,
          hasBackButton: true,
        ),
      );
    }

    final showSnackBar = useCallback((String message) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    }, []);

    ref.listen(
      routerListenerProvider,
      (previous, next) {
        if (next != previous && next == RoutePaths.profile) {
          updateAppBar();
        }
      },
    );

    useEffect(() {
      updateAppBar();
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 800,
          ),
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              ListTile(
                title: const Text('Name'),
                subtitle: Text('${user?.displayName}'),
                leading: Icon(Icons.person, size: 32),
                trailing: IconButton(
                  onPressed: () => _editValuePressed(
                    user,
                    context,
                    ref,
                    showSnackBar,
                  ),
                  icon: Icon(
                    Icons.edit,
                    size: 32,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Email'),
                subtitle: Text('${user?.email}'),
                leading: Icon(Icons.email, size: 32),
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Register as a Therapist'),
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: OutlinedButton(
                  onPressed: () async => await userAuthService.signOut(),
                  // style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                  //       side: WidgetStateProperty.all(
                  //         BorderSide(
                  //           color: Theme.of(context).colorScheme.error,
                  //         ),
                  //       ),
                  //       backgroundColor: WidgetStateProperty.all(
                  //         Theme.of(context).colorScheme.errorContainer,
                  //       ),
                  //     ),
                  child: Text(
                    'Sign Out',
                    // style: TextStyle(
                    //   color: Theme.of(context).colorScheme.onErrorContainer,
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editValuePressed(
    AppUser? user,
    BuildContext context,
    WidgetRef ref,
    void Function(String message) showSnackBar,
  ) {
    var newValue = user?.displayName;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit Name',
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          content: TextField(
            controller: TextEditingController(text: user?.displayName),
            onChanged: (value) => newValue = value,
          ),
          actions: <Widget>[
            Center(
              child: FilledButton(
                onPressed: () async {
                  Navigator.of(context).pop();

                  if (newValue == null || newValue == user?.displayName) {
                    return;
                  }

                  // ref
                  //     .read(collapsingAppBarProvider.notifier)
                  //     .updateState(AppBarType.loading);

                  final result =
                      await userProfileService.updateUserName(name: newValue!);

                  LoggerService.debug('result: $result');

                  // ref
                  //     .read(collapsingAppBarProvider.notifier)
                  //     .updateState(AppBarType.hidden);

                  final message = result.isSuccess ? result.data : result.error;
                  LoggerService.debug('message: $message');

                  if (message != null) {
                    showSnackBar(message);
                  }
                },
                child: Text('Accept'),
              ),
            ),
          ],
        );
      },
    );
  }
}
