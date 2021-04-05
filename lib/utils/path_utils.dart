class PathUtils {
  static String testDataPathFrom(String path) =>
      'test/data/${path.replaceAll('/', '_')}.html';
}
