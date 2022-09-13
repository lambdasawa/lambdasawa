locals {
  name = format(
    "%s-%s",
    substr(var.project, 0, 12),
    substr(var.stage, 0, 8),
  )
}

resource "aws_backup_vault" "main" {
  name = local.name

  tags = local.tags
}

resource "aws_backup_plan" "main" {
  name = local.name

  rule {
    rule_name = local.name

    target_vault_name = aws_backup_vault.main.name

    schedule = "cron(0 19 * * ? *)" # JST AM 04:00

    lifecycle {
      delete_after = 14
    }
  }

  tags = local.tags
}

resource "aws_iam_role" "main" {
  name = local.name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : ["sts:AssumeRole"],
        "Effect" : "allow",
        "Principal" : {
          "Service" : ["backup.amazonaws.com"]
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "main" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"

  role = aws_iam_role.main.name
}

resource "aws_backup_selection" "main" {
  name = local.name

  plan_id = aws_backup_plan.main.id

  iam_role_arn = aws_iam_role.main.arn

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Project"
    value = local.project
  }

  condition {
    string_equals {
      key   = "aws:ResourceTag/Stage"
      value = local.stage
    }
    string_not_equals {
      key   = "aws:ResourceTag/Backup"
      value = "false"
    }
  }
}
