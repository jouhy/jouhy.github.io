#!/bin/bash
 
echo -e "\033[0;32mDeploying updates to GitHub***\033[0m"
 
# 모든 서브모듈의 변경사항을 업데이트
git submodule update --remote
 
# `hugo -t <테마명>` 명령어로 Hugo 정적 페이지 렌더링
# `--gc` 옵션은 `garbage collection` 을 의미하며 불필요한 페이지를 삭제
hugo -t hugo-book-jouhy --gc
 
# `source` 브랜치로 이동
cd public
git add .
 
# 인자가 없을 경우 현재 시간을 커밋 메시지로 등록
msg="rebuild: $(date +"%Y-%m-%dT%H:%M:%S%z")"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"
 
# 빌드 결과를 `source` 브랜치에 반영
git push origin main
 
# `main` 브랜치로 이동
cd ..
 
# 현재까지의 변경사항을 `main` 브랜치에 반영
git add .
 
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"
 
git push origin main