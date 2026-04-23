Received: from sg-3-28.ptr.tlmpb.com (sg-3-28.ptr.tlmpb.com [101.45.255.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB1B317143
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974844; cv=none; b=dIMi1CQvvJNH+HCckP89hykR1+b4OYbqIYQ29UGlcidXqfxnjWU1+Qyo2Uxwh9rlfoxJRW6ASDB2aoLgRJNY8ForC7uJm4WSb2dZ5Uqb36twDfFIt/o1GcIzr3+uSX/d5VnBJE+5xmir9g0VjU6PYS5rn/W2X7uMNHM15tG5riw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974844; c=relaxed/simple;
	bh=rjI498hI1fu0b8c70Qiv+1yICOLwmCALbhUQIITmhoc=;
	h=Subject:Date:Mime-Version:To:Cc:Content-Type:From:Message-Id; b=kc+pzPame430nhZ33/7+8OEriXnUnqWpcvXxuEvGPoJI2ucJDpJ1M+RYkJ4RuDLpwbyQ8w3HEpETxJJgFy6J9TbuJQWsExKAGmewWytHZ0P+4RIweyPL9O6cfUYW6hFDQFzvWp/vO8oLrx4pLPIUDjmasxSJrwPz8YQKf1ZJw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=rw4clU9s; arc=none smtp.client-ip=101.45.255.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="rw4clU9s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1776974793; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/MC22ya8tB3bUfsvqay3OcBy6PgxPW5l71TL5dCz/sE=;
 b=rw4clU9sk1y+/h/YUD0/dpYPaoGnaeo3QvP+q8xtcUhxNSloYK8NSojj8j4mKeDJtd79ao
 ilyXkt0TdV17gBVbfI0qFC4znohBDnjtk4S8DfLe5la5ZD6HWnaJX9OR22AxuNg1TidBRf
 1dvsrq6LFSbjrQPDU4zAp7rpx7q/ECErsSx+4901MM5rrfgUbl99m9gxk5GOMYfgNvlHmz
 VCSh/kuiXUMG6l88gKcPuMpwILM2WgGyShxwMwFXAiuPg92iVwxza3fXUAdhTLqHuY7y+5
 FslfC31eU/EwEo9l+CQ4pPZlWGUtI53Qc08Dk+aaqMDgpF1CH77fAhxdJag7LA==
X-Change-Id: 20260424-fix_proc_write_return-cd48edb86600
X-Lms-Return-Path: <lba+269ea7bc7+353dce+vger.kernel.org+me@cherr.cc>
X-B4-Tracking: v=1; b=H4sIALx76mkC/x2MWwqAIBAArxL7nWAiIl0lQkq32h+LtReId0/6H JiZDAmZMEHfZGC8KdEeK3RtA36b4oqCQmVQUhmplRYLve7g3buH6UTHeF4chQ/aYpitMVJCbQ/ GKv7fYSzlA8IHMMhnAAAA
Subject: [PATCH] proc: fix comm_write return value when truncated or error
Date: Fri, 24 Apr 2026 04:06:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Received: from pve.cherr ([111.42.148.159]) by smtp.feishu.cn with ESMTPS; Fri, 24 Apr 2026 04:06:31 +0800
To: "John Stultz" <johnstul@us.ibm.com>, 
	"Andrew Morton" <akpm@linux-foundation.org>
Cc: "Yao Zi" <me@ziyao.cc>, <linux-kernel@vger.kernel.org>, 
	<linux-fsdevel@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <20260424-fix_proc_write_return-v1-1-7a793c2aad32@cherr.cc>
X-Mailer: b4 0.14.2

When count exceeds TASK_COMM_LEN-1, comm_write() copies at most
TASK_COMM_LEN-1 bytes but returns the original count. This violates
write(2) semantics, which require returning the number of bytes
actually written.

The count parameter is size_t and should not be repurposed to carry a
negative error code on the same_thread_group() failure path.

Introduce a local len for the truncated length and a separate ssize_t
ret for the return value.

Fixes: 4614a696bd1c ("procfs: allow threads to rename siblings via /proc/pid/tasks/tid/comm")
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 fs/proc/base.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894bd1608580331e1d5b3018c59123b..5d34590dbe9d9f05147c3e6b34c615cbf0984b1c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1727,8 +1727,10 @@ static ssize_t comm_write(struct file *file, const char __user *buf,
 	struct task_struct *p;
 	char buffer[TASK_COMM_LEN] = {};
 	const size_t maxlen = sizeof(buffer) - 1;
+	size_t len = count > maxlen ? maxlen : count;
+	ssize_t ret;
 
-	if (copy_from_user(buffer, buf, count > maxlen ? maxlen : count))
+	if (copy_from_user(buffer, buf, len))
 		return -EFAULT;
 
 	p = get_proc_task(inode);
@@ -1738,13 +1740,14 @@ static ssize_t comm_write(struct file *file, const char __user *buf,
 	if (same_thread_group(current, p)) {
 		set_task_comm(p, buffer);
 		proc_comm_connector(p);
+		ret = len;
+	} else {
+		ret = -EINVAL;
 	}
-	else
-		count = -EINVAL;
 
 	put_task_struct(p);
 
-	return count;
+	return ret;
 }
 
 static int comm_show(struct seq_file *m, void *v)

---
base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
change-id: 20260424-fix_proc_write_return-cd48edb86600

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
