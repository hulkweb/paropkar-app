class ProductModel {
    int? id;
    String? name;
    int? categoryId;
    int? subcategoryId;
    String? price;
    int? stock;
    String? discountType;
    String? discountValue;
    String? image;
    String? productType;
    String? description;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    Category? category;
    Category? subcategory;
    
    ProductModel({
        this.id,
        this.name,
        this.categoryId,
        this.subcategoryId,
        this.price,
        this.stock,
        this.discountType,
        this.discountValue,
        this.image,
        this.productType,
        this.description,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.category,
        this.subcategory,
    });

}

class Category {
    int? id;
    String? name;
    String? image;
    String? description;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? categoryId;

    Category({
        this.id,
        this.name,
        this.image,
        this.description,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
    });

}
