Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93FC4FB9A3;
	Mon, 12 Oct 2026 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843074; cv=none; b=aHduDUEC8u6nmeSv+nrh/YARtJQaPkAeuyAVxTUIn6xyTugm/VkVE6H6F0ZV/tlQOVfhRbaIsgsbPxnKwrR/zgZIxviN3lRAciGVTVYB/If7UrC9feaJ878wgFcT40QrHCR97QoZZtVXjhEcPI+oHU76dVYs7XP3bEbUHxPeL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843074; c=relaxed/simple;
	bh=3qE/16NCgr2cIwk9NkWfjnRCWroBLzKH8rq6AdKxOsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGCByOsReR/5+Skwrr160R1E5K0ap/6v26cpnFx2HgWYSyTIfHBHsncBgETb3WIYZUXqI2cXeCtpEySa7WwzPPr2bSmCgScojVXeflvQ577CYp/JfoO8XVQgZkF6373WApzEBOg/qOHnARyH3otMXaIHmxxIQBhXU/5DUYnfDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1GDGxfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1GDGxfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9861F008A1;
	Mon, 12 Oct 2026 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791843073;
	bh=oKIUKWdhuVRafGZ2fApHnxwzTdQI5O+LciIqoNK6n+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d1GDGxfwXSKMy41xRRAChH55+6kAaMqnW4CjDB+Gk/tQzlxwl6MHJ5d80+oYVv8hD
	 C/DlXgvav1KV8jI9uYeCAAQrTwmaPKOynTwlyJ3jql+qsHD8LtUWW1lFubq/cD0BlS
	 Fi8gmYnayGOmSt/EwwV85nsCSwuAXhl6Di3Y8nSQojjsvxR551y8HodGMUqXhWMlH4
	 1aJfI6Pgg5I2e/CEeGnV1sdJqY0bOv2Is+W68F216fO+I17ZUG7i+fqcOdJrpqaWBD
	 CitMqeV4nNVcoUx/RsTzcCYhcLyGg2a3rZ83ZUGfq7aKa0CMzAIQqmWQ9++hYv5fVW
	 ifL3Cvu13yEUQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 13 Oct 2026 00:11:06 +0200
Subject: [PATCH 1/2] fs: pass flags to copy_fs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-work-fs-idle_fs-v1-1-2063d1bcb5aa@kernel.org>
References: <20261013-work-fs-idle_fs-v1-0-2063d1bcb5aa@kernel.org>
In-Reply-To: <20261013-work-fs-idle_fs-v1-0-2063d1bcb5aa@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3qE/16NCgr2cIwk9NkWfjnRCWroBLzKH8rq6AdKxOsM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdjfqj9aWg8pnd+5dL7j0rVIwI630gd14qdYfotFYzg
 +0c534ndZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkIzsjw93Za1fqlhcI/Veb
 eopjZdJd0ztrjibObJsTuvSFB3etXh3DH76AYOnA2/0zlNqve648/07t+gyZqbMDNvZos6rY7vy
 4kh0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Turn the umh boolean into a flags argument. Idle threads need their own
case in copy_fs() as well and that's nicer than a second boolean.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/fork.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index eb198c8dfdc7..947136cdd115 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1619,7 +1619,12 @@ static int copy_exec_state(u64 clone_flags, struct task_struct *tsk)
 	return task_exec_state_copy(tsk);
 }
 
-static int copy_fs(u64 clone_flags, struct task_struct *tsk, bool umh)
+enum copy_fs_flags_t {
+	COPY_FS_UMH	= (1 << 0),
+};
+
+static int copy_fs(u64 clone_flags, struct task_struct *tsk,
+		   enum copy_fs_flags_t flags)
 {
 	struct fs_struct *fs;
 
@@ -1629,7 +1634,7 @@ static int copy_fs(u64 clone_flags, struct task_struct *tsk, bool umh)
 	 * filesystem state, or be started from a non-initial mount
 	 * namespace.
 	 */
-	if (umh) {
+	if (flags & COPY_FS_UMH) {
 		if (clone_flags & (CLONE_NEWNS | CLONE_FS))
 			return -EINVAL;
 		if (current->nsproxy->mnt_ns != &init_mnt_ns)
@@ -2299,7 +2304,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_files(clone_flags, p, args->no_files);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
-	retval = copy_fs(clone_flags, p, args->umh);
+	retval = copy_fs(clone_flags, p, args->umh ? COPY_FS_UMH : 0);
 	if (retval)
 		goto bad_fork_cleanup_files;
 	retval = copy_sighand(clone_flags, p);

-- 
2.53.0

