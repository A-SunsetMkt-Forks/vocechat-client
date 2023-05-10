import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocechat_client/app_consts.dart';
import 'package:vocechat_client/shared_funcs.dart';
import 'package:vocechat_client/ui/chats/chat/message_tile/tile_pages/file_page.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class VoceFileBubble extends StatelessWidget {
  final String filePath;
  final String name;

  /// Integer size in byte.
  final int size;
  final Future<File?> Function() getLocalFile;
  final Future<File?> Function(Function(int, int)) getFile;

  final bool isReply;

  const VoceFileBubble(
      {Key? key,
      required this.filePath,
      required this.name,
      required this.size,
      required this.getLocalFile,
      required this.getFile})
      : isReply = false,
        super(key: key);

  const VoceFileBubble.reply(
      {Key? key,
      required this.filePath,
      required this.name,
      required this.size,
      required this.getLocalFile,
      required this.getFile})
      : isReply = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (filePath.isEmpty || name.isEmpty) {
      return const SizedBox.shrink();
    }

    final filename = p.basenameWithoutExtension(name);
    String extension;
    try {
      extension = p.extension(name).substring(1);
    } catch (e) {
      // App.logger.severe(e);
      extension = "";
    }

    Widget svgPic;

    double width, height;
    if (isReply) {
      width = 18;
      height = 24;
    } else {
      width = 36;
      height = 48;
    }

    if (_isAudio(extension)) {
      svgPic = SvgPicture.asset("assets/images/file_audio.svg",
          width: width, height: height);
    } else if (_isVideo(extension)) {
      svgPic = SvgPicture.asset("assets/images/file_video.svg",
          width: width, height: height);
    } else if (extension.toLowerCase() == "pdf") {
      svgPic = SvgPicture.asset("assets/images/file_pdf.svg",
          width: width, height: height);
    } else if (extension.toLowerCase() == "txt") {
      svgPic = SvgPicture.asset("assets/images/file_txt.svg",
          width: width, height: height);
    } else if (_isImage(extension)) {
      svgPic = SvgPicture.asset("assets/images/file_image.svg",
          width: width, height: height);
    } else if (_isCode(extension)) {
      svgPic = SvgPicture.asset("assets/images/file_code.svg",
          width: width, height: height);
    } else {
      svgPic = SvgPicture.asset("assets/images/file.svg",
          width: width, height: height);
    }

    return GestureDetector(
      onTap: () => _viewFile(context),
      child: _buildFileInfo(svgPic, filename, extension),
    );
  }

  Widget _buildFileInfo(Widget svgPic, String filename, String extension) {
    if (isReply) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          svgPic,
          const SizedBox(width: 4),
          Flexible(child: _buildFileName(filename, extension))
        ],
      );
    }
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(212, 212, 212, 1)),
          borderRadius: BorderRadius.circular(6),
          color: const Color.fromRGBO(243, 244, 246, 1)),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          svgPic,
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFileName(filename, extension),
                const SizedBox(height: 4),
                Text(SharedFuncs.getFileSizeString(size),
                    style: const TextStyle(
                        color: Color.fromRGBO(97, 97, 97, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w400))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildFileName(String filename, String extension) {
    return Row(
      children: [
        Flexible(
          child: Text(
            filename,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Color.fromRGBO(28, 28, 30, 1),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        if (extension.isNotEmpty)
          Text(
            ".$extension",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Color.fromRGBO(28, 28, 30, 1),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          )
      ],
    );
  }

  bool _isAudio(String extension) {
    return audioExts.contains(extension.toLowerCase());
  }

  bool _isVideo(String extension) {
    return videoExts.contains(extension.toLowerCase());
  }

  bool _isImage(String extension) {
    return imageExts.contains(extension.toLowerCase());
  }

  bool _isCode(String extension) {
    return codeExts.contains(extension.toLowerCase());
  }

  bool fileExists(String filePath) => File(filePath).existsSync();

  Future setFilePath(String type, String assetPath) async {
    final directory = await getTemporaryDirectory();
    return "${directory.path}/fileview/${base64.encode(utf8.encode(assetPath))}.$type";
  }

  Future<void> _viewFile(BuildContext context) async {
    final fileName = p.basenameWithoutExtension(name);
    final extension = p.extension(name).split(".").last;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FilePage(
            // filePath: filePath,
            fileName: fileName,
            extension: extension,
            size: size,
            getLocalFile: getLocalFile,
            getFile: getFile)));
  }
}
