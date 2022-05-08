import {
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonText,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import {
  barbellOutline,
  carOutline,
  close,
  colorPaletteOutline,
  desktopOutline,
  fastFoodOutline,
  flaskOutline,
  gameControllerOutline,
  homeOutline,
  libraryOutline,
  medicalOutline,
  pawOutline,
  planetOutline,
  shirtOutline,
  sparklesOutline,
} from "ionicons/icons";
import React from "react";

type Props = {
  dismiss: () => void;
  handleSelect: (item: string) => void;
};

export default function ChooseCategory({ dismiss, handleSelect }: Props) {
  const categories = [
    {
      name: "Fashion",
      icon: shirtOutline,
      options: [
        "Men's Clothing and Shoes",
        "Women's Clothing and Shoes",
        "Babies Clothing and Shoes",
        "Bags and Luggage",
        "Jewellery & Accessories",
      ],
    },
    {
      name: "Food & Grocery",
      icon: fastFoodOutline,
      options: [
        "Breakfast",
        "Beverages",
        "Coffee",
        "Snacks",
        "Canned & Packaged Foods",
        "Baby Food",
      ],
    },
    {
      name: "Electronics",
      icon: desktopOutline,
      options: [
        "Computers & Accessories",
        "Cell Phones & Accessories",
        "TV & Video",
        "Home Audio & Theater",
        "Camera, Photo & Video",
        "Headphones",
        "Video Games",
        "Bluetooth & Wireless Speakers",
        "Car Electronics",
        "Musical Instruments",
        "Wearable Technology",
        "Electronics",
      ],
    },
    {
      name: "Health & Beauty",
      icon: medicalOutline,
      options: [
        "All Beauty",
        "Premium Beauty",
        "Professional Skin Care",
        "Salon & Spa",
        "Men's Grooming",
        "Women's Grooming",
        "Health, Household & Baby Care",
        "Vitamins & Dietary Supplements",
      ],
    },
    {
      name: "Home & Office",
      icon: homeOutline,
      options: [
        "Home Décor",
        "Furniture",
        "Kitchen & Dining",
        "Bed & Bath",
        "Garden & Outdoor",
        "Mattresses",
        "Lighting",
        "Storage & Organization",
        "Home Appliances",
        "Event & Party Supplies",
        "Home Improvement",
      ],
    },
    {
      name: "Collectibles & Art",
      icon: colorPaletteOutline,
      options: [
        "Art",
        "Collectibles",
        "Sport Memorabilia, Fan Shop & Sport Cards",
        "Coins & Paper Money",
        "Antiques",
        "Art & Craft Supplies",
        "Dolls & Teddy Bears",
        "Pottery & Glass",
        "Entertainment Memorabilia",
        "Stamps",
        "Vintage & Antique Jewelry",
      ],
    },
    {
      name: "Sports & Outdoors",
      icon: barbellOutline,
      options: [
        "Athletic Clothing",
        "Exercise & Fitness",
        "Hunting",
        "Fishing",
        "Team Sports",
        "Golf",
        "Fan Shop",
        "The Ride Shop",
        "Leisure Sports & Game Room",
        "Collectibles",
        "Sport Memorabilia, Fan Shop & Sport Cards",
      ],
    },
    {
      name: "Books, Movies & Music",
      icon: libraryOutline,
      options: [
        "Musical Instruments & Gear",
        "Books & Magazines",
        "Movies & TV",
        "Music",
      ],
    },
    {
      name: "Toys & Games",
      icon: gameControllerOutline,
      options: [
        "Collectible Card Games",
        "Video Games",
        "Action Figures",
        "Diecast & Toy Vehicles",
        "Board & Traditional Games",
        "Building Toys",
        "Model Trains",
        "Toy Models & Kits",
        "Preschool Toys & Pretend Play",
        "Vintage & Antique Toys",
        "Outdoor Toys & Play Structures",
        "Slot Cars",
        "Stuffed Animals",
        "Puzzles",
        "Beanbag Plushies",
      ],
    },
    {
      name: "Baby Essentials",
      icon: planetOutline,
      options: [
        "Baby & Toddler Clothing & Shoes",
        "Baby Accessories",
        "Baby Feeding Supplies",
      ],
    },
    {
      name: "Pet Supplies",
      icon: pawOutline,
      options: [
        "Dog Supplies",
        "Dog Food",
        "Cat Supplies",
        "Cat Food",
        "Fish & Aquatic Pets",
        "Small Animals",
        "Birds",
        "Others",
      ],
    },
    {
      name: "Scientific & Industrial",
      icon: flaskOutline,
      options: [
        "Industrial and Scientific",
        "Doctors and Medical Staff",
        "Teachers and Educators",
        "Restaurant Owners and Chefs",
        "Retailers and Small Business",
        "Movers, Packers, Organizers",
        "Property Managers",
        "Dentists and Hygienists",
        "Scientists and Lab Technicians",
        "MRO Professionals",
        "Product Designers and Engineers",
        "Automotive and Fleet Maintenance",
        "Construction and General Contractors",
        "Beauty Professionals",
        "Hoteliers and Hospitality",
        "Fitness and Nutrition",
        "Landscaping Professionals",
        "Farmers and Agriculturalists",
        "Breakroom Essentials",
      ],
    },
    {
      name: "Automotive",
      icon: carOutline,
      options: [
        "Automotive Parts & Accessories",
        "Automotive Tools & Equipment",
        "Car/Vehicle Electronics & GPS",
        "Tires & Wheels",
        "Motorcycle & Powersports",
        "RV Parts & Accessories",
        "Your Garage",
      ],
    },
    {
      name: "Others",
      icon: sparklesOutline,
      options: ["Miscellaneous"],
    },
  ];
  return (
    <>
      <IonHeader translucent>
        <IonToolbar>
          <IonTitle>Choose Category</IonTitle>
          <IonButtons slot="start">
            <IonButton
              color="dark"
              onClick={() => {
                dismiss();
              }}
            >
              <IonIcon slot="icon-only" icon={close} />
            </IonButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen className="ion-padding-vertical">
        <IonList className="bg-transparent" lines="none">
          {categories.map(({ name, icon, options }) => (
            <React.Fragment key={name}>
              <IonItem>
                <div
                  className="rounded-full bg-light flex ion-align-items-center ion-justify-content-center"
                  style={{
                    padding: "0.5rem",
                    fontSize: 25,
                    width: 45,
                    height: 45,
                  }}
                  slot="start"
                >
                  <IonIcon icon={icon} />
                </div>
                <IonLabel>
                  <IonText className="font-medium">{name}</IonText>
                </IonLabel>
              </IonItem>
              {options?.map((option, index) => (
                <IonItem
                  onClick={() => {
                    handleSelect(option);
                  }}
                  key={option + index}
                >
                  <div
                    slot="start"
                    style={{
                      padding: "0.5rem",
                      fontSize: 25,
                      width: 45,
                      height: 45,
                    }}
                  ></div>
                  <IonLabel>
                    <IonText>{option}</IonText>
                  </IonLabel>
                </IonItem>
              ))}
            </React.Fragment>
          ))}
        </IonList>
      </IonContent>
    </>
  );
}
