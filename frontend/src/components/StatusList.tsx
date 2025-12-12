import React from 'react';
import { Link } from 'react-router-dom';

interface UserStatus {
  id: number;
  name: string;
  department: string;
  status: 'office' | 'remote' | 'out_of_office' | 'unknown';
  date: string;
}

const StatusList: React.FC = () => {
  // Dummy data for today's status
  const today = new Date().toISOString().split('T')[0];
  
  const dummyData: UserStatus[] = [
    { id: 1, name: '田中 太郎', department: '開発部', status: 'office', date: today },
    { id: 2, name: '山田 花子', department: '営業部', status: 'remote', date: today },
    { id: 3, name: '佐藤 次郎', department: '開発部', status: 'out_of_office', date: today },
    { id: 4, name: '鈴木 一郎', department: 'マーケティング部', status: 'office', date: today },
    { id: 5, name: '高橋 美咲', department: '人事部', status: 'unknown', date: today },
    { id: 6, name: '渡辺 健太', department: '開発部', status: 'remote', date: today },
    { id: 7, name: '伊藤 さくら', department: '営業部', status: 'unknown', date: today },
    { id: 8, name: '中村 大輔', department: '総務部', status: 'office', date: today },
    { id: 9, name: '小林 愛', department: 'マーケティング部', status: 'remote', date: today },
    { id: 10, name: '加藤 翔太', department: '開発部', status: 'unknown', date: today },
  ];

  const getStatusLabel = (status: string): string => {
    switch (status) {
      case 'office':
        return 'オフィス';
      case 'remote':
        return 'リモート';
      case 'out_of_office':
        return '外出/休暇';
      case 'unknown':
        return '不明';
      default:
        return '不明';
    }
  };

  const getStatusColor = (status: string): string => {
    switch (status) {
      case 'office':
        return 'bg-blue-100 text-blue-800 border-blue-200';
      case 'remote':
        return 'bg-green-100 text-green-800 border-green-200';
      case 'out_of_office':
        return 'bg-orange-100 text-orange-800 border-orange-200';
      case 'unknown':
        return 'bg-gray-100 text-gray-800 border-gray-200';
      default:
        return 'bg-gray-100 text-gray-800 border-gray-200';
    }
  };

  const getStatusIcon = (status: string): string => {
    switch (status) {
      case 'office':
        return '🏢';
      case 'remote':
        return '🏠';
      case 'out_of_office':
        return '🚶';
      case 'unknown':
        return '❓';
      default:
        return '❓';
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-indigo-500 via-purple-500 to-pink-500 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-7xl mx-auto">
        {/* Back Button */}
        <div className="mb-6">
          <Link 
            to="/"
            className="inline-flex items-center px-4 py-2 bg-white/20 hover:bg-white/30 text-white font-semibold rounded-lg transition duration-200 backdrop-blur-sm"
          >
            <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
            ホームに戻る
          </Link>
        </div>

        {/* Header */}
        <div className="text-center mb-12">
          <h1 className="text-4xl font-extrabold text-white mb-2 drop-shadow-lg">
            本日の勤務状況
          </h1>
          <p className="text-xl text-white/90">
            {new Date().toLocaleDateString('ja-JP', { 
              year: 'numeric', 
              month: 'long', 
              day: 'numeric',
              weekday: 'long'
            })}
          </p>
        </div>

        {/* Status Summary Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
          <div className="bg-white/95 backdrop-blur-sm rounded-xl shadow-lg p-6 border-l-4 border-blue-500 transform hover:scale-105 transition-transform duration-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-gray-600 text-sm font-medium">オフィス</p>
                <p className="text-3xl font-bold text-gray-800">
                  {dummyData.filter(u => u.status === 'office').length}
                </p>
              </div>
              <div className="text-4xl">🏢</div>
            </div>
          </div>
          
          <div className="bg-white/95 backdrop-blur-sm rounded-xl shadow-lg p-6 border-l-4 border-green-500 transform hover:scale-105 transition-transform duration-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-gray-600 text-sm font-medium">リモート</p>
                <p className="text-3xl font-bold text-gray-800">
                  {dummyData.filter(u => u.status === 'remote').length}
                </p>
              </div>
              <div className="text-4xl">🏠</div>
            </div>
          </div>
          
          <div className="bg-white/95 backdrop-blur-sm rounded-xl shadow-lg p-6 border-l-4 border-orange-500 transform hover:scale-105 transition-transform duration-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-gray-600 text-sm font-medium">外出/休暇</p>
                <p className="text-3xl font-bold text-gray-800">
                  {dummyData.filter(u => u.status === 'out_of_office').length}
                </p>
              </div>
              <div className="text-4xl">🚶</div>
            </div>
          </div>
          
          <div className="bg-white/95 backdrop-blur-sm rounded-xl shadow-lg p-6 border-l-4 border-gray-500 transform hover:scale-105 transition-transform duration-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-gray-600 text-sm font-medium">不明</p>
                <p className="text-3xl font-bold text-gray-800">
                  {dummyData.filter(u => u.status === 'unknown').length}
                </p>
              </div>
              <div className="text-4xl">❓</div>
            </div>
          </div>
        </div>

        {/* Status List Table */}
        <div className="bg-white/95 backdrop-blur-sm rounded-2xl shadow-2xl overflow-hidden">
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gradient-to-r from-indigo-600 to-purple-600">
                <tr>
                  <th scope="col" className="px-6 py-4 text-left text-xs font-bold text-white uppercase tracking-wider">
                    氏名
                  </th>
                  <th scope="col" className="px-6 py-4 text-left text-xs font-bold text-white uppercase tracking-wider">
                    所属
                  </th>
                  <th scope="col" className="px-6 py-4 text-left text-xs font-bold text-white uppercase tracking-wider">
                    ステータス
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {dummyData.map((user, index) => (
                  <tr 
                    key={user.id} 
                    className={`hover:bg-gray-50 transition-colors duration-150 ${
                      index % 2 === 0 ? 'bg-white' : 'bg-gray-50/50'
                    }`}
                  >
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center">
                        <div className="flex-shrink-0 h-10 w-10 bg-gradient-to-br from-indigo-400 to-purple-500 rounded-full flex items-center justify-center text-white font-bold">
                          {user.name.charAt(0)}
                        </div>
                        <div className="ml-4">
                          <div className="text-sm font-medium text-gray-900">{user.name}</div>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="text-sm text-gray-900">{user.department}</div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-semibold border ${getStatusColor(user.status)}`}>
                        <span className="mr-2">{getStatusIcon(user.status)}</span>
                        {getStatusLabel(user.status)}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {/* Footer Info */}
        <div className="mt-8 text-center">
          <p className="text-white/80 text-sm">
            全 {dummyData.length} 名の勤務状況を表示しています
          </p>
        </div>
      </div>
    </div>
  );
};

export default StatusList;
