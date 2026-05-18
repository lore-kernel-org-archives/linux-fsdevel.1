Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992A48AE2A
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122131; cv=none; b=NBxKHsXOTYm87DUYkrzDSL/2UeT/A6YEcNujxv8IIJUlF2hDcO4eyA35X1uznPzqNOQglxhVdfb/3DEy/9OJ5J4YtEBTlBq/YbVHQ9npElvfLjkdRO/kpZV9qW3F945Cgj+SAVKmeJNr6oVBYbUAzOYK3diLqdVqz9ERCLuQQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122131; c=relaxed/simple;
	bh=djRGGOfNBbozjPnt/kQUnWI/N0nUnUMisT2sVceci6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWA6xoU3tSvgYrvSLmC+LWY1Bl5x4IuVw3bNQ2IDODmNXBH0q5QyGCwDIQqmC9xZBwyHc4RgWoFAGMBsqr9A9GgWKNu45pzXQ7O2FYLeki0LQ6IgEdClIR6CFCeV68g/q6yRfzeIzET0qyKA3C42oUuPHtRjYmjAhlVvaFqGbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tSS/vC2D; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSS/vC2D"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso1135e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779122127; x=1779726927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GM6eeee61f70ct0y/r5ABG7xt/dD+OPujWKV47jCuiw=;
        b=tSS/vC2DIW/yg5OPWACD4lnLLjFciL98hQ4rs19gGcnxsX6gOcoLbvYpeEKzvXioG5
         ZD7V0nt7UsBf3YkeTgTXulGhs2gDtmlibXZKhce2Unrc1DhQ/vJ9EOOSESAQAUE2gbri
         yTl+MvcVJ8teIcdQZpqgVG/Z+A/qJ/q5L1cOHCjTEHCnUjKUbqczIVI7izuf+89lSYM8
         xHkIkQoYs3I2jlvFwpoaJZlFCn/WwJKx3IlPSlAu+UAs0MHgPIYCY3dgk9FPrlTEHw2K
         nhXIO+jEu9sW1LBRwwLcG5DfZNQ2agk2ns3L9C0YN0dnPT4XskWe+KV61qyhMv5ZDsRq
         x7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122127; x=1779726927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GM6eeee61f70ct0y/r5ABG7xt/dD+OPujWKV47jCuiw=;
        b=loJUwj3qteJciCTzUx/7l2EKovlEIpixceNeHLqjf1b7BhPI3V5X/fV8VgVq4CUG5x
         g0o71uCLs8P08BsqWtESJ7kaacJajBlWMvG/J6WkiMyHzKUxISlX6Wdkd1in3vhTZmVn
         N9cZwaIeefi+yoRpSuMSVPP/w3s36YsCunoYBc4UK9NPUSXDAs0EpUlj7hOZdvYW1sDK
         g0PVeDGD5+eUOIPru6j6uVo4GvjyoXP9Nfsz/7anQuMi8hxvtxrqzo+MeK5yFuPQnWkg
         LGirNSQihplkYRt2BJH0zaZKELlDzRDO0NnAewOka6sSGcL0xwduBHyucm+uAhNHfst8
         U9ng==
X-Forwarded-Encrypted: i=1; AFNElJ+EkD7Y53MRGgJ4XLWw3t9suUfd8kSaMheTYJmYFFbIZAthFRYdL/31d6XEKs2OKlr7s87nbuwcTiBgdNrV@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDxZDqWs8IwQnUv66Ht0SCn58o2IVitawdA6WyyEGSPupc42i
	fBVQDHYJ3rDuU3WnpZot3lqRSP7uMlnx8v5HLIfQdtIQ4BPyz/HZisLUvjTpwBgf9Q==
X-Gm-Gg: Acq92OHJCY7YWRRGDSvd7HihZSxB0K6idyPqwLPrarv9bOcqsGWblqaSvMO5g6zoX3I
	CYH6k85k8WpzZBIL6NfU+sZ1MlStydqOUqv2SgalGwMgdOou8CI4Fpx0V2chTQPfzMcEIiIEixo
	Mu/wHrDYguThblF/kYima+kduPLX//c2fx2iDg4a+XKXmgE+JID/YXYh8xoeqT5LwVXlDAckWdC
	Ku9feb6Ec8t/7Q7+Cb8RYMfuEkvwZCYDhQgFC5Vr/WIfL5ZQObzWsKaFIUW/1RZr1BQP3TCVSJc
	/gxTTi4q0zKBvHP43SSHBR4+tjiv75x62XOsk63WmwjjbNu31SnyA5ak5tehhBNgSVYSEF0wmiR
	pPzhf+yPZMjdrLkSdvL6puDpu8F3q1jAG4b2iZK1hAvRdtQQ9kZrlbOJvzoEkIz/RjBWCzJGzM/
	vSL0X4Asn4Q0y/GiPbw0cY5AUEGgMvFVlSnplGgNjuRVQWXDLf+0e0tTctMr1o
X-Received: by 2002:a7b:cc8b:0:b0:48f:de33:777a with SMTP id 5b1f17b1804b1-48ffd857abfmr2248535e9.11.1779122126285;
        Mon, 18 May 2026 09:35:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:866a:e549:273b:bc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3acf7sm38427000f8f.12.2026.05.18.09.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:35:25 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 18:35:15 +0200
