import WarningPage from "../../../warning/view.tsx";
import { BackButton } from "./style.ts";

function RegistrationFailure() {
  return (
    <WarningPage iconPath={":("} title={"기관 등록 신청에 실패하였습니다."}>
      <BackButton to={"/expert"}>메인으로</BackButton>
    </WarningPage>
  );
}

export default RegistrationFailure;
