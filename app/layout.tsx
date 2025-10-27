import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Azure Sora 2 UI",
  description: "Next-generation video generation interface powered by Azure",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="antialiased">
        {children}
      </body>
    </html>
  );
}
