import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

interface WorkLocation {
  id: number;
  name: string;
  department: string;
  status: 'office' | 'remote' | 'out_of_office';
  date: string;
}

interface UserProfile {
  id: number;
  name: string;
  department: string;
}

const OfficeStatus: React.FC = () => {
  const [workLocations, setWorkLocations] = useState<WorkLocation[]>([]);
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [myStatus, setMyStatus] = useState<string>('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [updating, setUpdating] = useState(false);
  const { token, logout } = useAuth();
  const navigate = useNavigate();

  const fetchProfile = async () => {
    try {
      const response = await fetch('http://localhost:3000/api/v1/profile', {
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (response.status === 404) {
        navigate('/profile-setup');
        return;
      }

      if (!response.ok) {
        throw new Error('Failed to fetch profile');
      }

      const data = await response.json();
      setProfile(data);
    } catch (err) {
      console.error('Profile fetch error:', err);
    }
  };

  const fetchWorkLocations = async () => {
    try {
      const response = await fetch('http://localhost:3000/api/v1/work_locations/today', {
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error('Failed to fetch work locations');
      }

      const data = await response.json();
      setWorkLocations(data.work_locations || []);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchProfile();
    fetchWorkLocations();
    // Refresh every 30 seconds
    const interval = setInterval(fetchWorkLocations, 30000);
    return () => clearInterval(interval);
  }, []);

  const handleStatusUpdate = async () => {
    if (!myStatus) return;
    
    setUpdating(true);
    try {
      const response = await fetch('http://localhost:3000/api/v1/work_locations', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify({ status: myStatus }),
      });

      if (!response.ok) {
        throw new Error('Failed to update status');
      }

      // Refresh the list
      await fetchWorkLocations();
      setMyStatus('');
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Status update failed');
    } finally {
      setUpdating(false);
    }
  };

  const handleLogout = async () => {
    try {
      await fetch('http://localhost:3000/api/v1/auth/logout', {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });
    } catch (err) {
      console.error('Logout error:', err);
    }
    logout();
    navigate('/login');
  };

  const getStatusLabel = (status: string) => {
    switch (status) {
      case 'office':
        return 'オフィス';
      case 'remote':
        return 'リモート';
      case 'out_of_office':
        return '外出/休暇';
      default:
        return '不明';
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'office':
        return 'bg-green-100 text-green-800 border-green-300';
      case 'remote':
        return 'bg-blue-100 text-blue-800 border-blue-300';
      case 'out_of_office':
        return 'bg-gray-100 text-gray-800 border-gray-300';
      default:
        return 'bg-gray-100 text-gray-800 border-gray-300';
    }
  };

  const officeCount = workLocations.filter(wl => wl.status === 'office').length;
  const remoteCount = workLocations.filter(wl => wl.status === 'remote').length;
  const outCount = workLocations.filter(wl => wl.status === 'out_of_office').length;

  return (
    <div className="min-h-screen bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500 py-8 px-4">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <div className="bg-white rounded-lg shadow-xl p-6 mb-6">
          <div className="flex justify-between items-center">
            <div>
              <h1 className="text-3xl font-bold text-gray-800">
                オフィス出社状況
              </h1>
              {profile && (
                <p className="text-gray-600 mt-1">
                  {profile.name} さん ({profile.department})
                </p>
              )}
            </div>
            <button
              onClick={handleLogout}
              className="bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-4 rounded-md transition duration-200"
            >
              ログアウト
            </button>
          </div>
        </div>

        {/* Status Update Section */}
        <div className="bg-white rounded-lg shadow-xl p-6 mb-6">
          <h2 className="text-xl font-semibold text-gray-800 mb-4">
            今日の勤務地を登録
          </h2>
          <div className="flex gap-4">
            <select
              value={myStatus}
              onChange={(e) => setMyStatus(e.target.value)}
              className="flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500"
            >
              <option value="">勤務地を選択してください</option>
              <option value="office">オフィス</option>
              <option value="remote">リモート</option>
              <option value="out_of_office">外出/休暇</option>
            </select>
            <button
              onClick={handleStatusUpdate}
              disabled={!myStatus || updating}
              className="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-6 rounded-md transition duration-200 disabled:bg-gray-400"
            >
              {updating ? '更新中...' : '登録'}
            </button>
          </div>
        </div>

        {/* Summary Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <div className="bg-white rounded-lg shadow-md p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-gray-600 text-sm">オフィス</p>
                <p className="text-3xl font-bold text-green-600">{officeCount}</p>
              </div>
              <div className="bg-green-100 rounded-full p-3">
                <svg className="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                </svg>
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg shadow-md p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-gray-600 text-sm">リモート</p>
                <p className="text-3xl font-bold text-blue-600">{remoteCount}</p>
              </div>
              <div className="bg-blue-100 rounded-full p-3">
                <svg className="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                </svg>
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg shadow-md p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-gray-600 text-sm">外出/休暇</p>
                <p className="text-3xl font-bold text-gray-600">{outCount}</p>
              </div>
              <div className="bg-gray-100 rounded-full p-3">
                <svg className="w-8 h-8 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
            </div>
          </div>
        </div>

        {/* Employee List */}
        <div className="bg-white rounded-lg shadow-xl p-6">
          <h2 className="text-xl font-semibold text-gray-800 mb-4">
            社員一覧 ({workLocations.length}名)
          </h2>

          {loading && (
            <div className="text-center py-8">
              <div className="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-gray-900"></div>
              <p className="mt-2 text-gray-600">読み込み中...</p>
            </div>
          )}

          {error && (
            <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
              {error}
            </div>
          )}

          {!loading && !error && workLocations.length === 0 && (
            <div className="text-center py-8 text-gray-500">
              本日の勤務地情報が登録されていません
            </div>
          )}

          {!loading && !error && workLocations.length > 0 && (
            <div className="overflow-x-auto">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      名前
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      部署
                    </th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                      勤務地
                    </th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {workLocations.map((location) => (
                    <tr key={location.id} className="hover:bg-gray-50">
                      <td className="px-6 py-4 whitespace-nowrap">
                        <div className="text-sm font-medium text-gray-900">
                          {location.name}
                        </div>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap">
                        <div className="text-sm text-gray-500">
                          {location.department}
                        </div>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap">
                        <span className={`px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full border ${getStatusColor(location.status)}`}>
                          {getStatusLabel(location.status)}
                        </span>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="mt-6 text-center text-white text-sm">
          <p>自動更新: 30秒ごと</p>
        </div>
      </div>
    </div>
  );
};

export default OfficeStatus;
