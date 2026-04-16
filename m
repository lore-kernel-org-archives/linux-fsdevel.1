Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C02E06E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357845; cv=none; b=poKBErpN3GEjBY+NT5+i0rq0joXv/Ds5c3GPjnPCX7eHWVf0XLmi80vIR6uZ5hfUrKAWzR/pGpNh+JUi6VMWHonVrnbR3Ig5bvnSMKq3haDyW004ouivZF7Mnp7rT+nIESVl0Xl/KAgwT4GbcdnGcUnWIjLXiKHr0eHgviuvF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357845; c=relaxed/simple;
	bh=l6Rmx5K6Ntq6CFC0gtN3rxwhj+CgmxqLmk+1545M1Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8aOAINPSWa9zrD5Ae1zjGQVbw1s9rbRfiF9ZcjtKXlQyRQS+ejSu74xxlU6LUl+hpr929Kx+GUX8ZuTLBuyCjwHceCmnK7aB4B03m58RkxQvxocpfTjACjUeOFQRX8ypcnK+lN1Xh25AOuxN/I2Vgk++eQWjIj9GDj2nG6aOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7KCmRl5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7KCmRl5"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b8efed61so9835055e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357842; x=1776962642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld46oPO3p3ufmRzPskilBxxvzozvgh7NzEXkq2AckD0=;
        b=Q7KCmRl5rmnFFi5YdwpnASeuwNStpOKlyc94bvS1K1fQF7MM1ELJ7dmLng7n+Nbp04
         r+KQB8G55GeFygypnIPRoNsjER2V364yyjPYiUxPrC5Rke9ubzrzM7hXS01tELnEk8T5
         H/Jp7Ge7EmXFsqO4ZtvCjzmIrdrdVD+/9/H0JuObqS/hnxe3S2dtw0eD2pi2XFvaOnYB
         bB7+E7Zc7TCaOcfagE3T7Je8oAzwRG1l2r6GbY4/IBTyIdCw8/iebRBUS2vnziiaIDdL
         yCXvAps9lR0Mc0JCIXtXI5YFFTnRoJ74D1WTfgohKO8MHVupE45XsRtBCLNx21OW4lCP
         +1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357842; x=1776962642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ld46oPO3p3ufmRzPskilBxxvzozvgh7NzEXkq2AckD0=;
        b=nxmijRFrzXcjovCzV4IbABHU/fWN/96ckNu92LZOeEaMePlj/O2y+Afq+Paym/fjd8
         o3KHTqjnVW/fp5wWHdvNt5KWayZ7kudPeL2ZSA7BVFFD/G29XiM06Z7BO7BItNRvohTd
         ZqsZ19zx1lHjnw5vc5BuceV8E/8nBOCfYFYY2PNhW34xLC2VX0e1yesTZrciYhESh7oA
         FMUW973r0i4eCbwhi072O8Lj4Wmwgm+Gh8PjNHOXXrv+rNR3r7aLcGRkdE5DPHIYGoKS
         XTm+uLAK9unNHUrS3u9O+PnPBOpVVXkk7lAcWXZIoK+XI4mwhl3ZoKvtvqAHzFo/YpsH
         XERg==
X-Forwarded-Encrypted: i=1; AFNElJ8vQM+siazRybDiXoCjZxUBZYn80tkTW3bhlvxTYeugz+UfX4q4/1gKCf//DugYL/bBNMgvunZOHB881+8a@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsAonU4UZ+BYv587aOVbCd+iMy4HosnKVXlLAPdXV2gVKYwuR
	I2887nF6a0B9hKPFvSbdEPTLcpTckIgo7eqMY0u3w8JgsHsVdADr1x0=
X-Gm-Gg: AeBDieuowkHfaTf/TYYBAAejTpO/6xSqW52YlEvnlm1d7qH/5VYrUmWtbbS4ChdqD0q
	82tvng84e9gJd0ihRTj93eH6zAjxmNtyC+nmMamvLZFe5SpQJ+gfOocZaI3VymEj457WI8JbNHp
	93FJUk+THCop2T1EUxSbU+ku9LjQJsjcZTw46VLl1DL5tJXga8PN82dOyYDmn5Ijaky6udaZDuM
	ZyE9bXApZJs6PsCioRfQQGNgsYPFo7xjkPL0MZNUEcu38pCXTEScFRxb9Fjw+TpGXhzJJlpJCwS
	b3U0vBtPXYt94zZ+9+UkqwXAt0VN3ggCCx3YPhknPK9O8M1ftKMRcEFZyMC3MDp2GZVXeg9m7sJ
	wi7neOuBBSthzrtalwKHLvBe30JgCULQ+jLW+inS6sBKp0qJW8xoKDAFnhitDW2KPQWygpygdmd
	ylaIpnoaB30ig4F3sqDzBrBxQ=
X-Received: by 2002:a05:600c:a40e:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-488f480c2c5mr52836345e9.11.1776357842417;
        Thu, 16 Apr 2026 09:44:02 -0700 (PDT)
Received: from p183 ([178.172.147.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f58163cbsm66810835e9.1.2026.04.16.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:44:02 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] proc: rewrite next_tgid()
Date: Thu, 16 Apr 2026 19:45:55 +0300
Message-ID: <20260416164555.77430-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416164555.77430-1-adobriyan@gmail.com>
References: <20260416164555.77430-1-adobriyan@gmail.com>
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

