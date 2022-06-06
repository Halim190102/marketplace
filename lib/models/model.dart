class Model {
  String? laptop, lokasi, image;
  int? harga, jumlah;

  Model(this.laptop, this.harga, this.lokasi, this.image);
}

class Model2 {
  String? id, laptop, lokasi, image;
  int? harga, jumlah;

  Model2(
      this.id, this.laptop, this.harga, this.lokasi, this.image, this.jumlah);
}

class Model3 {
  String? createdAt, id, nama, laptop, lokasi, image, nomor, metode;
  int? harga, jumlah;

  Model3(this.id, this.nama, this.laptop, this.harga, this.lokasi, this.image,
      this.jumlah, this.nomor, this.metode, this.createdAt);
}

class Profil {
  String? id, nomor, tgl;

  Profil(this.id, this.nomor, this.tgl);
}
