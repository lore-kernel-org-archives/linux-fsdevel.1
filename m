Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320715;
	b=iAY3GA+OYv/m34Z8toZuGAGGwpGp9WHvrw/cgjhvemRkgI6BSjsiWEJgjhb/8HTkcvcQ
	 LPZ3wvFgsD7dpVO+KU30NSnSyCTIGpYfqd4uEKCel1mLeQS65KRZEIR6d98HEDlptmWi1
	 9sxOS9+H8x2cMgGiRTWCGOVwhxVDy+qcuv2LP0v7vu20HDwlSCLNtT1bCVFaVC8EIPD0+
	 eoX8cfuNDZBYyjQf7CBPGoSmT93GSHxyGVfMpoLaXLDIhNhOpOPP9u+VDPH6HbSS2Gy8i
	 s+u37xFSCIhGSImUKSRsohfE8AVOMUaxWya79bMpyhYzgblK3Kj1e+Ix/N+t4fzooAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=pcyTIIwBPjmyAElj9Plr/S42lIJXiadAytcA81h3A/U=;
	b=svGuw+GrX5pzEGiI5J5zapjMmp/8Y4PeUiwYU2SeebAvGIxOsKP4EQI+qnk/2QKcT14v
	 ZAT7vjntNn9GXnM+7D9C/upH52dyrRFe5SwPRl/y89M/5UFkf5dlcTc0j8fYuP//efyOe
	 NXI5t+Br5V6LM+AMDLb7bn/hDxCVXsdLiMGtuZyvXCiFgZI/242edGyfKvjeomYMllZx5
	 QhirP+eJsuX0Bz5nQjFfPNvQNteigvl+4gsh8aRgiZswF+ysQ7BulAoCMI75vFrMp2NyW
	 bXLTfU0qwAXYxYBSt3LfHesgPV1EzcpOr4OLB5BOUSBPk4GR345Tx6lfAwCjZ7wzNCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=fJd+3mar;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F64606A980
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1F64606A980
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=fJd+3mar
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53fdd2fb171so23209811cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 06:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794320714; x=1794925514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcyTIIwBPjmyAElj9Plr/S42lIJXiadAytcA81h3A/U=;
        b=fJd+3marC+EMsRC/1xy8JJMSfX+zrYIEaqvT9qehJSqaYPV/tTmzr6PktTBIwPY6PF
         j2Z6auoTPzI4XNNqWS5IQp89CwMJvQ/2HY/PljtkoyzIw76HV3mme4JvPLmYXUltAkp6
         2e2pfjg6riBRJ7M3gVw+z8mnT939ypCmngLPYNXxxhoDlQgF9CqRhOLEozNvnCEu1P6p
         1iPXTiqHNGzBtudNJ6rNODrsnIhaN5i8/ALhjMWFf275ZMrcw1IBqPkYcxjgcYRwknrj
         elYn4H7d4XZBGrm/eH+eBrOKjmugEegPE6VZDFNToBPj3RPikmOO3bIy7QrELZPhVbwU
         /qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320714; x=1794925514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcyTIIwBPjmyAElj9Plr/S42lIJXiadAytcA81h3A/U=;
        b=fh4c3XLHxntJwsduE8pkK4xbOgegaZf/xLQ1wMjwVYKC2gDAhXboUGwYl6wFHVHfIK
         8382e5jOBVROABK2KJJd1cgovyc+O8oFKJ/KELfUyd8/xpGWld89Ww6b36MEsT070XG6
         7qjGIVHAwmwgupHUhrxy00JjIv9amIF/MuUaz1grDj8pbngY4Da/LrkPCYgOMNEdiClo
         oCSAnBJaaV1ix3/QdhHKzNxYZuNLqo8wLR5nO1yIC1hoQmAqIIsFsI7mh6/TT9S8iHIE
         2LMJE5sQmlWJcWlGYGO+10V2hjE3lsY+6LYfpquBAjMcHSQ9eHitylzsKSI1MaW/x99d
         rPVw==
X-Forwarded-Encrypted: i=1; AL+hErEqj2GmrWq8L+jV4Q8VQN5Ip+EyqAWHr7y8IMuugZU/WJRGajvjuYyKP0shQfy1I0IVLIFgfCI3ejINkqOX@vger.kernel.org
X-Gm-Message-State: APuU4Z+TvYNClDPVNlVD8VTY6da7w/WBfvGHKCaWWxiQ80UhIDNs/xc7
	qrwjHaSHmKG2+IJYjVCBI7UeXDbsuypa3x3yXgmvs7qCk6yKGElZ20q48eeHLetWsS3BhmMWww5
	APoJZUPw=
X-Gm-Gg: AYBFou2ojifQUEycO09yb/0riczNBDaowaiTf++l6N4duFzjHEwk/hDmUeY/mZgqCHW
	Ji7Dlj5nXibuWeDzEQ5lnkwDNJ/H+jbpNvfxhg6GciXm+EJe80B4K8HZ1HZ6s3GJW2A37E2ur8T
	/3FyYNNKxax6uusHdkMUzszw5gSY2MshhtXaPZm8XzrCYZ+ucEfv5WXM8/9OmV/JNefAHwOruCv
	LDg66qMwSJssjBbkUPOwg+N1574dL7nH4bfVaEPbZM0XoqBM05wpKGBmTjPjXv651eUNS5UF6vj
	T3Iq8wkLFKiMYNu9eJdWUR0KUmWSQse5m/9uFxYyMclNStinmmHSAOMpKfQXmK1iCT0whGc1Np5
	cdbi6x2lF3Z0iuY5vvs/3pk59CAYUh5KnuUGYKA/H6qj/mMDv7d/2foGyvPcxBNTlOurnzaLWvA
	BFFYLMRIu7gq++Jd7m1a+PjDm9odQ3mw3yGgiZPFZBaRRanlBz6TrSsMJRWiCzB3awgZeGFaJv+
	8dtjVscT0+m1kX3SVHYZdeQrUg+3D2XinPdfL06PquOKjeG15dYBb+PLAyad9vb1fP8Ndj5QqrZ
	G+qfqy3xlnO9NkBFRX8uwNJq7JooolE6oHM5zgKJV+sc4a01AA3Ktt5grDty4AqC5c8=
