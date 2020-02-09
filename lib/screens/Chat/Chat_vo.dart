class Message {
  String text;
  bool isSender; // 是否自己发送
  Message(this.text, this.isSender);
}

List<Message> message =[
  Message('你好啊', false),
  Message('你叫什么？', true),
  Message('我叫郑佩询，你呢？', false),
  Message('我叫潘鹤，很高兴认识你', true),
  Message('我也是', false),
  Message('过年好啊', true),
  Message('新年快乐，我亲爱的鹤哥', false),
  Message('好妹子，新年好', true),
  Message('我叫郑佩询，你呢？', false),
  Message('我叫潘鹤，很高兴认识你', true),
  Message('我也是', false),
  Message('过年好啊', true),
  Message('新年快乐，我亲爱的鹤哥', false),
  Message('好妹子，新年好', true),
  Message('我叫郑佩询，你呢？', false),
  Message('我叫潘鹤，很高兴认识你', true),
  Message('我也是', false),
  Message('过年好啊', true),
  Message('新年快乐，我亲爱的鹤哥', false),
  Message('好妹子，新年好', true)
];