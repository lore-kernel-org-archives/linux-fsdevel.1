Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9062521225
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788996241; cv=none; b=X7aerNlGxGG66/z6vZbO6LAzZ5bEB11oTtGMV9v/OrRbenS6aa3pNpDpLlgcHPMAKj4J/i0f1kyaCitJ+jCJAu6cGH3qM9PxPIZSTx0a9LB6ezmJv/r5U4NJH5SsFHH30xPSUvHBuo8hYUiYo/51HybneSWAC9JsOLqvJnv1xYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788996241; c=relaxed/simple;
	bh=SFcGPCTIsPFMlNPNeBbLx0ghqzJJA5xJv+EVBSqQNpw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mAcoGRA5yHI9Rgr1KS5dN7EkulSI0vwoA2Uws5qmsRm/e2RiaNOFcMSAY6v+pTZOvffu8m1hhnd9X+K+CpbjYdnEf9yruIbUOlbdO6DQJwKBsKpjhWwLsagfgruL7qgznbLX/bqC8OftUrfAenB2WDnR8R1Kn+1QjSjhNzLWKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shayba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9qDuc7d; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shayba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9qDuc7d"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so8580880a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 16:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788996238; x=1789601038; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i/IibwXTNGnPsm2Gao34Cgg+5xpN5gHK3teielaz1Co=;
        b=Y9qDuc7dOkqCZDO+Rjmgk2RQT5BlT7CFkMMCMjkzi6lUTpkNydvxHS8H3w3WXESEe/
         jAkDrmrCXWlGdpPfOnJIMHrGUs+8loNAK4mH7bKUD4UceHZ/YkkGRv+gLhxLBE36ATgQ
         KmZo2FrIa8y4GHL2OtSRAAoTttGc5vJBOu6dY8cDWROKgLkyylDUSETZp/YmZ5mnkCzn
         J4GGbXAblnznt1LYQJpdihr36L5u0yCrq+oBP4yoW7purxrs7v1xlNQNBMnwyxSRw8E8
         xQO0zl28dphXnJDFpDOM9Q1saE7X6SJqIvBMgBG6TOLuMEYcmxzaxWIE/y1xYjWq0sOx
         ONbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788996238; x=1789601038;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i/IibwXTNGnPsm2Gao34Cgg+5xpN5gHK3teielaz1Co=;
        b=X2riooqvuQT6xP8c/ckZyYzQJCsowxksJKEfS58Seu+M8fxycbMswq9cqYp6SWZRMX
         lbi+i7ZRNZShSMjenLjjzErI1BqsiCiaciWjNqB8yNWTVzVAARdcUkZOrY0eKC83/MkA
         5ab1sUqsrySGTdjGB/YaNhwki6eDLKJbr/PkaXkV8KF9WM7HKos9CtbeLelKlb08TJ/n
         7HuamM/r9XzS8iU+/OFDQfPN91xIxTG/J35ibmhz+5+9HVNEi+Ca0DuKNVMjEw4bC3/n
         EPHwcPP1c3okA/YtRWLIkuZme4gVoGiOcUaygbaPs14ZKkCsUDDOdp8z+f56rRdzh8UT
         l4+Q==
X-Forwarded-Encrypted: i=1; AKwUvByovc8jx7O0bzZGhM1bqMOLMzlYL5n87IBPrFbGqENUQ9IC6tAlnEalj/REq5yWREUVZONtG1s4HlsjYk9z@vger.kernel.org
X-Gm-Message-State: AFuF++n1dMiiQVWF0jgQ0BVeHEEmsdAUe74A3nA5YfoVydA88MZ8UMfH
	FLDN5Udm/+X7MEo5LX750TZyAXnx4JksovlwboeUu9M6NKrrVmaqve2T4wO53avD/XK368MaZOS
	TzxCXhg==
