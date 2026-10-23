Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773053;
	b=csrI7kVdawgobOhDhugILIWC57wAlHrfZ9MJSeuY+NUHZ5MqgetVFJROimAn2GTodgP6
	 EIRTzpAnGHikDbKenxOLMFswrBIUpUy+K9dePM1Y9VQTPiaTG8WxAJburV8DJmhzPdiJO
	 zr0okweqILjsdWxlW0C3KFnK7rOOtFsyaTK1ebDql2v+ohuD6oRynEvOGXk9NeLzF6Pg3
	 IejhnSEVVQJhwZVmsHZCqVG69ot6yHDLBa8tqoW532yh4uDmp30+SCs90A9f/e4lcf5mm
	 PG+LS+9tBpSpz4r6uT68r895v+914aIx3RzmucoavpkCpAhkaZ6ZRdDEQiSgMeta76A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6bNlVCZdjYAvgP6QO2gndG+D4cTAO8w/bNRFA2POieg=;
	b=e929BlobDCSMRvG6m5mx2OEHJUrlosSZXO0WhGyuHZjruPQ+AveFqL8pQBusBf2H/p+G
	 5QoiCkNxtYRTCmV0Asmg++1zr+VFzrWw2IqkrfuphzmzLcR4IwTNaAN+kYheA557a7EGW
	 +6S6C7cwxpeZ2693uM+IERV5QM5g4qq7Rtj3vGpF1a13UlYlHQHEDlJhytEmLqNAhJ+/t
	 j3Q9hlkQsIiHhfig2jxQJhYj3zVGfjWHsrTqeKWBFjg867byJCgQtgxa7QLo4WjfnIpcm
	 EYGiz802wzVco/daQg9PxZbnkb9vCwaN5jAtP0SSv66xvcBgNPmYiSlU1K03a+lyAWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=m0ejNXGo;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFA606A338
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 16:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23CFA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=m0ejNXGo
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53669f7b518so10084241cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792773039; x=1793377839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6bNlVCZdjYAvgP6QO2gndG+D4cTAO8w/bNRFA2POieg=;
        b=m0ejNXGoKNmGCd96DHBtEFO9ONodc5JDA44ybgnVGm3aTRzKFRIkCzHezrHBVXHb4Y
         svnCD9xmCQRjbMUxPIJPyJpGy6UB/ya5ljd5owii/hG7D4GGqYtlKemeneF2UQxoyFWV
         8Em4xIfPp/jKdJZQN65F5/lSxQ4VCED/H2mXa/gf3jUU3T7JYu5K1K9kv5kUoulMjoOF
         kKMjN5MhhT9MJtgkQZRBK/W0No6KoNErgXoBhYlavoCMHoYwa7dD/rrYM/bYSjbrhB8J
         FRcAr16Aqv3FUTdsDKOrmXHOfDjlypDL97znnD75qPJ3tzBOqQN6VXG78yH/hzo57UO0
         UccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773039; x=1793377839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6bNlVCZdjYAvgP6QO2gndG+D4cTAO8w/bNRFA2POieg=;
        b=g+vLyz5g5LGWYGYEJaHaEsEEewgFhxO+NL4MDroCym0Hd1T2GFNTJ6WJ6JJxmTKCSq
         ySDeZKp3OmG7sKLhCs0ltbHSCavHcPCFQE+UM4c2nFC7TmKxoTuZawQIyvrjpnBq6lLu
         FTMTZy6yoSLmn/LOHOmxLM3Wk5yWCxhLu17UEvTVN9tPHL+Mj7sj07Cz5esCQQjptX+H
         0Eyqu/XReBW8npwzWLOnjee0uMe+p2ucvNwe9kjczQgOyi0WgbAjGxtlARsZeOcJ9wiY
         td9Pjhf9zXCbsf13SMWLCzU0gcVjtG9Shxk2NvucddOPNqtTBsBugfwgfuD0CMrm/4a4
         Geag==
