import 'dart:async';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:shrub/shrub.dart';

class ShrubAssetFilesystem extends ShrubFilesystem {
  final String package;
  final AssetReader reader;
  final AssetWriter writer;

  ShrubAssetFilesystem(this.package, this.reader, this.writer);

  factory ShrubAssetFilesystem.forBuildStep(BuildStep buildStep) =>
      new ShrubAssetFilesystem(buildStep.inputId.package, buildStep, buildStep);

  @override
  ShrubDirectory directory(String path) {
    return new ShrubAssetDirectory(this, path);
  }
}

class ShrubAssetDirectory extends ShrubDirectory {
  final ShrubAssetFilesystem filesystem;
  final String path;

  ShrubAssetDirectory(this.filesystem, this.path);

  @override
  ShrubDirectory child(String dirname) {
    return new ShrubAssetDirectory(filesystem, p.join(path, dirname));
  }

  @override
  ShrubFile findShrubFile(String name) {
    var filePath = p.setExtension(p.join(path, name), shrubFileExtension);
    var assetId = new AssetId(filesystem.package, filePath);
    return new ShrubAssetFile(filesystem, assetId);
  }

  @override
  Stream<ShrubFile> listShrubFiles() {
    return filesystem.reader
        .findAssets(
            new Glob(p.setExtension(p.join(path, '*'), shrubFileExtension)))
        .map((assetId) => new ShrubAssetFile(filesystem, assetId));
  }
}

class ShrubAssetFile extends ShrubFile {
  final ShrubAssetFilesystem filesystem;
  final AssetId assetId;

  ShrubAssetFile(this.filesystem, this.assetId);

  @override
  ShrubDirectory get directory =>
      new ShrubAssetDirectory(filesystem, p.dirname(path));

  @override
  Future<bool> get exists => filesystem.reader.canRead(assetId);

  @override
  String get path => assetId.path;

  @override
  ShrubFile changeExtension(String extension) {
    return new ShrubAssetFile(
        this.filesystem, assetId.changeExtension(extension));
  }

  @override
  Future<String> read() {
    return filesystem.reader.readAsString(assetId);
  }

  @override
  Future write(String contents) {
    return filesystem.writer.writeAsString(assetId, contents);
  }
}
