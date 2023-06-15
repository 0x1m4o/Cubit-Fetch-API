// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:typed_data';

import 'package:profileapp/cubits/response/response_cubit.dart';
import 'package:profileapp/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profileapp/models/login_response.dart';
import 'package:profileapp/models/user_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../partials/text_form.dart';
import '/utils/constant.dart' as constants;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditPage extends StatefulWidget {
  TextEditingController userC = TextEditingController();
  LoginResponse? loginResponse;
  UserResponse? savedUserResponse;
  XFile? image;
  String base64Image = '';
  final ImagePicker picker = ImagePicker();
  TextEditingController avatarC = TextEditingController();
  TextEditingController fullNameC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  TextEditingController aboutC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController twitter = TextEditingController();

  EditPage({
    super.key,
    this.savedUserResponse,
    this.loginResponse,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Future getImage(ImageSource media) async {
    widget.image = await widget.picker.pickImage(source: media);
    final bytes = await File(widget.image!.path).readAsBytes();
    final imageFormat = widget.image!.path.split('.').last;
    widget.base64Image =
        "data:image/$imageFormat;base64," + base64Encode(bytes);
    widget.avatarC.text = widget.base64Image;
  }

  void getUserData() async {
    box = await Hive.openBox('box');
    widget.loginResponse = await box!.get(constants.loginRespStorage);
  }

  @override
  void initState() {
    getUserData();
    widget.fullNameC.text = widget.savedUserResponse!.fullname;
    widget.aboutC.text = widget.savedUserResponse!.about;
    widget.avatarC.text = widget.savedUserResponse!.avatar;
    widget.cityC.text = widget.savedUserResponse!.city;
    widget.countryC.text = widget.savedUserResponse!.country;
    widget.jobC.text = widget.savedUserResponse!.job;
    widget.instagram.text = widget.savedUserResponse!.instagram;
    widget.twitter.text = widget.savedUserResponse!.twitter;
    widget.facebook.text = widget.savedUserResponse!.facebook;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResponseCubit(),
      child: BlocConsumer<ResponseCubit, ResponseState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () {},
            editSuccess: (value) =>
                Navigator.pop(context, widget.savedUserResponse),
          );
        },
        builder: (context, state) {
          final regex = RegExp(r'base64,(.*)');
          final match = regex.firstMatch(widget.avatarC.text);
          final base64String = match?.group(1);

          Uint8List? bytes =
              base64String != null ? base64Decode(base64String) : null;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(150),
                          onTap: () async {
                            getImage(ImageSource.gallery);
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Container(
                                  color: Colors.black,
                                  width: 200,
                                  height: 200,
                                  child: bytes != null
                                      ? Image.memory(
                                          fit: BoxFit.cover,
                                          bytes,
                                        )
                                      : Image.network(
                                          'https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png',
                                          fit: BoxFit.cover))),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Click Image to Edit Profile Picture',
                    style: TextStyle(fontSize: 11),
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView(children: [
                        TextForm(
                            icon: Icons.add_card_rounded,
                            controller: widget.fullNameC,
                            label: 'Fullname',
                            hint: 'Enter your Fullname'),
                        TextForm(
                            icon: Icons.location_city,
                            controller: widget.cityC,
                            label: 'City',
                            hint: 'Enter your City'),
                        TextForm(
                            icon: Icons.flag_outlined,
                            controller: widget.countryC,
                            label: 'Country',
                            hint: 'Enter your Country'),
                        TextForm(
                            icon: Icons.work,
                            controller: widget.jobC,
                            label: 'Job',
                            hint: 'Enter your Job'),
                        TextForm(
                            icon: Icons.subtitles,
                            controller: widget.aboutC,
                            label: 'About',
                            hint: 'Enter your About'),
                        TextForm(
                            icon: FontAwesomeIcons.instagram,
                            controller: widget.instagram,
                            label: 'Instagram',
                            hint: 'Enter your Instagram Account'),
                        TextForm(
                            icon: FontAwesomeIcons.facebook,
                            controller: widget.facebook,
                            label: 'Facebook',
                            hint: 'Enter your Facebook Account'),
                        TextForm(
                            icon: FontAwesomeIcons.twitter,
                            controller: widget.twitter,
                            label: 'Twitter',
                            hint: 'Enter your Twitter Account'),
                        SizedBox(
                          height: 55,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 73, 66, 228)),
                              onPressed: () async {
                                widget.savedUserResponse = UserResponse(
                                  job: widget.jobC.text,
                                  fullname: widget.fullNameC.text,
                                  city: widget.cityC.text,
                                  country: widget.countryC.text,
                                  avatar: widget.avatarC.text,
                                  instagram: widget.instagram.text,
                                  about: widget.aboutC.text,
                                  facebook: widget.facebook.text,
                                  twitter: widget.twitter.text,
                                );

                                context.read<ResponseCubit>().editDataUser(
                                      widget.loginResponse!.username,
                                      widget.loginResponse!.token,
                                      widget.savedUserResponse!,
                                    );
                              },
                              child: const Text('Submit')),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
