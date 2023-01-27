import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
class AgoraCallVideo extends StatefulWidget {
   AgoraCallVideo({Key? key}) : super(key: key);

  @override
  State<AgoraCallVideo> createState() => _AgoraCallVideoState();
}

class _AgoraCallVideoState extends State<AgoraCallVideo> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "e5daa0d351814320857b18aea59abdfd",
      channelName: "exd_project",
      username: "Ahmad"
    ),
    enabledPermission: [Permission.camera,Permission.microphone]
  );
  void initAgora() async {
    await client.initialize();
  }
// Initialize the Agora Engine
  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(client: client,
              showNumberOfUsers: true,

            ),

            AgoraVideoButtons(client: client,
            enabledButtons: [
              BuiltInButtons.toggleCamera,
              BuiltInButtons.callEnd,
              BuiltInButtons.toggleMic,
              BuiltInButtons.switchCamera,
            ],),
          ],
        ),
      ),
    );
  }
}
