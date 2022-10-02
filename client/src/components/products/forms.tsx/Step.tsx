type Props = {
  noXPadding?: boolean;
  children: React.ReactNode;
};

export default function Step({ noXPadding, children }: Props) {
  return (
    <div
      className={`${
        noXPadding ? "" : "ion-padding-horizontal"
      } pt-16 pb-20 w-full h-full overflow-y-scroll text-left`}
    >
      {children}
    </div>
  );
}
