# Backend Skills（Next.js API / Server Actions）
## API 设计原则
- RESTful 风格，语义化 HTTP 方法
- 统一响应格式（见下方）
- 所有输入用 Zod 验证
- 敏感操作必须鉴权
## 统一响应格式
```typescript
// src/types/api.ts
export type ApiResponse<T = null> = {
  success: boolean
  data?: T
  error?: string
  message?: string
}
// 成功
return NextResponse.json({ success: true, data: result })
// 失败
return NextResponse.json({ success: false, error: '错误信息' }, { status: 400 })
## server actions 规范
'use server'

import { z } from 'zod'
import { auth } from '@/lib/auth'

const schema = z.object({
  title: z.string().min(1).max(100),
})

export async function createPost(formData: FormData) {
  // 1. 鉴权
  const session = await auth()
  if (!session) return { error: '未登录' }

  // 2. 验证
  const parsed = schema.safeParse(Object.fromEntries(formData))
  if (!parsed.success) return { error: parsed.error.message }

  // 3. 业务逻辑
  try {
    const post = await db.post.create({ data: { ...parsed.data, userId: session.user.id } })
    revalidatePath('/posts')
    return { success: true, data: post }
  } catch (e) {
    return { error: '创建失败' }
  }
}

