import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

interface ProfileFormData {
  name: string;
  department: string;
}

const ProfileRegistration: React.FC = () => {
  const { logout } = useAuth();
  const navigate = useNavigate();
  const [formData, setFormData] = useState<ProfileFormData>({
    name: '',
    department: ''
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [message, setMessage] = useState<{ type: 'success' | 'error'; text: string } | null>(null);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    // Validation
    if (!formData.name.trim() || !formData.department.trim()) {
      setMessage({ type: 'error', text: 'すべての項目を入力してください。' });
      return;
    }

    setIsSubmitting(true);
    setMessage(null);

    try {
      // Submit to dummy_path as specified
      // Since dummy_path doesn't exist, we simulate the submission
      await fetch('dummy_path', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData)
      }).catch(() => {
        // Expected to fail for dummy_path - this is intentional
      });

      // Show success message for demo purposes
      setMessage({ 
        type: 'success', 
        text: '情報を登録しました。（ダミーパス送信完了）' 
      });
      
    } catch (error) {
      // Unexpected errors
      setMessage({ 
        type: 'error', 
        text: 'エラーが発生しました。' 
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <div className="min-h-screen bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500 flex items-center justify-center p-4">
      <div className="bg-white rounded-lg shadow-xl p-8 max-w-md w-full">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-3xl font-bold text-gray-800">
            ユーザー情報登録
          </h1>
          <button
            onClick={handleLogout}
            className="text-sm text-gray-600 hover:text-gray-800 underline"
          >
            ログアウト
          </button>
        </div>

        <p className="text-gray-600 mb-6">
          以下の情報を入力してください。既に登録済みの場合は、情報が更新されます。
        </p>

        <form onSubmit={handleSubmit} className="space-y-6">
          {/* Name Field */}
          <div>
            <label htmlFor="name" className="block text-sm font-medium text-gray-700 mb-2">
              名前 <span className="text-red-500">*</span>
            </label>
            <input
              type="text"
              id="name"
              name="name"
              value={formData.name}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition"
              placeholder="田中 太郎"
              required
            />
          </div>

          {/* Department Field */}
          <div>
            <label htmlFor="department" className="block text-sm font-medium text-gray-700 mb-2">
              所属部署 <span className="text-red-500">*</span>
            </label>
            <input
              type="text"
              id="department"
              name="department"
              value={formData.department}
              onChange={handleInputChange}
              className="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition"
              placeholder="開発部"
              required
            />
          </div>

          {/* Message Display */}
          {message && (
            <div className={`p-4 rounded-md ${
              message.type === 'success' 
                ? 'bg-green-50 border border-green-200 text-green-800' 
                : 'bg-red-50 border border-red-200 text-red-800'
            }`}>
              <p className="text-sm font-medium">{message.text}</p>
            </div>
          )}

          {/* Submit Button */}
          <button
            type="submit"
            disabled={isSubmitting}
            className={`w-full py-3 px-4 rounded-md text-white font-semibold transition duration-200 ${
              isSubmitting
                ? 'bg-gray-400 cursor-not-allowed'
                : 'bg-gradient-to-r from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600'
            }`}
          >
            {isSubmitting ? '送信中...' : '登録する'}
          </button>
        </form>

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

export default ProfileRegistration;
