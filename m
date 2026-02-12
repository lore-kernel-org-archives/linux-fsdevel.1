Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8D35BDA0
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902854; cv=none; b=se/LxAclB9gZrw23J0Y3N0EYi+TwAeTSpRC2fjoJMGiRd77tkcwiSS2C8Ed8bd741UTREuhWotV04BsckvJ/Doyx9sBDS4ew5/QLpEj55TWJPRZwad4766dkrN0RHaYzEFm6VP2CWYz3gAlJY0HoAra940M9gWnNr/zuzyXggC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902854; c=relaxed/simple;
	bh=YH+7x+x46pBnWbLGmTaruk6nq3xf4ir5hKZmKRnsjvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7EmfF9XrIM0tgjQU+I5DM6NJBulKR8Yk8DEw/BINp95wGAQzElzp0mBSLDK78tyG4pi/wq5yl/mu2oGiqS7dpBU4IGfkMFwYU+t9wSdQSlZHnUaGjvKw2ZgBCoGmxFNHshNWM860GvG1M7j6f62VBcMcASGfVhqJBoWhvFgAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61CDRCBv041920;
	Thu, 12 Feb 2026 22:27:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61CDRCnw041917
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 12 Feb 2026 22:27:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
Date: Thu, 12 Feb 2026 22:27:10 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: evaluate the upper 32bits for detecting overflow
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
 <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp

On 2026/02/12 7:36, Viacheslav Dubeyko wrote:
>> Only compile tested.
> 
> Maybe, it makes sense to run some tests? :)
> 

I tried below diff. While this diff worked, I came to feel that we don't need to
fail operations upon overflow of ->file_count or ->folder_count.

Since ->next_id is used for inode number, we should check for next_id >= 16.

But ->file_count and ->folder_count are (if I understand correctly) only for
statistical purpose and *currently checking for overflow on creation and not
checking for overflow on deletion*. There are ->root_files and ->root_dirs
which are also for statistical purpose and *currently not checking for overflow*.
Overflowing on these counters are not fatal enough to make operations fail.

I think that we can use 32bits atomic_t for ->file_count / ->folder_count, and cap
max/min range using atomic_add_unless(v, 1, -1)/atomic_add_unless(v, -1, 0).

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 878535db64d6..b2c095555797 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -199,7 +199,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	if (next_id > U32_MAX) {
+	if (upper_32_bits(next_id)) {
 		atomic64_dec(&HFS_SB(sb)->next_id);
 		pr_err("cannot create new inode: next CNID exceeds limit\n");
 		goto out_discard;
@@ -217,7 +217,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		if (folder_count> U32_MAX) {
+		if (upper_32_bits(folder_count)) {
 			atomic64_dec(&HFS_SB(sb)->folder_count);
 			pr_err("cannot create new inode: folder count exceeds limit\n");
 			goto out_discard;
@@ -231,7 +231,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		if (file_count > U32_MAX) {
+		if (upper_32_bits(file_count)) {
 			atomic64_dec(&HFS_SB(sb)->file_count);
 			pr_err("cannot create new inode: file count exceeds limit\n");
 			goto out_discard;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..bdfa54833a4f 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -68,16 +68,17 @@ bool is_hfs_cnid_counts_valid(struct super_block *sb)
 {
 	struct hfs_sb_info *sbi = HFS_SB(sb);
 	bool corrupted = false;
+	s64 next_id = atomic64_read(&sbi->next_id);
 
-	if (unlikely(atomic64_read(&sbi->next_id) > U32_MAX)) {
+	if (unlikely(upper_32_bits(next_id) || next_id < HFS_FIRSTUSER_CNID)) {
 		pr_warn("next CNID exceeds limit\n");
 		corrupted = true;
 	}
-	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
+	if (unlikely(upper_32_bits(atomic64_read(&sbi->file_count)))) {
 		pr_warn("file count exceeds limit\n");
 		corrupted = true;
 	}
-	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
+	if (unlikely(upper_32_bits(atomic64_read(&sbi->folder_count)))) {
 		pr_warn("folder count exceeds limit\n");
 		corrupted = true;
 	}

