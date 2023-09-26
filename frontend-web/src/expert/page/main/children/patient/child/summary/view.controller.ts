import { PatientPageViewModel } from "../../view.model.ts";
import { useEffect } from "react";
import { useLocation } from "react-router-dom";

export const useSummaryViewController = () => {
  const { patientInfo } = PatientPageViewModel.getStates();

  const location = useLocation();
  const lastSlashIndex = location.pathname.lastIndexOf("/");
  const patientId = +location.pathname.substring(lastSlashIndex + 1);

  useEffect(() => {
    PatientPageViewModel.fetchLastETC(patientId);
    PatientPageViewModel.fetchGeriatricSyndrome(patientId);
    PatientPageViewModel.fetchScreening(patientId);
  }, [patientId]);

  return {
    medication: patientInfo.medication,
    geriatricSyndrome: patientInfo.geriatricSyndrome,
    screeningDetail: patientInfo.screeningDetail,
  };
};
