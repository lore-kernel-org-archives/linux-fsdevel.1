Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B189E36A03F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005618; cv=none; b=lOoTtPs7ZLSxrny0GC+e9PR9l3Pzb+87b7kL98FlS9mlodP6hudYzHkKLPAl4kuza2VPQ033XKZiYCuIZ1lJA7PPIeeLAtoa8gs90m7nIMjjYMHovvjxxm3EecD63fHK299RjKerjbTEtrZD92iqK6WzQy71VSIt0L3oIpm1FSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005618; c=relaxed/simple;
	bh=ewchwNOJSoKlJ9JagQs/kTQULWbRvWajLmzGwT+tl6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IwZNvyKE1aOUnnVZTNriJeDKEXfYKuNmGhq/mHn+ulIKKvftSPn7+djoDPDWdoYwQoDWp8kDQajKP0tSwWoMgTRWdkgszi/YE8bFglm+p5JP2sp2wRpXBuAhiHvxUWAVpb0k3gM2ZiDcfOEKj+llqgR4maE7HtH9lULgJ9VBphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shayba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIiIImpL; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shayba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIiIImpL"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-156b5338d4bso1250826c88.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792005616; x=1792610416; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aECaE+DbTs0zA1//hmy17ogzl4KfVyvhPwgQUxqIw5k=;
        b=tIiIImpLxnWNmnjg0l29baonjolJPaNbKmCPGEa7+i5NFAjhPavw5DM9oY0xWykxne
         C84X1hMeAZK+LLwQI379ijkNeS6kRxewAxz5jM7iHkZVFe4NsX3ss+h1ddXa4LPgNwMU
         cJImnqrpUmMfL/LwSjcV8vG2nbSOrat7fhAi7MnEGl4XWZt8fRHxhvSKWMTlvQ5wH1vg
         Feae+vo/YN7IgB2UiftQrXQNgRQio5Nm/SsgYIWLFsAbqSLGjyN23KFu2y3kIT13X7wG
         gV0NjPhoppZmLIKntk1udOEpMjoLTSjBiA/cKSJmSwOO+SIOa+jq5X//mvYVpvDxMKNQ
         LxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005616; x=1792610416;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aECaE+DbTs0zA1//hmy17ogzl4KfVyvhPwgQUxqIw5k=;
        b=CkOFLqF+/Wi3IGwv5Uu5Nk5k8c5g/gyF8ZxnaQBT/ZF4bREuuGXWqMWEZ6TMeKB6YY
         kgcNYoYUVVSoUC6AlIu9kHOjqhKVXOj75Yun0iImG7ZmECJS2am0BQntDs5DvJGSQANE
         RVk+8XM1Ai+u7uyY638x6s/3hLwekkOUR3NnBxVr9YLrE5WrgrdNRzRWgtxPisNqsCgg
         j8ciQP3eD0ofNDSx3K1zA6PfRKAwirxVUHA8iR6kBO2c4QzmF9+vmPNSRSpd+pv327SU
         UKlOpW1p/Q2CDnz72wv+ry4h6BaxEyWg/GNrW/82YsUJCuYoJz0G0gDIBC7630p5NLBL
         QT+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzbh5lhJ4yh2gB7WYPnrOE/FO7s/rexNc8L8sq4GkGEnj46ng0zCCYl+FOwrm6pKqnbf7uLZWNUeSgAgcmt@vger.kernel.org
X-Gm-Message-State: AFq9FYKaNsVSw+yz9D+xKc+CCIbE5MeKw4bFfKkYiXuISsb/SHtDdg+i
	BawgDh1ziQPau+z55xV+q//Geuy5nc3fMb1X1W17BfAgONcAqzcA2EFY+Ek/qzm3NFT1Uckyqt+
	dbbEdBA==
X-Received: from dldyr18-n2.prod.google.com ([2002:a05:701b:4512:20b0:168:3bc7:9e8])
 (user=shayba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:5f14:b0:168:6ad8:e89f
 with SMTP id a92af1059eb24-16a56c9dd9dmr21867195c88.3.1792005615123; Wed, 14
 Oct 2026 12:20:15 -0700 (PDT)
Date: Wed, 14 Oct 2026 19:20:14 +0000
In-Reply-To: <20260910184424.156341-1-shayba@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910184424.156341-1-shayba@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014192014.3373048-1-shayba@google.com>
Subject: [PATCH v3] fuse: Forward vfs_fadvise to backing_file in passthrough mode
From: Shai Barack <shayba@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, 
	"T . J . Mercier" <tjmercier@google.com>, Sandeep Dhavale <dhavale@google.com>, 
	Akilesh Kailash <akailash@google.com>, Suren Baghdasaryan <surenb@google.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shai Barack <shayba@google.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Shai Barack <shayba@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: T.J. Mercier <tjmercier@google.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Akilesh Kailash <akailash@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: fuse-devel@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v3:
- Rebase onto fuse.git for-next (commit bbe2d73a8231 "fuse: don't assume
  ff->passthrough is set for FOPEN_PASSTHROUGH"): use fuse_is_passthrough()
  in fuse_file_fadvise(), take struct file * in fuse_passthrough_fadvise(),
  and fall back to generic_fadvise() when backing_file is NULL (T.J. Mercier)
- Collect Reviewed-by tags from Amir Goldstein and T.J. Mercier

v2:
- Remove redundant !backing_file check in fuse_passthrough_fadvise() (Amir Goldstein)
- Remove unused fuse_passthrough_fadvise() stub under #ifndef CONFIG_FUSE_PASSTHROUGH (Amir Goldstein)
- Reorder fuse_passthrough_fadvise() above fuse_passthrough_open() alongside other passthrough ops (Amir Goldstein)
- Add fuse-devel@lists.linux.dev to CC list (Amir Goldstein, T.J. Mercier)

 fs/fuse/file.c        | 11 +++++++++++
 fs/fuse/fuse_i.h      |  1 +
 fs/fuse/passthrough.c | 17 +++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6d707f2..6e6136e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3100,6 +3100,16 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
 	return ret;
 }
 
+static int fuse_file_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	struct fuse_file *ff = file->private_data;
+
+	if (fuse_is_passthrough(ff))
+		return fuse_passthrough_fadvise(file, offset, len, advice);
+
+	return generic_fadvise(file, offset, len, advice);
+}
+
 static const struct file_operations fuse_file_operations = {
 	.llseek		= fuse_file_llseek,
 	.read_iter	= fuse_file_read_iter,
@@ -3120,6 +3130,7 @@ static const struct file_operations fuse_file_operations = {
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
 	.setlease	= generic_setlease,
+	.fadvise	= fuse_file_fadvise,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8546855..49b3101 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1316,6 +1316,7 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 				      struct file *out, loff_t *ppos,
 				      size_t len, unsigned int flags);
 ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
+int fuse_passthrough_fadvise(struct file *file, loff_t offset, loff_t len, int advice);
 
 #ifdef CONFIG_SYSCTL
 extern int fuse_sysctl_register(void);
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index b43d3e0..2d29ff6 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -148,6 +148,23 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
 	return backing_file_mmap(backing_file, vma, &ctx);
 }
 
+int fuse_passthrough_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	const struct cred *old_cred;
+	int ret;
+
+	if (!backing_file)
+		return generic_fadvise(file, offset, len, advice);
+
+	old_cred = override_creds(ff->cred);
+	ret = vfs_fadvise(backing_file, offset, len, advice);
+	revert_creds(old_cred);
+
+	return ret;
+}
+
 /*
  * Setup passthrough to a backing file.
  *
-- 
2.56.0.385.gd3acb90ef8-goog

