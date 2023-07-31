class Shoe {
  Shoe({
    required this.name,
    required this.price,
    required this.img,
    required this.prodPrimaryColor,
  });
  String name;
  double price;
  String img;
  String prodPrimaryColor;

  static List<Shoe> productList = [
    Shoe(
      name: 'Nike Dunk Hi Retro',
      price: 125,
      img: 'assets/shoe/shoe0.png',
      prodPrimaryColor: 'be0000',
    ),
    Shoe(
      name: 'Air Jordan 1 Retro High OG',
      price: 180,
      img: 'assets/shoe/shoe1.png',
      prodPrimaryColor: '005891',
    ),
    Shoe(
      name: 'Air Jordan 1 Mid SE',
      price: 135,
      img: 'assets/shoe/shoe2.png',
      prodPrimaryColor: '673335',
    ),
    Shoe(
      name: 'Nike Dunk High Retro',
      price: 135,
      img: 'assets/shoe/shoe3.png',
      prodPrimaryColor: 'eb4835',
    ),
  ];
}
