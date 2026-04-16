Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C530EF7B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357701; cv=none; b=iJ0lcnZOfZqXqHLq83WSgJXEtSxccMV6x7atnlMEdHJFs8Wr06+l+l12Kv/rUxn/Jsk3mCykokf6Q1KIizHEj2HJgHmoyFgoTqDZEVS9pEH6As0md+pBqlB0grPQiHsxtxndM/U4ukGOGy0dmtmlaRcMs/7T6684sjR2f+KaO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357701; c=relaxed/simple;
	bh=n+D/Dcp8WAjTCEeW11ShWwxcgK67nFg/1lgxgzVfjDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOhTUFdpck0qmt+HXW4ph3E9zwmT1TNJREd+/DK81JatzOqoQ25oLgo6meoy0YX9D9VihBafSOoa1XR+RNkyiZujNu9NOsN0ksBpqVv5SrFfdCI2lvU1CqPAJ19KPEWyWuZLbX9dO/uYcFX2/nTC60SmkX2mIldsBKGbqlVajNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6grP2zM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6grP2zM"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so6453025f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357699; x=1776962499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIa43lbzdcbvCbtrNCFTDN2DaMvs51Q6LIwAUTCP1A4=;
        b=O6grP2zM87IGqJee3AzjUACnkwPGerPRawt/JM1f+N+pQ+1kLMvAD8zIatTtJ+23ti
         47dvracuI8D+z2W2gkPJNusiQehZuvVU1wrC6uFJDZcSPnQTDZH8xMYjf02bAbJnFvRj
         LacoBvFhiShw9Vu7ZKQV2/CYOeVQt0YJ6cLKYjCUxpf2nN+FKU0MgFcX7riVpyB13+yy
         bphdetmxQvPksRX1eJ0pWBhTWHwZs0K+pi3VMFJz2qGyiwMn+NHnnRsrOPrzf7GuK6gb
         IC90GR/j8PLRL+YBKiPnBuDX58MlrQYtcSz6Djd1fh/pvMVsQxxp9MJtVQfHbGtZJl91
         RZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357699; x=1776962499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIa43lbzdcbvCbtrNCFTDN2DaMvs51Q6LIwAUTCP1A4=;
        b=P8wiqZ4U7jzvLYaVw5K1qi+uYcrxOZfte0eqwIMTfnpXjiite7kmKonIWYwaty1N+Q
         QmxzlhnKhgU+5d6HZJ2O8/FSrC7kiNnHrCuW/wO9r1rDF6rMe1hGSE/x6Fw8nmPmflIw
         xqsJVA7ddJUOrx3vSbwr0i/wbCxrNB0ObuIwQ+1Mp1oTjE+DfVxMU/5sRvgO4/sF6mzk
         WRz/n3xx/9iTBpk8egHkSQcKZ+8NAxsbwJj34jYwtYZWfAqjyyVkaonS4lgZkGedTE7L
         tg9FmBTEtNWWq4CSACMmH5RNV5U2dO0d8g8lSWk17/q9p2gg5uaTPTVEmpt5341eyOF3
         x8OA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZNTphbvUCzKOQ1E4jR79+0uExOPI2lJ6daKqx8mPciXtTTUfO7JAsou9Y2uEr+81csD3s98N6CB+LxSPT@vger.kernel.org
X-Gm-Message-State: AOJu0YysWbiyntkWjuwo8HTeBPh3HOiEts/Y/dkYb2v6T8GXUmOkwNUE
	2/33CdJPQatiHry4jEOmyMWO0N6wUG1qoo4QRZgG2I3xRSzSFpEiyug=
X-Gm-Gg: AeBDieu9Yd58A27FVU1ej4aF6WPrqliPUYUwamwoDVcHTEr2ZqbF7zoc0LvFiWlPkJq
	TapVKv4DxO/Ft8bm9S+qr2YJmBh2ms68FguH2okbxpQQK5rJKGdw2cFB7pYlUu86DooyOCHqbQt
	RYQQP+g7nkmOkEQoK3vElOAyRVLRhnKZhXqWkjMIvYKzs3VHq4AEqos6chOXy3IhIVoxAH609El
	ZT3vFYt0dl4FonBG+GVu8CRswOrFY9DxTpftTmg0KPX6KVAn6x1dxUIzH4WT77BdbWbEg36eehA
	ueSXwJppKWtUdfGC5fFoH2t/93RQHEArnFrms+3SxaGRa2Tarsb+HmHX0s1lhxzwKrbtqQG98mJ
	F8FbjU8ThTSTX6IyCH5c5HBV7+Wg6rr6E1ua4r5x6D3hwa++0ErMiJ0DgldB2NLgjzc0SUiipPU
	oGGs+j1PYfq87QoEjxaSyyuEg=
X-Received: by 2002:a05:6000:1841:b0:439:c62a:6dc2 with SMTP id ffacd0b85a97d-43fe16a4990mr98493f8f.41.1776357698482;
        Thu, 16 Apr 2026 09:41:38 -0700 (PDT)
Received: from p183 ([178.172.147.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead402ee8sm14843662f8f.37.2026.04.16.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:41:37 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] proc: add tgid_iter.pid_ns member
Date: Thu, 16 Apr 2026 19:43:29 +0300
Message-ID: <20260416164330.77043-1-adobriyan@gmail.com>
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

