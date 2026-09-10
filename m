Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2C585982
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066578; cv=none; b=VTOSuE4MOmnxOyzbezK7LAJGt+tylzD6pkbpyYo3gikqueRGN0CW7eyw9qQ+l3M/mBdK4Fpmj6yCZRsYWJZFaemxwZXIB5VreeXVVQAftp+CXnGI6ayEyNXv6Acd+l7ZU3k0xkBUJt33dH8UEtsbpmLK+ihG5NcEvLbTlfRsePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066578; c=relaxed/simple;
	bh=ADY0E/FRYWRHk7Nt4TCtye/O+NyvQw/YCRQZj37EZz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bgIQRGxWEM9i7RClT7GCy/mdpGirx6wBXi5HQw7Yl3Ayoj7IAraPgtJS7kU/sURfyvGfxFe4b5xqnTcAsh3/2Q5yOfgGvDbFypEC/As2xiHYvGgqLWif6V4ZzHaUDiLoGAul/Td3V67yMB+vnzg3+veABl1zD3M9c5IhzzlWBss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shayba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lchHCQ8C; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shayba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lchHCQ8C"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-399311947f6so121520a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789066576; x=1789671376; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAhSPIEvBmS+PCKcxa/XH9lFSCc/+FANgNlh9nivbso=;
        b=lchHCQ8CgLkxGuhndPrDWwSlfLHXu0H776JFB860mkPF40Ndv4BYaob0EPa3ACgaxX
         o9yTzVrjKHr/8zpIrrBn4HUKglgYsvJxubbDWb8pFQ4tVsgmy1BWN4D2W8jlb5rmsYLu
         Vx7KaLgiSRPLoRjI8Nmpst+ZbDYmy7FSMnwigrG05C2zMij6dpxbvAT2xpTp7jKFZiZn
         7Q00srPBp+7OpFsS/GTYJ5lNTWRx3M2t0w/xcBoenCzC0Omsc2SvxJoHCaVyKbPbHuV7
         brHRnKSdXAEUiymfX+gdcyBC+KDsaAHMsU/o/oscOBs2NxsUJJ5v6zrzhw7+pFAG1jIi
         nJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066576; x=1789671376;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fAhSPIEvBmS+PCKcxa/XH9lFSCc/+FANgNlh9nivbso=;
        b=Rxp2DpnWqGqKrrM27tl8h7A9zw/o/a9bj7qp1KqQE+dhfHQoGGjmPSZsUcecqY4EgS
         UrUa0FD1aQKya/eDVR1sQdXSeyGQVT0G6djrGPdyXh784O51HG6YUJzAAcSfa880Xo7v
         QG+VzD0VX+OGlaXp948a8eKjXZHwweOgcq6WbEiMYAqWvgztbY4x+QEt2zIXGzkzAQyO
         fXOFdUPrVRZc/G26Plj3d3A3/4ubn5sDe0MZXVjCafwBnp3vip/oobmZPp4uIG/kppsn
         FnKgZ+BiJkVSTsM/XwJrHHXHf1xE5iQYlkVYjue1ZUZVD6SJ5KS06GhHPfRrn6+oxP4R
         Ws/A==
X-Forwarded-Encrypted: i=1; AKwUvBxL8WlpSJutXWduQtsdYjoxjVcsJaPf7bDySC6KzNUjOxzRdH7BafoS/OHgkPzm598LW06yZwQIPR1rQPUP@vger.kernel.org
X-Gm-Message-State: AFuF++nSBgxzAiPdRhtQIZ3o6DwbNeWunf6tzcbk8TEHwIVbwl4w84h9
	DSaMMg3KwcMrtIAuy+4qqzjLNOck3a/Py7Lxa2O4dfdi/sK9TtpgtLW0TTMk8aC6Y/iV6pGd5fe
	nbCyxfQ==
X-Received: from dld34.prod.google.com ([2002:a05:7022:322:b0:142:e0f7:1a4d])
 (user=shayba job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5287:b0:398:9bd5:490d
 with SMTP id 98e67ed59e1d1-39d9c22e224mr103903a91.20.1789066576318; Thu, 10
 Sep 2026 11:56:16 -0700 (PDT)
Date: Thu, 10 Sep 2026 18:56:14 +0000
In-Reply-To: <20260909232351.1533034-1-shayba@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909232351.1533034-1-shayba@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910185614.262511-1-shayba@google.com>
Subject: [PATCH v2] fuse: Forward vfs_fadvise to backing_file in passthrough mode
From: Shai Barack <shayba@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, 
	Sandeep Dhavale <dhavale@google.com>, Akilesh Kailash <akailash@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, fuse-devel@lists.linux.dev, 
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

Signed-off-by: Shai Barack <shayba@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Akilesh Kailash <akailash@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: fuse-devel@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v2:
- Remove redundant !backing_file check in fuse_passthrough_fadvise() (Amir Goldstein)
- Remove unused fuse_passthrough_fadvise() stub under #ifndef CONFIG_FUSE_PASSTHROUGH (Amir Goldstein)
- Reorder fuse_passthrough_fadvise() above fuse_passthrough_open() alongside other passthrough ops (Amir Goldstein)
- Add fuse-devel@lists.linux.dev to CC list (Amir Goldstein, TJ Mercier)

 fs/fuse/file.c        | 11 +++++++++++
 fs/fuse/fuse_i.h      |  1 +
 fs/fuse/passthrough.c | 13 +++++++++++++
 3 files changed, 25 insertions(+)

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
index 939553b34..6c60716e7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1581,6 +1581,7 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 				      struct file *out, loff_t *ppos,
 				      size_t len, unsigned int flags);
 ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
+int fuse_passthrough_fadvise(struct fuse_file *ff, loff_t offset, loff_t len, int advice);
 
 /* backing.c */
 
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 059e57969..8a8fa6b8c 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -160,6 +160,19 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
 	return backing_file_mmap(backing_file, vma, &ctx);
 }
 
+int fuse_passthrough_fadvise(struct fuse_file *ff, loff_t offset, loff_t len, int advice)
+{
+	struct file *backing_file = fuse_file_passthrough(ff);
+	const struct cred *old_cred;
+	int ret;
+
+	old_cred = override_creds(ff->cred);
+	ret = vfs_fadvise(backing_file, offset, len, advice);
+	revert_creds(old_cred);
+
+	return ret;
+}
+
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
 	if (fb && refcount_inc_not_zero(&fb->count))
-- 
2.43.0
