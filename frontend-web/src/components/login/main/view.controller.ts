import { useCallback, useState } from "react";
import { useNavigate } from "react-router-dom";
import { getKakaoRedirectUrl } from "@api/noauth/auth/api.ts";
import { HttpStatusCode, isAxiosError } from "axios";
import { logOnDev } from "@util/log-on-dev.ts";

export const useLoginMainPageViewController = () => {
  const [open, setOpen] = useState<boolean>(false);

  const navigate = useNavigate();

  const onKakaoLoginClick = useCallback(async () => {
    try {
      const response = await getKakaoRedirectUrl();

      if (response.status === HttpStatusCode.Ok) {
        window.location.href = response.data.data.url;
      } else {
        logOnDev(
          `🤔 [Invalid Http Response Code] Code ${response.status} Is Received But ${HttpStatusCode.Ok} Is Expected.`,
        );
        setOpen(true);
      }
    } catch (error) {
      if (isAxiosError(error)) {
        setOpen(true);
      }
    }
  }, [setOpen]);

  const onGoogleLoginClick = useCallback(async () => {
    navigate("/expert");
    // try {
    //   const response = await getGoogleRedirectUrl();
    //
    //   if (response.status === HttpStatusCode.Ok) {
    //     setOpen(false);
    //     window.location.href = response.data.data.url;
    //   }
    // } catch (error) {
    //   if (isAxiosError(error)) {
    //     setOpen(true);
    //   }
    // }
  }, [setOpen]);

  return {
    onKakaoLoginClick,
    onGoogleLoginClick,
    snackbarController: { open, setOpen },
  };
};
