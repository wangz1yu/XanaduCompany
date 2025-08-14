import axios from 'axios'

// 根据环境设置API基础URL
const baseURL = process.env.NODE_ENV === 'production' 
  ? 'https://xanadu-backend.onrender.com/api'  // Render后端地址
  : '/api'  // 开发环境代理

export default axios.create({
  timeout: 10000,
  baseURL
})