X-Forwarded-Encrypted: i=1; AKwUvByryVkHHwNaE9jT/6MhZL7RvnSLJbEFgusEeSeJZj4xd6roxdcEX8JN+C2CV8csHQMCDZ+KmF1KhwaaI76R@vger.kernel.org
X-Gm-Message-State: AFq9FYJshHeP8/JEct/V7htj0/+VJ5JDkLAz9V1TSVEQOUdIAaeWeo2+
	SPHqnfzjUxDiF5reEMahy187dYJUCX3AYhdAg8nSetTdLXwA48Oxniz3yggLVab82HA=
X-Gm-Gg: AYBFou1TTHXOHfCYheaX7beKXZ29TMspGY509lP8+5SjVlOC9TblMlyiqFW8UfKRu/y
	+b3Rl2+5BjloFmiiUvR0oonFliBNf5rfsl0Wuft1gAjqbQ+XAqkOZvQB7BGX/6Ytq86r87TKiRf
	NYuZjX4tJBCLd3oofpOp8cxjd+b8hyHfK0WaDNvOdDO6uMoUXc2ckNYloEof4GMJFn5yUjcOCw8
	W8azws1dLpGwSZLC4xTrl5uG04JeG1EbRBdZtYVuSmVGok6dgUfV5sZjrvh+kVakU3bjObEyaPG
	etttgtF44LpJrgC0G3vqA2/yEBm3Ff1GDUqMdlDPKw6q64FkCcQaY/TvuwJeFiO3A+O5GInxkOp
	FxNFCrnWOHjpy7Vy9N7c7BkepvaFf6RPA0N1WeKkOlWYSZmtYXNnnZBhs5hlCvOWB2kcQZdj7Ne
	IdfpH7mjY5LtalTnSmdCdwL40XHT1hFgI7o0uRc4R36dRJY7WZ9VOgkDcuDphd938z6DQyzjMXX
	OuR6kBTM8Sf3sD0baQKdEl6qXn5oHegMnZmc/oC9FnjfiSLDPrR76HhhWVEF1st/yjG843o
X-Received: by 2002:a05:620a:1a17:b0:93f:31bb:e31 with SMTP id af79cd13be357-93f6f7f8b24mr530920385a.48.1792773039135;
        Fri, 23 Oct 2026 09:30:39 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b52582sm56415085a.41.2026.10.23.09.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:30:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 16:30:11 +0000
Subject: [PATCH v5 5/5] capabilities: don't let ptrace borrow CAP_SETFCAP
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
Message-Id: <20261023-b4-setfcap-userns-v5-5-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
In-Reply-To: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792773019; l=5986;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=7nZhFjQPJ5b+azEi1eZhhmLccT8uOOzebcebv/k6Evk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ9h6KQ0L9h+vH5v8gb9+KPPTp03Fbrlbk8eq3lYfZ++eu7oLeO6QwH0KZ1VFqfFf5nmUspmTn1
 +7ilZ+tIH+A0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Tasks in a user namespace created by a task with CAP_SETFCAP may map uid
0 of the parent and write file capabilities that are honoured there.
That is the one privilege they keep outside of their namespace.  setns()
no longer lets anybody in who doesn't have it, but the ptrace checks
don't know about it: for a target in another user namespace
cap_ptrace_access_check() is satisfied with CAP_SYS_PTRACE over the
target's namespace, which the owner rule hands to any task with the
right euid.

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    ptrace(PTRACE_ATTACH, A)
                                      uids match, euid == ns->owner
                                    make A write "0 0 1" to its uid_map,
                                    or set file capabilities
                                      A is entitled -> allowed

The same goes for /proc/<pid>/mem, process_vm_writev() and pidfd_getfd().