X-Received: by 2002:a05:622a:53cc:b0:535:a20:8277 with SMTP id d75a77b69052e-5552609b27fmr38562291cf.10.1794320713629;
        Tue, 10 Nov 2026 06:25:13 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0543c8esm22168616d6.40.2026.11.10.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:25:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 10 Nov 2026 14:24:57 +0000
Subject: [PATCH v6 9/9] ovl: implement containerized syncfs for overlayfs
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-b4-ovl-containerized-sync-v6-9-43d1be16a4d6@toxicpanda.com>
References: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
In-Reply-To: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengguang Xu <charliecgxu@tencent.com>, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794320698; l=4798;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Xo2M5cHMBoiidKt8p5NTtHZ9BfQZnZy1FRZYhPiv9Fw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHLN7kEC1SQEmeJVgeJNARdJzVGyGiG5xdAwugZHdHFZRG/vffQgzIfpxxH0BSODqWKaSmXur4L
 +1nj/jncZDg8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <charliecgxu@tencent.com>

Now overlayfs can only sync own dirty inodes during syncfs,
so remove unnecessary sync_filesystem() on upper file system.

Do that with fsync=relaxed only.  Call sync_fs_and_bdev() on the upper
filesystem instead, which is what sync_filesystem() does after it has
written the inodes.  Do the same for a read-only remount.

The root inode of an overlay is not hashed and cannot be on a dirty list,
so write its upper inode every time.

Upper inodes that have no overlay inode, like whiteouts and the work
directories, are not tracked.  It is up to ->sync_fs() and the block device
to get them to disk.  ext4, xfs and btrfs log all metadata, and ext4
without a journal keeps it in the buffers of the block device.

With many containers on one upper filesystem, stopping one of them no
longer writes out the dirty data of all the others.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
[josef: everything after the first paragraph, no wait_sb_inodes() on the
 upper filesystem]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/filesystems/overlayfs.rst |  2 +-
 fs/overlayfs/params.c                   | 14 +++----------
 fs/overlayfs/super.c                    | 36 +++++++++++++++++++++++++--------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 1a59500834a1..34fc4e6f8a84 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -830,7 +830,7 @@ Traditionally, syncfs(2) and unmount of an overlay sync the entire upper
 filesystem, including the dirty data of other overlays that share it.
 Overlayfs can be told to only write back the files that were modified
 through the overlay, and then ask the upper filesystem to commit its
-metadata.
+metadata and write its block device.
 
 On traditional local filesystems with a single journal (e.g. ext4, xfs),
 fsync on a file also persists the parent directory changes, because they
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 549fc1e83ac9..6de99e79eb6b 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -774,22 +774,14 @@ static int ovl_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	struct ovl_fs *ofs = OVL_FS(sb);
-	struct super_block *upper_sb;
-	int ret = 0;
 
 	if (!(fc->sb_flags & SB_RDONLY) && ovl_force_readonly(ofs))
 		return -EROFS;
 
-	if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb)) {
-		upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
-		if (ovl_should_sync(ofs)) {
-			down_read(&upper_sb->s_umount);
-			ret = sync_filesystem(upper_sb);
-			up_read(&upper_sb->s_umount);
-		}
-	}
+	if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb) && ovl_should_sync(ofs))
+		return sync_filesystem(sb);
 
-	return ret;
+	return 0;
 }
 
 static const struct fs_context_operations ovl_context_ops = {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a0fb85405f68..570e2ea6af93 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -270,18 +270,38 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	/*
 	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 	 * All the super blocks will be iterated, including upper_sb.
-	 *
-	 * If this is a syncfs(2) call, then we do need to call
-	 * sync_filesystem() on upper_sb, but enough if we do it when being
-	 * called with wait == 1.
 	 */
-	if (!wait)
-		return 0;
-
 	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
 
+	if (ovl_should_sync_upper_fs(ofs)) {
+		/* Enough if we do it when being called with wait == 1 */
+		if (!wait)
+			return 0;
+
+		down_read(&upper_sb->s_umount);
+		ret = sync_filesystem(upper_sb);
+		up_read(&upper_sb->s_umount);
+
+		return ret;
+	}
+
+	/*
+	 * sync_filesystem() has already written the dirty inodes of this
+	 * overlay through ovl_write_inode().  What is left are the last two
+	 * steps of sync_filesystem() on the upper filesystem.  They have to
+	 * take care of the upper inodes that have no overlay inode, like
+	 * whiteouts and the work directories.  Do not write the inodes that
+	 * others have dirtied on the upper filesystem.
+	 *
+	 * The root inode is not hashed, so it is never on the dirty list.
+	 * Write its upper inode every time.  sb->s_root is gone during an
+	 * unmount.  An error ends up in s_wb_err, like for any other inode.
+	 */
+	ovl_write_upper_inode(sb, d_inode(ovl_upper_mnt(ofs)->mnt_root),
+			      wait ? OVL_WRITE_WAIT : OVL_WRITE_START);
+
 	down_read(&upper_sb->s_umount);
-	ret = sync_filesystem(upper_sb);
+	ret = sync_fs_and_bdev(upper_sb, wait);
 	up_read(&upper_sb->s_umount);
 
 	return ret;

-- 
2.55.0

