# GitHub Actions の run が完了するまで待つ
# Usage: wait_gh_run <RUN_ID>  または  echo <RUN_ID> | wait_gh_run
# 例: wait_gh_run 22126694762
# 例: echo 22126694762 | wait_gh_run
function wait_gh_run --description "Wait for GitHub Actions run to complete"
  if test -z "$argv[1]"
    echo "Usage: wait_gh_run <BRANCH_NAME>"
    return 1
  end
  set BRANCH_NAME $argv[1]
  set -l run_info (gh run list --branch $BRANCH_NAME --json databaseId,createdAt -q '.[0] | .databaseId, .createdAt')
  set RUN_ID $run_info[1]
  set created_at $run_info[2]
  if test -z "$created_at"; or test -z "$RUN_ID"
    echo "Run を取得できません（ブランチ $BRANCH_NAME に run がありません）"
    return 1
  end
  set target_epoch (date -d "$created_at + 15 minutes" +%s 2>/dev/null)
  set now_epoch (date +%s)
  set sleep_sec (math $target_epoch - $now_epoch)
  if test $sleep_sec -gt 0
    echo "createdAt $created_at の15分後まで $sleep_sec 秒待機..."
    sleep $sleep_sec
  end
  while test (gh run view $RUN_ID --json status -q '.status' 2>/dev/null) != "completed"
    echo (date +%H:%M:%S) 実行中...
    sleep 60
  end
  echo "完了: "(gh run view $RUN_ID --json conclusion -q '.conclusion')
end
# wait_gh_run の第1引数に git のローカルブランチ・タグを補完
complete -c wait_gh_run -f -a '(
  git for-each-ref --format="%(refname:short)" refs/heads/ 2>/dev/null
  git tag -l 2>/dev/null
)'
