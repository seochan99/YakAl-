import { useCallback, useState } from "react";

export const useAdminMainViewController = () => {
  const [isExpert, setIsExpert] = useState<boolean>(true);

  const onClickExpertList = useCallback(() => {
    setIsExpert(true);
  }, [setIsExpert]);

  const onClickFacilityList = useCallback(() => {
    setIsExpert(false);
  }, [setIsExpert]);

  return { isExpert, onClickExpertList, onClickFacilityList };
};
