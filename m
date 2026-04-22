Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F8364EB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776885357; cv=none; b=W73BJmDjAg7UE2ddlhN0wWIenrH50o1DmTAOsl9BGCKdE2+ydCAn2IYeiuf22pTn9OLfoYP5RMF1g4jH/Tk0dDdqdGFuVvX8iGjJGx5Sh9PMSwPK+2lKRtOG0daSOJygSa2ya6mYQcY0bZKFd2E6W0gbjSfk7HRrsT5WxAgkl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776885357; c=relaxed/simple;
	bh=K46wLRQLJ7Hzb3HS4jLXpFrNo1DeVw5lT/nBhkxQuUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=quHV6DqKutvd7BZbpqVF0qAFbytRqUEY9B8i9V8y7z+Zj41JzJcPRyyHZACpvR0S/KOoSxCNa6E1hIfhpje+WZkQ07IB+pDJpwAS7K5WiK/cd488wnW5HUdNw5kHrjhadGYzE5OBStQz3ElX0pHKHvxmZgEIgMZT3NMMJ31PGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/5x4mfA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/5x4mfA"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38e936caafeso58235831fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776885345; x=1777490145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tss2NFnS4WNHYKs6+Pb3NhQ3BMaMcw1cNRiwvfWC6Qw=;
        b=m/5x4mfANFUiC2TZ/zPPxwCYZZ4XMQAOP0XfyxW2t95PCiUEtaz+Pntl1601r/Aqtn
         sHvVUz7n3ejZt9OwnamjmmYuk6EB6xnJ1pasUo6Qob5fCkkaNtRf1MNJPGd67vNhaGtF
         4iG5U9vI00HpQXtEYTXhKskS6PiSfyROBeTDH57cCUxPD0mIVvaX+qmcgDU54N/uwwlq
         7+ek464haHWL8gLgql9KlkpJ5/n8E5Y0eeIxwDNs2eu7JvzhcOX7fsMLwbABWgKx+Ipj
         CJpZMxMqd7bw3R20vnq3k15EWM51izb1HcB/qeS3xkZ7Dd0rb0tg+7X5UmT3jLQGMIOQ
         LgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776885345; x=1777490145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tss2NFnS4WNHYKs6+Pb3NhQ3BMaMcw1cNRiwvfWC6Qw=;
        b=WL10ONBnfHK7o3qMgepd3glGsiBG+tn/2TjXJYG/77n0sk3U0NnpHmXhh3zeUtqX3t
         UnObbg3ZEifazINtdBnYmJ2KemwBp+ZubEsGQUy2ay2nYqFyeSTObOhs2ThqE0/VEcON
         cVuaHfzMXR1/FqEVf7iSqRtB2pn8VtxVrVQm7xs8W6sYZHC56SbHfzmvvaV2/SYJWYWw
         vq+4uji7oLKPoQBEZ/TrtTprgg5khHpkHrWHWwl4oD8N2anTJIshxY5OZWPby87v+Dy8
         UIFroyMDIbTxM8dZvtMLJyt+pljD4IqLMufCOomOXJiktOOKVLLQ7I8zbTOSf8HYcHFT
         eZPg==
X-Forwarded-Encrypted: i=1; AFNElJ85HgDxJnHBTm8FLUcjLJLVlzjXjJZlQLpNEu69n4Qc+7unMD0j4iT7UEKDu/+2O9+Qvh2ZKSmERxOO3tA3@vger.kernel.org
X-Gm-Message-State: AOJu0YzwlKWKhtCvqBU34eZHIxigrtnfp/qQpE4EqOZ3FmydsPQ0c/V9
	F6/SKNCNnCXZwP7y46tF/bSla+/hHVevCnppI/vlZnzNGHiAKm97aCGP5bha
X-Gm-Gg: AeBDievKeSXB9q5Mp9husJ95Dlip6fjAVRq4Xf2rb1BZ/MQip3xq34hs3nSqnTCGgqA
	18M3RV28zrDa/qvIkHftCdem0jP4SE8L3fU5VgCXU7lwHcL32O0eitgrkHt+BLDgQlNH67RItjt
	UQIoCMP69IEktLI9Rd0mmV0u6lCIyEEgsi8fiYLj6pYlWqtzWSkR0IsUbCjtRqwZVnUYtYv8KBw
	z2uHezzXdpwBVoijLQApc3+lkFkoHZUZvqOv1kt7xfjegGP1xDvj3rFyVaqU3p7xI/KZPlLRowR
	OeuFfFFma/YtfdrbaetzXeXyn8N2fzcK4yJ8Y0hZz+k26Iyvn41LqiCa4Hu94Y6B+O9qU3n7W+e
	a4FIvxuAGmDWWX6dVFyvccAsfcn87gFzkvrM7ujG3hz0AMwESYQmmVyDYAd0C0YkPfScRwMNL5A
	WG4h9Vt4k5EexXG6HnFUPJgg==
X-Received: by 2002:a05:6512:234f:b0:5a4:304:43c9 with SMTP id 2adb3069b0e04-5a4172ca2femr9225060e87.14.1776885344645;
        Wed, 22 Apr 2026 12:15:44 -0700 (PDT)
Received: from p183 ([178.172.147.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad108sm4640295e87.3.2026.04.22.12.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:15:44 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ebiederm@xmission.com
Subject: [PATCH 1/2] proc: add tgid_iter.pid_ns member
Date: Wed, 22 Apr 2026 22:17:44 +0300
Message-ID: <20260422191745.435556-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

next_tgid() accept pid namespace as an argument, but it never changes
during readdir (which would be unthinkable thing to do anyway).

Move it inside iterator type and hide from direct usage.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/base.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..f2db455dbbfd 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3543,8 +3543,10 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 struct tgid_iter {
 	unsigned int tgid;
 	struct task_struct *task;
+	struct pid_namespace *pid_ns;
 };
-static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter iter)
+
+static struct tgid_iter next_tgid(struct tgid_iter iter)
 {
 	struct pid *pid;
 
@@ -3553,9 +3555,9 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 	rcu_read_lock();
 retry:
 	iter.task = NULL;
-	pid = find_ge_pid(iter.tgid, ns);
+	pid = find_ge_pid(iter.tgid, iter.pid_ns);
 	if (pid) {
-		iter.tgid = pid_nr_ns(pid, ns);
+		iter.tgid = pid_nr_ns(pid, iter.pid_ns);
 		iter.task = pid_task(pid, PIDTYPE_TGID);
 		if (!iter.task) {
 			iter.tgid += 1;
@@ -3574,7 +3576,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct tgid_iter iter;
 	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
-	struct pid_namespace *ns = proc_pid_ns(file_inode(file)->i_sb);
+	struct pid_namespace *pid_ns = proc_pid_ns(file_inode(file)->i_sb);
 	loff_t pos = ctx->pos;
 
 	if (pos >= PID_MAX_LIMIT + TGID_OFFSET)
@@ -3592,9 +3594,10 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 	}
 	iter.tgid = pos - TGID_OFFSET;
 	iter.task = NULL;
-	for (iter = next_tgid(ns, iter);
+	iter.pid_ns = pid_ns;
+	for (iter = next_tgid(iter);
 	     iter.task;
-	     iter.tgid += 1, iter = next_tgid(ns, iter)) {
+	     iter.tgid += 1, iter = next_tgid(iter)) {
 		char name[10 + 1];
 		unsigned int len;
 
-- 
2.52.0

