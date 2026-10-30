Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365484;
	b=i86LfJ9Tzz9OojR+qtHlidwPyHW5l82xyyibQCBaOFKs05g8DofT2T+M/jYBQIFtnN6Y
	 qbIPjRztqdYJLmtskcyinZaTHZzcGoGs47YQJXjZsQ0i1AQInnSAx9Yn5oC0m7X8HsJ3S
	 ohKV5pSxmozGKvrBUvAg0u8lAFDT25AirLkAGLDfkurKaJc790K0kfapvWjFF1tKwF/Fv
	 saJi6S5VH1oazLNGQkHRvCD2ZPSkiKMhWvRaPHyXfSiHRfV7jFVfvtJXnfJ7xoXal+oMV
	 RNE4Q3hFsDwJUqTotC/tIaB0Gl1xaDcqT6YEkB+D8oHkBmt1hndFuvZFqum1mdEVGNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365484;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0IWmS4WC95xy01as/JCFcIPD2W8HOZ24Kv38L9m1u+w=;
	b=tAofAloXHsyTW3zgznjX02amDfvp2XLAVe1RsA2NzngjjW4usLuMVJsCsCUysxnTdwmY
	 TheuFyhDuPsPku+0u+W7u7p34ST+JgHEyoY3U9TvJXHXvWYXeG6pOF5SpvK9+D5sqanfh
	 +yjPFVvlDS9bGYKSGFfZ0WL5amSjNuyoNp0T26hkQUOIPKLkPfLfQj7F6RMOQf7hpSUVb
	 ZDoXZv+s45RvdlxgCa5qWFcsKyY1qkL8b1q6+zXLll3Das/D1bozyCgP2zZO72RvYMLaM
	 +bIm6QV7W9po87/7uGX+/lCJttgJ4RXH0offLixxZhLvCTbL5I/7Vtm3h4k2ykXVnoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lMNv5oNm;
	arc=none smtp.remote-ip=91.218.175.108
Received: from mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B3606A322
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 13:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5B3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lMNv5oNm
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=F6CW+GlYFn9RDkv4iwwAtyN5SQkQZyzRTuwmWu/xWfE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793365481; v=1; x=1793970281;
 b=lMNv5oNmjeSnPYhNV8khi6kkZpNj64DyBAOa2NEBopgvnRA3wpxpDddT9FGyBlmCGYox7uVc
 EouGIxXyEVsDlE8S8g4zLrPKd3r7aGNSMbrcFHYEmDQkJWzf8xPKNTpQVfeeRwBHwvkvXa9aZdQ
 4eFn/Zx5+i2oEts4UTQAVvlU=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1c8fc233732a9821;
	Fri, 30 Oct 2026 13:04:41 +0000
X-Mizu-Trace-ID: 1c8fc233732a9821
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Andrei Vagin <avagin@gmail.com>,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/2] nsfs: require ptrace read access for pid translation ioctls
Date: Fri, 30 Oct 2026 21:04:21 +0800
Message-ID: <20261030130422.738277-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030130422.738277-1-cui.tao@linux.dev>
References: <20261030130422.738277-1-cui.tao@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The four NS_GET_{PID,TGID}_{FROM,IN}_PIDNS ioctls translate a pid
between the caller's pid namespace and the namespace referred to by
the open nsfs file without checking that the caller may ptrace the
task being looked up.  Nsfs fds travel freely over SCM_RIGHTS, so
once such an fd reaches a process on a hidepid=2 host it can
enumerate and resolve the pids of tasks hidepid means to hide.

Mirror the ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS) check
the PIDFD_GET_*_NAMESPACE ioctls have had since
commit 5b08bd408534 ("pidfs: allow retrieval of namespace file
descriptors"): perform the check inside the existing RCU read-side
critical section and return -EACCES when the caller lacks ptrace
access.  Legitimate holders such as LXCFS are unaffected.

Fixes: ca567df74a28 ("nsfs: add pid translation ioctls")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 fs/nsfs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 8179d69da038..9ff30bd876cf 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -9,6 +9,7 @@
 #include <linux/ktime.h>
 #include <linux/seq_file.h>
 #include <linux/pid_namespace.h>
+#include <linux/ptrace.h>
 #include <linux/user_namespace.h>
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
@@ -268,6 +269,19 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		if (!tsk)
 			return ret;
 
+		/*
+		 * The returned ids reveal whether @tsk is alive and which
+		 * pid it has in @pid_ns, so require the same read access
+		 * to @tsk that ptrace-gated /proc/<pid> files need. @tsk is
+		 * only pinned by RCU, but calling ptrace_may_access()
+		 * here is safe by the same pattern as validate_nsset()
+		 * (kernel/nsproxy.c); ptrace_may_access() runs under
+		 * the target's task_lock.  The PIDFD_GET_*_NAMESPACE ioctls
+		 * in fs/pidfs.c carry the same check.
+		 */
+		if (!ptrace_may_access(tsk, PTRACE_MODE_READ_FSCREDS))
+			return -EACCES;
+
 		switch (ioctl) {
 		case NS_GET_PID_FROM_PIDNS:
 			ret = task_pid_vnr(tsk);
-- 
2.43.0

