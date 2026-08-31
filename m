Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D83EFFA9;
	Mon, 31 Aug 2026 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175321; cv=none; b=QYh/FTb1Zo0XndWmapHrafl5UNkoDzZYEhQhDUY/MZY+Q3xuO33kWjjgmII5O4v6olL455G/ffjNXfRjXfMemgdRkmFuS6q5lzo7EtO0Pqq81EV3llw2Dhs1gzEzvAvthEYUMW/Yzr7PCUgtzjwB44J7HYJAoZhO2FO3QNPHR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175321; c=relaxed/simple;
	bh=VLssKX8GIOxfbHmQLMsVyfJ1wjYRa6l1ALugNjTkGP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFh32TwNKm9utzSmLq8fT8Ssz33klt1EbyBUw0zZwHYCBBMCzr8wMw5y9UJXdKyIkKi+K6ruTcYODDpL4UEOLw9UAuXRq8x/0K2kWHOQFFZEhGCMgXfp/EswmEeImVKs2Z7SICIqFeMZ+lg8z8dmvPu+kOWbgIIL6MTAEccrdjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm+Gtv/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm+Gtv/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C6A1F00A3D;
	Mon, 31 Aug 2026 11:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175320;
	bh=6ELI+s/2g2iPQPGx3WRbVPVNLhrYyFGbu19t3cCh+FA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wm+Gtv/MPvueJtqbljoCLIXCcW1ukR1bhLUz4uIJtVbZurSMQOGeYKw6V750lZJoe
	 rv4NokgI+vj1urVOmSIDwTnexdZkm6ilevHzhH0qPs4+IjB8M/hY9IHYSqBI9Ifoho
	 CU0y1TpuOty5IZrUQXvapC58baZvqYYYfePWgfNdAzvAfyjX5WMpcYxYuW+Y8ke/xw
	 m3nXCrCAEn0rnEjvYcnD3ISNQpQBlIrCKxBRahAnZWSxjXO21x9cOUGXd1Kz5acbKb
	 23dgR42xBXL5rcsmh576zdFNEkvcsnVFdFevFukPilNxElT9+KQEvgMNmMWm5YYrvO
	 8DUh186wtk5Mw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 31 Aug 2026 13:21:21 +0200
Subject: [PATCH 09/10] pidfs: record the coredump on the dumping thread's
 pid too
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-work-unix-passpidfd-v1-9-70cbfda0c7ba@kernel.org>
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4565; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VLssKX8GIOxfbHmQLMsVyfJ1wjYRa6l1ALugNjTkGP4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNTd648tabbNXT9c8l5tp/P/6venOwQF/Ukwe3BU6ff
 3mf7ZxNRUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEuHkZ/tkfuCixa3L/ea7Z
 Fr9XrMw1WF5gXzM1MWrOxvksEu3Ml78yMuy78OCRKhdzlU1+ZuRMu3AHrbV2pofZtLQ2xH10v1L
 iwgUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

If a thread-group coredumps only the thread-group leader pidfd will
return coredump information. A pidfd for the thread that took the fatal
signal cannot be used to retrieve it.

Record both the thread-group leader and the specific thread that took
the signal and register both in pidfs. Mark both the thread-group leader
and the specific thread with the coredump information so retrieval works
for both pidfds.

Now that both SO_PEERPIDFD and SO_PEERPIDFD_THREAD are available it's
easy to get the coredump information for the specific thread.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c            | 22 +++++++++++++---------
 fs/pidfs.c               | 11 +++++++++--
 include/linux/coredump.h |  4 +++-
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 71a0093ada1b..b5ff4b3e1831 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -454,7 +454,7 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 				 * leader we know that the thread-group leader
 				 * cannot be reaped until @current has exited.
 				 */
-				cprm->pid = task_tgid(current);
+				task_pids(cprm->pid, current);
 				err = cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
 				break;
 			}
@@ -626,13 +626,17 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 	struct coredump_params *cp = (struct coredump_params *)info->data;
 	int err;
 
-	if (cp->pid) {
+	if (cp->pid[PIDTYPE_TGID]) {
 		struct file *pidfs_file __free(fput) = NULL;
 
-		pidfs_file = pidfs_alloc_file(cp->pid, 0);
+		pidfs_file = pidfs_alloc_file(cp->pid[PIDTYPE_TGID], 0);
 		if (IS_ERR(pidfs_file))
 			return PTR_ERR(pidfs_file);
 
+		err = pidfs_register_pids(cp->pid);
+		if (err)
+			return err;
+
 		pidfs_coredump(cp);
 
 		/*
@@ -695,12 +699,12 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
 		return false;
 
 	/*
-	 * Set the thread-group leader pid which is used for the peer
-	 * credentials during connect() below. Then immediately register
-	 * it in pidfs...
+	 * Set the pids of the dumping thread and its thread-group leader
+	 * which are used for the peer credentials during connect() below.
+	 * Then immediately register them in pidfs...
 	 */
-	cprm->pid = task_tgid(current);
-	retval = pidfs_register_pid(cprm->pid);
+	task_pids(cprm->pid, current);
+	retval = pidfs_register_pids(cprm->pid);
 	if (retval)
 		return false;
 
@@ -722,7 +726,7 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
 	}
 
 	/* ... and validate that @sk_peer_pid matches @cprm.pid. */
-	if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid[PIDTYPE_TGID] != cprm->pid))
+	if (WARN_ON_ONCE(!pids_equal(unix_peer(socket->sk)->sk_peer_pid, cprm->pid)))
 		return false;
 
 	cprm->limit = RLIM_INFINITY;
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 586af2e5811c..29299b2c7ca7 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -793,9 +793,9 @@ void pidfs_exit(struct task_struct *tsk)
 }
 
 #ifdef CONFIG_COREDUMP
-void pidfs_coredump(const struct coredump_params *cprm)
+static void pidfs_coredump_pid(struct pid *pid,
+			       const struct coredump_params *cprm)
 {
-	struct pid *pid = cprm->pid;
 	struct pidfs_attr *attr;
 
 	attr = READ_ONCE(pid->attr);
@@ -814,6 +814,13 @@ void pidfs_coredump(const struct coredump_params *cprm)
 	smp_wmb();
 	set_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask);
 }
+
+void pidfs_coredump(const struct coredump_params *cprm)
+{
+	/* The dumping thread's pidfd reports the coredump as well. */
+	for (enum pid_type type = PIDTYPE_PID; type <= pids_last(cprm->pid); type++)
+		pidfs_coredump_pid(cprm->pid[type], cprm);
+}
 #endif
 
 static struct vfsmount *pidfs_mnt __ro_after_init;
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 7b38ee2e7913..0bbb7de6a402 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/pid_types.h>
 #include <linux/sched/coredump.h>
 #include <asm/siginfo.h>
 
@@ -32,7 +33,8 @@ struct coredump_params {
 	int vma_count;
 	size_t vma_data_size;
 	struct core_vma_metadata *vma_meta;
-	struct pid *pid;
+	/* Dumping thread and its thread-group leader by pid type. */
+	DECLARE_PIDS(pid, PIDTYPE_TGID);
 };
 
 extern unsigned int core_file_note_size_limit;

-- 
2.53.0

