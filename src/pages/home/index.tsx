import {
  IonAvatar,
  IonButtons,
  IonCard,
  IonCardContent,
  IonCardHeader,
  IonCardTitle,
  IonContent,
  IonHeader,
  IonList,
  IonMenuButton,
  IonNote,
  IonPage,
  IonThumbnail,
  IonToolbar,
} from "@ionic/react";
import GraphCard from "../../components/GraphCard";
import "./index.scss";

const Home: React.FC = () => {
  const user = {
    firstName: "John",
    lastName: "Doe",
    avatar: "https://randomuser.me/api/portraits/men/86.jpg",
  };

  const orders = [
    {
      orderId: "#774312",
      customer: {
        firstName: "John",
        lastName: "Doe",
      },
      cart: [
        {
          product: {
            images: [
              "https://picsum.photos/200/300",
              "https://picsum.photos/200/300",
            ],
            name: "Nike shoes",
            price: "120",
          },
          quantity: "2",
        },
      ],
      createdAt: "2020-04-20T10:00:00.000Z",
    },
    {
      orderId: "#774312",
      customer: {
        firstName: "John",
        lastName: "Doe",
      },
      cart: [
        {
          product: {
            images: [
              "https://picsum.photos/200/300",
              "https://picsum.photos/200/300",
            ],
            name: "Nike shoes",
            price: "120",
          },
          quantity: "2",
        },
        {
          product: {
            images: [
              "https://picsum.photos/200/300",
              "https://picsum.photos/200/300",
              "https://picsum.photos/200/300",
            ],
            name: "Adiddas shoes",
            price: "100",
          },
          quantity: "1",
        },
      ],
      createdAt: "2020-04-20T10:00:00.000Z",
    },
  ];

  return (
    <IonPage id="home">
      <IonHeader collapse="fade">
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton>
              <IonAvatar>
                <img src={user.avatar} alt="avatar" />
              </IonAvatar>
            </IonMenuButton>
          </IonButtons>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <div className="ion-text-center ion-padding mx-auto" id="intro-header">
          <h3>Hi Elvis</h3>
          <IonNote>
            Lorem ipsum dolor sit amet consectetur adipisicing elit
          </IonNote>
        </div>
        {/* Todo: Would be a carousel of several stats soon */}
        <GraphCard title="Your Sales" />
        <IonCard>
          <IonCardHeader>
            <IonCardTitle className="text-sm">Active Orders</IonCardTitle>
          </IonCardHeader>
          <IonCardContent>
            <IonList>
              {orders.map((order) => (
                <IonThumbnail
                  className="flex ion-align-items-center ion-justify-content-center"
                  slot="start"
                >
                  {order.cart.length > 1 ? (
                    <p className="ion-text-center text-xs! leading-none">
                      {order.cart.length} <br />
                      <span className="text-xxs">items</span>
                    </p>
                  ) : (
                    <img src={order.cart[0].product.images[0]} alt="product" />
                  )}
                </IonThumbnail>
              ))}
            </IonList>
          </IonCardContent>
        </IonCard>
      </IonContent>
    </IonPage>
  );
};

export default Home;
