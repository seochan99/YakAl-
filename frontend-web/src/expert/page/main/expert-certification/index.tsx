import {
  AddressHeader,
  BackButton,
  BackIcon,
  BelongInput,
  BelongInputBox,
  BelongInputBoxWrapper,
  CertHeader,
  CertImgBox,
  CertImgPreview,
  CertInputImgBox,
  CertInputLabel,
  DoctorIcon,
  ImgBoxWrapper,
  InnerBox,
  Item,
  ItemAddress,
  ItemName,
  ListHeader,
  NameHeader,
  NextButton,
  Outer,
  PharmacistIcon,
  ProgressBar,
  ProgressBarWrapper,
  ProgressText,
  SearchBar,
  SearchButton,
  SearchInput,
  SearchResultBox,
  SelectButtonBox,
  SelectButtonWrapper,
  Subtitle,
  Title,
} from "@/expert/page/main/expert-certification/style.ts";
import { EJob } from "@/expert/type/job.ts";
import React, { useRef, useState } from "react";
import Pagination from "react-js-pagination";
import { ListFooter } from "@/expert/style.ts";

type TFacility = {
  id: number;
  name: string;
  address: string;
};

function ExpertCertification() {
  const [selected, setSelected] = useState<EJob | null>(null);
  const [certificationImg, setCertificationImg] = useState<File | null>(null);
  const [certImgFileName, setCertImgFileName] = useState<string>("첨부파일");
  const [belongImg, setBelongImg] = useState<File | null>(null);
  const [belongImgFileName, setBelongImgFileName] = useState<string>("첨부파일");
  const [page, setPage] = useState<number>(1);
  const [selectedFacility, setSelectedFacility] = useState<TFacility | null>(null);

  const certificationImgPreviewRef = useRef<HTMLImageElement>(null);
  const belongImgPreviewRef = useRef<HTMLImageElement>(null);

  const isFinished = selectedFacility !== null && certificationImg !== null && belongImg !== null;

  const facilityList: TFacility[] = [
    { id: 1, name: "분당 차병원A", address: "경기도 성남시 분당구 야탑로 59" },
    { id: 2, name: "분당 차병원B", address: "경기도 성남시 분당구 야탑로 59" },
    { id: 3, name: "분당 차병원D", address: "경기도 성남시 분당구 야탑로 59" },
    { id: 4, name: "분당 차병원C", address: "경기도 성남시 분당구 야탑로 59" },
    { id: 5, name: "분당 차병원E", address: "경기도 성남시 분당구 야탑로 59" },
    { id: 6, name: "분당 차병원F", address: "경기도 성남시 분당구 야탑로 59" },
    { id: 7, name: "분당 차병원G", address: "경기도 성남시 분당구 야탑로 59" },
  ];

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
    console.log("Submit!!");
  };

  return (
    <Outer>
      <CertHeader>
        <BackButton to="/expert">
          <BackIcon />
          대시 보드로
        </BackButton>
        <ProgressBarWrapper>
          <ProgressBar className={selected !== null ? "on" : "off"} />
          <ProgressBar className={selected !== null && isFinished ? "on" : "off"} />
          <ProgressText>{selected !== null ? (isFinished ? "2 / 2" : "1 / 2") : "0 / 2"}</ProgressText>
        </ProgressBarWrapper>
      </CertHeader>
      <InnerBox>
        <Title>전문가 인증 페이지입니다.</Title>
        <Subtitle>
          1. 전문가 인증을 완료해야 본 서비스를 이용하실 수 있습니다. 아래에서 본인에게 해당되는 직군을 선탹해주세요.
        </Subtitle>
        <SelectButtonWrapper>
          <SelectButtonBox
            className={selected === EJob.DOCTOR ? "selected" : "unselected"}
            onClick={() => setSelected(EJob.DOCTOR)}
          >
            <DoctorIcon />
            의사입니다.
          </SelectButtonBox>
          <SelectButtonBox
            className={selected === EJob.PHARMACIST ? "selected" : "unselected"}
            onClick={() => setSelected(EJob.PHARMACIST)}
          >
            <PharmacistIcon />
            약사입니다.
          </SelectButtonBox>
        </SelectButtonWrapper>
        {selected !== null && (
          <>
            <Subtitle>2. 전문가 인증에 필요한 정보를 입력해주세요.</Subtitle>
            <BelongInputBoxWrapper>
              <CertInputLabel>소속 기관*</CertInputLabel>
              <BelongInputBox>
                <BelongInput
                  type={"text"}
                  name={"facility-name"}
                  placeholder={"기관명"}
                  readOnly={true}
                  value={selectedFacility ? selectedFacility.name : ""}
                />
                <BelongInput
                  type={"text"}
                  name={"facility-address"}
                  placeholder={"기관 주소"}
                  readOnly={true}
                  value={selectedFacility ? selectedFacility.address : ""}
                />
              </BelongInputBox>
              <SearchBar>
                <SearchButton />
                <SearchInput type="text" placeholder="기관명으로 검색" />
              </SearchBar>
              <SearchResultBox>
                <ListHeader>
                  <NameHeader>기관명</NameHeader>
                  <AddressHeader>기관 주소</AddressHeader>
                </ListHeader>
                {facilityList.slice(5 * (page - 1), 5 * page).map((facility) => (
                  <Item key={facility.name} onClick={handleFacilityItemClick(facility.id)}>
                    <ItemName>
                      {facility.name.length > 21 ? facility.name.substring(0, 20).concat("...") : facility.name}
                    </ItemName>
                    <ItemAddress>
                      {facility.address.length > 41
                        ? facility.address.substring(0, 40).concat("...")
                        : facility.address}
                    </ItemAddress>
                  </Item>
                ))}
              </SearchResultBox>
              <ListFooter>
                <Pagination
                  activePage={page}
                  itemsCountPerPage={5}
                  totalItemsCount={facilityList.length}
                  pageRangeDisplayed={5}
                  prevPageText={"‹"}
                  nextPageText={"›"}
                  onChange={handlePageChange}
                />
              </ListFooter>
            </BelongInputBoxWrapper>
            <ImgBoxWrapper>
              <CertImgBox>
                <CertInputLabel>자격증 사진*</CertInputLabel>
                <CertInputImgBox>
                  <input readOnly={true} type="text" value={certImgFileName} placeholder="첨부파일" />
                  <label htmlFor="cert">파일찾기</label>
                  <input
                    type="file"
                    accept="image/jpg,impge/png,image/jpeg,image/gif"
                    id="cert"
                    name="cerification_img"
                    onChange={handleCertImgChange}
                  />
                </CertInputImgBox>
                <CertImgPreview ref={certificationImgPreviewRef} />
              </CertImgBox>
              <CertImgBox>
                <CertInputLabel>소속 증명 사진*</CertInputLabel>
                <CertInputImgBox>
                  <input readOnly={true} type="text" value={belongImgFileName} placeholder="첨부파일" />
                  <label htmlFor="belong">파일찾기</label>
                  <input
                    type="file"
                    accept="image/jpg,impge/png,image/jpeg,image/gif"
                    id="belong"
                    name="belong_img"
                    onChange={handleBelongImgChange}
                  />
                </CertInputImgBox>
                <CertImgPreview ref={belongImgPreviewRef} />
              </CertImgBox>
            </ImgBoxWrapper>
          </>
        )}
      </InnerBox>
      <NextButton
        className={selected !== null && isFinished ? "is-finished" : ""}
        disabled={!(selected !== null && isFinished)}
        onClick={handleSubmit}
      >
        다음
      </NextButton>
    </Outer>
  );
}

export default ExpertCertification;