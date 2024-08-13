class ImageInfo {
  float x, y;
  int imgIndex;
  int size;
  int timer;
  int direction;

  ImageInfo(float x, float y, int imgIndex) {
    this.x = x;
    this.y = y;
    this.imgIndex = imgIndex;
    this.size = 30;
    this.timer = 0;
    this.direction = 1;
  }
}
