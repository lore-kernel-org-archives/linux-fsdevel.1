Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492101;
	b=YR2hg1ABW93esLKSflhEtTSNnfLIUeGMYJ0uaNHQ7Qzp4iKHixIoPX57zxU6Yqjcmxu7
	 S6dVabC0246gG6guECulwX1rERbUrQXx23KOw20ouokVqPxQrQFebvYN5QtA3t5BhQZko
	 cgYI/FAuttgRnbv4fsOqpSP3UquUmdu8Q6iZkHf3Hylq1xlJx4W3qCTUK/FDJ2fTxy852
	 7+WjqK5//+wRCybIDJuXoxuKe+4a8dZjC6NyEtHAYrtoJdsm5HFMMSX1ntVaYYhfkkV2l
	 +vLPN0DRws8bItMrZHXo6yIGPRVWGbn6+lPatHh8S3STDVZtkwUjcrO24Thv2N8nFaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492101;
	h=DMARC-Filter:Received:Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=2C0F4jSSXg55jCUDPWaS9QJYR5yt7FbyRB5+agU41Y8=;
	b=WsjajHRKhPh1rPJqMqwyHy4xIssciS03oaQo1cfUyYybsBpi18q0EjscUZg4GVg5O4oj
	 0w6qCT2MxVSrz+A36e1+mDBszMf8AN+lvfQUC1bMzPYJCuWWumvosK6SOtTPjUn30LQC4
	 DygbkR/Y1851H/jdEPRqYlSsJmjRhzXKqIFYewZ22+2BCVNHm17DZQdNe32N+s/kligAP
	 X+NkFHrXJzv6JT2guxo1zPVIa32S3BFuOst02+3yhjQgan1hiDuzrufiM1NQe7eBrHyp4
	 +RUOw2OuzEjqgAmugXSsPg6SKdejABHd+eA7RfWfrvVsN/xawrKxf4p6eijgYGIJZ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79927606AEAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 14:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79927606AEAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jQMVc5L3Xz1yn1
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 22:00:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7077F40561
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 22:01:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgAnZPPBxvVqjQdSEA--.11409S4;
	Thu, 12 Nov 2026 22:01:37 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: hold freeze protection across writable regular file ->open()
Date: Thu, 12 Nov 2026 21:52:45 +0800
Message-Id: <20261112135245.3347102-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnZPPBxvVqjQdSEA--.11409S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy8urW5Xr4ktFW7tr1xuFg_yoW5KFWxpF
	Wruas8GFW8K3srKrs7AF4DZ3WF9rn7XF1xuFykW34UXr9Yqr1YgFyIgr9YkF4rtr97tFyr
	tF4jka4DC347CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

A writable open of a regular file reaches the filesystem's ->open()
callback without holding any superblock write (freeze) protection.
->open() can nevertheless write to the filesystem: ext4_file_open() ->
dquot_file_open() -> dquot_initialize() may acquire a dquot and write
the quota file, which starts a jbd2 transaction.  If the filesystem
reaches SB_FREEZE_COMPLETE in that window, ext4_journal_check_start()
hits

	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);

and the open then sleeps in jbd2 until the filesystem is thawed.

The hole was created over time:

  - Commit 907f4554e252 ("dquot: move dquot initialization responsibility
    into the filesystem") moved quota initialization into ->open() and
    introduced dquot_file_open(), making ->open() a potentially writing
    operation for writable opens.

  - Commit eb04c28288bb ("fs: Add freezing handling to mnt_want_write() /
    mnt_drop_write()") added sb_start_write() to mnt_want_write() but
    deliberately kept the write reference held by an open file on the
    non-freezing __mnt_want_write() variant, so the file's own write
    reference does not protect its ->open().

  - Commit 64894cf84327 ("simplify lookup_open()/atomic_open() - do the
    temporary mnt_want_write() early") moved the temporary write count
    into do_last() and dropped it before finish_open(), so a writable
    open that is not O_TRUNC reaches ->open() with no sb write count at
    all.

Since then only O_TRUNC opens take mnt_want_write() in do_open().

Fix this by taking mnt_want_write() for any writable open of a regular
file and holding it across vfs_open()/->open().  Regular files are
checked explicitly so that opening device nodes on a read-only mount is
not newly rejected.  Read-only opens are unaffected.

Fixes: eb04c28288bb ("fs: Add freezing handling to mnt_want_write() / mnt_drop_write()")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/namei.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f573fd0aacaf..0ee4cf282cf5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4906,6 +4906,7 @@ static int do_open(struct nameidata *nd,
 	const struct mnt_idmap *idmap;
 	int open_flag = op->open_flag;
 	bool do_truncate;
+	bool got_write;
 	int acc_mode;
 	int error;
 
@@ -4935,12 +4936,23 @@ static int do_open(struct nameidata *nd,
 		return -ENOTDIR;
 
 	do_truncate = false;
+	got_write = false;
 	acc_mode = op->acc_mode;
 	if (file->f_mode & FMODE_CREATED) {
 		/* Don't check for write permission, don't truncate */
 		open_flag &= ~O_TRUNC;
 		acc_mode = 0;
 	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
+		do_truncate = true;
+	}
+
+	/*
+	 * ->open() can write to the filesystem, e.g. when it initializes
+	 * quota, so writable opens of regular files need freeze protection
+	 * as well.  O_TRUNC opens already need it for handle_truncate().
+	 */
+	if (do_truncate ||
+	    (d_is_reg(nd->path.dentry) && (file->f_mode & FMODE_WRITE))) {
 		error = mnt_want_write(nd->path.mnt);
 		if (error)
 			return error;
@@ -4950,7 +4962,7 @@ static int do_open(struct nameidata *nd,
 		 * while we need to undo write access below.
 		 */
 		mnt = mntget(nd->path.mnt);
-		do_truncate = true;
+		got_write = true;
 	}
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
@@ -4963,7 +4975,7 @@ static int do_open(struct nameidata *nd,
 		WARN_ON(1);
 		error = -EINVAL;
 	}
-	if (do_truncate) {
+	if (got_write) {
 		mnt_drop_write(mnt);
 		mntput(mnt);
 	}
-- 
2.34.1

