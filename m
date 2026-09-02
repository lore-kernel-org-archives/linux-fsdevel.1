Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83F49F118
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364748; cv=none; b=N2TvFwoXJRh5NXMCnhoozBQGTHgia+ElPVgb9+AKD8TrD3bGqkK3azPLFHMvf0HKoHP09f0PyiGaSPWYWwJSHnU1Lumf6hCYrsl5BHX84IG6dI6jJXiSmdNQnjxqs2jh6erYNAi5vfMyWIhXmnhbQC4PrFaWayfwZqpuZEWTKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364748; c=relaxed/simple;
	bh=w5XzCNvtISA11x/79z4k70SkTnJoEx63BOLbxemarHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lXzoK26R+dgefKS0svBd1pMTIgKIJ6lyS5PqRWuhIyfG9dS6HxKJz6ZtKBgQIKh+dSbUvde/zGKCS/DPCVFXHZe0uvi+SEyhJ/dxR3cSeeuMQzq5QGL5B9uWoShfK1LNLqQh8qwpCkqGXz8R8FIz/ucgDVB1WqIaGdH4pVtVYZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYlkQtMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYlkQtMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC59E1F000E9;
	Wed,  2 Sep 2026 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364745;
	bh=L1XJ1r2xt5aE7vmReSMfA1K25jgXdTcqXM3YU0cEydE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hYlkQtMn3bcrXhuLHDGJQ3SywuCQL6wxw1zq/P55laeTRd3eEdSjpbqTBqB272sN8
	 ZC4+f1na33Xt9PmyyQNerhGoJpr4X++W6MkLRKUHSgGlILMmYSqRoyfGf8lWyv2/Lh
	 8Kd3ik+96s8e/7teUurzryH1FiTXotuy2G8CwmmycQhkGkoPl1lK+HWDp+mSeldAZk
	 AVBZxkkQm95wuvGdoDrIpKZENw4LI3kOIBCOh60UiszJSLugrDBJLez1CApdFzYNL3
	 YKnWm45e9Xb45+ZzF/Do3N8S66P8OE+MM6Ya+u6+fLDmncRTBof5ZnWlADzOFhJkZI
	 i6iJbrGCW5/3w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:28 +0200
Subject: [PATCH RFC v2 10/16] fs: make close_range() synchronous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-10-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303; i=brauner@kernel.org;
 h=from:subject:message-id; bh=w5XzCNvtISA11x/79z4k70SkTnJoEx63BOLbxemarHg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF+h4XWZYdLMBTViuwqn3mdVF/FStv47PaDFVY73Q
 8zX3iavjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlcW87wTzUiVi52S/PDWyk8
 x1Rrbc89KfoxW9WWreGMyAq59oRwT4b/nhpLhVzOLptqFn/3Au+XWkEF8czrHR/T1hjbZatuypR
 lBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

__range_close() closes through filp_close() so every file the caller
held the last reference to is punted to task work. That costs one
cmpxchg per file plus a list entry for any later task_work_cancel() to
search under ->pi_lock. close_range(2) exists to close many descriptors
in one go fast. So convert it to the same synchronous treatment as
close(2) and close_files().

We collect the last references through filp_close_list() and run any
final __fput()s through fput_list() right before returning.
close_range(2) now behaves like close(2).

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 47ce844be95b..608e6a1fa69b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -798,7 +798,7 @@ static inline void __range_cloexec(struct files_struct *cur_fds,
 }
 
 static inline void __range_close(struct files_struct *files, unsigned int fd,
-				 unsigned int max_fd)
+				 unsigned int max_fd, struct llist_head *list)
 {
 	struct file *file;
 	struct fdtable *fdt;
@@ -815,7 +815,8 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
 		file = file_close_fd_locked(files, fd);
 		if (file) {
 			spin_unlock(&files->file_lock);
-			filp_close(file, files);
+			filp_flush(file, files);
+			fput_close_list(file, list);
 			cond_resched();
 			spin_lock(&files->file_lock);
 			fdt = files_fdtable(files);
@@ -845,6 +846,7 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 {
 	struct task_struct *me = current;
 	struct files_struct *cur_fds = me->files, *fds = NULL;
+	LLIST_HEAD(to_close);
 
 	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC))
 		return -EINVAL;
@@ -876,7 +878,7 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 	if (flags & CLOSE_RANGE_CLOEXEC)
 		__range_cloexec(cur_fds, fd, max_fd);
 	else
-		__range_close(cur_fds, fd, max_fd);
+		__range_close(cur_fds, fd, max_fd, &to_close);
 
 	if (fds) {
 		/*
@@ -886,6 +888,7 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 		put_files_struct(switch_files_struct(me, cur_fds));
 	}
 
+	fput_list(&to_close);
 	return 0;
 }
 

-- 
2.53.0

