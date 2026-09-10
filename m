Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01682F25F3
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055324; cv=none; b=Uw1SYolRcq5mbXKxd1sMk2clLF5qxanOerg5PacJmz/Zm37fFnUbOC7HIyvy5I7mhie9WNU55Bk4oM7lPivbIdsm/iAZ9WWpdtU3HYhwaywYPdgoYGygHHuSK8k+KG0Y+N03TeYMiqCumn7CQidLzfRo9vxmCnknOir0eh6Snb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055324; c=relaxed/simple;
	bh=TPRhuqVrGxIg6pWqw6kj7D9anREDeG7QdvEtijGGrAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBqf3HSvOZXI+HGJsrsWeEd/+STBKqga0GUMHMx1bIC6iuHdeHT/hNokCcdTXXQV86tqaFqjVT2HcfH/FlHXlL2Ik5Acw7tmC9S/kXI+4dGwfUJs9N2HRf4dKAVT4Y215AiefWl4MmYjTgN2l2L2PSJ1AI8gdE4WrEXwBq1nRkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+w0pqcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+w0pqcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BC41F00893;
	Thu, 10 Sep 2026 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055323;
	bh=er46SIE6PcQdytIzMSb+MKAMPlm1xhbelm0B2x8TLuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c+w0pqcTgpN4WY8SphB2uzqLTAKl6sjeQdhE4qKsF2768yBYanfEzfSnABWtKOW3W
	 PQADlrodPQBxHAEKpruFZUzqlferXrsCVc+EK/jGNuKAZ88Y0FpKA5NO92b7aNY3CQ
	 iiYNFlq8qApvT0AcrEV9xMSSWngaexYFj4v+nmENLfm7b1Fnv5teL9iVs5143cmO4j
	 yEO6c4BgExA3qjWDwgOuLKLFa7EOZZWx/Qqq6AMjAEAm2jhM/FsOq1hk6uqe9oN1ws
	 /4UJ/vAh+r3DmZ61w9QQM0ejxs0YacG2y3EhCLHnnfYu7ewxWYeK48/tzBUdKkTpsf
	 iBFuIkiimXneA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:07 +0200
Subject: [PATCH RFC v4 09/18] fs: make close_cloexec_files() synchronous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-9-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
In-Reply-To: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2573; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TPRhuqVrGxIg6pWqw6kj7D9anREDeG7QdvEtijGGrAk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumi3i4dnksoBjfNrd39af1Gl+pWe34WNdnsDfiw6w
 qNvs6wpsKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAifdcZ/sfr3D2id3G+d+bN
 RT93Zglx9vcw2/sWP5siGZnf6rb95SKGf3p7RGSuLK+U3lHSUfiOcbW+7+2Ci/U9c6Oa/Rp3fZl
 xnREA
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
close_cloexec_files() runs, de_thread() ensured that the calling task is
the only one alive in its thread-group. That leaves ptrace() waiting on
cred_guard_mutex of the tracee going through exec. exec already sleeps
under cred_guard_mutex in de_thread() when it reads binary and
interpreter. So while we add wait-time to an attaching ptracer no new
lock dependency is added. vfork() als waits but that's a dup_fd() copy
of the fdtable and rarely holds the last reference. If that's an issue
we can always change that later.

Link: https://lore.kernel.org/CAGudoHEsGP1P+sAWaw_tbh1NesJhSeww8869uzmaqtgk8F43=Q@mail.gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c | 6 +++---
 fs/file.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1d9163155d16..075a744421e1 100644
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
index b0490566719c..76e328edf630 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -928,7 +928,7 @@ void close_cloexec_files(struct files_struct *files)
 			rcu_assign_pointer(fdt->fd[fd], NULL);
 			__put_unused_fd(files, fd);
 			spin_unlock(&files->file_lock);
-			filp_close(file, files);
+			filp_close_sync(file, files);
 			cond_resched();
 			spin_lock(&files->file_lock);
 		}

-- 
2.53.0

