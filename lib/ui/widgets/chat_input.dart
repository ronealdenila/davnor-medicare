import 'dart:io';
import 'package:davnor_medicare/core/controllers/live_chat_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget chatInput(LiveChatController liveChatCont) {
  if (liveChatCont.image.value.isNotEmpty) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFA9A9A9),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: SizedBox(
        width: 80,
        height: 80,
        child: Wrap(children: [
          Stack(
            children: [
              kIsWeb
                  ? Image.network(
                      liveChatCont.image.value,
                      fit: BoxFit.fill,
                    )
                  : Image.file(
                      File(liveChatCont.image.value),
                      width: 80,
                      height: 80,
                      fit: BoxFit.fitWidth,
                    ),
              Positioned(
                right: 5,
                top: 5,
                child: InkWell(
                  onTap: liveChatCont.clearImage,
                  child: const Icon(
                    Icons.remove_circle,
                    size: 25,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  } else if (liveChatCont.images.isNotEmpty) {
    return Container(
      height: (liveChatCont.images.length <= 3) ? 100 : 170,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFA9A9A9),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Center(
        child: GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          children: List.generate(liveChatCont.images.length, (index) {
            return Container(
              height: 68.5,
              color: verySoftBlueColor,
              child: Center(
                child: Wrap(children: [
                  Stack(
                    children: [
                      kIsWeb
                          ? Image.network(
                              liveChatCont.images[index].path,
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              File(liveChatCont.images[index].path),
                              fit: BoxFit.fill,
                              height: 68.5,
                            ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: InkWell(
                          onTap: () {
                            liveChatCont.images
                                .remove(liveChatCont.images[index]);
                          },
                          child: const Icon(
                            Icons.remove_circle,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            );
          }),
        ),
      ),
    );
  }
  return Container(
    constraints: const BoxConstraints(maxHeight: 100),
    child: TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: liveChatCont.chatController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      onChanged: (value) {
        return;
      },
      onSaved: (value) => liveChatCont.chatController.text = value!,
    ),
  );
}
