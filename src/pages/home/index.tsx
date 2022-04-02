import {
  IonAvatar,
  IonButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonListHeader,
  IonMenuButton,
  IonNote,
  IonPage,
  IonThumbnail,
  IonToolbar,
} from "@ionic/react";
import { format } from "date-fns";
import { notifications } from "ionicons/icons";
import { Link } from "react-router-dom";
import { User } from "../../App";
import ChartCard from "../../components/ChartCard";
import { getCurrentDayPeriod } from "../../utils";
import "./index.scss";

const Home: React.FC = () => {
  const orders = [
    {
      orderId: "#774312",
      customer: {
        firstName: "John",
        lastName: "Doe",
      },
      total: 200,
      cart: [
        {
          product: {
            images: [
              "https://picsum.photos/200/300",
              "https://picsum.photos/200/300",
            ],
            name: "Nike shoes",
            price: 120,
          },
          quantity: "2",
        },
      ],
      createdAt: "2022-02-20T10:00:00.000Z",
    },
    {
      orderId: "#774122",
      customer: {
        firstName: "John",
        lastName: "Doe",
      },
      total: 120.5,
      cart: [
        {
          product: {
            images: [
              "https://picsum.photos/200/300",
              "https://picsum.photos/200/300",
            ],
            name: "Nike shoes",
            price: 120,
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
            price: 100,
          },
          quantity: "1",
        },
      ],
      createdAt: "2022-02-19T10:00:00.000Z",
    },
    {
      orderId: "#774316",
      customer: {
        firstName: "John",
        lastName: "Doe",
      },
      total: 200,
      cart: [
        {
          product: {
            images: [
              "https://picsum.photos/202/300",
              "https://picsum.photos/200/300",
            ],
            name: "Nike shoes",
            price: 120,
          },
          quantity: "2",
        },
      ],
      createdAt: "2022-02-18T10:00:00.000Z",
    },
    {
      orderId: "#774313",
      customer: {
        firstName: "John",
        lastName: "Doe",
      },
      total: 200,
      cart: [
        {
          product: {
            images: [
              "https://picsum.photos/201/300",
              "https://picsum.photos/200/300",
            ],
            name: "Nike shoes",
            price: 120,
          },
          quantity: "2",
        },
      ],
      createdAt: "2022-02-14T10:00:00.000Z",
    },
  ];

  type Order = {
    orderId: string;
    customer: {
      firstName: string;
      lastName: string;
    };
    total: number;
    cart: {
      product: {
        images: string[];
        name: string;
        price: number;
      };
      quantity: string;
    }[];
    createdAt: string;
  };

  return (
    <IonPage id="home">
      <IonHeader collapse="fade" translucent>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton>
              <IonAvatar>
                <img src={User.avatar} alt="avatar" />
              </IonAvatar>
            </IonMenuButton>
          </IonButtons>
          <IonButton fill="solid" color="white" slot="end">
            <IonIcon slot="icon-only" icon={notifications} />
          </IonButton>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <div className="ion-padding">
          <h3>
            Good {getCurrentDayPeriod()},{" "}
            <span className="font-light">{User.firstName}</span>
          </h3>
          <div className="bubble">
            <IonNote>
              Check out our <Link to="/tips">tips and tricks</Link> and 🔥fire
              up your sales skills 💎.
            </IonNote>
          </div>
        </div>
        {/* Todo: Would be a carousel of several stats soon */}
        <IonListHeader>
          <IonLabel className="font-light text-lg">Statistics</IonLabel>
          <IonButton routerLink="/analytics">See all</IonButton>
        </IonListHeader>
        <ChartCard title="Your Sales" />

        <IonList lines="none" className="table">
          <IonListHeader>
            <IonLabel>Recent Orders</IonLabel>
          </IonListHeader>
          {orders.map((order: Order) => (
            <IonItem key={order.orderId} shape="round" button>
              <IonThumbnail
                className="flex ion-align-items-center ion-justify-content-center"
                slot="start"
              >
                {order.cart.length > 1 ? (
                  <p className="ion-text-center leading-none bg-card w-full h-full flex flex-column ion-justify-content-center rounded-full">
                    {order.cart.length} <br />
                    <span className="text-xs">items</span>
                  </p>
                ) : (
                  <img src={order.cart[0].product.images[0]} alt="product" />
                )}
              </IonThumbnail>
              <IonLabel>
                <h2>{order.orderId}</h2>
                <p>
                  {order.customer.firstName}
                  {order.customer.lastName}
                </p>
              </IonLabel>
              <IonLabel slot="end">
                <h2>${order.total.toFixed(2)}</h2>
                <p>{format(new Date(order.createdAt), "MMM dd, yyyy")}</p>
              </IonLabel>
            </IonItem>
          ))}
        </IonList>
      </IonContent>
    </IonPage>
  );
};

export default Home;