Subject: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
In-Reply-To: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Arjan van de Ven <arjan@linux.intel.com>, 
 "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779122120; l=5553;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=djRGGOfNBbozjPnt/kQUnWI/N0nUnUMisT2sVceci6g=;
 b=bO91HUMzG4P0W1Yx2ORHO+hPa3YyNmBXkVORAsg8OmR5uNHV92gGhL0bfoVSeWZ9al1W5U9z2
 ltoGAmawz8gBzEJuWVGfPrqVR0sRvKboxFfgbs829qqeXF5kjImB5df
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Fix the easy cases where procfs currently calls ptrace_may_access() without
exec_update_lock protection, where the fix is to simply add the extra lock
or use mm_access():

 - do_task_stat(): grab exec_update_lock
 - proc_pid_wchan(): grab exec_update_lock
 - proc_map_files_lookup(): use mm_access() instead of get_task_mm()
 - proc_map_files_readdir(): use mm_access() instead of get_task_mm()
 - proc_ns_get_link(): grab exec_update_lock
 - proc_ns_readlink(): grab exec_update_lock

Fixes: f83ce3e6b02d ("proc: avoid information leaks to non-privileged processes")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/array.c      |  6 ++++++
 fs/proc/base.c       | 40 ++++++++++++++++++++--------------------
 fs/proc/namespaces.c | 12 ++++++++++++
 3 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 90fb0c6b5f99..479ea8cb4ef4 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -482,6 +482,11 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long flags;
 	int exit_code = task->exit_code;
 	struct signal_struct *sig = task->signal;
+	int ret;
+
+	ret = down_read_killable(&task->signal->exec_update_lock);
+	if (ret)
+		return ret;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -657,6 +662,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_puts(m, " 0");
 
 	seq_putc(m, '\n');
+	up_read(&task->signal->exec_update_lock);
 	if (mm)
 		mmput(mm);
 	return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..09b02d1621e5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -423,18 +423,24 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 {
 	unsigned long wchan;
 	char symname[KSYM_NAME_LEN];
+	int err;
 
+	err = down_read_killable(&task->signal->exec_update_lock);
+	if (err)
+		return err;
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto print0;
 
 	wchan = get_wchan(task);
 	if (wchan && !lookup_symbol_name(wchan, symname)) {
 		seq_puts(m, symname);
+		up_read(&task->signal->exec_update_lock);
 		return 0;
 	}
 
 print0:
 	seq_putc(m, '0');
+	up_read(&task->signal->exec_update_lock);
 	return 0;
 }
 #endif /* CONFIG_KALLSYMS */
@@ -2360,17 +2366,15 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 	if (!task)
 		goto out;
 
-	result = ERR_PTR(-EACCES);
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		goto out_put_task;
-
 	result = ERR_PTR(-ENOENT);
 	if (dname_to_vma_addr(dentry, &vm_start, &vm_end))
 		goto out_put_task;
 
-	mm = get_task_mm(task);
-	if (!mm)
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
+	if (IS_ERR(mm)) {
+		result = ERR_CAST(mm);
 		goto out_put_task;
+	}
 
 	result = ERR_PTR(-EINTR);
 	if (mmap_read_lock_killable(mm))
@@ -2420,23 +2424,19 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	if (!task)
 		goto out;
 
-	ret = -EACCES;
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
+	if (IS_ERR(mm)) {
+		ret = PTR_ERR(mm);
 		goto out_put_task;
+	}
 
 	ret = 0;
 	if (!dir_emit_dots(file, ctx))
-		goto out_put_task;
-
-	mm = get_task_mm(task);
-	if (!mm)
-		goto out_put_task;
+		goto out_put_mm;
 
 	ret = mmap_read_lock_killable(mm);
-	if (ret) {
-		mmput(mm);
-		goto out_put_task;
-	}
+	if (ret)
+		goto out_put_mm;
 
 	nr_files = 0;
 
@@ -2462,8 +2462,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		if (!p) {
 			ret = -ENOMEM;
 			mmap_read_unlock(mm);
-			mmput(mm);
-			goto out_put_task;
+			goto out_put_mm;
 		}
 
 		p->start = vma->vm_start;
@@ -2471,7 +2470,6 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p->mode = vma->vm_file->f_mode;
 	}
 	mmap_read_unlock(mm);
-	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
 		char buf[4 * sizeof(long) + 2];	/* max: %lx-%lx\0 */
@@ -2488,6 +2486,8 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos++;
 	}
 
+out_put_mm:
+	mmput(mm);
 out_put_task:
 	put_task_struct(task);
 out:
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 39f4169f669f..2f46f1396744 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -55,6 +55,10 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	if (!task)
 		return ERR_PTR(-EACCES);
 
+	error = down_read_killable(&task->signal->exec_update_lock);
+	if (error)
+		goto out_put_task;
+
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto out;
 
@@ -64,6 +68,8 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 
 	error = nd_jump_link(&ns_path);
 out:
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
 	put_task_struct(task);
 	return ERR_PTR(error);
 }
@@ -80,11 +86,17 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 	if (!task)
 		return res;
 
+	res = down_read_killable(&task->signal->exec_update_lock);
+	if (res)
+		goto out_put_task;
+
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		res = ns_get_name(name, sizeof(name), task, ns_ops);
 		if (res >= 0)
 			res = readlink_copy(buffer, buflen, name, strlen(name));
 	}
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
 	put_task_struct(task);
 	return res;
 }

-- 
2.54.0.563.g4f69b47b94-goog

