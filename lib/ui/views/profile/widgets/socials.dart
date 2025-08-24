import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_styles.dart';
import '../../../common/ui_helpers.dart';

class Socials extends StatelessWidget {
  const Socials({
    super.key,
    required this.avatar,
    required this.name,
    required this.handle,
    required this.onTap,
  });

  final String avatar;
  final String name;
  final String handle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            SvgPicture.asset(avatar, width: 24, height: 24),
            horizontalSpaceSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kcWhiteColor,
                    ),
                  ),
                  verticalSpaceTiny,
                  Text(
                    handle,
                    style: titleTextMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kcFollowColor.withOpacity(0.8),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.adaptive.arrow_forward,
              color: kcFollowColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// Solution 2: Flexible Layout with Ellipsis
class SocialsFlexible extends StatelessWidget {
  const SocialsFlexible({
    super.key,
    required this.avatar,
    required this.name,
    required this.handle,
    required this.onTap,
  });

  final String avatar;
  final String name;
  final String handle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: SvgPicture.asset(avatar, width: 24, height: 24),
      title: Text(
        name,
        style: titleTextMedium.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: kcWhiteColor,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              handle,
              style: titleTextMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: kcFollowColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          horizontalSpaceSmall,
          Icon(
            Icons.adaptive.arrow_forward,
            color: kcFollowColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

// Solution 3: Constrained Width with Truncation
class SocialsConstrained extends StatelessWidget {
  const SocialsConstrained({
    super.key,
    required this.avatar,
    required this.name,
    required this.handle,
    required this.onTap,
  });

  final String avatar;
  final String name;
  final String handle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: SvgPicture.asset(avatar, width: 24, height: 24),
      title: Text(
        name,
        style: titleTextMedium.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: kcWhiteColor,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width *
                  0.3, // 30% of screen width
            ),
            child: Text(
              handle,
              style: titleTextMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: kcFollowColor,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
          horizontalSpaceSmall,
          Icon(
            Icons.adaptive.arrow_forward,
            color: kcFollowColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

// Solution 4: Smart Truncation Function
class SocialsSmart extends StatelessWidget {
  const SocialsSmart({
    super.key,
    required this.avatar,
    required this.name,
    required this.handle,
    required this.onTap,
  });

  final String avatar;
  final String name;
  final String handle;
  final VoidCallback onTap;

  String _truncateHandle(String handle, {int maxLength = 20}) {
    if (handle.length <= maxLength) return handle;

    // Try to truncate at a sensible point (after @ or .)
    final truncated = handle.substring(0, maxLength);
    final lastAt = truncated.lastIndexOf('@');
    final lastDot = truncated.lastIndexOf('.');

    if (lastAt > 0 && lastAt > maxLength - 5) {
      return '${handle.substring(0, lastAt)}...';
    } else if (lastDot > 0 && lastDot > maxLength - 5) {
      return '${handle.substring(0, lastDot)}...';
    }

    return '$truncated...';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: SvgPicture.asset(avatar, width: 24, height: 24),
      title: Text(
        name,
        style: titleTextMedium.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: kcWhiteColor,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _truncateHandle(handle),
            style: titleTextMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kcFollowColor,
            ),
          ),
          horizontalSpaceSmall,
          Icon(
            Icons.adaptive.arrow_forward,
            color: kcFollowColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

// Solution 5: Tooltip for Full Handle
class SocialsTooltip extends StatelessWidget {
  const SocialsTooltip({
    super.key,
    required this.avatar,
    required this.name,
    required this.handle,
    required this.onTap,
  });

  final String avatar;
  final String name;
  final String handle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final displayHandle =
        handle.length > 20 ? '${handle.substring(0, 17)}...' : handle;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: SvgPicture.asset(avatar, width: 24, height: 24),
      title: Text(
        name,
        style: titleTextMedium.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: kcWhiteColor,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: handle,
            child: Text(
              displayHandle,
              style: titleTextMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: kcFollowColor,
              ),
            ),
          ),
          horizontalSpaceSmall,
          Icon(
            Icons.adaptive.arrow_forward,
            color: kcFollowColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
