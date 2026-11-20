Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182156;
	b=R2nfI6TDbC8llV1om2R6P9Uo9CC5a6JbXyS2gxnNg026laOBbKkePeElkeKDQoEFB+VW
	 WggAFVgPANHZoru9GGyEEVAMYUjYj/K5SOo/0tVsa9fYRfUpO2O0Pfw3FMsLMlhXil9lN
	 gXKnLax75noBcGR3lFHJvgmkPZzUv8s/yiAQYPQpdBctqRGpzcasLQDBrBDk1zdALtiGQ
	 MwxiHFmWt+0W8Yphom6KjUMJ4o2HvAeml7mFJuwJghLSIhpK+muLLBMNf1VuDTgnRE2SF
	 JDXXs6IFsVuTd2zy5c5XBMNSnlAuOyHYfjEjOGMDAV3Txs53PEonOszYuEamtnZH/9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182156;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=F3cUMF/axjpm7NLzQr7ZTPMw3JSwqyBaDBp2ykqJ5Lk=;
	b=RaX6GFZ9qZpmQuCjOfHWrqmtl8GBZXNKCbuX8yT4NHfpa3JPzrrl1SOq/ZelDBVXJKqO
	 DLE8GryTQpwdm6WBMDtRYOWVVL4BAi2YGdSZfoMNPzBcwP5eCJpihqUvQqaCm0SVoKJjp
	 luVyLyDMizo4SbdPb0XOJFE7At2EOR5HQW+vEUCogCIKYA0m8Crrt6mqSS5L7qPOmydGR
	 aMO5eWGKkIsR2UTwQnqpNDyrBdchAWx3IVfLPh7lPmf9jribTDM9jnpKCd9aSJCrTzV7V
	 0MMPu9Ls0cmKXQkjtyYqarAizK+otYs8inBBE77ilMK2uk6QJScha83RBqA7md/P/2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9ejTIGx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46440606A33C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9ejTIGx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967321F000D3;
	Fri, 20 Nov 2026 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182155;
	bh=F3cUMF/axjpm7NLzQr7ZTPMw3JSwqyBaDBp2ykqJ5Lk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N9ejTIGxrkmHTH0Z4pSMVBRLv6qUQ1V40Jw7UJj9j8Ma8BqCixqcSdVamwDMZhWZH
	 KwVq2NWMrGUXhEpW7u5FhkK90AdpdvUhrbkDOCkzsBbbJbJmuMVPohAGlUehkpUp5A
	 ldUhKHz3x3IIysmAMhOKbqWHUQioYdhLIhiHayESvEdSjV+eF4evBWsMBEQ09xN57T
	 6VJdBLeDFmA/OsaER6kBULFJcWPhKWZIv8HoPKfY17DrGnFxK2qI1U4aSpDlL/uH5m
	 SxvC9PfajK1b05ZVY/njp1dVJZMeVXaMkx08CTc5ZxLc1w/IggaNKaCXPPikO8rLLM
	 EFOR7E4L35/yw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Nov 2026 14:42:10 +0100
Subject: [PATCH 2/3] pidfd: convert remaining visibility checks to
 pid_in_current_pidns()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-work-pidfd-pidns_visible-v1-2-0e82d08469ae@kernel.org>
References: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
In-Reply-To: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jiwoo Kim <arpe1618@gmail.com>, Chen Linxuan <me@black-desk.cn>, 
 linux-mm@kvack.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=3831; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hlLoaUSApv644mXQ3+zCbYHIM+rVd8v7BP7D1RrUt7g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQz+NmvcuhY1rnr9Zf1BlJX0nZwTfcJsrlky+4avlNvU
 8P3/ML6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn0n2f47zVnQ4eKyVuu6N9a
 +zVyZrp4TjQNbfthbyChd/K+UlmcDMM/wyP/lylUPDu3tPtz/yz1rjSmmzffXW/S/fLN2+Jf7qa
 D3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Switch the two remaining open-coded visibility checks in the pidfd api
over to pid_in_current_pidns() and drop access_pidfd_pidns().

pidfd_getfd() uses !pid_vnr(pid) which is the same check as explained
in the previous patch.

access_pidfd_pidns() walks up from ns_of_pid(pid) via ->parent until it
either finds the caller's active pid namespace or runs out of parents.
pid_in_current_pidns() instead looks directly at
pid->numbers[active->level]. Both answer the same question. alloc_pid()
fills in pid->numbers[i].ns with the ancestor at level i of the pid
namespace the pid was allocated in, starting from that namespace at
pid->level down to the initial pid namespace at level 0, and a pid
namespace is always exactly one level below its parent. So
pid->numbers[] is just the ->parent chain of ns_of_pid(pid) laid out by
level:

(1) The pid was allocated in the caller's active pid namespace or in a
    descendant of it. The walk reaches the caller's namespace and
    succeeds. The caller's namespace sits at active->level <= pid->level
    in the chain, so pid->numbers[active->level].ns == active as well.

(2) The pid was allocated in an ancestor of the caller's active pid
    namespace. Then pid->level < active->level, pid_in_current_pidns()
    fails right away, and the walk only visits namespaces above the
    caller's and ends at the initial pid namespace's NULL parent.

(3) The pid was allocated in an unrelated pid namespace, i.e., neither
    an ancestor nor a descendant. The walk never meets the caller's
    namespace and fails. If active->level <= pid->level then
    pid->numbers[active->level].ns is the pid's ancestor at that level
    which isn't the caller's namespace, so pid_in_current_pidns() fails
    too.

With CONFIG_PID_NS=n everything lives in init_pid_ns at level 0 and
both checks trivially succeed.

pidfd_send_signal() keeps returning -EINVAL for an invisible target as
that is existing uapi. pidfd_getfd() keeps returning -EREMOTE.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/pid.c    |  2 +-
 kernel/signal.c | 23 +----------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index aa3ed6b5d4a9d..72b98d0f35ab1 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -918,7 +918,7 @@ static int pidfd_getfd(struct pid *pid, int fd)
 	 * Require the target to be visible in the caller's pid namespace,
 	 * like the pidfs ioctls that grant access to its resources.
 	 */
-	if (!pid_vnr(pid))
+	if (!pid_in_current_pidns(pid))
 		return -EREMOTE;
 
 	task = get_pid_task(pid, PIDTYPE_PID);
diff --git a/kernel/signal.c b/kernel/signal.c
index dd770e68faee0..2c2907d969485 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4045,27 +4045,6 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
 	return kill_something_info(sig, SEND_SIG_NOINFO, pid);
 }
 
-/*
- * Verify that the signaler and signalee either are in the same pid namespace
- * or that the signaler's pid namespace is an ancestor of the signalee's pid
- * namespace.
- */
-static bool access_pidfd_pidns(struct pid *pid)
-{
-	struct pid_namespace *active = task_active_pid_ns(current);
-	struct pid_namespace *p = ns_of_pid(pid);
-
-	for (;;) {
-		if (!p)
-			return false;
-		if (p == active)
-			break;
-		p = p->parent;
-	}
-
-	return true;
-}
-
 static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo,
 		siginfo_t __user *info)
 {
@@ -4186,7 +4165,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		if (IS_ERR(pid))
 			return PTR_ERR(pid);
 
-		if (!access_pidfd_pidns(pid))
+		if (!pid_in_current_pidns(pid))
 			return -EINVAL;
 
 		/* Infer scope from the type of pidfd. */

-- 
2.53.0

