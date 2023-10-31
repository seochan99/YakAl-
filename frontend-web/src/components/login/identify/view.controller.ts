import { useCallback, useState } from "react";
import { logOnDev } from "../../../util/log-on-dev.ts";
import { useNavigate } from "react-router-dom";
import { identify } from "../../../api/auth/user/api.ts";
import { HttpStatusCode } from "axios";
import { authAxios } from "@api/auth/instance.ts";

type TIdResponse = {
  error_code: string | null;
  error_msg: string | null;
  imp_uid: string;
  merchant_uid: string;
  pg_provider: string;
  pg_type: string;
  success: boolean;
};

export const useIdentifyPageViewController = () => {
  const naviagte = useNavigate();

  const [identifyStart, setIdentifyStart] = useState<boolean>(false);

  const onIdentificationClick = useCallback(() => {
    setIdentifyStart(true);

    // const cookies = new Cookies();
    //
    // if (!cookies.get("accessToken") || cookies.get("accessToken") === "") {
    //   naviagte("/login/social/not-yet");
    //   return;
    // }
    //
    // cookies.remove("accessToken", { path: "/" });

    const IMP = window.IMP;
    IMP.init(`${import.meta.env.VITE_MERCHANDISE_ID}`);

    /* Pop Up Integrated Identification Window */
    IMP.certification(
      {
        pg: "inicis_unified",
        merchant_uid: `mid_${Date.now().toString()}`,
        popup: true,
      },
      async (response: TIdResponse) => {
        logOnDev(`🛬 [Identification Response] ${response}`);

        if (response.success) {
          logOnDev(`🎉 [Identification Success]`);

          authAxios.defaults.headers.common[
            "Authorization"
          ] = `Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1aWQiOiI0Iiwicm9sIjoiUk9MRV9NT0JJTEUiLCJpYXQiOjE2OTg3Nzk5MTEsImV4cCI6MTY5ODc4MzUxMX0.GeEVkgMUzkdTwnEGkvsGygskpC-dz1O0ySmshezwbmVOqSog_zW0IKCwoRmwkTnKqADOEBLHi-Xtvapd3CDWmA`;

          const sendIdentifyResponse = await identify(response.imp_uid);

          if (sendIdentifyResponse.status === HttpStatusCode.Ok) {
            naviagte("/login/identify/result", { state: { isSuccess: true } });
            return;
          } else {
            naviagte("/login/identify/result", { state: { isSuccess: false } });
            return;
          }
        } else {
          logOnDev(`🚨 [Identification Failure] ${response.error_code} | ${response.error_msg}`);

          /* Identification Failure Logic */
          naviagte("/login/identify/result", { state: { isSuccess: false } });
          return;
        }
      },
    );
  }, [setIdentifyStart, naviagte]);

  return { identifyStart, onIdentificationClick };
};
