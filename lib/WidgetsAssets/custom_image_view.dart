// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// extension ImageTypeExtension on String {
//   ImageType get imageType{
//     if (startsWith('http') || startsWith('https')){
//       return ImageType.network;
//     } else if (startsWith('.svg')){
//       return ImageType.svg;
//     } else if (startsWith('file://')){
//       return ImageType.file;

//     } else {
//       return ImageType.png;
//     }
//   }
// }
// enum ImageType {svg, png, network, file, unknown}
// class CustomImageView extends StatelessWidget {
//   CustomImageView(
//     {super.key, this.imagePath, this.height, this.width, this.color, this.fit, this.alignment, this.onTap, this.radius, this.margin, this.border, this.placeHolder = 'Assets/images/image_not_found.png'}

//   );
//   String? imagePath;
//   double? height;
//   double? width;
//   Color? color;
//   BoxFit? fit;
//   final String placeHolder;
//   Alignment? alignment;
//   VoidCallback? onTap;
//   EdgeInsetsGeometry? margin;
//   BorderRadius? radius;
//   BoxBorder? border;
//   @override
//   Widget build(BuildContext context){
//     return alignment != null ? Align(alignment : alignment!, child: _buildWidget()) : _buildWidget();
//   }
//   Widget _buildWidget() {
//     return Padding(padding: margin ?? EdgeInsets.zero, child: InkWell(onTap: onTap,child: _buildCircleImage(),),);}

//   _buildCircleImage() { 
//     if(radius != null) {
//       return ClipRRect(
//         borderRadius: radius ?? BorderRadius.zero, child: _buildImageWithBorder(),
//       );
//     }else{
//       return _buildImageWithBorder(); //
//     }
//   }
//   _buildImageWithBorder() { 
//     if( border != null){
//       return Container(decoration: BoxDecoration( border: border, borderRadius: radius,), child: _buildImageView(),);
//     }else {
//       return _buildImageView();
//     }
//   }
//   Widget _buildImageView() {
//     if(imagePath != null) {
//       switch (imagePath!.imageType) {
//         case ImageType.svg: 
//           return SizedBox(height: height, width: width, child: SvgPicture.asset
//           (imagePath!, height: height, width: width,fit: fit ?? BoxFit.contain, colorFilter: color != null ? ColorFilter.mode
//           (color ?? Colors.transparent, BlendMode.srcIn):null,),);
//         case ImageType.file: 
//           return Image.file(File(imagePath!),height: height, width: width,fit: fit ?? BoxFit.cover,color: color,);
//         case ImageType.network: 
//           return CachedNetworkImage(height: height,width: width,fit: fit,imageUrl: imagePath!, color: color, placeholder: (Context, url)=> SizedBox(
//             height: 30,
//             width: 30,
//             child: LinearProgressIndicator(color: Colors.grey.shade200, backgroundColor: Colors.grey.shade100,)
//           ),
//           errorWidget: (context, url, error)=> Image.asset(
//             placeHolder, height: height, width: width,fit: fit ?? BoxFit.cover,
//           ),
//           );
//         case ImageType.png:
//         default :
//           return Image.asset( imagePath!, height: height, width: width, fit: fit ?? BoxFit.cover, color: color,);
        
//       }
//     }
//     return const SizedBox();
//   }
// }