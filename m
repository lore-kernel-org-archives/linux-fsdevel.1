Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA33AF669;
	Mon,  1 Jun 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322220; cv=none; b=HBtzuq09lz6QfrKXvGajAcDbqrcWIZpsAI7pmdyOo5iwPqas4yQvNq74EZ1RgsiPm8xoNWAQPr3sx6NxxR2RenoAv7zR+hY02wHDl58rVXQ9GZIB0rKW27dhtnv9OxkWeCPX0heYVIvx1z4oncA3H7wKg1bHQmeaqvkFz5FQSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322220; c=relaxed/simple;
	bh=uzDsq5saOQh+1Y1bm40YmrgnDb4r207ZRmo9VeInStw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PGG2aFTZjoUb+ObNi7rGvHumqP8vSZVinRA5DDi2YggHfKYr5s/T70w6PNIp4A0+oq80Kp7z5Lk2IjC/NQ04OL74LRzeMUFcD1J8VB4yPG8PlCVDvhgYM4edQ++iCck7FScJQ1Lzw0P/kQn+8m0slDW0A6T4ODimGkrhqg7yg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ0HbSTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ0HbSTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3A21F00898;
	Mon,  1 Jun 2026 13:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322219;
	bh=+2qRXu5+Zv2hewWQhS9ylqafA5cEsVCwivOZguEcn6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JJ0HbSTAKgfVk/VovJMwvvhgqKo/i9b+EHCqYUWT+pxJmbVoIBk8almx6ACfiR50d
	 zAMDH27BZ/6IuBFqsRauo0wf7fBQyYUEbrLbwWsiXkImRks73BfJELHCew6qWy7jKO
	 Rsv5cesv9OoAgPH8W0cIaX8Qeyb+x/ILFOtKcexWV34a1EwHrwYaDAvlFD9yNyjOnB
	 gwqEmLE62ptEQxSKKs8XUhbM7/boDm5E+HVfHfQzvK5134+hldeqZrXbEg9ZChrTaq
	 iytdZXLCKosk50fgh/nOZCRqTBdyPvTy5tWBKG23+1YzHSlN3C28F8+xp3eLYaQqpi
	 lBocByvkbkwVg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:34 +0200
Subject: [PATCH RFC v4 01/25] fs: add switch_fs_struct()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-1-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uzDsq5saOQh+1Y1bm40YmrgnDb4r207ZRmo9VeInStw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i/13/iPZ57KmnRWvhkat1fbXZh0omuHieakzq+BH
 Du7vqcs7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIBVlGhjUef77czfjun/uR
 n+/eB/Wr/MeMSt/68u7XlD7lsDPvZS0jw6tXj38XG1kdjzTvZfG5P23fg3Odi3PD7TJ4zq0sznz
 /lRcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't open-code the guts of replacing current's fs struct.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
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
index f1ad69c6dc2d..846a49088fae 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3192,7 +3192,7 @@ static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp
  */
 int ksys_unshare(unsigned long unshare_flags)
 {
-	struct fs_struct *fs, *new_fs = NULL;
+	struct fs_struct *new_fs = NULL;
 	struct files_struct *new_fd = NULL;
 	struct cred *new_cred = NULL;
 	struct nsproxy *new_nsproxy = NULL;
@@ -3270,23 +3270,13 @@ int ksys_unshare(unsigned long unshare_flags)
 			new_nsproxy = NULL;
 		}
 
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

