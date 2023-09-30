import { EXPERT_LOGIN_ROUTE } from "../../../../../global/router.tsx";
import * as S from "./style.ts";
import WarningPage from "../../../warning/view.tsx";

function SocialLoginFailurePage() {
  return (
    <WarningPage
      iconPath=":("
      title="소셜 로그인 실패"
      subtitle="소셜 로그인에 문제가 발생했습니다. 다시 시도해주세요."
    >
      <S.BackLink to={EXPERT_LOGIN_ROUTE}>로그인 페이지로</S.BackLink>
    </WarningPage>
  );
}

export default SocialLoginFailurePage;