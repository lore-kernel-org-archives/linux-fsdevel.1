Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943E1A7264;
	Thu, 14 May 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762792; cv=none; b=cqtA/YX0V2exA7CKVJppWBpCd0nNXetGkbTZrBGDDNj+mWrzEVpjSfsncLeQP93rJhsjXrCuN4n90zMhCzIlKqyn0xWd+NgmXlYwzOwQqRjoinE/CB1sxHNpEIPolgitG3c84fF8IaASMhuB+5gd/QiqoIP6FyE6uhDatD0ToVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762792; c=relaxed/simple;
	bh=j4jNiw2+TbYp9y1p6APMQ2mfwNDwPg9EGXIDRJaHPfY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oa4m2Qj51x+envKnFd1AxTnuxbVuD7ViWwLtKbtbyo0SaRkN7jUndaYbVJwQIk4qT0b8cta5fiYl0mxmyD3UjZGO++zXzdzBepVh+xVvQhnqy+4hZk2fM5lJa7xCxUw14GN2fddqz7VNTraYt6Y5S6dTivgXtLgpFgX1r+1hBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FI+wr1uz; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FI+wr1uz"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1WbvFnMrMphGhwFMRtLVcw5b48UPe4RDSM16IiWVXOw=;
	b=FI+wr1uzLtLbX0TTVACOvXl01vELRn2fXi+c7SLI/E9psxYc1OUO4JoOx65ySygOfafP23k5y
	zZYw7uWtHFgoUZI3VmgvL+DyGN69nZB8/ODToOQFwnM2fISrO8FTvIksj6qiq/LEJZlsPSxNhpz
	M+JL3gR+KrutxmrKa6nPVzo=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gGVHk0QxVzLlXL;
	Thu, 14 May 2026 20:38:42 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 65F8740563;
	Thu, 14 May 2026 20:46:19 +0800 (CST)
Received: from huawei.com (10.50.85.155) by kwepemk500005.china.huawei.com
 (7.202.194.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 May
 2026 20:46:18 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <miklos@szeredi.hu>, <djwong@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] fuse: virtiofs: fix illegal inode address access in fuse_release_end
Date: Thu, 14 May 2026 20:41:02 +0800
Message-ID: <20260514124102.2703313-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500005.china.huawei.com (7.202.194.90)

When a submount (e.g. virtiofs with fc->auto_submounts=true) is umounted
while an async RELEASE request is still pending, an illegal inode address
accessing occurs in fuse_release_end()->iput().

Trigger process:
 1. virtiofs has a submount; user opens and closes a file under it
 2. Close calls fuse_file_put() with sync=false, sending RELEASE
    asynchronously
 3. fuse_release_end() is scheduled to run later via igrab() holding
    inode ref
 4. File is freed, mount/dentry refcounts are released
 5. User umounts the submount; fuse connection detects remaining
    superblock and does NOT flush the connection's requests
 6. generic_shutdown_super() destroys the superblock and poisons busy
    inodes' inode->i_sb = VFS_PTR_POISON
 7. Later, fuse_request_end() calls fuse_release_end() which does
    iput(inode)
 8. iput() accesses inode->i_sb->s_op at the poisoned address, crash!

There are two solutions to fix it:
 Solution A: Hold path reference in fuse_file_put, and put path
 synchronously, which could reintroduce the issue fixed by commit
 5a18ec176c934 ("fuse: fix hang of single threaded fuseblk filesystem").

 Solution B (chosen): Use synchronous RELEASE for auto_submounts (which
 is only supported by virtiofs). The virtiofsd(fuse daemon) and virtiofs
 won't work together under one same kernel instance, so the problem fixed
 by commit 26e5c67deb2e ("fuse: fix livelock in synchronous file put from
 fuseblk workers") won't be brought back in virtiofs.

Fetch a reproducer in https://bugzilla.kernel.org/show_bug.cgi?id=221519.

Fixes: 26e5c67deb2e ("fuse: fix livelock in synchronous file put from fuseblk workers")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/fuse/file.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c59452d60b8d..a6192b96d861 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -375,13 +375,20 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
 	 *
-	 * Always use the asynchronous file put because the current thread
-	 * might be the fuse server.  This can happen if a process starts some
-	 * aio and closes the fd before the aio completes.  Since aio takes its
-	 * own ref to the file, the IO completion has to drop the ref, which is
-	 * how the fuse server can end up closing its clients' files.
+	 * For auto_submounts (e.g. virtiofs), always use synchronous
+	 * release to avoid illegal inode address access when umount
+	 * happens before async release completes. The async release
+	 * holds inode reference via igrab(), but umount can shutdown
+	 * superblock and poison inode->i_sb before release ends,
+	 * causing crash in fuse_release_end()->iput(). Otherwise,
+	 * always use the asynchronous file put because the current
+	 * thread might be the fuse server. This can happen if a
+	 * process starts some aio and closes the fd before the aio
+	 * completes. Since aio takes its own ref to the file, the IO
+	 * completion has to drop the ref, which is how the fuse server
+	 * can end up closing its clients' files.
 	 */
-	fuse_file_put(ff, false);
+	fuse_file_put(ff, ff->fm->fc->auto_submounts);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
-- 
2.52.0

