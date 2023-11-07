import { styled } from "styled-components";
import "/src/style/font.css";

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: row;
  align-items: start;
  gap: 1.25rem;
`;

export const ColumnDiv = styled.div`
  display: flex;
  flex-direction: column;
  gap: 2rem;
  width: 50%;
`;

export const CardDiv = styled.div`
  display: flex;
  flex-direction: column;
  align-items: stretch;
`;

export const HeaderDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: end;
  padding: 1.25rem;
  border-radius: 0.5rem 0.5rem 0 0;
  background: var(--Gray1, #f5f5f9);
`;

export const LeftTitleDiv = styled.div`
  display: flex;
  flex-direction: row;
  align-items: end;
  gap: 0.6rem;
`;

export const RightTitleDiv = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 1rem;
  min-width: 30%;
  justify-content: end;
`;

export const RiskLevelDiv = styled.div<{
  riskLevel: number;
}>`
  display: inline-flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 1.7rem;
  height: 1.7rem;
  border-radius: 1.7rem;
  color: var(--White, #fff);
  background-color: ${(params) =>
    params.riskLevel === 3
      ? "var(--Red, #fb5d5d)"
      : params.riskLevel === 2
      ? "var(--Yellow, #fb5d5d)"
      : params.riskLevel === 1
      ? "var(--Green)"
      : "var(--Gray1)"};
`;

export const TitleSpan = styled.span`
  color: var(--Black, #151515);
  font-family: SUIT, serif;
  font-size: 1.25rem;
  font-style: normal;
  font-weight: 700;
  line-height: 1.25rem;
`;

export const SubtitleSpan = styled.span`
  color: var(--Black, #151515);
  font-family: SUIT, serif;
  font-size: 1rem;
  font-style: normal;
  font-weight: 700;
  line-height: 1.25rem;
`;

export const ContentDiv = styled.div`
  display: flex;
  flex-direction: column;
  border-radius: 0 0 0.5rem 0.5rem;
  border: 2px solid var(--Gray2, #e9e9ee);
  background: var(--White, #fff);
  gap: 0.125rem;
`;

export const ListDiv = styled.div`
  display: flex;
  flex-direction: column;
  border: 0;
  gap: 0.125rem;
  flex: 1;
`;

export const MedicationSummaryContentDiv = styled(ContentDiv)`
  height: 18rem;
`;

export const MedicationETCContentDiv = styled(ContentDiv)`
  height: 22.5rem;
`;

export const MedicationGraphContentDiv = styled(ContentDiv)`
  height: 20rem;
`;

export const Bar = styled.hr`
  height: 0.125rem;
  margin: 0 1rem;
  border: 0;
  background: var(--Gray1, #f5f5f9);
`;

export const GraphDiv = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 2rem;
`;

export const RowDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  padding: 1rem 1.25rem;
  align-items: center;
  gap: 1rem;
`;

export const AnticholinergicRowDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  padding: 0.775rem 1.25rem;
  align-items: center;
  gap: 1rem;
`;

export const NormalSpan = styled.span`
  color: var(--Black, #151515);
  font-family: SUIT, serif;
  font-size: 1rem;
  font-style: normal;
  font-weight: 500;
  line-height: 1.25rem;
`;

export const PaginationDiv = styled.div`
  & {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    font-family: Pretendard, serif;
    font-weight: 500;
    margin: 1rem 0;
  }

  & .pagination {
    display: flex;
    flex-direction: row;
    gap: 0.4rem;
    margin: 0;
  }

  & ul {
    list-style: none;
    padding: 0;
  }

  & ul.pagination li {
    width: 2.2rem;
    height: 2.2rem;
    border-radius: 0.5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 0.0625rem solid var(--Gray3, #c6c6cf);
  }

  & ul.pagination li:hover {
    background-color: var(--Gray2, #e9e9ee);
    cursor: pointer;
  }

  & ul.pagination li:active {
    background-color: var(--Sub1, #5588fd);
  }

  & ul.pagination li.active {
    background-color: var(--Main, #2666f6);
  }

  & ul.pagination li a {
    text-decoration: none;
    color: var(--Black, #151515);
  }

  & ul.pagination li:hover a {
    color: var(--Black, #151515);
  }

  & ul.pagination li:active a {
    color: white;
  }

  & ul.pagination li.active a {
    color: white;
  }
`;

export const CenterDiv = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  flex: 1;
  color: var(--Gray4, #90909f);
  font-family: SUIT, serif;
  font-size: 1.25rem;
  font-style: normal;
  font-weight: 600;
  line-height: 1.25rem;
`;
