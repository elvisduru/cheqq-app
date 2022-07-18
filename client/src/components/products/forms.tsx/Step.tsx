type Props = {
  children: React.ReactNode;
};

export default function Step({ children }: Props) {
  return (
    <div className="ion-padding-horizontal ion-padding-bottom py-16 w-full h-full overflow-y-scroll">
      {children}
    </div>
  );
}
