import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

const Login: React.FC = () => {
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleLogin = () => {
    login();
    navigate('/profile');
  };

  return (
    <div className="min-h-screen bg-gradient-to-r from-blue-500 to-purple-600 flex items-center justify-center p-4">
      <div className="bg-white rounded-lg shadow-xl p-8 max-w-md w-full">
        <h1 className="text-3xl font-bold text-gray-800 text-center mb-6">
          ログイン
        </h1>
        
        <p className="text-gray-600 text-center mb-8">
          ユーザー情報登録画面にアクセスするにはログインが必要です。
        </p>

        <button
          onClick={handleLogin}
          className="w-full bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white font-bold py-3 px-4 rounded-md transition duration-200"
        >
          ログインする（デモ）
        </button>

        <div className="mt-6 text-center">
          <button
            onClick={() => navigate('/')}
            className="text-sm text-purple-600 hover:text-purple-800 underline"
          >
            ホームに戻る
          </button>
        </div>
      </div>
    </div>
  );
};

export default Login;
