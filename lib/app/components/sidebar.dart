import 'package:bionic/app/components/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/routes/app_pages.dart';
import 'package:bionic/app/utils/utility.dart';

class NavigationSidebar extends StatelessWidget {
  final Color? isActived1;
  final Color? isActived2;
  final String storeName;
  final RxString role;
  final RxString storeId;
  final String photoUrl;
  const NavigationSidebar({
    super.key,
    this.isActived1,
    this.isActived2,
    required this.storeName,
    required this.role,
    required this.storeId,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Flexible(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 150,
                  child: GestureDetector(
                    child: DrawerHeader(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: storeName,
                                textSize: textMedium,
                                textColor: Colors.black,
                                textWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: paddingVerySmall),
                              CustomText(
                                text: role.value,
                                textSize: textSmall,
                                textColor: primary,
                                textWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(photoUrl),
                            child: const Icon(
                              Icons.person,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(Routes.PROFILE);
                    },
                  ),
                ),
                GestureDetector(
                  child: const SizedBox(
                    height: tileNormal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingMedium),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: 'Katalog',
                              textSize: textMedium,
                              textColor: primary,
                              textWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.CATALOG_PRODUCT,
                        arguments: storeId.value);
                  },
                ),
                const Divider(),
                Obx(
                  () {
                    if (role.value == "Owner") {
                      return Column(
                        children: [
                          GestureDetector(
                            child: const SizedBox(
                              height: tileNormal,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: paddingMedium),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        text: 'Laporan',
                                        textSize: textMedium,
                                        textColor: primary,
                                        textWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(Routes.REPORT_SALES,
                                  arguments: storeId);
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                GestureDetector(
                  child: const SizedBox(
                    height: tileNormal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingMedium),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: 'Penjualan',
                              textSize: textMedium,
                              textColor: primary,
                              textWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.SALES, arguments: storeId.value);
                  },
                ),
                const Divider(),
                Obx(
                  () {
                    if (role.value == "Owner") {
                      return GestureDetector(
                        child: const SizedBox(
                          height: tileNormal,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: paddingMedium),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text: 'Tambah Produk',
                                    textSize: textMedium,
                                    textColor: primary,
                                    textWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.toNamed(Routes.ADD_PRODUCT);
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const Divider(color: primary, height: 2.0),
              Obx(
                () {
                  if (role.value == "Owner") {
                    return Column(
                      children: [
                        GestureDetector(
                          child: const SizedBox(
                            height: tileNormal,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: paddingMedium),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      text: 'Tambah Karyawan',
                                      textSize: textMedium,
                                      textColor: primary,
                                      textWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.person_add,
                                    color: primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(Routes.KARYAWAN);
                          },
                        ),
                        const Divider(),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              GestureDetector(
                child: const SizedBox(
                  height: tileNormal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: 'Keluar',
                            textSize: textMedium,
                            textColor: primary,
                            textWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.login_outlined,
                          color: primary,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  showSuccessSnackbar('Success', 'Logout success');
                },
              ),
              const Divider(color: primary, height: 2.0),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: paddingMedium),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(),
                        CustomText(
                          text: 'Bionic, Inc.',
                          textSize: textSmall,
                          textColor: Colors.grey,
                          textWeight: FontWeight.w400,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(),
                        CustomText(
                          text: 'Rohand, Co.',
                          textSize: textSmall,
                          textColor: Colors.grey,
                          textWeight: FontWeight.w400,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
