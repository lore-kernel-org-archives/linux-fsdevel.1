Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249773128C6
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357703; cv=none; b=qOOHTeK31UMF1aClrKDfq6+H5KIDO1X3dxbYjGxXvhejQrt07hoMOqfuJpazO3Srpl7g8s7R/KrMT9hoAHyBkUSaIJ9BQ3yLnJSX6uOHZ9mHYOxY8bQRzUF727x31AomI+dEVFjO5fI4pPe6IQI1l5FfZZT5iBLgnJV/b0yZ7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357703; c=relaxed/simple;
	bh=l6Rmx5K6Ntq6CFC0gtN3rxwhj+CgmxqLmk+1545M1Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azbUKkzuzgtpQe35vtcW0YcCZQHHvTah69jYtXu1DYaEsGmKD9SYjcJgZuAAjcE+/2l1D3L38YaQB+ANCTv+//12PJO3jthcP9/rLmNN6qJhY/DvylvDOUVBw2y/0ZI6Aw6A7jJXMKl+zb08pI+pmvgCOSq0T6xe0yCsp5qK68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHpLXKX9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHpLXKX9"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d572f7437so5177562f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357701; x=1776962501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld46oPO3p3ufmRzPskilBxxvzozvgh7NzEXkq2AckD0=;
        b=DHpLXKX9vXG+9w/83OzPVtJ1ueFO/opx6D7v08YWyqxwNQkA7eTP4tdJG+AmlOHRcn
         LF4N/94A6T92GvvLN0rDAjEXWMQojR4XOSipj0vAUCi0NLfwrN4AxdfPmUN0LAoLUB5h
         0U6ZP/WOF6+ysJc09UZsfDVLkSZFnUlyJXlGGMaV9lkjdYc4PLEjjey5otOfLM1ZvXI5
         6LglUUv97uBqyde5Ynvc/EbqXoCV+Gj+cwtUZAVhlODjVCdVDalOVBacQKVHLTIbQJTl
         wH6T66WEQkE3xrhv+Is/+G8HLP6HfMsyqlAmUqowU6/u8TzUQcawkUp9a0fQbizajb+J
         ESOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357701; x=1776962501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ld46oPO3p3ufmRzPskilBxxvzozvgh7NzEXkq2AckD0=;
        b=aQ11vz6PVrjsvQH/ipnHU+vxALp9yF7azCLnN0CxsDrhcJIsY8qxaSgcDxR2OPA15b
         98VohM2n98nsHb1Sqw5ztXj0ywUAQ0PXTfvBJycHikWOdO8yYZTM/X0FCxVtLRNf3yV0
         MRY7harBmeU8XZHUHg2FvG9jOc8sKouP/R580ptLOp5YB/GWgzhE77PGS+XXDPDgcThO
         jGPusEzJy0m6oXUULbXL7czkneMgs9WW1qweRn5VQcwN9zJKUqxHO8ceKTRdtk1j4p5v
         4/l116ov8eZLPKJEQUrL5RGzVg7cXCLFboU+rIHy0dGfcIOmWLY9n4kIhVXvW9ZDn4VZ
         t2fg==
X-Forwarded-Encrypted: i=1; AFNElJ8+IFfpurp61lKtbByYC+Es/hKY6sPeLtEoiLICNnWzRJ3PPRCK3X6L3J6V+XE/cobG9crgn9jkC6VnkzWU@vger.kernel.org
X-Gm-Message-State: AOJu0YzYegP/z3iRc5QrN1HaqQOF0DI4Adr9xUlMM8KOTJZ0807DayLv
	zM8IFNNDXt9T0gsRlBdMzEaTmbDIh9BDyEJMAwb7rztlITOSFYFmvHQ=
X-Gm-Gg: AeBDieuGD/BfMlEKmkbozt2jezvF1mz7UIoSgvXfD9sRpICZig2EQgbcWjZKu41JwT7
	PJDSAerJ+7x2bm06mqzikp8qPJb5AGqpheDi12dGOmuUqpvNq5yEwjzuxpiuSe2QLmh5FZDs/Dm
	Ck/GOOnYmc9fHK3augWFzHXUDY3DGUvmwa+1YSzAFbUS5gnyKKST5pvbqn4/4p82GFkbuhX/Fl0
	u3eBLrQ8HPhCQe6t0H6dx3wCP+od0/VsWvc3AxgCjplxh3XiumSWI3xn8AGC4FZXtZ2kwJcNu06
	Px+G4brXkOfAbhxb+VFmw6SzdnOVRT5pg/fdbm+nQBz6CTFOjRXlVHQKvg/p+E3T5suTxkY1iUe
	tukQBk93r/7yBMqU5wpdqxjJDTO4Ut4aLQyhufafIOyeuYhwkrMxd7oFF6vCoPb6+H5qf3qaW7e
	+kMwl4bsurEvh6mKiRnaA2azQ=