Require for PTRACE_MODE_ATTACH and PTRACE_TRACEME what setns() requires
to get into the target's namespace: CAP_SETFCAP of the tracer has to
reach the root users of ancestors that tasks in the namespace can write
file capabilities for, or the tracer has CAP_SYS_PTRACE over the topmost
of those ancestors, which gives control of tasks there that have
CAP_SETFCAP anyway.  As in setns(), root users stored through an
idmapped mount are not considered.  A tracer in the target's namespace
got in with as much and always passes.

Targets in the initial namespace, in namespaces created without
CAP_SETFCAP (what unprivileged users create) and in namespaces that
don't map the root user of an ancestor (the usual container) are not
affected.  What remains is a tracer that gave up CAP_SETFCAP and
CAP_SYS_PTRACE and a target in a namespace that maps the root user of
an ancestor and was created by a task that didn't give it up, which the
tracer can't setns() into either.  PTRACE_MODE_READ is unchanged.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 3551ce9b046a..bb126aba8736 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -254,14 +254,41 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
 	return 0;
 }
 
+/*
+ * Tasks in a user namespace have CAP_SETFCAP that can count in ancestors of
+ * the namespace, see cap_setfcap_level().  That is a privilege outside of the
+ * namespace, so capabilities over the namespace are not enough to take
+ * control of such a task.
+ */
+static bool cap_covers_setfcap(const struct cred *cred,
+			       const struct cred *child_cred)
+{
+	struct user_namespace *ns = child_cred->user_ns, *top;
+
+	/* setns() only lets in tasks whose CAP_SETFCAP reaches as far. */
+	if (cred->user_ns == ns)
+		return true;
+
+	top = setfcap_top(ns);
+	if (!top)
+		return true;
+
+	/* CAP_SYS_PTRACE up there gives control of tasks with CAP_SETFCAP. */
+	return cred_setfcap_reaches(cred, ns->parent, top->level) ||
+	       !cap_capable(cred, top, CAP_SYS_PTRACE, CAP_OPT_NOAUDIT);
+}
+
 /**
  * cap_ptrace_access_check - Determine whether the current process may access
  *			   another
  * @child: The process to be accessed
  * @mode: The mode of attachment.
  *
- * If we are in the same or an ancestor user_ns and have all the target
- * task's capabilities, then ptrace access is allowed.
+ * For PTRACE_MODE_ATTACH, if the target task may make use of CAP_SETFCAP in
+ * an ancestor of its user_ns that our CAP_SETFCAP or CAP_SYS_PTRACE doesn't
+ * reach, then ptrace access is denied.
+ * Otherwise, if we are in the same or an ancestor user_ns and have all the
+ * target task's capabilities, then ptrace access is allowed.
  * If we have the ptrace capability to the target user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -282,11 +309,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 		caller_caps = &cred->cap_effective;
 	else
 		caller_caps = &cred->cap_permitted;
+	if ((mode & PTRACE_MODE_ATTACH) &&
+	    !cap_covers_setfcap(cred, child_cred))
+		goto deny;
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, *caller_caps))
 		goto out;
 	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
+deny:
 	ret = -EPERM;
 out:
 	rcu_read_unlock();
@@ -297,8 +328,11 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
  * cap_ptrace_traceme - Determine whether another process may trace the current
  * @parent: The task proposed to be the tracer
  *
- * If parent is in the same or an ancestor user_ns and has all current's
- * capabilities, then ptrace access is allowed.
+ * If current may make use of CAP_SETFCAP in an ancestor of its user_ns that
+ * parent's CAP_SETFCAP or CAP_SYS_PTRACE doesn't reach, then ptrace access
+ * is denied.
+ * Otherwise, if parent is in the same or an ancestor user_ns and has all
+ * current's capabilities, then ptrace access is allowed.
  * If parent has the ptrace capability to current's user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -314,11 +348,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
 	rcu_read_lock();
 	cred = __task_cred(parent);
 	child_cred = current_cred();
+	if (!cap_covers_setfcap(cred, child_cred))
+		goto deny;
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
 		goto out;
 	if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
+deny:
 	ret = -EPERM;
 out:
 	rcu_read_unlock();

-- 
2.55.0

