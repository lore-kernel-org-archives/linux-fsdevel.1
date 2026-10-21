Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615070;
	b=jQKDMErTkHzgrHQ6dnRu/PDvpe1zmnxNQ69veoU753fp5ZNPcFlYd9lAR4ao57F5fDiZ
	 uIqxADz/mrlx7wniWpNC1OcxhSFg8qve6NhCmCjbFi0+pr1G9Bx7RDXodM992k1+KhkyJ
	 Mrc3WIi76AWm2J+iTjChJTLGgsHJ/9mqRUnEn9C0+KsczXqNgB2QBWkJSRifwqb01OO+Y
	 /zMi3x+TkfXIO8skid0ATfnoza3/BqrURrtXGMcopDa26SAlSrM4thdr3m8bQ7Wa+CZMY
	 FHL3ZeSD0r6BKdgwLprfA9zBa8B2Vbjba9eWNcyPZJ3qWcbwg9517mlsM1L92CC/Nxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6neoyuO9WVG9+oq/4dYe4WiuWbAVKQ2HQotw+Faco/s=;
	b=M4A0w62v5pX8+1epWBkPbE+nY2E8eRnEwErfnmI84r9m9LpN8OpFtfx6MN7b2NDM54JZ
	 7YlUfwL7xQyrQLlsMqF4qMc/xdhYCKWefAhvBVBsKYaAXrf5klg4mavU25nH4bBMjiAW+
	 qOsIdW6eRJInKWzQWS/FOcnKFMbu1fnEWfq5soETnEEipRnkkJFyuraeAVTqzqakDz6o7
	 T333cTZamghoZFV7vZvXJMT1jxGnl/xPnNzJIwvTBBte0chRelESse//TaE0EDCD+4NQm
	 8j0n7s7o6h9vb8IGZqBiMIYQNQ3ys9ZMTp8trd3ehZ13dQofWMScpmND/Mcli2NhTMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ovAxEuCz;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDE606A327
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 20:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADFDE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ovAxEuCz
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e7ad9f78dso118580185a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792615068; x=1793219868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6neoyuO9WVG9+oq/4dYe4WiuWbAVKQ2HQotw+Faco/s=;
        b=ovAxEuCzc7F4CoFW9Xh87m78zRG3A3J2JsWmFQnRjH7vpZqB1D63bnkbJfLuXsoSbT
         CHq8CJ7NeVG0Tm60KjgM/m35YRBqM7EzGfF56G9GQ3GzEJ8xkXl+4T18Un9acMva12HT
         37A6RucVv6J1j9FSUR8kvnv6Y0+a6SBN6EsyQgrNtIJFm/lqWa9ygnXcdehj46Hn0K+b
         hhSi9USlP2QwfBOz6jzmQ3VbUsyL4MmMx9fj2KKqw8PkCrWSUK6ACt9XSoYqyEfGmR1l
         T2Aof3SXRryb9q8fxWYG++DQHEAZesbCuV0X5f4I1WFDiFHmF4VVf9hUSp8yaB8HbwOJ
         SDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615068; x=1793219868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6neoyuO9WVG9+oq/4dYe4WiuWbAVKQ2HQotw+Faco/s=;
        b=qnCLt9+NUf1uae8FPXXJYtiFOZwKx4fMlUGrEZrS/Obnms0Q6vOzXvWY6Tb4IxMeXJ
         hQ7nfdaVWknqxGhCNpAdVQWqD3t/d/JzTu+fEh5DwhNYHb1Hjff93iqFgP2NayWb4SiW
         MlZdnJFAPl5PtySYXOwwBBew9/d9gYAfcsYdfASwUF3xTpnS5fYHkN3TmyyuNgMk5pl4
         mF5S9TNl6SFkX1dgAruHeJGQUdZeMdm0SkZP2/5AppxWK4CQBW1A9cHT1HyqPpQTYyx7
         sf6ILbAseO6dVuORQJTKflwlK+l5WuA3LeE4P1p3UAg8dkwfAf0gYi1IRgW7qC9YKga6
         vgbg==
X-Forwarded-Encrypted: i=1; AKwUvBx0kVnXwufDzpIvPscgQIRCN058V+EkjtyQb35tGBlF3qh1d1vQlpmjq1PFkAbYsGKC9iKlsC5YXwAdsFuU@vger.kernel.org
X-Gm-Message-State: AFq9FYLl1wLcZur6RMTEdqUtUOKwVwwjKi00ErR8O2mosr9CbMvsrxjk
	/sJeDNZH6LI0dIlxtJUNkSJFCoKLR16+/5wSGe09opK33FVYoyRijBEjXdZFC2muhLk=
X-Gm-Gg: AYBFou3KAto/381H3sYxInTgXAgpJC5BOAAWLyvVPE61kTB4JcCFkI67hjvw7g/Ci+9
	zBI2As+yh8cRRP7RjT9d5QZd9CIlnLNkL/DItro++TQc1fY3taizhEePaBrtXVTsCI5OehlRq5r
	LxIbGYIE7bfkwdBqtIphHXlPFPvlaNF+T8ZjvNS7hj2oa0x77iL7oj3DVhOxmYtrLtKxxdMcnF/
	BFK9ts1WEofqJSynIgg92zCzLaskxMTk9ChWZNJtq8ZhgDnS0MdcJ4K3c4diEIcqgG2ul2nawKe
	lKnGv2YnNxdrpTbiaOZ/Yihh7Y+oA+yFf8vcwNDPBl/4XssSIr0YRYntHC1WZmJbIECw1I1iKfp
	XEWwsDyOqlfy8wTPvMJXAww2k4NyMPh4ZQ16+58IHTIsf1LbGyfzJJ1Q2JrJX5jbbWqnoUZvBNe
	X8VZ7a2rN8Dv+hX2khTU7ojiJ+MAN91YLz04+3XzxAMyQaf35kOMKyq8Y5rETKegZgupvooOe97
	9sz8/o5O07Eti3DJP/wxZ+0pgPr78pdqbGKOoh6ApAMjgasxpNS2Ahq29CsBtNM6azENvIb
X-Received: by 2002:a05:620a:170e:b0:93e:6620:bde7 with SMTP id af79cd13be357-93f57f05160mr601165085a.20.1792615068591;
        Wed, 21 Oct 2026 13:37:48 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56df2ad5sm340579085a.27.2026.10.21.13.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:37:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 20:37:29 +0000
Subject: [PATCH v3 5/5] capabilities: don't let ptrace borrow CAP_SETFCAP
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
Message-Id: <20261021-b4-setfcap-userns-v3-5-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
In-Reply-To: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792615055; l=5986;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=W2kSx/qe7l49ZZBzw9DtlnCKyQegAX6iShR4vv51qaI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEkdsvPaHaZjrxPgJ9HdsO2yy8XI/n1w4E3ibCu2MnFUZ7veliYYUsfzQ1az/tw7ZrXrBE6M+HX
 QwjBqhYs5YgE=
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
index 1a419a4a872c..af7564b38b67 100644
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

