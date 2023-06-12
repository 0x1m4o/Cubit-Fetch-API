import 'package:cubitfetchapi/cubits/response/response_cubit.dart';
import 'package:cubitfetchapi/main.dart';
import 'package:cubitfetchapi/models/user_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../partials/text_form.dart';

class EditPage extends StatefulWidget {
  TextEditingController userC = TextEditingController();
  final String tokenResponse;
  final String userResponse;
  late Box box;
  // ignore: prefer_typing_uninitialized_variables

  UserResponse? savedUserResponse;

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
    this.tokenResponse = '',
    this.userResponse = '',
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  void initState() {
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
    // widget.box = Hive.box<UserResponse>('box');
    // editAllData();
  }

  // void editAllData() async {
  //   widget.box.put('loginResp', widget.savedUserResponse);
  //   final finalLoginResponse = widget.box.get('loginResp');
  //   if (finalLoginResponse != null) {
  //     widget.savedUserResponse = finalLoginResponse;
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
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
            icon: Icons.work,
            controller: widget.aboutC,
            label: 'About',
            hint: 'Enter your About'),
        TextForm(
            icon: Icons.work,
            controller: widget.instagram,
            label: 'Instagram',
            hint: 'Enter your Instagram'),
        TextForm(
            icon: Icons.password,
            controller: widget.avatarC,
            label: 'Avatar',
            hint: 'Enter your Avatar'),
        TextForm(
            icon: Icons.work,
            controller: widget.facebook,
            label: 'Facebook',
            hint: 'Enter your Facebook'),
        TextForm(
            icon: Icons.work,
            controller: widget.twitter,
            label: 'About',
            hint: 'Enter your About'),
        editButton(context),
      ]),
    );
  }

  Widget editButton(BuildContext context) {
    UserResponse? editresponse;
    return SizedBox(
      height: 55,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 73, 66, 228)),
          onPressed: () async {
            editresponse = UserResponse(
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
                widget.userResponse, widget.tokenResponse, editresponse!);
            Navigator.pop(context);
          },
          child: const Text('Submit')),
    );
  }
}
