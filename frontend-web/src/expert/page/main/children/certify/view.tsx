import { ListFooter } from "../../../../style.ts";
import * as S from "./style.ts";
import React, { useRef, useState } from "react";
import Pagination from "react-js-pagination";
import { EJob } from "../../../../type/job.ts";
import { useNavigate } from "react-router-dom";
import { facilityList } from "../../../../store/facility-list.ts";
import { TFacility } from "../../../../../admin/page/main/facility-registration-list";

const PAGING_SIZE = 5;

function CertifyPage() {
  const [selected, setSelected] = useState<EJob | null>(null);
  const [certificationImg, setCertificationImg] = useState<File | null>(null);
  const [certImgFileName, setCertImgFileName] = useState<string>("첨부파일");
  const [belongImg, setBelongImg] = useState<File | null>(null);
  const [belongImgFileName, setBelongImgFileName] = useState<string>("첨부파일");
  const [page, setPage] = useState<number>(1);
  const [selectedFacility, setSelectedFacility] = useState<TFacility | null>(null);
  const [facilityNameSearchQuery, setFacilityNameSearchQuery] = useState<string>("");

  const navigate = useNavigate();

  const certificationImgPreviewRef = useRef<HTMLImageElement>(null);
  const belongImgPreviewRef = useRef<HTMLImageElement>(null);

  const isFinished = selectedFacility !== null && certificationImg !== null && belongImg !== null;

  const handlePageChange = (page: number) => {
    setPage(page);
  };

  const handleCertImgChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const fileList = e.target.files;

    if (fileList && fileList[0]) {
      setCertificationImg(fileList[0]);

      const reader = new FileReader();
      reader.onload = (e: ProgressEvent<FileReader>) => {
        if (!certificationImgPreviewRef.current) {
          return;
        }

        certificationImgPreviewRef.current.src = e.target?.result as string;
        setCertImgFileName(fileList[0].name);
      };

      reader.readAsDataURL(fileList[0]);
    } else {
      if (!certificationImgPreviewRef.current) {
        return;
      }

      certificationImgPreviewRef.current.src = "";
      setCertImgFileName("첨부파일");
    }
  };

  const handleBelongImgChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const fileList = e.target.files;

    if (fileList && fileList[0]) {
      setBelongImg(fileList[0]);

      const reader = new FileReader();
      reader.onload = (e: ProgressEvent<FileReader>) => {
        if (!belongImgPreviewRef.current) {
          return;
        }

        belongImgPreviewRef.current.src = e.target?.result as string;
        setBelongImgFileName(fileList[0].name);
      };

      reader.readAsDataURL(fileList[0]);
    } else {
      if (!belongImgPreviewRef.current) {
        return;
      }

      belongImgPreviewRef.current.src = "";
      setBelongImgFileName("첨부파일");
    }
  };

  const handleFacilityItemClick = (id: number) => () => {
    const selectedItem = facilityList.findLast((facility) => facility.id === id);

    if (selectedItem) {
      setSelectedFacility(selectedItem);
    }
  };

  const handleSubmit = () => {
    navigate("/expert/certification/success");
  };

  return (
    <S.Outer>
      <S.CertHeader>
        <S.BackButton to="/expert">
          <S.BackIcon />
          대시 보드로
        </S.BackButton>
        <S.ProgressBarWrapper>
          <S.ProgressBar className={selected !== null ? "on" : "off"} />
          <S.ProgressBar className={selected !== null && isFinished ? "on" : "off"} />
          <S.ProgressText>{selected !== null ? (isFinished ? "2 / 2" : "1 / 2") : "0 / 2"}</S.ProgressText>
        </S.ProgressBarWrapper>
      </S.CertHeader>
      <S.InnerBox>
        <S.Title>전문가 인증 페이지입니다.</S.Title>
        <S.Subtitle>
          1. 전문가 인증을 완료해야 본 서비스를 이용하실 수 있습니다. 아래에서 본인에게 해당되는 직군을 선탹해주세요.
        </S.Subtitle>
        <S.SelectButtonWrapper>
          <S.SelectButtonBox
            className={selected === EJob.DOCTOR ? "selected" : "unselected"}
            onClick={() => {
              setSelected(EJob.DOCTOR);
              setSelectedFacility(null);
            }}
          >
            <S.DoctorIcon />
            의사입니다.
          </S.SelectButtonBox>
          <S.SelectButtonBox
            className={selected === EJob.PHARMACIST ? "selected" : "unselected"}
            onClick={() => {
              setSelected(EJob.PHARMACIST);
              setSelectedFacility(null);
            }}
          >
            <S.PharmacistIcon />
            약사입니다.
          </S.SelectButtonBox>
        </S.SelectButtonWrapper>
        {selected !== null && (
          <>
            <S.Subtitle>2. 전문가 인증에 필요한 정보를 입력해주세요.</S.Subtitle>
            <S.BelongInputBoxWrapper>
              <S.CertInputLabel>소속 기관*</S.CertInputLabel>
              <S.BelongInputBox>
                <S.BelongInput
                  type={"text"}
                  name={"facility-name"}
                  placeholder={"기관명"}
                  readOnly={true}
                  value={selectedFacility ? selectedFacility.name : ""}
                />
                <S.BelongInput
                  type={"text"}
                  name={"facility-address"}
                  placeholder={"기관 주소"}
                  readOnly={true}
                  value={selectedFacility ? selectedFacility.directorName : ""}
                />
              </S.BelongInputBox>
              <S.SearchBar>
                <S.SearchButton />
                <S.SearchInput
                  type="text"
                  placeholder="기관명으로 검색"
                  value={facilityNameSearchQuery}
                  onChange={(e) => setFacilityNameSearchQuery(e.target.value)}
                />
              </S.SearchBar>
              <S.SearchResultBox>
                <S.ListHeader>
                  <S.NameHeader>기관명</S.NameHeader>
                  <S.AddressHeader>기관 주소</S.AddressHeader>
                </S.ListHeader>
                {facilityList.map((facility) => (
                  <S.Item key={facility.name} onClick={handleFacilityItemClick(facility.id)}>
                    <S.ItemName>
                      {facility.name.length > 21 ? facility.name.substring(0, 20).concat("...") : facility.name}
                    </S.ItemName>
                    <S.ItemAddress>
                      {facility.directorName.length > 41
                        ? facility.directorName.substring(0, 40).concat("...")
                        : facility.directorName}
                    </S.ItemAddress>
                  </S.Item>
                ))}
              </S.SearchResultBox>
              <ListFooter>
                <Pagination
                  activePage={page}
                  itemsCountPerPage={PAGING_SIZE}
                  totalItemsCount={facilityList.length}
                  pageRangeDisplayed={PAGING_SIZE}
                  prevPageText={"‹"}
                  nextPageText={"›"}
                  onChange={handlePageChange}
                />
              </ListFooter>
            </S.BelongInputBoxWrapper>
            <S.CertImgBox>
              <S.CertInputLabel>자격증 사진*</S.CertInputLabel>
              <S.CertInputImgBox>
                <input readOnly={true} type="text" value={certImgFileName} placeholder="첨부파일" />
                <label htmlFor="cert">파일찾기</label>
                <input
                  type="file"
                  accept="image/jpg,impge/png,image/jpeg,image/gif"
                  id="cert"
                  name="cerification_img"
                  onChange={handleCertImgChange}
                />
              </S.CertInputImgBox>
              <S.CertImgPreviewBox>
                <S.CertExampleBox>
                  {selected === EJob.DOCTOR ? <S.CertDoctorImgExample /> : <S.CertPharmacistEmgExample />}
                  <S.CertExampleText>
                    {selected === EJob.DOCTOR
                      ? "* 전문의 자격증을 성명과 주민등록번호가 잘 드러나도록 찍어서 제출해주세요."
                      : "* 약사 면허증을 성명, 생년월일이 잘 드러나도록 찍어서 제출해주세요."}
                  </S.CertExampleText>
                </S.CertExampleBox>
                <S.CertImgPreviewWrapper>
                  <S.CertImgPreview ref={certificationImgPreviewRef} />
                </S.CertImgPreviewWrapper>
              </S.CertImgPreviewBox>
            </S.CertImgBox>
            <S.CertImgBox>
              <S.CertInputLabel>{"소속 증명 사진*"}</S.CertInputLabel>
              <S.CertBelongExplanation>
                {"소속 증명 사진이라 함은 소속 기관이 기재되어 있는 명함 등 "}
                <S.Emphasis>{"해당 기관에 재직 중임을 확인할 수 있는 사진"}</S.Emphasis>
                {
                  "입니다. (예: 대학병원라면 내과 000 전문의 이름 적혀있는 사진, 개인병원이라면 해당 병원에 있는 의사 팻말 등)"
                }
              </S.CertBelongExplanation>
              <S.CertInputImgBox>
                <input readOnly={true} type="text" value={belongImgFileName} placeholder="첨부파일" />
                <label htmlFor="belong">파일찾기</label>
                <input
                  type="file"
                  accept="image/jpg,impge/png,image/jpeg,image/gif"
                  id="belong"
                  name="belong_img"
                  onChange={handleBelongImgChange}
                />
              </S.CertInputImgBox>
              <S.CertBelongImgPreview ref={belongImgPreviewRef} />
            </S.CertImgBox>
          </>
        )}
      </S.InnerBox>
      <S.NextButton
        className={selected !== null && isFinished ? "is-finished" : ""}
        disabled={!(selected !== null && isFinished)}
        onClick={handleSubmit}
      >
        다음
      </S.NextButton>
    </S.Outer>
  );
}

export default CertifyPage;