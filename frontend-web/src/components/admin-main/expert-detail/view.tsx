import { useAdminExpertDetailViewController } from "@components/admin-main/expert-detail/view.controller.ts";
import * as S from "./style.ts";
import { getDateStringFromArray } from "@util/get-date-string-from-array.ts";
import ApprovalDialog from "@components/admin-main/approval-dialog/view.tsx";
import { EJob } from "@type/enum/job.ts";
import { EFacilityType } from "@type/enum/facility-type.ts";
import { formatTel } from "@util/format-tel.ts";

function AdminExpertDetail() {
  const {
    expertDetail,
    isLoading,
    openApprovalDialog,
    approvalDialogOpen,
    onCloseApprovalDialog,
    onClickOkayOnApprovalDialog,
    openRejectionDialog,
    rejectionDialogOpen,
    onCloseRejectionDialog,
    onClickOkayOnRejectionDialog,
    rejectionReason,
    onChangeRejectionReason,
  } = useAdminExpertDetailViewController();

  if (isLoading || expertDetail == null) {
    return (
      <S.OuterDiv>
        <S.HeaderDiv>
          <S.BackLink to="/admin">
            <S.StyledLinkIconSvg />
            목록으로
          </S.BackLink>
        </S.HeaderDiv>
        <S.InnerDiv></S.InnerDiv>
      </S.OuterDiv>
    );
  }

  const {
    belongInfo: {
      type: facilityType,
      chiefName,
      chiefTel,
      facilityName,
      facilityNumber,
      zipCode,
      address,
      businessRegiNumber,
      tel: facilityTel,
      clinicHours,
      features,
    },
    name,
    tel: expertTel,
    requestedAt,
    type: jobType,
    certificateImg,
    affiliationImg,
  } = expertDetail;

  return (
    <S.OuterDiv>
      <S.HeaderDiv>
        <S.BackLink to="/admin">
          <S.StyledLinkIconSvg />
          목록으로
        </S.BackLink>
      </S.HeaderDiv>
      <S.InnerDiv>
        <S.HeaderSpan>{"전문가 정보"}</S.HeaderSpan>
        <S.OneItemSpan>
          <S.NameSpan>{"성함"}</S.NameSpan>
          <S.NormalSpan>{name}</S.NormalSpan>
        </S.OneItemSpan>
        <S.OneItemSpan>
          <S.NameSpan>{"연락처"}</S.NameSpan>
          <S.NormalSpan>{formatTel(expertTel)}</S.NormalSpan>
        </S.OneItemSpan>
        <S.OneItemSpan>
          <S.NameSpan>{"직종"}</S.NameSpan>
          <S.NormalSpan>{jobType === EJob.DOCTOR ? "의사" : "약사"}</S.NormalSpan>
        </S.OneItemSpan>
        <S.Bar />
        <S.HeaderSpan>{"소속 기관 정보"}</S.HeaderSpan>
        <S.BelongInfoDiv>
          <S.BelongInnerDiv>
            <S.OneItemSpan>
              <S.NameSpan>{"기관명"}</S.NameSpan>
              <S.NormalSpan>{facilityName}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"요양기관 번호"}</S.NameSpan>
              <S.NormalSpan>{facilityNumber}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 종류"}</S.NameSpan>
              <S.NormalSpan>{facilityType === EFacilityType.HOSPITAL ? "병원" : "약국"}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관장 성함"}</S.NameSpan>
              <S.NormalSpan>{chiefName}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관장 연락처"}</S.NameSpan>
              <S.NormalSpan>{formatTel(chiefTel)}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 우편번호"}</S.NameSpan>
              <S.NormalSpan>{zipCode}</S.NormalSpan>
            </S.OneItemSpan>
          </S.BelongInnerDiv>
          <S.BelongInnerDiv>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 주소"}</S.NameSpan>
              <S.NormalSpan>{address}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"사업자등록번호"}</S.NameSpan>
              <S.NormalSpan>{businessRegiNumber}</S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 연락처"}</S.NameSpan>
              <S.NormalSpan>
                {facilityTel === null || facilityTel === "" ? "기관 연락처 정보가 없습니다." : formatTel(facilityTel)}
              </S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"운영 시간"}</S.NameSpan>
              <S.NormalSpan>
                {clinicHours === null || clinicHours === "" ? "운영 시간 정보가 없습니다." : clinicHours}
              </S.NormalSpan>
            </S.OneItemSpan>
            <S.OneItemSpan>
              <S.NameSpan>{"기관 특징"}</S.NameSpan>
              <S.NormalSpan>
                {features === null || features === "" ? "기관 특징 정보가 없습니다." : features}
              </S.NormalSpan>
            </S.OneItemSpan>
          </S.BelongInnerDiv>
        </S.BelongInfoDiv>
        <S.Bar />
        <S.HeaderSpan>{"전문가 인증 정보"}</S.HeaderSpan>
        <S.ImgDiv>
          <S.InnerImgDiv>
            <S.NameSpan>{"면허증 사진"}</S.NameSpan>
            <S.InnerImg
              alt={"certificateImg"}
              src={`${import.meta.env.VITE_SERVER_HOST_WITHOUT_API}/images/${certificateImg}`}
            />
          </S.InnerImgDiv>
          <S.InnerImgDiv>
            <S.NameSpan>{"소속 증명 사진"}</S.NameSpan>
            <S.InnerImg
              alt={"affiliationImg"}
              src={`${import.meta.env.VITE_SERVER_HOST_WITHOUT_API}/images/${affiliationImg}`}
            />
          </S.InnerImgDiv>
        </S.ImgDiv>
        <S.OneItemSpan>
          <S.NameSpan>{"신청일"}</S.NameSpan>
          <S.NormalSpan>{getDateStringFromArray(requestedAt)}</S.NormalSpan>
        </S.OneItemSpan>
      </S.InnerDiv>
      <S.BottomButtonDiv>
        <S.RejectionButton onClick={openRejectionDialog}>거절</S.RejectionButton>
        <S.ApprovalButton onClick={openApprovalDialog}>승인</S.ApprovalButton>
      </S.BottomButtonDiv>
      <ApprovalDialog
        title={"정말 본 사용자를 전문가로 승인하시겠습니까?"}
        isOpen={approvalDialogOpen}
        onClose={onCloseApprovalDialog}
        onClickOkay={onClickOkayOnApprovalDialog}
        hasDepartment={true}
        department={rejectionReason}
        onChangeDepartment={onChangeRejectionReason}
      />
      <ApprovalDialog
        title={"정말 본 사용자의 승인 요청을 거절하시겠습니까?"}
        isOpen={rejectionDialogOpen}
        onClose={onCloseRejectionDialog}
        onClickOkay={onClickOkayOnRejectionDialog}
        hasDepartment={false}
      />
    </S.OuterDiv>
  );
}

export default AdminExpertDetail;
