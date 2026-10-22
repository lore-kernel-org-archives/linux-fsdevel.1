Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694207;
	b=dhRXlmRM3lh58C/6cyLOMf039PZcjS1nVGxoozwWYXi20C5vrkSAnOSKUybpsPxBRXSq
	 srXRZPIvZC9CDIRVm7YKIFUbrhezweZMFiqMVMTabbm18hzhf6e5QBc3KcDhwvJvT6K6I
	 WaUAW4iKWbTsU3r+Je3OhREcy1zoiBg/kyMuN10Ek+CieUcCVZ5TYgwwLWo1azqbi702r
	 IbJoq8njVl8wJkJ16+0yCnodPS7zos2pBOIXg9ilHHeQKOOCCMoy0dubYkItZqmeQpjvs
	 aBjAfyciIRL91ZJHCJbrwpW9xnDGgbhV3q3vyt/UqGJ+ZXvlTXGKDtGzUt8vmtnF2+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8r5BCsxmHZxLH4Un1fs3O+/5YNLq5p7F1V9jPnaSk70=;
	b=Ajt/Z1+QyG1FvqGQXDoynV9dEggchyRNQ3lGF5mYkzwaJgiiXajCCSTz0etxXwV8Atm+
	 4DXGfxwkxM9ZBZO8PcyuxRxXDWUc6ZzKCPK0eRhR7tUk+6+Aompib2hcKiIu6fpJIVT/E
	 HSoW/IXK0uSeaShIgJ5UZfDuTC0DRDn4APvxA+mgPr4VMfYyO4KuLUW2FdHo0bSIN0Y4L
	 zbAnLhIcvMdr6NOAo3Bys7Q1jpNmOD5zDf6OFHo9xpzAhv2uQ300jr97cA3/dP8GzozWD
	 uygyMkxG7RY+zlMPGE9guu6x5eJ6imgKlYEezCTBbeEaTlgdnPRGOs8TsNqK49R6UVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EPvKwcer;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F160A3838
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 18:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 238F160A3838
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EPvKwcer
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f2b8cf037so6840685a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792694206; x=1793299006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8r5BCsxmHZxLH4Un1fs3O+/5YNLq5p7F1V9jPnaSk70=;
        b=EPvKwceruooaSpEuq/d9NX/0RSTGjLoIvN4dwmjNQmOXxeAaL4IM/5oldx2Sjjn6Cl
         Vt8X0TF2zGvQ/2Xo/wPc3NP0TdVg5dgUioEEpXkoK8T4zTqYy093PAdzQHYxj31XkNcI
         YAC9SiPa/W6r5KPG5tJmlr/s67mWff6xG94T610ScxVAunagFyCVQtv1NjCTwwSR1iEw
         C1CkL/Yiz2rILac3GOQXbGDhm/wPk9qG7CEK0JVbXNw/rAwsgJKmCh7vp9HXBcNHoGJk
         dwYOasHp7zDAj3a0RjFOziC5q7nG21er6io8cvoCkjzeXseHjHPwk77zO7moU05RFyJm
         36gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694206; x=1793299006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8r5BCsxmHZxLH4Un1fs3O+/5YNLq5p7F1V9jPnaSk70=;
        b=u2d39Pztv6NYasQHME75/CNqejzorSlFBIpvvYA31TG6H0brUviMNEQ4fovKJflauT
         EYHx5/QE8TImGZgc/ZLnwyvFXN3QPuRQcKcN7ysQ1B/qj3xqcyrdgmCXlgHsjOw5M8kD
         RZ5cJ8Kx1KeL31YqhaRPgVATyj9MRrtBcaryPhL5y201xwdb35+8O3DOihEr3G2DGlJo
         N3aXY/Zpjl5BiE8GLvZx7VrETOtV3IFiAFv0+SK+m2vv4FmYtRgN/6VYxiKyvjnrf0GC
         eN3pvpiTILIx0rGVJvoUiBMImW0ttGi6vj3i0GE1xRLVw+vSwxBUtUaoceaM22ELKS0u
         El/w==
X-Forwarded-Encrypted: i=1; AKwUvBxvpF152Az6DzadxiXqXnVKvfw1Cih0ujWYTSoV7NoUlglvVsgh9tskjXk4RkEu+UmeS6Z/YhTdJWMvb0/U@vger.kernel.org
X-Gm-Message-State: AFq9FYLq6FnCljFxQOT/StEZAMnSlPUH1A3NBiAABKKPEq7BcBuwIBnq
	S0PYeVy4HxlB/mIsF1HJwzbRC1735awq1ahpW8nmhkmABlhp5hH60fAeu8UlkbthQFw=
X-Gm-Gg: AYBFou1jzX9qT+jL9AwGsw7EIht8+dMERMlyPMOC2w9owJd2l5PvwifaxqSAypNeNiV
	l1zSleS6KESu/k5IF4O/iAyDnY6B8TaYCPoT37wC6TaynKt91VERPYIcGx4Qy0u5BnNWdTnYsRc
	4ftUn7g36jPaYum87MSUZIcS9BOIl5dFBJzWNvrJvaSaLWFjaL1KerggDGLLNe6r4lijo1RTBf8
	AR39gfgpJvi464Pn1YmoGCjTThXL24pqO9EM54fCVC1piluLWgkKwAAcOVmOJB4ABbjEbqRZ//T
	EKl4Df4xHyAGu3yI82MQJF77NrHn8fXfcHlY9vul2SCKsv7z5xNkI5b40KJkvWbUh1k7nSRnAAJ
	togu3K9qSRtKdsq3Hx8AODJBKhz1EOOsO5VU5LcGXwBUiSX6A+vyJ7oynFkepi7lWWayzPs6jf+
	HN7UWgofY8XXtBltlPydH/xPLFKz9fSKmMUONjSb2YdYNFgV5Zgk3n+lcdagIwreW/sLHG6u/9F
	IHksJs+U97VELf+ZVTQMiWKg4XnppyW7MEzKk/0rCxbN43GxyFLJifOvg/BzqffPjJylUm2Jek0
	EYu+UU7+Gq3Qb6xa4A==
X-Received: by 2002:a05:620a:261e:b0:93f:1445:82a5 with SMTP id af79cd13be357-93f6f8ebd8fmr54802785a.79.1792694205890;
        Thu, 22 Oct 2026 11:36:45 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f6fbd9609sm18480285a.26.2026.10.22.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:36:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 22 Oct 2026 18:36:23 +0000
Subject: [PATCH v4 5/5] capabilities: don't let ptrace borrow CAP_SETFCAP
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
Message-Id: <20261022-b4-setfcap-userns-v4-5-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
In-Reply-To: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792694192; l=5986;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=BQlhhPSD1xeXj+53MhIV4kladVTv5N+1sZePBcGqCkU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLlUqTvveTNAy2Vwzfj2AVuzq5DWs6LaLqZu1uqxd6QgwxWGmeDSq57SHyihZaSFAHmCPOlDRGm
 +dBr/StnVGQ8=
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
index 655e822c8e76..b33b10b444bf 100644
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

