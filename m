Received: from mail-yx2-f18.google.com (mail-yx2-f18.google.com [74.125.224.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9BE4CC620
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213008; cv=none; b=o4TBAnyPeRSC9Y0P8ONVstaYoLkjHds3w1VP+ahXUircIfnDiGnqNpJtGg7cjIrMab9OcKFFp8WSs5A1dfDl72s71OvdQhdgRaw7Odr7EXkuXFB94soNN5hyg6UkwC/lTrBgyZmm8a24dPlaZmNHT2xtQ1uvFh80koQoo48lNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213008; c=relaxed/simple;
	bh=K47S0o1IDTs57pfVqb5rYlm9JcVvnUglkwthK/H1mRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNi63PtZWSKPU7FYb312u/Mxr/UW7SYoOv4U8k6bTjzIxXGA3RIl14rs0uDc2dhgrYiFbJ6pqOB1DvpRqsssxnkYv+5JlE6H1AgswQGIaxn5tL+LWTuzkyc9OtBt5o8wxNVtWAx1tn4YK+MIG9Prg7pgtmqV9FvAInmWtI2urbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=w31Q5w6S; arc=none smtp.client-ip=74.125.224.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="w31Q5w6S"
Received: by mail-yx2-f18.google.com with SMTP id 00721157ae682-8abc87cbd93so13238507b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791213000; x=1791817800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+LAF+kkW3AoPDUIK7HIdkMlRTlUPB1ATHdV+Y8MxEC4=;
        b=w31Q5w6Sp/xpjvwMiFNOqqmNAAvLTQuMo9G0/hihQ/TDFNkczuU4s0RyUXcINGRcfR
         RwnKWBHYuHsh57niyNQOlo9Ef5DK6+LFVG/O2EOQAQX3QiGEQLq5ENa/vr/D0gXH85jS
         5qJviqFyCK4qvaubyaoMvbvYvbDUdr8LhGabOby0TT8cU1lY1GttHNEjRdxDjjifQJ3t
         9cPS38ODR23KPlXAwL5WtdDjyc2lA1fLRJEppcz+d5EvgEjWScRBiR92j0emAufqMRad
         966tmTKxu3zkroMyGMLmyqEvXuFqsk6qKEuql6YFTW64tWuY/5m3MS8yq3lQkvKoJHjY
         Kt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213000; x=1791817800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+LAF+kkW3AoPDUIK7HIdkMlRTlUPB1ATHdV+Y8MxEC4=;
        b=gtzk/qLCnuntCLckHjOW+EAaNNv1nSvjv7Ktuo3Rfp9de4b3uQLDjiIjY9A09O7XS8
         rMlymjXKRpKRa7/N1KQSp8EwwGozhbm0f+CfOPlK2u46xzRf61lIhyHLBkRPxtnL6oFO
         84P36tXrUpYHXW5ZfK51lek9gqeEsIGWF3Pb/afaxdotyEKLQuWEsFgoOUjcWMjbEgiG
         N9JtuhbXwyciRATLXH5PqX7dlNGq+CTUgn/Na/T43QQG1qlOxnRm1t3b9JGEfDO7QGqN
         713HU6x+iKsce7OZLQUtBBlG5+DzDdfvaWYNvTG9I53nQ/A0sHX9hyupYtBbstBakjJr
         9j+A==
X-Forwarded-Encrypted: i=1; AKwUvBx4d102XvRfqtc99YRPhq2Z/zZPGdH0HBR5lcdyHzsDN+E92MM2+DI9i5b10OPXELgSy40vhYJs/U1wDBW4@vger.kernel.org
X-Gm-Message-State: AFq9FYI0OeUSY/9gb3j+y99t2fhwNkq/1zBYgDfxAPPosGmNV53RMk1U
	PhnXC/3vkiTWvQgLg30T0KT95Tv3qRlovIoEjCpPC+ddeExv34b3FdPniXAA1/8oSt9y
X-Gm-Gg: AYBFou1jFQSpB/ogBV7PnMhT0JBahfmM5NsUggmBjfomi+Hk0nd8UwgPFqJBms4EOGm
	jAAuyXltpcYJTJhwY4kR1GQ4Vpsenp5SWV9VKV4pbv/xh9q7wRUdCreryMirYkmIQ/l4MBzp532
	d7pq35CmEggmcwIPcHx+aTHvzMqdWitS0H7ut5NCvQUMSyoYtR3w0eqauNFJiskHVKDBF5XntX5
	tOJQ0J3WTT3X/KhO6Mm/eB6CSdiMhX10gBKoi+8TsHeRWvjYsYxr4GJ9bnK1rIfA6E9ce7sw7fS
	FhjuQqLOYIHcgR+nZe8HWA696tHmeH6RRP5xGbwSXOLOXwXRV/YW/lv9OY6yfqWXxvwj5KYFPJC
	dRZa1wdkVV6hlBB/aL1mZir7jwpdw/MxCcMp+OkoeYcNilJStPKSePyor8pNE0kBlUy4STeO62+
	BqRz/ZzGbq+A9DV5Ph31VF4OmnHF+Kiza+DZO3rgtI92F0aUWEhPk5VdiDyJhWycP3sw9O4ScHX
	7vcayNhxzHEKZ1SEdE36BmIWRGddbByDECmxRU8gDlz9MMh5bws8GQ=
X-Received: by 2002:a05:690c:60c4:b0:883:768:7432 with SMTP id 00721157ae682-8ae3a2f521fmr49906927b3.49.1791212999962;
        Mon, 05 Oct 2026 08:09:59 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:59 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:39 -0500
Subject: [PATCH v4 09/10] pidfs: record the coredump on the dumping
 thread's pid too
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-9-350183b6e02a@amutable.com>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Eric Dumazet <edumazet@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

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
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 fs/coredump.c            | 22 +++++++++++++---------
 fs/pidfs.c               | 11 +++++++++--
 include/linux/coredump.h |  4 +++-
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 9b267d3c0ed7..870ad720b215 100644
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
2.55.0

