Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D23101BC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636227; cv=none; b=WRv5afTYOIkILsFiWsf1GtPkkzxbo6Lj3VBxxUxbDwd10nTozaLTPk0vhPvfnhzQnDMr69w4qENCs8xJ+z50uxKuRZymXG8wbi4etdKKVOvBBErZdMW/iDLPOVSry1gjrB6Eexe1D4ghbZVL7AOBxEmJGnMDr6EFtuU9T9986I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636227; c=relaxed/simple;
	bh=jJ5DMaBJqUtVcsxnphyndFBcDC55vNmWPHxqKdhZYxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IX0406J6U8NBbKoWxk6RJ+sAfw9amQ8yQMdL8neSH4n2rlf3cT/kmstWYZrehfTerSe+KCInz2+GsffPUrci66miMQRF77zYheioQue/hgW1M1DMvTDPGpPbz9rZVPXd8rwgC5+iydNOxSkmvN1Z3ynpBhApNJ+uy7ZtTuVnFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+H4hHnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+H4hHnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E371F000E9;
	Thu,  9 Jul 2026 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636225;
	bh=XLoO7MX1yFKSW7aJED8m27wZw29SVMwCrGQcExHp8qY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b+H4hHnI4xtz08MVofnEkRhHMMYDnFBmQmwpOz0nNBD1eDiSK1ojgfewVQQXyo42s
	 CkUabdZhwTPJiDAOFuJlZY9XjVJrpJkuqXuu/STniV38S6ztfqCKVf7RTvxQRfYnDX
	 9WLXKSYSERg9tFvQurjS0n3PTsbbbRwUnD7uh9kd4JTTiy8PIEsUn3T5W5Nod5phSG
	 odTVzlt2gqh33Ks8d12h+CChdYWXSinDiqsCTbnkjVB/0LS8Y53HmTwxkTdUqCFOLH
	 kLyjRZROofXvOE3S5QtTi8f+c+UlrLzpWU8Sqwlm4nN71/YaztjIuaBx/f/+y5uFAq
	 Q+sP9Jx2YHmfA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:00 +0200
Subject: [PATCH v2 05/23] binfmt_misc: annotate racy accesses to ->enabled
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-5-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jJ5DMaBJqUtVcsxnphyndFBcDC55vNmWPHxqKdhZYxk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHwtVPP6Fj/RVEhix7d9V5+ZLD3MXLkk66dlZK5Qy
 OEfn9Kud5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkPZCR4fGTQJnS15ETIx5U
 Xjfmu6Pk89wu+5jL47C3i2Z2mGtcsmT4wx2Yb6v3QCG45wrvgzc7SqMXLtCfLv72q8fCByqZPcb
 vGAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

->enabled has always been read and written locklessly: every exec
reads it in load_misc_binary() while bm_status_write() or a concurrent
remount via bm_fill_super() may flip it. That is fine as it is an
independent boolean toggle but the accesses should be marked
accordingly for KCSAN. Annotate them with READ_ONCE()/WRITE_ONCE().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 08fd7991d4c8..2a9025627f6b 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -217,7 +217,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	struct binfmt_misc *misc;
 
 	misc = load_binfmt_misc();
-	if (!misc->enabled)
+	if (!READ_ONCE(misc->enabled))
 		return retval;
 
 	fmt = get_binfmt_handler(misc, bprm);
@@ -871,7 +871,7 @@ bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	char *s;
 
 	misc = i_binfmt_misc(file_inode(file));
-	s = misc->enabled ? "enabled\n" : "disabled\n";
+	s = READ_ONCE(misc->enabled) ? "enabled\n" : "disabled\n";
 	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
 }
 
@@ -888,11 +888,11 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 	switch (res) {
 	case 1:
 		/* Disable all handlers. */
-		misc->enabled = false;
+		WRITE_ONCE(misc->enabled, false);
 		break;
 	case 2:
 		/* Enable all handlers. */
-		misc->enabled = true;
+		WRITE_ONCE(misc->enabled, true);
 		break;
 	case 3:
 		/* Delete all handlers. */
@@ -1003,7 +1003,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * someone mounts binfmt_misc for the first time or again we simply
 	 * reset ->enabled to true.
 	 */
-	misc->enabled = true;
+	WRITE_ONCE(misc->enabled, true);
 
 	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
 	if (!err)

-- 
2.53.0

