// API configuration
// When running in Docker, REACT_APP_API_URL should be set to http://backend:3000
// When running locally, it defaults to http://localhost:3000
const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:3000';

export const API_ENDPOINTS = {
  welcome: `${API_BASE_URL}/api/v1/welcome`,
  register: `${API_BASE_URL}/api/v1/auth/register`,
  login: `${API_BASE_URL}/api/v1/auth/login`,
  logout: `${API_BASE_URL}/api/v1/auth/logout`,
  currentUser: `${API_BASE_URL}/api/v1/auth/current_user`,
  profile: `${API_BASE_URL}/api/v1/profile`,
  workLocationsToday: `${API_BASE_URL}/api/v1/work_locations/today`,
  workLocations: `${API_BASE_URL}/api/v1/work_locations`,
  workLocationsHistory: `${API_BASE_URL}/api/v1/work_locations/history`,
};

export default API_BASE_URL;
