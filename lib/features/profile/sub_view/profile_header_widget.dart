part of '../profile_view.dart';

class _ProfileHeaderWidget extends StatelessWidget {
  final double borderWidth = 3;
  final double cameraIconBorderWidth = 2;
  final double cameraIconBottomAndRightPosition = 0;
  const _ProfileHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Image
        Padding(
          padding:
              Paddings.paddingInstance.profileImagePickerTopAndBottomPadding,
          child: Stack(
            children: [
              Container(
                width: WidgetSizesEnum.profileImageSize.value,
                height: WidgetSizesEnum.profileImageSize.value,
                decoration: _ContainerDecoration(),
                child: ClipOval(
                  child: Container(
                    color: ColorName.loginInputColor,
                    child: GlobalIcon(
                      IconConstants.iconConstants.personIcon,
                      iconColor: ColorName.loginGreyTextColor,
                      iconSize: IconSizesEnum.imagePickerInsideIconSize.value,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: cameraIconBottomAndRightPosition,
                right: cameraIconBottomAndRightPosition,
                child: Container(
                  width: WidgetSizesEnum.profileCameraContainerSize.value,
                  height: WidgetSizesEnum.profileCameraContainerSize.value,
                  decoration: _CameraContainerDecoration(),
                  child: GlobalIcon(
                    IconConstants.iconConstants.cameraIcon,
                    iconColor: ColorName.whiteColor,
                    iconSize: IconSizesEnum.cameraIconSize.value,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration _CameraContainerDecoration() {
    return BoxDecoration(
      color: ColorName.scaffoldBackgroundColor,
      shape: BoxShape.circle,
      border: Border.all(
        color: ColorName.yellowColor,
        width: cameraIconBorderWidth,
      ),
    );
  }

  BoxDecoration _ContainerDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: ColorName.yellowColor, width: borderWidth),
    );
  }
}
