class PageModel{
  String _title;
  String _message;
  String _image;

  PageModel(this._title, this._message, this._image);

  String get image => _image;

  String get message => _message;

  String get title => _title;


}