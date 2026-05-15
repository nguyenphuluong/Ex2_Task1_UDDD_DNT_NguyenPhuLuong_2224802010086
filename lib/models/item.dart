class Item {
  final int id;
  final String name;
  final int price;

  const Item({
    required this.id,
    required this.name,
    required this.price,
  });
}

final List<Item> catalogItems = [
  Item(id: 1, name: 'Áo thun', price: 120000),
  Item(id: 2, name: 'Quần jean', price: 350000),
  Item(id: 3, name: 'Giày sneaker', price: 590000),
  Item(id: 4, name: 'Balo', price: 250000),
  Item(id: 5, name: 'Đồng hồ', price: 420000),
];