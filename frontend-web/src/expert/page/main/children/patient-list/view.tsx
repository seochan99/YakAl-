import * as S from "./style.ts";
import { usePatientListPageViewController } from "./view.controller.ts";
import { EPatientField } from "../../../../type/patient-field.ts";
import Pagination from "react-js-pagination";

import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import PatientItem from "./child/patient-item/view.tsx";
import { PatientListModel } from "./model.ts";

function PatientListPage() {
  const {
    selectListRef,
    onChangePage,
    managed: {
      isOnlyManaged,
      onSelectMangedList,
      onSelectEntireList,
      onClickToManageFactory,
      onClickToNotManageFactory,
    },
    searching: { nameQueryCache, setNameQueryCache, onSearchBarEnter },
    sorting: { onSelectSortingOption, sortingOptionOpen, setSortingOptionOpen },
    data: { isLoading, patientList, paging, sorting },
  } = usePatientListPageViewController();

  if (isLoading || patientList === null) {
    return <></>;
  }

  return (
    <S.OuterDiv>
      <S.TabBarDiv>
        <S.TabDiv className={isOnlyManaged ? "selected" : "unselected"} onClick={onSelectMangedList}>
          <S.TabTitleSpan>관리 환자 리스트</S.TabTitleSpan>
          <S.TabSubtitleSpan>Managed Patient List</S.TabSubtitleSpan>
        </S.TabDiv>
        <S.TabDiv className={isOnlyManaged ? "unselected" : "selected"} onClick={onSelectEntireList}>
          <S.TabTitleSpan>전체 환자 리스트</S.TabTitleSpan>
          <S.TabSubtitleSpan>Entire Patient List</S.TabSubtitleSpan>
        </S.TabDiv>
      </S.TabBarDiv>
      <S.InnerDiv>
        <S.OptionBarDiv>
          <S.SearchBarDiv>
            <S.StyledSearchIconSvg />
            <S.SearchInput
              type="text"
              placeholder="환자 이름으로 검색"
              value={nameQueryCache}
              onChange={(e) => setNameQueryCache(e.target.value)}
              onKeyUp={onSearchBarEnter}
            />
          </S.SearchBarDiv>
          <S.SelectDiv data-role="selectbox">
            <S.SelectButton
              className={sortingOptionOpen ? "open" : ""}
              onClick={() => setSortingOptionOpen(!sortingOptionOpen)}
            >
              <ArrowDropDownIcon />
              <span>{sorting.field}</span>
            </S.SelectButton>
            {sortingOptionOpen && (
              <S.SelectList ref={selectListRef}>
                {Object.keys(EPatientField).map((patientFilter) => {
                  const value = EPatientField[patientFilter as keyof typeof EPatientField];
                  return (
                    <S.SelectItem key={patientFilter}>
                      <S.SelectItemButton value={value} onClick={onSelectSortingOption}>
                        {value}
                      </S.SelectItemButton>
                    </S.SelectItem>
                  );
                })}
              </S.SelectList>
            )}
          </S.SelectDiv>
        </S.OptionBarDiv>
        <S.ListDiv>
          <S.TableHeaderDiv>
            <S.NameSpan>{`이름`}</S.NameSpan>
            <S.SexBirthdaySpan>{`(성별, 나이)`}</S.SexBirthdaySpan>
            <S.TelephoneSpan>{`전화번호`}</S.TelephoneSpan>
            <S.LastQuestionnaireDateSpan>{`최근 설문일`}</S.LastQuestionnaireDateSpan>
          </S.TableHeaderDiv>
          {patientList.map((patientItem) => (
            <PatientItem
              key={patientItem.id}
              patientInfo={patientItem}
              onClickToManage={onClickToManageFactory(patientItem.id)}
              onClickToNotManage={onClickToNotManageFactory(patientItem.id)}
            />
          ))}
        </S.ListDiv>
        <S.PaginationDiv>
          <Pagination
            activePage={paging.pageNumber}
            itemsCountPerPage={PatientListModel.PATIENT_COUNT_PER_PAGE}
            totalItemsCount={paging.totalCount as number}
            pageRangeDisplayed={5}
            prevPageText={"‹"}
            nextPageText={"›"}
            onChange={onChangePage}
          />
        </S.PaginationDiv>
      </S.InnerDiv>
    </S.OuterDiv>
  );
}

export default PatientListPage;
