import { css, styled } from "styled-components";
import { Dialog } from "@mui/material";

export const StyledDialog = styled(Dialog)`
  & .MuiPaper-root {
    padding: 2rem;
    gap: 2rem;
  }

  & .MuiTypography-root {
    color: var(--Black, #151515);
    font-family: SUIT, serif;
    font-size: 1.25rem;
    font-style: normal;
    font-weight: 600;
    line-height: 1.25rem;
    padding: 0;
  }

  & .MuiDialogActions-root {
    padding: 0;
    gap: 1rem;
  }
`;

const BottomButtonCss = css`
  & {
    display: inline-flex;
    padding: 1rem 1.6rem;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
    border-radius: 0.5rem;
    border: 0;
    color: var(--White, #fff);
    font-family: Pretendard, serif;
    font-size: 1.1rem;
    font-weight: 600;
    line-height: 1.1rem;
    text-decoration: none;

    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
  }

  &:hover {
    cursor: pointer;
  }
`;

export const DepartmentInput = styled.input`
  & {
    border-radius: 8px;
    border: 2px solid;
    border-color: var(--Gray2, #e9e9ee);
    color: var(--Black, #151515);
    font-family: Pretendard, serif;
    font-size: 1.1rem;
    font-style: normal;
    font-weight: 500;
    line-height: 2rem;
    outline: none;
    padding: 0.6rem 1rem;
  }

  &::placeholder {
    color: var(--Gray3, #c6c6cf);
    font-family: Pretendard, serif;
    font-size: 1rem;
    font-style: normal;
    font-weight: 500;
    line-height: 2rem;
  }

  &:focus {
    border-color: var(--Sub1, #5588fd);
  }
`;

export const OkayButton = styled.button`
  ${BottomButtonCss}
  & {
    background-color: var(--Main, #2666f6);
  }

  &:hover {
    background-color: var(--Sub1, #5588fd);
  }
`;

export const CancelButton = styled.button`
  ${BottomButtonCss}
  & {
    background-color: var(--Red, #fb5d5d);
  }

  &:hover {
    opacity: 0.8;
  }
`;
