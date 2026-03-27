# Next.js Skills
## 版本与配置
- Next.js 15 + App Router（不用 Pages Router）
- React 19，使用最新特性
- 配置文件：next.config.ts（TypeScript）
## 目录结构规范
src/
├── app/                    # App Router 页面
│   ├── (auth)/             # 路由分组
│   ├── (dashboard)/
│   ├── api/                # API Routes
│   ├── globals.css
│   └── layout.tsx
├── components/
│   ├── ui/                 # 基础 UI 组件（shadcn/ui）
│   └── features/           # 业务组件，按功能模块划分
├── lib/
│   ├── db.ts               # 数据库连接
│   ├── auth.ts             # 认证配置
│   └── utils.ts            # 工具函数
├── hooks/                  # 自定义 hooks
├── types/                  # 全局类型定义
├── actions/                # Server Actions
└── config/                 # 配置常量

## 渲染策略
- 默认用 Server Component，减少客户端 JS
- 需要交互/状态/浏览器 API 才加 'use client'
- 数据获取在 Server Component 中直接 async/await
- 动态数据用 fetch + revalidate，静态数据用 generateStaticParams

## Server Actions
- 表单提交、数据变更优先用 Server Actions
- 文件放在 src/actions/ 目录，顶部加 'use server'
- 配合 useActionState 处理表单状态
- 操作完成后调用 revalidatePath / revalidateTag

## API Routes
- 仅用于：第三方 webhook、需要流式响应、公开 API
- 文件：src/app/api/[route]/route.ts
- 统一返回格式：{ data, error, message }

## 数据获取规范
- ORM：Prisma（类型安全第一）
- 数据库操作封装在 src/lib/db/ 目录
- 禁止在组件中直接写 SQL/Prisma 查询
- 使用 Zod 验证所有输入数据

## 样式规范
- Tailwind CSS v4
- 组件库：shadcn/ui（按需添加）
- 响应式：mobile first，断点 sm/md/lg/xl
- 不写内联 style，除非动态值

## 状态管理
- 服务端状态：React Query（TanStack Query）或直接 Server Component
- 客户端 UI 状态：useState / useReducer
- 全局状态（谨慎使用）：Zustand
- 不用 Redux，除非项目已有

## 认证
- 优先使用 NextAuth v5 / Auth.js
- 中间件鉴权：src/middleware.ts

## 性能规范
- 图片：必须用 next/image
- 字体：必须用 next/font
- 大组件/第三方库用 dynamic() 懒加载
- 列表渲染必须有 key，且不用 index 作为 key

