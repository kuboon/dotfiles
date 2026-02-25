# GitHub Actions の run が完了するまで待つ
# Usage: wait_gh_run <RUN_ID>  または  echo <RUN_ID> | wait_gh_run
# 例: wait_gh_run 22126694762
# 例: echo 22126694762 | wait_gh_run
function wait_gh_run --description "Wait for GitHub Actions run to complete"
  if test -n "$argv[1]"
    set RUN_ID $argv[1]
  else
    read RUN_ID
  end
  if test -z "$RUN_ID"
    echo "Usage: wait_gh_run <RUN_ID>  or  echo <RUN_ID> | wait_gh_run"
    return 1
  end
  set created_at (gh run view $RUN_ID --json createdAt -q '.createdAt' 2>/dev/null)
  if test -z "$created_at"
    echo "Run を取得できません: $RUN_ID"
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
