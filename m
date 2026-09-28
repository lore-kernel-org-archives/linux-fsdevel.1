Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB248FF6F
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587670; cv=none; b=SRA29bqM3fZAzBTGZoNOGT9rlwWSxE0Il7RRmS9ZCGfOAqvwljdJ4I8y/ucVikIWoMQrLptoSRrJkmY+5n+927WNJdYxObQJygn2f66pJ2w76AAgP004OK6+HiqgV69cM1ghdw0QcKROv740BVq13ThhpLSDvAThepyxDeSW/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587670; c=relaxed/simple;
	bh=K47S0o1IDTs57pfVqb5rYlm9JcVvnUglkwthK/H1mRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c/8JZB9pdYen1GVTnzJTjheuoLC98CGnntWl2ONctEGewU0WjC9blxniCuVF3duUArhisjQo5hRFNf9Tpkwryu5eB/tt3ZFvsnAo9WTZFiE/FPwCp22csCcM8j9Z+nHDReJEFMZtckmD1yYqX8Kx0BeXqBHJpeQrE+Mxz2yYOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=k9Z2m/Bd; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="k9Z2m/Bd"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a4fbc5586so419527966b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587665; x=1791192465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+LAF+kkW3AoPDUIK7HIdkMlRTlUPB1ATHdV+Y8MxEC4=;
        b=k9Z2m/BdqTzFMoyHfv/JOARWm/8AnlceIYR0N7n5+Wmg5ipNyzKzyIJjnxQDOwjjXT
         s5UefAkoWyfXD4/hKaXSDdDAyUwTXVdL+7mFELQWXHAKNozgGjjeTzjDgtAQ8JvRyRSx
         v0s4msjOmS5GzYSDXMG8TICnot+7vHlUL0sIARwOkLbCoAAyNndCYAW3qEwcYIuntI3t
         8yoE9yseKi4a4IIWsWFftPkoet8D4rSWcclWmrwXEc/D+2/sX+E1d8LaHjwfyEEZUpZR
         kdGenezbQx3d0FzoZsfj/MfuWlH+Exv8H84BxPl8hg/KKol6YQmlQ712okDC06NG97Yg
         NCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587665; x=1791192465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+LAF+kkW3AoPDUIK7HIdkMlRTlUPB1ATHdV+Y8MxEC4=;
        b=V9DSscro5CctKuk7h5WITqaWEaC5OeHW/lVCjXZoC+7DbborOWY1hSGcbyiU6XWVvE
         c9F2UIpt7Qc5m6SnBxhVHFXjfI+YPRr1arbp+lurC3EdKG8nfwmh2sPBv3RC+wrjRt5z
         jp710B99iTID9GlhYQCm/ZlR4C2VoGiSAZmscLSD9/YsAyAHWexyf9VfFJX8NpdzXSv8
         9wfgyPwRWiq8sTmucwfgFLUCTU1VEwyZL/+veucBie+CO0N2f4qUNlvOc3TOmm9TLwnU
         JNHEhcZf19GGbvzjXkbvZBtRlCaiFO82LTxsSTXQ0Ab49h2XDni2IJm5D0f6c9t0btMe
         WgDw==
X-Forwarded-Encrypted: i=1; AKwUvBwhvu5L9ASv02MmV6V5l9EDWBTG4QBJMPijQFkpckorDIAZOpVYHltyC6hqhVOmBXD90UNpBnf9o4CWmeWc@vger.kernel.org
X-Gm-Message-State: AFuF++mxNhX9ED3oFtV0RkeRD5UJYjplgXh9gOOFhHftjPG5aN7ynzJs
	f0UQpBbUmJcNxvffVOXHtoVZFJa7qcrU775Tdi5S8Zkr4gdDCDdH5FFT7cxzn9bLMIFI
X-Gm-Gg: AYBFou3P+h2IzUgleaHOsc+hmGT7Bi1u9gki1Szv3li/hjT1sK8af20junXEZjz6nzq
	a8FUpWgLaxP1pk4+uF8IP68G5O+UkiXZegA4gL732xTis5ac0o9IdHbNCHPQ3VWEISm5C9uqqTp
	yo3dSyEYYPsxblOST+wV1CcVp8vRk9qGAVbMpn6SkHc1a4UxDgb+MbP8tES2js7CFR0dUGoQZN1
	9XuKAyPiRRq3nlarr7SkC6Knj+suVsAAz0vSDkhO9OD1xLeJv9VGjOvXcLBlgchSWh1nX7WuWpy
	13M0pI6UCPNGoMWkWb5rXyzyaEzTeij34N4ZmYHXS+AtLjpucRaUc+neFcZ0KnK2s8i2Y/6Im51
	zx0bqzzRgwbyI1ODZXL9cmab9cXbVqs9OQB6IzJ52CqOhpZ0YnRO6EEm7nwnOZutc73NyhNwDzH
	iuRYROZSV+TcHN7KsocWEpMACQSU+hMXAiS2JypLj1BECX+t3YBzLfzH/iyKPkcI3Ma7tW4zl5O
	e4AdV1OAf0/9MbRONh8fprnOh6DaJWrx2EctDSCtLxsguxLAqrS
X-Received: by 2002:a17:906:9fc4:b0:c29:f5d8:9c76 with SMTP id a640c23a62f3a-c2ac229852bmr1018769466b.37.1790587665531;
        Mon, 28 Sep 2026 02:27:45 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:45 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 28 Sep 2026 11:27:16 +0200
Subject: [PATCH v3 09/10] pidfs: record the coredump on the dumping
 thread's pid too
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-work-unix-passpidfd-v3-9-532018a91b21@amutable.com>
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, 
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

