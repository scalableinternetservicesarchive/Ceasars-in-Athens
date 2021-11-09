import axios from 'axios';

export default axios.create({
    baseURL: process.env.REACT_APP_BASE_URL
});

export const axiosConfig = (jwt) => {
    const header = {
        headers: {
            'Authorization': jwt || localStorage.getItem("jwt")
        }
    };
    return header;
};