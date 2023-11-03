import * as S from "./style.ts";
import { Outlet } from "react-router-dom";

import Footer from "@layout/footer/view.tsx";
import Header from "@layout/header/view.tsx";

import KeyboardArrowDownIcon from "@mui/icons-material/KeyboardArrowDown";
import { useMainPageViewController } from "./view.controller.ts";
import Profile from "@components/main/profile/view.tsx";
import LoadingSpinner from "@components/loading-spinner/view.tsx";

export function MainPage() {
  const {
    expertUser,
    isLoading,
    nav: { navList, currentNavItem },
    mobileNav: { isWideMobile, mobileNavOpen, onClickMobileNavTitle, closeMobileNavList },
  } = useMainPageViewController();

  return (
    <S.OuterDiv>
      <Header to="/expert">
        {!isWideMobile && (
          <S.NavOuterDiv>
            {navList.map((navItem) => (
              <S.ItemNavLink
                key={navItem.path + "_" + navItem.name}
                to={navItem.path}
                end={navItem.path === "/expert"}
                className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
              >
                {navItem.name}
              </S.ItemNavLink>
            ))}
          </S.NavOuterDiv>
        )}
        {expertUser === null ? null : (
          <Profile
            job={expertUser.job}
            department={expertUser.department}
            belong={expertUser.belong}
            name={expertUser.name}
            imgSrc="https://mui.com/static/images/avatar/1.jpg"
          />
        )}
      </Header>
      {isWideMobile && currentNavItem && (
        <S.MobileNavOuterDiv>
          <S.MobileTitleDiv onClick={onClickMobileNavTitle} className={mobileNavOpen ? "open" : ""}>
            <S.MobileCurrentNavDiv>
              <currentNavItem.icon />
              {currentNavItem.name}
            </S.MobileCurrentNavDiv>
            <KeyboardArrowDownIcon />
          </S.MobileTitleDiv>
          <S.DrawableListDiv className={mobileNavOpen ? "open" : ""}>
            <S.MobileNavListDiv className={mobileNavOpen ? "open" : ""}>
              {navList.map((navItem) => (
                <S.MobileItemNavLink
                  end={navItem.path === "/expert"}
                  key={navItem.path + "_" + navItem.name}
                  to={navItem.path}
                  onClick={closeMobileNavList}
                  className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
                >
                  <navItem.icon />
                  {navItem.name}
                </S.MobileItemNavLink>
              ))}
            </S.MobileNavListDiv>
          </S.DrawableListDiv>
        </S.MobileNavOuterDiv>
      )}
      <S.MainDiv>
        <Outlet />
      </S.MainDiv>
      <Footer />
      {isLoading && <LoadingSpinner />}
    </S.OuterDiv>
  );
}
