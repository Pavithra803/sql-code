import { api } from "./constants";
import axios from "axios";

export const Movement202 = async (data) => {
    const response = await axios.post(`${api}/Movement202/File`, data);
    return response;
};

export const Movement202ReUpload = async (data) => {
    const response = await axios.post(`${api}/Movement202/FileReupload`, data);
    return response;
};

export const getdetails=async (user)=>{
    const response = await axios.get(`${api}/Movement202/get_details?userid=${user}`);
    return response.data;
};
export const getAdd = async (data)=>{
    const response = await axios.post(`${api}/Movement202/Get_Add`, data);
    return response;
};
export const getPlants = async ()=>{

    const response = await axios.get(`${api}/Movement202/Get_Plants`);
    return response;
};
export const getView=async ()=>{
    const response = await axios.get(`${api}/Movement202/get_View`);
    return response.data;
};


export const get202ApprovalView = async (docId) => {
  const response = await axios.get(`${api}/Movement202/View202ApprovalStatus?Doc_ID=${docId}`);
  
  return response.data;
};


export const getresubmit = async (data) => {
  const response = await axios.post(`${api}/Movement202/HandleResubmitAction`, data);
  
  return response.data;
};


export const getCancel = async (data) => {
  const response = await axios.post(`${api}/Movement202/HandleCancelAction?Doc_ID`,data);
  
  return response.data;
};



export const DownloadAllExcel = async (DocID) => {
  if (!DocID) {
    throw new Error("DocID is required");
  }
  console.log('Calling API with docId:', DocID);
  const response = await axios.get(`${api}/Movement202/download_data?Doc_ID=${encodeURIComponent(DocID)}`);
  return response;
};

// ✅ FIXED: Update this path to match backend
export const getTransactionData = async (fromDate, toDate) => {
  const response = await axios.get(`${api}/Movement202/getTransactionData`, {
    params: {
      From: fromDate,
      to: toDate,
    }
  });
  return response;
};