X-Received: from dybgz3.prod.google.com ([2002:a05:7301:2603:b0:338:508a:ac2b])
 (user=shayba job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c86:b0:395:5f43:4ec4
 with SMTP id 98e67ed59e1d1-39b25f78ab8mr53847823a91.0.1788996237266; Wed, 09
 Sep 2026 16:23:57 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:23:51 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909232351.1533034-1-shayba@google.com>
Subject: [PATCH] fuse: Forward vfs_fadvise to backing_file in passthrough mode
From: Shai Barack <shayba@google.com>
To: shayba@google.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, Sandeep Dhavale <dhavale@google.com>, 
	Akilesh Kailash <akailash@google.com>, Suren Baghdasaryan <surenb@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When an application invokes posix_fadvise(..., POSIX_FADV_DONTNEED) or
other fadvise advice on a FUSE passthrough file descriptor, the VFS
currently only executes generic_fadvise() on the upper FUSE inode
mapping.

Because FUSE passthrough does not forward fadvise operations to the
underlying backing file, pages residing in the lower filesystem's
pagecache remain resident in memory.

During media-heavy workloads (such as image thumbnail generation or
streaming), single-access file data accumulates in the inactive pagecache
of the lower filesystem. Under memory pressure, the kernel retains these
stale media pages and instead evicts active executable pages from
running processes, leading to severe direct reclaim latency spikes.

Architecturally, Linux VFS supports filesystem-specific fadvise
delegation via the .fadvise hook in struct file_operations. Implement
fuse_file_fadvise() in fs/fuse/file.c and register it in
fuse_file_operations. When passthrough is active on a fuse_file,
fuse_file_fadvise() forwards the vfs_fadvise() call to the lower
backing_file under the opened credentials, allowing POSIX_FADV_DONTNEED
to cleanly invalidate the physical backing filesystem pagecache.

Signed-off-by: Shai Barack <shayba@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Akilesh Kailash <akailash@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/fuse/file.c        | 11 +++++++++++
 fs/fuse/fuse_i.h      |  7 +++++++
 fs/fuse/passthrough.c | 16 ++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a4d736945..81709ab82 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3537,6 +3537,16 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
 	return ret;
 }
 
+static int fuse_file_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	struct fuse_file *ff = file->private_data;
+
+	if (fuse_file_passthrough(ff))
+		return fuse_passthrough_fadvise(ff, offset, len, advice);
+
+	return generic_fadvise(file, offset, len, advice);
+}
+
 static const struct file_operations fuse_file_operations = {
 	.llseek		= fuse_file_llseek,
 	.read_iter	= fuse_file_read_iter,
@@ -3557,6 +3567,7 @@ static const struct file_operations fuse_file_operations = {
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
 	.fop_flags	= FOP_DONTCACHE,
+	.fadvise	= fuse_file_fadvise,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 939553b34..50073e070 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1545,6 +1545,12 @@ static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 static inline void fuse_backing_put(struct fuse_backing *fb)
 {
 }
+
+static inline int fuse_passthrough_fadvise(struct fuse_file *ff, loff_t offset,
+					   loff_t len, int advice)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 void fuse_backing_files_init(struct fuse_conn *fc);
@@ -1575,6 +1581,7 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 				      struct file *out, loff_t *ppos,
 				      size_t len, unsigned int flags);
 ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
+int fuse_passthrough_fadvise(struct fuse_file *ff, loff_t offset, loff_t len, int advice);
 
 /* backing.c */
 
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 059e57969..8062110dd 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -382,3 +382,19 @@ void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb)
 	put_cred(ff->cred);
 	ff->cred = NULL;
 }
+
+int fuse_passthrough_fadvise(struct fuse_file *ff, loff_t offset, loff_t len, int advice)
+{
+	struct file *backing_file = fuse_file_passthrough(ff);
+	const struct cred *old_cred;
+	int ret;
+
+	if (!backing_file)
+		return -EINVAL;
+
+	old_cred = override_creds(ff->cred);
+	ret = vfs_fadvise(backing_file, offset, len, advice);
+	revert_creds(old_cred);
+
+	return ret;
+}
-- 
2.43.0
