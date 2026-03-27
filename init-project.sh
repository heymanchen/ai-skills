#!/bin/bash
set -e
# ============================================
# AI Skills 项目初始化脚本
# 在当前项目目录注入对应的 skills 文件
# ============================================
BASE=~/dotfiles/ai-skills
SKILLS=$BASE/skills
TEMPLATES=$BASE/templates
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
# ---- 选择项目类型 ----
echo -e "${BLUE}🎯 选择项目类型：${NC}"
echo "  1) nextjs-fullstack  全栈应用"
echo "  2) nextjs-saas       SaaS 应用"
echo "  3) nextjs-landing    落地页"
echo ""
read -p "输入数字 (1-3): " choice
case $choice in
  1) TEMPLATE="nextjs-fullstack" ;;
  2) TEMPLATE="nextjs-saas" ;;
  3) TEMPLATE="nextjs-landing" ;;
  *) echo -e "${RED}❌ 无效选择${NC}"; exit 1 ;;
esac
echo -e "\n${YELLOW}📦 初始化 ${TEMPLATE} 项目...${NC}\n"
# ---- 合并函数（全局 base + 项目模板）----
merge_project_rules() {
  cat "$SKILLS/base.md" \
      "$SKILLS/nextjs.md" \
      "$SKILLS/frontend.md" \
      "$SKILLS/backend.md" \
      "$SKILLS/database.md" \
      "$TEMPLATES/$TEMPLATE/rules.md"
}
# ---- 生成各工具配置文件 ----
# Cursor
mkdir -p .cursor/rules
merge_project_rules > .cursor/rules/project.mdc
echo -e "${GREEN}✅ .cursor/rules/project.mdc${NC}"
# Codex
merge_project_rules > AGENTS.md
echo -e "${GREEN}✅ AGENTS.md${NC}"
# OpenCode
mkdir -p .opencode
merge_project_rules > .opencode/instructions.md
# opencode 项目配置
cat > opencode.json << JSON
{
  "\$schema": "https://opencode.ai/config.json",
  "instructions": ".opencode/instructions.md"
}
JSON
echo -e "${GREEN}✅ .opencode/instructions.md${NC}"
echo -e "${GREEN}✅ opencode.json${NC}"
# ---- 添加到 .gitignore（可选）----
if [ -f .gitignore ]; then
  if ! grep -q "AGENTS.md" .gitignore; then
    read -p "是否将 AI 配置文件加入 .gitignore？(y/n): " add_gitignore
    if [ "$add_gitignore" = "y" ]; then
      echo "" >> .gitignore
      echo "# AI Tools" >> .gitignore
      echo "AGENTS.md" >> .gitignore
      echo ".cursor/rules/" >> .gitignore
      echo ".opencode/" >> .gitignore
      echo "opencode.json" >> .gitignore
      echo -e "${GREEN}✅ 已更新 .gitignore${NC}"
    fi
  fi
fi
echo -e "\n${BLUE}🎉 项目 Skills 初始化完成！(${TEMPLATE})${NC}"
echo -e "${BLUE}📁 当前目录: $(pwd)${NC}"