Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40011367F4E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770805816; cv=none; b=K/qlPmSr0tLqCFXggZar9SSCG0nS8Z1vrQwWeVpO5mJpi1f0gHZFB8SJoTEe/s/khtPyQs615EFgnuneNWm6jKMFHwNHr1Isujp2MEmINZNxpCCI/cEZ/T4hb6tDBHcxqzoReBOii8ywziCbRponLpYKqlffNJpRL/h/VCq23vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770805816; c=relaxed/simple;
	bh=6Svp2yakS4ISlSmYeVfCWOnhOVOb5kEc4Wzio/ROhBw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YVYqdfWrsNkcBRuM6rC7AegdvM8WBW62fyiUSgXTSi1QcHl+JZVdpccHSAkuFD2wpAFI8nAaoigHSIWWRNWs6OkcgAO/8k708DfIkRNpu0UD0AzTZMqcf49eG4gzYncWW2e6s5h/kubnb9Hzaf9/ui6yUN/d06OwThen4zzAR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61BATwZT065526;
	Wed, 11 Feb 2026 19:29:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61BATwoH065523
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 11 Feb 2026 19:29:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
Date: Wed, 11 Feb 2026 19:29:59 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jori Koolstra <jkoolstra@xs4all.nl>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] hfs: evaluate the upper 32bits for detecting overflow
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

Commit b226804532a8 ("hfs: Replace BUG_ON with error handling for CNID
count checks") replaced BUG_ON() with "atomic64_inc_return() => check for
overflow => atomic64_dec() if overflowed" pattern. That approach works
because the 64bits signed variable is initialized using a 32bits unsigned
variable, making sure that the initial value is in [0, U32_MAX] range.

However, if HFS_SB(sb)->file_count is smaller than number of file inodes
that actually exists due to filesystem corruption, calling
atomic64_dec(&HFS_SB(sb)->file_count) from hfs_delete_inode() can make
HFS_SB(sb)->file_count < 0.

As a result, "atomic64_read(&sbi->file_count) > U32_MAX" comparison in
is_hfs_cnid_counts_valid() fails to detect overflow when
HFS_SB(sb)->file_count < 0, for this is a comparison between signed
64bits and unsigned 32bits. Evaluate the upper 32bits of the 64bits
variable for detecting overflow.

Fixes: b226804532a8 ("hfs: Replace BUG_ON with error handling for CNID count checks")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Only compile tested.

 fs/hfs/inode.c | 6 +++---
 fs/hfs/mdb.c   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d6..7b5a4686aa79 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -199,7 +199,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	if (next_id > U32_MAX) {
+	if (next_id >> 32) {
 		atomic64_dec(&HFS_SB(sb)->next_id);
 		pr_err("cannot create new inode: next CNID exceeds limit\n");
 		goto out_discard;
@@ -217,7 +217,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		if (folder_count> U32_MAX) {
+		if (folder_count >> 32) {
 			atomic64_dec(&HFS_SB(sb)->folder_count);
 			pr_err("cannot create new inode: folder count exceeds limit\n");
 			goto out_discard;
@@ -231,7 +231,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		if (file_count > U32_MAX) {
+		if (file_count >> 32) {
 			atomic64_dec(&HFS_SB(sb)->file_count);
 			pr_err("cannot create new inode: file count exceeds limit\n");
 			goto out_discard;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..68d3c0714057 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -69,15 +69,15 @@ bool is_hfs_cnid_counts_valid(struct super_block *sb)
 	struct hfs_sb_info *sbi = HFS_SB(sb);
 	bool corrupted = false;
 
-	if (unlikely(atomic64_read(&sbi->next_id) > U32_MAX)) {
+	if (unlikely(atomic64_read(&sbi->next_id) >> 32)) {
 		pr_warn("next CNID exceeds limit\n");
 		corrupted = true;
 	}
-	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
+	if (unlikely(atomic64_read(&sbi->file_count) >> 32)) {
 		pr_warn("file count exceeds limit\n");
 		corrupted = true;
 	}
-	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
+	if (unlikely(atomic64_read(&sbi->folder_count) >> 32)) {
 		pr_warn("folder count exceeds limit\n");
 		corrupted = true;
 	}
-- 
2.53.0

