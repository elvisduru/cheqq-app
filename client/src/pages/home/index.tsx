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
import ChartCard from "../../components/ChartCard";
import { useStore } from "../../hooks/useStore";
import { getCurrentDayPeriod } from "../../utils";

const Home = () => {
  const user = useStore((store) => store.user);
  const selectedStore = useStore((store) => store.selectedStore);
  const store = user?.stores.find((s) => s.id === selectedStore);

  const orders = [
    {
      orderId: "#774312",
      customer: {
        firstName: "John",
        lastName: "Doe",
      },
      total: 20000,
      currency_code: "₦",
      currency: "NGN",
      cart: [
        {
          product: {
            images: [
              "https://api.lorem.space/image/face?w=151&h=150",
              "https://api.lorem.space/image/face?w=150&h=150",
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
      total: 12000.5,
      currency_code: "₦",
      currency: "NGN",
      cart: [
        {
          product: {
            images: [
              "https://api.lorem.space/image/face?w=150&h=150",
              "https://api.lorem.space/image/face?w=150&h=150",
            ],
            name: "Nike shoes",
            price: 120,
          },
          quantity: "2",
        },
        {
          product: {
            images: [
              "https://api.lorem.space/image/face?w=152&h=150",
              "https://api.lorem.space/image/face?w=150&h=150",
              "https://api.lorem.space/image/face?w=150&h=150",
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
      total: 20000,
      currency_code: "₦",
      currency: "NGN",
      cart: [
        {
          product: {
            images: [
              "https://api.lorem.space/image/face?w=153&h=150",
              "https://api.lorem.space/image/face?w=150&h=150",
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
      total: 20000,
      currency_code: "₦",
      currency: "NGN",
      cart: [
        {
          product: {
            images: [
              "https://api.lorem.space/image/face?w=150&h=150",
              "https://api.lorem.space/image/face?w=150&h=150",
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
    currency_code: string;
    currency: string;
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
                <img src={store?.logo} alt="avatar" />
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
            <span className="font-light">{user?.name?.split(" ")[0]}</span>
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
          <IonLabel className="font-light text-lg">Stats</IonLabel>
          <IonButton routerLink="/analytics">See all</IonButton>
        </IonListHeader>
        <ChartCard store={store!} title="Your Sales" />

        <IonList lines="none">
          <IonListHeader>
            <IonLabel>Recent Orders</IonLabel>
          </IonListHeader>
          {orders.map((order: Order) => (
            <IonItem key={order.orderId} className="my-2" shape="round" button>
              <IonThumbnail
                className="flex items-center justify-center"
                slot="start"
              >
                {order.cart.length > 1 ? (
                  <p className="ion-text-center leading-none bg-card w-full h-full flex flex-col ion-justify-content-center rounded-full">
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
                  {order.customer.firstName} {order.customer.lastName}
                </p>
              </IonLabel>
              <IonLabel slot="end">
                <h2>
                  {order.currency_code}
                  {order.total.toFixed(2)}
                </h2>
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
