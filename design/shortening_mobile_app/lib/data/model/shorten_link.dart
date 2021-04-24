class ShortenLink {
  String code;
  String originalLink;
  String shortLink;
  String fullShortLink;
  String secondShortLink;
  String secondFullShortLink;
  String shareLink;
  String fullShareLink;
  bool isCopied;

  ShortenLink(
      {this.code,
      this.originalLink,
      this.shortLink,
      this.fullShortLink,
      this.secondShortLink,
      this.secondFullShortLink,
      this.shareLink,
      this.fullShareLink,
      this.isCopied});

  factory ShortenLink.fromJson(Map<String, dynamic> parsedJson) {
    return ShortenLink(
      code: parsedJson['code'],
      originalLink: parsedJson['original_link'],
      shortLink: parsedJson['short_link'],
      fullShortLink: parsedJson['full_short_link'],
      secondShortLink: parsedJson['short_link2'],
      secondFullShortLink: parsedJson['full_short_link2'],
      shareLink: parsedJson['share_link'],
      fullShareLink: parsedJson['full_share_link'],
      isCopied: false,
    );
  }
}

class ShortenLinkList {
  List<ShortenLink> links = [];
  void setAsCopiedByIndex(int index) {
    if (index <= links.length) {
      for (int i = 0; i < links.length; i++) {
        links[i].isCopied = false;
      }
      links[index].isCopied = true;
    }
  }
}
