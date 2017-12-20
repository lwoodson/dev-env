alias beep="echo -en '\007'"
alias tmux="TERM=xterm-256color tmux"
alias devkill="tmux kill-session -t dev"

# AWS aliases
alias aws-iam='aws iam --region "${REGION}" --profile "${PROFILE}"'
alias aws-ec2='aws ec2 --region "${REGION}" --profile "${PROFILE}"'
alias aws-s3='aws s3 --profile "${PROFILE}"'
alias aws-s3api='aws s3api --profile "${PROFILE}"'
alias aws-cfn='aws cloudformation --profile "${PROFILE}" --region "${REGION}"'
alias aws-sqs='aws sqs --profile="${PROFILE}" --region "${REGION}"'
alias aws-desc-stack='aws-cfn describe-stacks --stack-name'
