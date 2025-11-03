part of '../profile_view.dart';

class _ProfileHeaderWidget extends StatelessWidget {
  final String? imageUrl;
  final File? selectedImage;
  final VoidCallback onImagePicked;
  final double borderWidth = 3;
  final double cameraIconBorderWidth = 2;
  final double cameraIconBottomAndRightPosition = 0;

  const _ProfileHeaderWidget({
    required this.imageUrl,
    required this.onImagePicked,
    required this.selectedImage,
  });

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
                child: ClipOval(child: _buildNetworkOrPlaceholder()),
              ),
              Positioned(
                bottom: cameraIconBottomAndRightPosition,
                right: cameraIconBottomAndRightPosition,
                child: GestureDetector(
                  onTap: onImagePicked,
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkOrPlaceholder() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: WidgetSizesEnum.profileImageSize.value,
        height: WidgetSizesEnum.profileImageSize.value,
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      color: ColorName.loginInputColor,
      child: GlobalIcon(
        IconConstants.iconConstants.personIcon,
        iconColor: ColorName.loginGreyTextColor,
        iconSize: IconSizesEnum.imagePickerInsideIconSize.value,
      ),
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
