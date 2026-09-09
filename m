Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB77579828
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969204; cv=none; b=R3V7yI4jvq3Z6a1YIjjU+Gsi4/LPVhIyLStwmTW1yUqC+1RXbF+OEPm+LHf7o+BjpOUSq3p58pOlH8HFc/HgK96q/PEilHmvedObe0ogN4Awgdk3Hpgh4m4SDrlWXM0vV7ePlkIpFqtqxn5fzg2sq7BUdfjmxqo3qRmI/TvQF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969204; c=relaxed/simple;
	bh=s8p7ElH9xjNn694l1vqjx8/P0Xr9F6xQfPbQQfoqpvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6jcdJazfBV/pHXFK1qZSzOonMaoQXqBQrg4GqP6YiaTRhfySdgEP7JxODHikLTWlTPFzlgM6Ium/g7DHj2PRp9B2XJ+ZnM9dfb6Xxy239c0z7iLcVmNdAzG8mfq3lyqtb3bfwAGI6bgGVuOo4fuADuR8sX/tGCPJyCu3YZJZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOxEZj40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOxEZj40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA861F00A3A;
	Wed,  9 Sep 2026 15:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969203;
	bh=eOeApeN2qGpgs0Kz5AvLlZFWgpmxPAY/GDe8DhI/EkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jOxEZj40j6vJVSwsDS/ngVI6mIH5IS+o/RmY07/eP31n6anbYcUaij97SJCUI8AEp
	 Y2NGPS/JoVbYmRENSyuTtykTNOWs8tnjKrb0kJLe3TjzYoaI7Yph1msd6w8lKERNih
	 kPByc0aAXWYwZw8vEhAFuMRykUZtcnl/eq7QbyMRB8ExIYQ5oMdblZ3tjiLTzubdEQ
	 R823huwFYm0bK/l8VqveeHMQ7UWZG2oS22O7bZHTpTv15BvH74VD3xynDsp0YLyt95
	 fMwH3W3X78Jo8za0W8eJQuAQp3GeKX8eWeCmz5HJ2wlr2a8DrggGe33LZ3TtXHKM/M
	 lVoEdSDRJwt/Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:52 +0200
Subject: [PATCH RFC v3 09/15] fs: make close_cloexec_files() synchronous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-9-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
In-Reply-To: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2645; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s8p7ElH9xjNn694l1vqjx8/P0Xr9F6xQfPbQQfoqpvg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLhaKCPtFRdup5fav/zpoc4/qcdnLddj1nnA8my35
 jej338SOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyYykjww3lileJXepxR01k
 dqn8Ws9xOvwWr/zmrD2Fn1brT9oqPIGR4fUNSQZGmWkLlR1PbZbSvTmzfIlg2rv+XbvsXx7dPOP
 DQU4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Punting file closing to task work during exec slows down exec
significantly when its done with a bunch of file descriptors. We can
do this in-band instead. Flush already runs synchronous. Jann moved
close-on-exec in e780259b54e6 ("exec: do_close_on_exec() before taking
exec_update_lock") outside of exec_update_lock.

The only lock that's still held now is cred_guard_mutex. It's deprecated
and has five takers

(1) exec
(2) ptrace_attach()
(3) seccomp() with SECCOMP_FILTER_FLAG_TSYNC
(4) writes to /proc/<pid>/attr/*
(5) lsm_set_self_attr()

Four of them take the task's own cred_guard_mutex. When
close_cloexec_files() runs de_thread() ensured that the calling task is
the only one alive in its thread-group. That leaves ptrace() waiting on
cred_guard_mutex of the tracee going through exec. exec already sleeps
under cred_guard_mutex in de_thread() when it reads binary and
interpreter. So while we add wait-time to an attaching ptracer no new
lock dependency is added. vfork() als waits but that's a dup_fd() copy
of the fdtable and rarely holds the last reference. If that's an issue
we can always change that later.

Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Link: https://lore.kernel.org/CAGudoHEsGP1P+sAWaw_tbh1NesJhSeww8869uzmaqtgk8F43=Q@mail.gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c | 6 +++---
 fs/file.c | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 71268b916419..872ce89f054f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1173,9 +1173,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * trying to access the should-be-closed file descriptors of a process
 	 * undergoing exec(2).
 	 *
-	 * This can block on filesystem ->flush() handlers, including waiting
-	 * for FUSE daemons, so do it before exec_mmap takes the
-	 * exec_update_lock.
+	 * This can block on filesystem ->flush() and ->release() handlers,
+	 * including waiting for FUSE daemons, so do it before exec_mmap
+	 * takes the exec_update_lock.
 	 * This must happen after the point of no return, and after unsharing
 	 * the FD table.
 	 */
diff --git a/fs/file.c b/fs/file.c
index f99389bdfadb..2de638d99107 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -935,7 +935,8 @@ void close_cloexec_files(struct files_struct *files)
 			rcu_assign_pointer(fdt->fd[fd], NULL);
 			__put_unused_fd(files, fd);
 			spin_unlock(&files->file_lock);
-			filp_close(file, files);
+			filp_flush(file, files);
+			fput_close_sync(file);
 			cond_resched();
 			spin_lock(&files->file_lock);
 		}

-- 
2.53.0

