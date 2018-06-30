import 'package:shrub/shrub.dart';

/// The module system itself, and a view thereof.
///
/// It can resolve internal packages and installed packages.
class ModuleSystem extends ModuleSystemView {
  final Map<String, List<Module>> packageCache = {};
  final ShrubFilesystem filesystem;
  final ShrubDirectory globalCacheDirectory;

  ModuleSystem(this.filesystem, this.globalCacheDirectory);

  @override
  Module findModule(String name, String version) {
    var list = packageCache.putIfAbsent(name, () => []);
    var matching = list.firstWhere(
        (p) => p.version == version || version == null,
        orElse: () => null);
    if (matching != null) return matching;

    var dir =
        globalCacheDirectory.child(filesystem.context.join(name, version));
    var pkg = new Module(null, dir, name, version);
    list.add(pkg);
    return pkg;
  }
}
