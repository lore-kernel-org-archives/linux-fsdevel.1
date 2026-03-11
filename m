Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B26347BDC;
	Wed, 11 Mar 2026 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266174; cv=none; b=RXQqPec/4VK7JOuKRb/VNrJBgExPb4mhPvEotdmtzujsuQzmcqPxV2MeBK3Buku4bzzyNH1HdjDQAPQhBRzka7cx+6ea8c90RDszGpIfuuwzdvZFOvsNvTekujTRceL1w7BN1Sb2stGsSesm6AOyeO/QpBRQIflq/TJYR9j7JVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266174; c=relaxed/simple;
	bh=RqPfgxPamFr6lqnt39EHhN5Z6xIcw2+kX2pEDF2HePg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDbQ3rClhWcN416Gfo7/0LMeNKI9WPRR5cTEjQAsANmIxP+tXZexWmMUv3fItFWmjq2CNZtKBNcimTTaqOIzEU61G5raBer1O5UBbdva6uNMAoosQ7/Bz/7JwSNi/lLzzf2dV5PNBf5vpAB2vTNbsZsP2hsoJT1nitRyR3xSe8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR7cDe8s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR7cDe8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF043C4CEF7;
	Wed, 11 Mar 2026 21:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266174;
	bh=RqPfgxPamFr6lqnt39EHhN5Z6xIcw2+kX2pEDF2HePg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RR7cDe8sIoV7Mr9xozdCtxpRNbXFZR9o2LjH8/r4P+06X7ee6nQ4FLEXunljXi0pQ
	 f6olV49eAEfBJOP3SMWPBMGO+mhjtMBkUKXzA42MDQALBtvhkWnUqLUmYYqYusTmLz
	 WDHYBcYkVCjVdWPzPo7hhgqYWa7KTe0IlfeRUoxXOm0dNcHKC1zRrEZNSU20m5EG0U
	 3t0a47XeRaVY5C4jb0Oeqp9XTG6B99vhzfawmZOD+RdcLRKNaBM+/tt5tAjp5GzHCu
	 2UBu98VBb9i752LUTbpVbb2sgILk2WoF9Z0IBx+z0a+mIooWl24Vvv8hKDjpcw27o1
	 Wi62iM29MLePg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:44 +0100
Subject: [PATCH RFC v3 01/26] fs: add switch_fs_struct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-1-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2582; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RqPfgxPamFr6lqnt39EHhN5Z6xIcw2+kX2pEDF2HePg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJj+rFNsU46X1u/XJi8M5tDLFy/O60gOmI148/el
 TV/Tsyw7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIld0M/3SEXea33vEo/fRz
 /8/Zi0on33nl0XF4Z4SJy0tj81U2ircY/ooE/5h31z+qcbWd9by3CqaxAuK/vb9Xzki9eeRYvgz
 7b2YA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't open-code the guts of replacing current's fs struct.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c            | 18 ++++++++++++++++++
 include/linux/fs_struct.h |  2 ++
 kernel/fork.c             | 22 ++++++----------------
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 394875d06fd6..c441586537e7 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -147,6 +147,24 @@ int unshare_fs_struct(void)
 }
 EXPORT_SYMBOL_GPL(unshare_fs_struct);
 
+struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)
+{
+	struct fs_struct *fs;
+
+	scoped_guard(task_lock, current) {
+		fs = current->fs;
+		read_seqlock_excl(&fs->seq);
+		current->fs = new_fs;
+		if (--fs->users)
+			new_fs = NULL;
+		else
+			new_fs = fs;
+		read_sequnlock_excl(&fs->seq);
+	}
+
+	return new_fs;
+}
+
 /* to be mentioned only in INIT_TASK */
 struct fs_struct init_fs = {
 	.users		= 1,
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..ade459383f92 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -40,6 +40,8 @@ static inline void get_fs_pwd(struct fs_struct *fs, struct path *pwd)
 	read_sequnlock_excl(&fs->seq);
 }
 
+struct fs_struct *switch_fs_struct(struct fs_struct *new_fs);
+
 extern bool current_chrooted(void);
 
 static inline int current_umask(void)
diff --git a/kernel/fork.c b/kernel/fork.c
index 65113a304518..67e57ee44548 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3123,7 +3123,7 @@ static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp
  */
 int ksys_unshare(unsigned long unshare_flags)
 {
-	struct fs_struct *fs, *new_fs = NULL;
+	struct fs_struct *new_fs = NULL;
 	struct files_struct *new_fd = NULL;
 	struct cred *new_cred = NULL;
 	struct nsproxy *new_nsproxy = NULL;
@@ -3198,23 +3198,13 @@ int ksys_unshare(unsigned long unshare_flags)
 		if (new_nsproxy)
 			switch_task_namespaces(current, new_nsproxy);
 
-		task_lock(current);
+		if (new_fs)
+			new_fs = switch_fs_struct(new_fs);
 
-		if (new_fs) {
-			fs = current->fs;
-			read_seqlock_excl(&fs->seq);
-			current->fs = new_fs;
-			if (--fs->users)
-				new_fs = NULL;
-			else
-				new_fs = fs;
-			read_sequnlock_excl(&fs->seq);
-		}
-
-		if (new_fd)
+		if (new_fd) {
+			guard(task_lock)(current);
 			swap(current->files, new_fd);
-
-		task_unlock(current);
+		}
 
 		if (new_cred) {
 			/* Install the new user namespace */

-- 
2.47.3

