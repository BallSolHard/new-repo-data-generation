"use client";

import { useState, useEffect } from "react";
import { Menu, X, Home, BookOpen, Settings, LogOut } from "lucide-react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import styles from './Sidebar.module.scss';

export default function TopBar() {
  const currentPath = usePathname();
  const [isOpen, setIsOpen] = useState(false);
  const [isMobile, setIsMobile] = useState(false);

  const isActive = (path: string) => {
    if (!currentPath) return false;
    if (path === "/") {
      return currentPath === path;
    }
    return currentPath.startsWith(path);
  };

  useEffect(() => {
    const checkMobile = () => {
      const isMobileView = window.innerWidth < 768;
      setIsMobile(isMobileView);
    };

    checkMobile();
    window.addEventListener('resize', checkMobile);

    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  const handleMobileMenuToggle = () => {
    setIsOpen(!isOpen);
  };

  return (
    <>
      {/* Top Bar */}
      <div className={styles.topBar}>
        {/* Logo Section - Centered */}
        <Link href="/" className={styles.logoSection}>
          <div className="w-10 h-10 bg-blue-600 rounded-md flex items-center justify-center">
            <span className="text-white font-bold text-lg">ST</span>
          </div>
          <span className="ml-3 text-xl font-semibold tracking-tight text-gray-800">
            StudyTech
          </span>
        </Link>
      </div>

      {/* Spacer for fixed top bar */}
      <div className={styles.topBarSpacer}></div>
    </>
  );
}
