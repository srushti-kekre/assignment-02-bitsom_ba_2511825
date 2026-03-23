// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    _id: "prod_elec_001",
    name: "Smartphone X12",
    category: "Electronics",
    brand: "TechAlmond",
    price: 29999,
    currency: "INR",
    stock: 120,
    specifications: {
      processor: "Octa-core 2.4GHz",
      ram: "8GB",
      storage: "128GB",
      battery: "5000mAh",
      voltage: "5V"
    },
    warranty: {
      period_months: 12,
      type: "Manufacturer"
    }
  },
  {
    _id: "prod_cloth_001",
    name: "Men's Casual T-Shirt",
    category: "Clothing",
    brand: "UrbanWear",
    price: 799,
    currency: "INR",
    stock: 250,
    variants: [
      { size: "M", color: "Black", stock: 80 },
      { size: "L", color: "Black", stock: 70 }
    ],
    material: {
      fabric: "Cotton"
    }
  },
  {
    _id: "prod_groc_001",
    name: "Organic Cow Milk",
    category: "Groceries",
    brand: "FarmFresh",
    price: 60,
    currency: "INR",
    stock: 500,
    expiry: {
      manufacture_date: new Date("2026-03-20"),
      expiry_date: new Date("2026-03-25")
    },
    nutritional_info: {
      calories_per_100ml: 60
    }
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  "expiry.expiry_date": { $lt: new Date("2025-01-01") }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { _id: "prod_elec_001" },
  {
    $set: {
      discount_percent: 10
    }
  }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });