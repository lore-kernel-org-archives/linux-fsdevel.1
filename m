Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236191;
	b=fJqt+jaJv9YfWMaZ+/rb2L2s0UftmbySY0xz0AHaLH1tzzthIVCd1bHkZCJus17zAr3Z
	 Ms4ZzqOmvU0titS+Ed3BPjYvNrOWsLReEsbA5zpumbFnk+IYudynX8ZEDuio6USUFlvGE
	 xuasK13P3w0Qal5bS6+rEzHzfyQzHMI+qlxgP+upjJJtrODEkn7bOq9niHsU3L/VDdlSk
	 eshqAuVvIGRPl+2OvqqT2gEfIHM44m5WVc0V30K2utPFG0ooiqJV91xcZpKr5kHH+OzKm
	 sy1827/0eVcTGTxSs5cujokjkouwC1OLOlMblYVfShl75+nJGOYc7iJHW5Ger2JFNdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TzA2mc/mLcdZrHoaUuNZ2keKOYMXUbrliWDmeMGR2s0=;
	b=VDtRpajb+z5XlWL7QerSBiDoCZic2cVKcLyHw3kEpW5OkuTNdZZOBKE2qmub0NH+F9Am
	 A3I3dnfC5cgipxvTqko+QsbG9RQHGmHyYXjekGvsfoZwoGA5Ji0bdMSMEd4Ns5lEPxlqn
	 xigSilKNkDo4JGTfD/x3VEs/xzEC2JVxNRfbK9iI/3BWLYUE3HUEZxC3iSN7lzTyRQO5F
	 Bd5Nh/URyJoEmXoOd4lDvw4QxZtsdRvtFinzJQRS2wD9XAH+P4neOk6g2rrIwARNCfWp7
	 XeU8r5B1T6MDdHRdi6yQaTZTEBqo1JsUTI1uMfrE+xH1U7Obk8waEXZ8CyDUR+oGVFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=RMtw5JH6;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85408606A33A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 01:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85408606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=RMtw5JH6
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917a707f37eso16017206d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793236190; x=1793840990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzA2mc/mLcdZrHoaUuNZ2keKOYMXUbrliWDmeMGR2s0=;
        b=RMtw5JH61UxCPb7726mp0PyU17rIKr0Y3RKEmukB+ivYTKos58aMqKHz4BfNmDvGZ/
         WSzlInKgN3jMQuu3O94/UFtBzxayr1oeIqiS8EB51j4o8E+spnJmy5+nRpBK2s4WM7v/
         RnjX5jlW/ZxMpsMxear+Ns3hUuvPLy0xxtRXYkmgQhF+QJC+wfjF3a21th1vpUzWmI+P
         +evvuuD8qSBf0ozO6AV4LEhhrmBUBHtvlXoXDNCuUyc30ZNLIa0a7my8kByJgdrBjdTi
         0MD2NK9w7eGh5YKHjERSrujI3wNZfXG1LKoZvwSNtp1aSnVnKXhqRYwNJhrSZFQmFQ/f
         lHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236190; x=1793840990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzA2mc/mLcdZrHoaUuNZ2keKOYMXUbrliWDmeMGR2s0=;
        b=qVJ42nGH72Y6Aoyza/I/CiHSkfbkwbsYKlfPOQvPTJC6jHkYkwS0bIpWPDpBHXmfe3
         zD9yrydCFWO2rhws9S834mTWYKLHjUA5I7qBBnP3F+Rc6iQ/i53uvuPKwW+XHzaxCokx
         2aj/zV+bJW0LmB6b2sWQqwu+GK/EkZAoHAdI9oQtEnfuTDKCCSwx6kuEVNTpBAziWHwv
         MIz7kt7rmM3Wn1ppOaLt8wzRTzupqd/nARuQn/3xvdq68rHTo7IwQKWezNkDtJIK1f/H
         QAwcLfbZyahE6fNT8eaUHvqj+ZZufllIQ0n5euSdxF+qUd+IlhhyxKa8tCDPzRs6qhXg
         1gcw==
X-Forwarded-Encrypted: i=1; AKwUvBxbZOr20TYM2QSsSnuGTc6XFsPobEZ4x3nZ31W9cKx0Py6YeUDbNqeL+0crO62aS1QBSXmStTxBqB114HV5@vger.kernel.org
X-Gm-Message-State: AFq9FYLdsV9ppKlSq+lnOqV5pOZzdL7UcrK1SemBeC9uq0/pcApm2vuG
	JCUIhEy1Gdy8yq4TbhpvKFp6Rc5rxpHdmgXJ6Rpbknu8XNXg4ynmksWGz0CyKnI9ung=
X-Gm-Gg: AYBFou2a9tVff0+wdjSIBOIWsl/w0JPnmXm73jbHnFdN2VoSkEnbAfKTUf0/wifCrJS
	6z1HyUieFI1EYd0u+kbNywPYQgdMNX0ovHZtqLz6XH0ctE8CqXU9iRsK5vQc9AX6cB0/eLNwFaH
	ghi2i650PB5BbS1Wb2PFIU3nLmBYfgUy8KwkbtqxU9Ljq9FBwAEqkkWB/jJ3puRdWOr/pc0hpOX
	2+3lKt6i/H8m+VLFYG9SXbivdwtOzJBfSSyqhKDCLUbkZu2LcWV27XHwVhCIxxgTo79AEyS3ols
	djGSQFIUdRQ7jY5m0wuz7pj8xuvrlGSatwzFTOYPkeO6oHR1JRcruRyDSF/C39pqgl4eTbehubT
	LONS8/riMQ2flHHVVsnttvzznHVpGQFIWy5ddeaZbFBOtyIOKZ6psVOUy9LR8n+Jupu4A7WuhiD
	szkZDS3+6lAYJfH0sX3g7EtdgQ0Y3WV1LwU+Ix+gt7qWRwej1VekAfLYDo/Le1gxZdsTqB3Rpj7
	lBvMZzaeXQ+epr6WP6SaQcP6i8tFCBdEzN5FUorXclvBHgTEtjZOjgBziE+7/KjnoVEFBwLqWZ7
	SL9TNuGGtI8w8YnlwV0Yd4eBuz9JFbDXrGQSaoGQ5QThtDM=
X-Received: by 2002:a05:6214:226f:b0:918:c4b8:fc57 with SMTP id 6a1803df08f44-91c7cf43460mr68634406d6.9.1793236190484;
        Wed, 28 Oct 2026 18:09:50 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c69e721eesm80629256d6.11.2026.10.28.18.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:09:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 29 Oct 2026 01:09:24 +0000
Subject: [PATCH v2 10/10] ovl: implement containerized syncfs for overlayfs
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
Message-Id: <20261029-b4-ovl-containerized-sync-v2-10-4e9f08e4a052@toxicpanda.com>
References: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
In-Reply-To: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengguang Xu <charliecgxu@tencent.com>, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793236166; l=3396;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=tdDbnsJTefDUewrTG+UpRnu0LG6Km+NatXOQJlitgGg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGt6Z7dMdS6ldGMpoK7iR8XBtzEr7iaPM75LUqL96LpkoHzm6GEyIqSxSZTfsXU0+r04T+b5x/T
 Cmzf6RDJ77g0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <charliecgxu@tencent.com>

Now overlayfs can only sync own dirty inodes during syncfs,
so remove unnecessary sync_filesystem() on upper file system.

Call ->sync_fs() and write the block device of the upper filesystem
instead, which is what sync_filesystem() does after it has written the
inodes.  Do the same for a read-only remount.

With many containers on one upper filesystem, stopping one of them no
longer writes out the dirty data of all the others.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
[josef: everything after the first paragraph, no wait_sb_inodes() on the
 upper filesystem]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/params.c | 14 +++-----------
 fs/overlayfs/super.c  | 28 ++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 5a15e5478a6b..43fe0b1ef11f 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -764,22 +764,14 @@ static int ovl_reconfigure(struct fs_context *fc)
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
index 84258edb5530..361a3afa4ac8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/blkdev.h>
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/file.h>
@@ -271,18 +272,29 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
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
 
+	/*
+	 * sync_filesystem() has already written the dirty inodes of this
+	 * overlay through ovl_write_inode(), including the fake ones, see
+	 * ovl_upper_modified().  What is left are the last two steps of
+	 * sync_filesystem() on the upper filesystem.  Do not write the inodes
+	 * that others have dirtied there.
+	 */
 	down_read(&upper_sb->s_umount);
-	ret = sync_filesystem(upper_sb);
+	/* Like sync_filesystem(), do not call ->sync_fs() on a read-only sb */
+	ret = 0;
+	if (sb_rdonly(upper_sb))
+		goto out;
+
+	if (upper_sb->s_op->sync_fs)
+		ret = upper_sb->s_op->sync_fs(upper_sb, wait);
+	if (!ret && wait)
+		ret = sync_blockdev(upper_sb->s_bdev);
+	else if (!ret)
+		ret = sync_blockdev_nowait(upper_sb->s_bdev);
+out:
 	up_read(&upper_sb->s_umount);
 
 	return ret;

-- 
2.55.0

