class Note {
   String? id;
  late String content;
  late DateTime createdDate;
  late String title;

  Note({
    this.id,
    required this.content,
    required this.createdDate,
    required this.title,
  });

   factory Note.fromJson(String id, Map<String, dynamic> json) {
     return Note(
       id: id,
       createdDate: DateTime.parse(json['createdDate']), // Convert to DateTime
       title: json['title'],
       content: json['content'],
     );
   }
   Map<String, dynamic> toJson() {
     return {
       'createdDate': createdDate.toIso8601String(),
       'title': title,
       'content': content,
     };
   }
}
