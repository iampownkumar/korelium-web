class ProjectModel {
  final String title;
  final String description;
  final String tag;
  final String? githubUrl;
  final bool isFeatured;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tag,
    this.githubUrl,
    this.isFeatured = false,
  });
}
