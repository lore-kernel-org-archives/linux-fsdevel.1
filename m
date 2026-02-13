Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70AF3542C3;
	Fri, 13 Feb 2026 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979490; cv=none; b=eS4hMiP6GNsz1afxGQI2jU2BPsrq6f8vRIitQFYO8FWYsWq2sSdu8gRw/X2odKSVJdnRLgaNvEGKpNAjj+IxSkUHFQpxqWtrAsp1W1OiFlgkLBC++FEMicpGgtmQZnH733FCrIZKkbeQLOABrKj0K/SArvLBOVR7x4n12LVaJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979490; c=relaxed/simple;
	bh=kpXfv1aQjmRM7Lisa9SQR+o6ZN41NjPHRd8/uCOz0mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbCvygkvp3Vy6G1Di9ylIRnd4ouUxihKEm0abkIL+VxBvq9L27F9fDmP+dwYJUeJD9bYYY71jnRNOT7ue8aOOShnREqoEjqgF/H/9BUd9Bpz9BY1AbnvGDlUgwY8eFETp5rDu8p4IXMsR4cMavGLec1YPcFQKpVhBIi0bRUtDx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJnjD40A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJnjD40A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD0AC16AAE;
	Fri, 13 Feb 2026 10:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770979490;
	bh=kpXfv1aQjmRM7Lisa9SQR+o6ZN41NjPHRd8/uCOz0mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJnjD40AgaXOaFd2bB3q+hhoLOS7vWRMoLrKTwdz6g7aDZe1E48kbxJQgtAlhsC1D
	 KaZRQ1JaeyEaZAV3MV24Z2x4k2jHBI7MqMv9O0AOGiqxgAk8lAxRCHM2wVrKnX4hoE
	 +H9m9Z6hZIP2J88prwda4mJ2TsrF+vX7kRsjqAeJEgPUMP73P7HP/IsLEiFSaehydr
	 qfeF5ropfWFfOnT6B9JWg13kBmbaOmhtDvapThmWfiNKqnWlb/ucjjpzbZ42ZgR0CU
	 056TURduuQmvC9m4W6hY84cjeSZtRDva6ENfXUGMZsYV76Up7GiWN38/sjP9rMZVt/
	 P6DfLmco3Ttig==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/5] proc: subset=pid: Show /proc/self/net only for CAP_NET_ADMIN
Date: Fri, 13 Feb 2026 11:44:27 +0100
Message-ID: <624eb242fab38fd01589fb5cb51c65617620be89.1770979341.git.legion@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770979341.git.legion@kernel.org>
References: <cover.1768295900.git.legion@kernel.org> <cover.1770979341.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cache the mounters credentials and allow access to the net directories
contingent of the permissions of the mounter of proc.

Do not show /proc/self/net when proc is mounted with subset=pid option
and the mounter does not have CAP_NET_ADMIN. To avoid inadvertently
allowing access to /proc/<pid>/net, updating mounter credentials is not
supported.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/proc_net.c      | 8 ++++++++
 fs/proc/root.c          | 2 ++
 include/linux/proc_fs.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 52f0b75cbce2..6e0ccef0169f 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -23,6 +23,7 @@
 #include <linux/uidgid.h>
 #include <net/net_namespace.h>
 #include <linux/seq_file.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -270,6 +271,7 @@ static struct net *get_proc_task_net(struct inode *dir)
 	struct task_struct *task;
 	struct nsproxy *ns;
 	struct net *net = NULL;
+	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
 
 	rcu_read_lock();
 	task = pid_task(proc_pid(dir), PIDTYPE_PID);
@@ -282,6 +284,12 @@ static struct net *get_proc_task_net(struct inode *dir)
 	}
 	rcu_read_unlock();
 
+	if (net && (fs_info->pidonly == PROC_PIDONLY_ON) &&
+	    security_capable(fs_info->mounter_cred, net->user_ns, CAP_NET_ADMIN, CAP_OPT_NONE) < 0) {
+		put_net(net);
+		net = NULL;
+	}
+
 	return net;
 }
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index d8ca41d823e4..c4af3a9b1a44 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -254,6 +254,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 		return -ENOMEM;
 
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
+	fs_info->mounter_cred = get_cred(fc->cred);
 	proc_apply_options(fs_info, fc, current_user_ns());
 
 	/* User space would break if executables or devices appear on proc */
@@ -350,6 +351,7 @@ static void proc_kill_sb(struct super_block *sb)
 	kill_anon_super(sb);
 	if (fs_info) {
 		put_pid_ns(fs_info->pid_ns);
+		put_cred(fs_info->mounter_cred);
 		kfree_rcu(fs_info, rcu);
 	}
 }
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 19d1c5e5f335..ec123c277d49 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -67,6 +67,7 @@ enum proc_pidonly {
 struct proc_fs_info {
 	struct pid_namespace *pid_ns;
 	kgid_t pid_gid;
+	const struct cred *mounter_cred;
 	enum proc_hidepid hide_pid;
 	enum proc_pidonly pidonly;
 	struct rcu_head rcu;
-- 
2.53.0

