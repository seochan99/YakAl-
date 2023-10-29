import { NavLink } from "react-router-dom";
import { styled } from "styled-components";

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: column;
  align-items: stretch;
  justify-content: start;
  width: 100vw;
`;

export const MainDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: start;
  flex: 1;
  background-color: var(--Gray1, #f5f5f9);
`;

export const NavOuterDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  gap: 1rem;
`;

export const ItemNavLink = styled(NavLink)`
  & {
    color: #151515;
    font-size: 1.1rem;
    font-weight: 600;
    line-height: 1.1rem;
    width: 6rem;
    padding: 0.5rem 0;
    border-radius: 0.25rem;
    text-decoration: none;
    text-align: center;
  }

  &:hover {
    color: #2666f6;
    background-color: #f5f5f9;
    transition: color 0.2s;
  }

  &.active {
    background-color: var(--color-surface-900);
  }
`;

export const MobileNavOuterDiv = styled.div`
  display: flex;
  flex-direction: column;
`;

export const MobileTitleDiv = styled.div`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 2rem;
    font-size: 1.2rem;
    line-height: 1.2rem;
    font-weight: 700;
    color: #151515;
    border-top: 0.0625rem solid var(--Gray2, #e9e9ee);
    border-bottom: 0.0625rem solid var(--Gray2, #e9e9ee);
    background-color: #fff;
  }

  &:hover {
    cursor: pointer;
  }

  & > svg {
    opacity: 0.5;
    transform: rotate(0deg);
    transition: 0.2s;
  }

  &.open > svg {
    opacity: 1;
    transform: rotate(180deg);
  }
`;

export const DrawableListDiv = styled.div`
  & {
    overflow: hidden;
    background-color: transparent;
    height: 0;
    transition: all 0.3s ease-out;
  }

  &.open {
    height: 9.5rem;
  }
`;

export const MobileNavListDiv = styled.div`
  & {
    display: flex;
    flex-direction: column;
    gap: 0.4rem;
    padding: 0.4rem 1rem;
    visibility: hidden;
    transform: translateY(-100%);
    transition: all 0.3s ease-out;
    background-color: #fff;
  }

  &.open {
    visibility: visible;
    transform: translateY(0%);
    transition: all 0.3s ease-out;
  }
`;

export const MobileCurrentNavDiv = styled.div`
  & {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
  }

  & svg {
    margin-right: 0.6rem;
    height: 1.2rem;
  }
`;

export const MobileItemNavLink = styled(NavLink)`
  & {
    display: flex;
    flex-direction: row;
    align-items: center;
    padding: 0.8rem 1rem;
    font-size: 1.1rem;
    line-height: 1.1rem;
    font-weight: 500;
    color: #151515;
    text-decoration: none;
    border-radius: 0.25rem;
  }

  & svg {
    height: 1.1rem;
    margin-right: 0.6rem;
  }

  &:hover {
    cursor: pointer;
    color: #2666f6;
    background-color: #f5f5f9;
    transition: color 0.2s;
  }

  &.active {
    background-color: var(--Gray2, #e9e9ee);
  }
`;