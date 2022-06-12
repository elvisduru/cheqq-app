import { PrismaClient, Prisma } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  let categories = [
    {
      name: 'Fashion',
      options: [
        "Men's Clothing and Shoes",
        "Women's Clothing and Shoes",
        'Babies Clothing and Shoes',
        'Bags and Luggage',
        'Jewellery & Accessories',
      ],
    },
    {
      name: 'Food & Grocery',
      options: [
        'Breakfast',
        'Beverages',
        'Coffee',
        'Snacks',
        'Canned & Packaged Foods',
        'Baby Food',
      ],
    },
    {
      name: 'Electronics',
      options: [
        'Computers & Accessories',
        'Cell Phones & Accessories',
        'TV & Video',
        'Home Audio & Theater',
        'Camera, Photo & Video',
        'Headphones',
        'Video Games',
        'Bluetooth & Wireless Speakers',
        'Car Electronics',
        'Musical Instruments',
        'Wearable Technology',
        'Electronics',
      ],
    },
    {
      name: 'Health & Beauty',
      options: [
        'All Beauty',
        'Premium Beauty',
        'Professional Skin Care',
        'Salon & Spa',
        "Men's Grooming",
        "Women's Grooming",
        'Health, Household & Baby Care',
        'Vitamins & Dietary Supplements',
      ],
    },
    {
      name: 'Home & Office',
      options: [
        'Home Décor',
        'Furniture',
        'Kitchen & Dining',
        'Bed & Bath',
        'Garden & Outdoor',
        'Mattresses',
        'Lighting',
        'Storage & Organization',
        'Home Appliances',
        'Event & Party Supplies',
        'Home Improvement',
      ],
    },
    {
      name: 'Collectibles & Art',
      options: [
        'Art',
        'Collectibles',
        'Sport Memorabilia, Fan Shop & Sport Cards',
        'Coins & Paper Money',
        'Antiques',
        'Art & Craft Supplies',
        'Dolls & Teddy Bears',
        'Pottery & Glass',
        'Entertainment Memorabilia',
        'Stamps',
        'Vintage & Antique Jewelry',
      ],
    },
    {
      name: 'Sports & Outdoors',
      options: [
        'Athletic Clothing',
        'Exercise & Fitness',
        'Hunting',
        'Fishing',
        'Team Sports',
        'Golf',
        'Fan Shop',
        'The Ride Shop',
        'Leisure Sports & Game Room',
        'Collectibles',
        'Sport Memorabilia, Fan Shop & Sport Cards',
      ],
    },
    {
      name: 'Books, Movies & Music',
      options: [
        'Musical Instruments & Gear',
        'Books & Magazines',
        'Movies & TV',
        'Music',
      ],
    },
    {
      name: 'Toys & Games',
      options: [
        'Collectible Card Games',
        'Video Games',
        'Action Figures',
        'Diecast & Toy Vehicles',
        'Board & Traditional Games',
        'Building Toys',
        'Model Trains',
        'Toy Models & Kits',
        'Preschool Toys & Pretend Play',
        'Vintage & Antique Toys',
        'Outdoor Toys & Play Structures',
        'Slot Cars',
        'Stuffed Animals',
        'Puzzles',
        'Beanbag Plushies',
      ],
    },
    {
      name: 'Baby Essentials',
      options: [
        'Baby & Toddler Clothing & Shoes',
        'Baby Accessories',
        'Baby Feeding Supplies',
      ],
    },
    {
      name: 'Pet Supplies',
      options: [
        'Dog Supplies',
        'Dog Food',
        'Cat Supplies',
        'Cat Food',
        'Fish & Aquatic Pets',
        'Small Animals',
        'Birds',
        'Others',
      ],
    },
    {
      name: 'Scientific & Industrial',
      options: [
        'Industrial and Scientific',
        'Doctors and Medical Staff',
        'Teachers and Educators',
        'Restaurant Owners and Chefs',
        'Retailers and Small Business',
        'Movers, Packers, Organizers',
        'Property Managers',
        'Dentists and Hygienists',
        'Scientists and Lab Technicians',
        'MRO Professionals',
        'Product Designers and Engineers',
        'Automotive and Fleet Maintenance',
        'Construction and General Contractors',
        'Beauty Professionals',
        'Hoteliers and Hospitality',
        'Fitness and Nutrition',
        'Landscaping Professionals',
        'Farmers and Agriculturalists',
        'Breakroom Essentials',
      ],
    },
    {
      name: 'Automotive',
      options: [
        'Automotive Parts & Accessories',
        'Automotive Tools & Equipment',
        'Car/Vehicle Electronics & GPS',
        'Tires & Wheels',
        'Motorcycle & Powersports',
        'RV Parts & Accessories',
        'Your Garage',
      ],
    },
    {
      name: 'Others',
      options: ['Miscellaneous'],
    },
  ];
  await Promise.all(
    categories.map(async (category) => {
      await prisma.category.create({
        data: {
          name: category.name,
          subCategories: {
            createMany: {
              data: category.options.map((subCategory) => ({
                name: subCategory,
              })),
            },
          },
        },
      });
    }),
  );
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
