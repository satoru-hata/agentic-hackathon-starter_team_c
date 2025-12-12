import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

interface ApiResponse {
  message: string;
  timestamp: string;
}

const Welcome: React.FC = () => {
  const navigate = useNavigate();
  const [apiData, setApiData] = useState<ApiResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchWelcomeData = async () => {
      try {
        const response = await fetch('http://localhost:3000/api/v1/welcome');
        if (!response.ok) {
          throw new Error('Failed to fetch data');
        }
        const data = await response.json();
        setApiData(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setLoading(false);
      }
    };

    fetchWelcomeData();
  }, []);

  return (
    <div className="min-h-screen bg-gradient-to-r from-blue-500 to-purple-600 flex items-center justify-center">
      <div className="bg-white rounded-lg shadow-xl p-8 max-w-md w-full">
        <h1 className="text-3xl font-bold text-gray-800 text-center mb-6">
          Welcome Page
        </h1>
        
        {loading && (
          <div className="text-center">
            <div className="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-gray-900"></div>
            <p className="mt-2 text-gray-600">Loading...</p>
          </div>
        )}

        {error && (
          <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
            <p className="font-bold">Error:</p>
            <p>{error}</p>
            <p className="text-sm mt-2">Make sure the Rails API is running on port 3000</p>
          </div>
        )}

        {apiData && !loading && !error && (
          <div className="bg-green-50 border border-green-200 rounded p-4">
            <h2 className="text-xl font-semibold text-green-800 mb-2">
              API Response
            </h2>
            <p className="text-gray-700">
              <span className="font-semibold">Message:</span> {apiData.message}
            </p>
            <p className="text-gray-700 mt-2">
              <span className="font-semibold">Timestamp:</span> {new Date(apiData.timestamp).toLocaleString()}
            </p>
          </div>
        )}

        <div className="mt-6 text-center space-y-3">
          <div>
            <button 
              onClick={() => window.location.reload()}
              className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded transition duration-200 mr-2"
            >
              Refresh
            </button>
          </div>
          <div className="space-x-2">
            <button 
              onClick={() => navigate('/login')}
              className="bg-gradient-to-r from-indigo-500 to-purple-600 hover:from-indigo-600 hover:to-purple-700 text-white font-bold py-2 px-4 rounded transition duration-200"
            >
              ログイン
            </button>
            <button 
              onClick={() => navigate('/register')}
              className="bg-gradient-to-r from-purple-500 to-pink-600 hover:from-purple-600 hover:to-pink-700 text-white font-bold py-2 px-4 rounded transition duration-200"
            >
              新規登録
            </button>
          </div>
          <div>
            <button 
              onClick={() => navigate('/status')}
              className="bg-gradient-to-r from-indigo-500 to-purple-600 hover:from-indigo-600 hover:to-purple-700 text-white font-bold py-2 px-4 rounded transition duration-200"
            >
              本日の勤務状況を見る
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Welcome;