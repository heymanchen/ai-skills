# Frontend Skills
## 组件规范
- 每个文件只导出一个主组件
- Props 用 interface 定义，不用 type（保持一致）
- 必填 props 不给默认值，可选 props 给默认值
- 组件文件名与组件名一致（PascalCase）
## Hooks 规范
- 自定义 hook 必须以 use 开头
- hook 只做一件事
- 复杂逻辑抽离到 hook，保持组件简洁
## 表单处理
- 使用 react-hook-form + Zod resolver
- 验证逻辑复用：schema 定义在 src/lib/validations/
## 常用组件写法示例
```tsx
// ✅ 正确
interface ButtonProps {
  label: string
  onClick: () => void
  variant?: 'primary' | 'secondary'
  disabled?: boolean
}
export function Button({ label, onClick, variant = 'primary', disabled = false }: ButtonProps) {
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      className={cn(
        'px-4 py-2 rounded-md font-medium',
        variant === 'primary' && 'bg-blue-600 text-white',
        variant === 'secondary' && 'bg-gray-100 text-gray-900',
        disabled && 'opacity-50 cursor-not-allowed'
      )}
    >
      {label}
    </button>
  )
}
```
## 错误边界
- 页面级组件配置 error.tsx
- 加载状态配置 loading.tsx
- not found 配置 not-found.tsx
## 可访问性
交互元素必须有 aria-label 或可见文字
图片必须有 alt
表单元素必须有 label EOF
