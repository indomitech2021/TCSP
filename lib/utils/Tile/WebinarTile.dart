import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Models/WebinarModel.dart';
import '../const.dart';


class WebinarTile extends StatelessWidget {
  final Webinar webinar;
  WebinarTile({required this.webinar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.sp,
      height: 200.sp,
      margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5.r),
          bottomRight: Radius.circular(5.r),
        ),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150.sp,
            height: 200.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.r),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.r),
              ),
              child: webinar.image != null && webinar.image!.isNotEmpty
                  ? Image.network(
                    "https://royadagency.com/images/webinar_images/${webinar.image!}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Placeholder(
                        fallbackWidth: 50.sp,
                        fallbackHeight: 50.sp,
                      );
                    },
                  )
                  : Placeholder(
                fallbackWidth: 50.sp,
                fallbackHeight: 50.sp,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.sp),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(webinar.title.toString(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: WebinerTileTitelTextStyle,
                  ),
                  Text(webinar.shortDescription.toString(),
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: WebinerTileShortDescriptionTextStyle,
                  ),
                  Container(
                    width: 205.sp,
                    height: 23.sp,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F6FD), // Replace with your desired color
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.calendar_month,
                          color: Color(0xFF494A50),
                          size: 18.sp,
                        ),
                        Text("DATE: ${webinar.timing}",
                          style: WebinerTileInfoTextStyle,
                        )
                      ],
                    ),
                    // Add child widgets or content here
                  ),
                  Container(
                    width: 205.sp,
                    height: 23.sp,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F6FD), // Replace with your desired color
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.schedule,
                          color: Color(0xFF494A50),
                          size: 18.sp,
                        ),
                        Text("TIME: ${webinar.timing}",
                          style: WebinerTileInfoTextStyle,
                        ),
                      ],
                    ),
                    // Add child widgets or content here
                  ),
                  Row(
                    children: [
                      Text("Duration: ${webinar.duration}",
                        style: WebinerTileInfoTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}