X-Received: by 2002:a05:6000:1446:b0:43d:77a8:3bb5 with SMTP id ffacd0b85a97d-43fe15a2942mr102540f8f.37.1776357699373;
        Thu, 16 Apr 2026 09:41:39 -0700 (PDT)
Received: from p183 ([178.172.147.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead402ee8sm14843662f8f.37.2026.04.16.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:41:38 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] proc: rewrite next_tgid()
Date: Thu, 16 Apr 2026 19:43:30 +0300
Message-ID: <20260416164330.77043-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416164330.77043-1-adobriyan@gmail.com>
References: <20260416164330.77043-1-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* deduplicate "iter.tgid += 1" line,
  Right now it is done once inside next_tgid() itself and second time
  inside "for" loop.

* deduplicate next_tgid() call itself with different loop style:

	auto it = make_tgid_iter();
	while (next_tgid(&it)) {
		...
	}

  gcc seems to inline it twice:

  	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
	add/remove: 0/1 grow/shrink: 1/0 up/down: 100/-245 (-145)
	Function                                     old     new   delta
	proc_pid_readdir                             531     631    +100
	next_tgid                                    245       -    -245

* make tgid_iter.pid_ns const
  it never changes during readdir anyway
---
 fs/proc/base.c | 57 +++++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f2db455dbbfd..f38ac943ec32 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3543,30 +3543,43 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 struct tgid_iter {
 	unsigned int tgid;
 	struct task_struct *task;
-	struct pid_namespace *pid_ns;
+	struct pid_namespace *const pid_ns;
 };
 
-static struct tgid_iter next_tgid(struct tgid_iter iter)
+static
+struct tgid_iter
+make_tgid_iter(unsigned int init_tgid, struct pid_namespace *pid_ns)
 {
-	struct pid *pid;
+	return (struct tgid_iter){
+		.tgid = init_tgid - 1,
+		.pid_ns = pid_ns,
+	};
+}
+
+static bool next_tgid(struct tgid_iter *it)
+{
+	if (it->task) {
+		put_task_struct(it->task);
+		it->task = NULL;
+	}
 
-	if (iter.task)
-		put_task_struct(iter.task);
 	rcu_read_lock();
-retry:
-	iter.task = NULL;
-	pid = find_ge_pid(iter.tgid, iter.pid_ns);
-	if (pid) {
-		iter.tgid = pid_nr_ns(pid, iter.pid_ns);
-		iter.task = pid_task(pid, PIDTYPE_TGID);
-		if (!iter.task) {
-			iter.tgid += 1;
-			goto retry;
+	while (1) {
+		it->tgid += 1;
+		const auto pid = find_ge_pid(it->tgid, it->pid_ns);
+		if (pid) {
+			it->tgid = pid_nr_ns(pid, it->pid_ns);
+			it->task = pid_task(pid, PIDTYPE_TGID);
+			if (it->task) {
+				get_task_struct(it->task);
+				rcu_read_unlock();
+				return true;
+			}
+		} else {
+			rcu_read_unlock();
+			return false;
 		}
-		get_task_struct(iter.task);
 	}
-	rcu_read_unlock();
-	return iter;
 }
 
 #define TGID_OFFSET (FIRST_PROCESS_ENTRY + 2)
@@ -3574,7 +3587,6 @@ static struct tgid_iter next_tgid(struct tgid_iter iter)
 /* for the /proc/ directory itself, after non-process stuff has been done */
 int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
-	struct tgid_iter iter;
 	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
 	struct pid_namespace *pid_ns = proc_pid_ns(file_inode(file)->i_sb);
 	loff_t pos = ctx->pos;
@@ -3592,12 +3604,9 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
-	iter.tgid = pos - TGID_OFFSET;
-	iter.task = NULL;
-	iter.pid_ns = pid_ns;
-	for (iter = next_tgid(iter);
-	     iter.task;
-	     iter.tgid += 1, iter = next_tgid(iter)) {
+
+	auto iter = make_tgid_iter(pos - TGID_OFFSET, pid_ns);
+	while (next_tgid(&iter)) {
 		char name[10 + 1];
 		unsigned int len;
 
-- 
2.52.0

