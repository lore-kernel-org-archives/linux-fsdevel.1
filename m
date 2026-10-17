Received: from mail-qv2-f11.google.com (mail-qv2-f11.google.com [74.125.230.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F237C903
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216029; cv=none; b=nU3a+WTo+yg6U0CEwPGTLBG/bsHmhbnNTT+wyZNAfEjrwvO97WTl6bN1zV3nRHn1D2235zXNCmv0cXqcwlkeN2Vj1e7/ZJM/V9pU0cR3OnpCTkXmLEqbzI+80YQTQxMvQBQKZQHYDz0sejh7MVigBVpNucxHIMsuG3YASNZeqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216029; c=relaxed/simple;
	bh=zgjTeZsvb7VThAwQBOc/YEC5wO7y8b3CEvupw/426rE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtB+OyAhcXBXNEPQB604XDZc78spaMBp8dUUC1XRP/Y6jp6HNp7WuC9JWt57qtvzE9EPmGg7OQdWhhzzOXfYiUCl6IAQmKr1HJ41mFJHrxghPP4Z1qLayzq6MF50pcpWLkqRMXW5t6drqm7UtA6hxtZdwy2dFKUM0LDsOtLy/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbYrW0Ys; arc=none smtp.client-ip=74.125.230.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbYrW0Ys"
Received: by mail-qv2-f11.google.com with SMTP id 6a1803df08f44-9196746e002so5557016d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216027; x=1792820827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CmImhIlDsC+i+0CV3RMDF3TUt2Zs5F4OZUYa+9qiSQo=;
        b=pbYrW0YsutvjxuGvQ1Z1LO9AgD/IzLXxBjjb6XbySNnPeh1EpJEvl4/YMA3thICr0m
         tmssAXhzeRZMexU993hzEPpHK8FWeCsPPCZ3g4hACLSCp12Iql+JzHM/QknyjMuFD3/B
         Wntlnpzkhvv3XbZ6AkJQxglcq2g1RmkV66TlNc/TgGMSBydoA0lQmcsn0ZZ0WT8D/Pk6
         9ecIJurz9Zi9i1PS9N6Ui3YXVqthq+HKFTrdKWN1pRIIQN6FPCK4ilta9nNmAKad3e6E
         HKRAtZRKPsLMV3L+PYl2lNGPv0hDNAH+uxxQ8yfjv3WlICP7FjtH2J8meAdcsVNGOmz8
         2VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216027; x=1792820827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmImhIlDsC+i+0CV3RMDF3TUt2Zs5F4OZUYa+9qiSQo=;
        b=qaaRWeNuVpPYoiulqaDPkjIFCImfcjLUfJo2xUP355Tz+KRhBOW42FCb+ZtKrV9fO1
         3swkdHsOjn3k9CULoo5qDAP1l5Z7r53WJar4IBJKBfLH+n+PHdB1dHOqfHS/dQmEaGLI
         xh0S6GPCwURA08MeW2ndp2S1QunNKy+Tnzwa5Okr8t7DSem5hpXjgb72F6sg8g2dWgg5
         pCRWoXQQV36Rlc0/xYa4no1j+vGz/Tl/6QSycQL9dFItxaq3TM74IJvyy44CxQ1lBnOy
         X543/qIJwzlBLBjhGqkAOMsoD56B8jFtbb8oI8t3Y7pzw5Uuv0WFzt98cQDGveXibTLF
         b6ng==
X-Gm-Message-State: AFq9FYJYItxQGmi+CeCzS2XMuwgCXTVq1fzJC0hY5XyCuQ1+TUyzeITH
	uaTOmEqIW/4ahp/qJ9H9i6B2G3zw8e+A6Q8x9Um1rNzMmZiXy/usRLKLW6ulFPx3oJk=
X-Gm-Gg: AYBFou1HRojOhepr87LHi8chg7insuhTcQi+9b9EQL5F9lS5arT54IpP0GsBJ4e5DcZ
	EOP3psMPWke8Ek4uoKnTmX34PqKs9zwMPGtkRWAgKxxtyXIoxz9uAqwYUxaeGCD0S/Jqwc1jERr
	tRefL7k1bgTLs2UzKkIkqDQ2q75BScSAv43WlE91d6iGF6xZKuTbkpzNzPTz9eDQDqlcjQ2eHKI
	+Tdl8E7Rv4+WQlF9gmw0Kuz0thkRPCFdbPsjZBvrgfveDtQUmodAMqOtoe0MMDDrhS2y+sLUeMR
	PrKsYX0VRBgAamnP5QGoxRF+Ut/FKkIJoQwSob/jLHHWwXZL4PptN0RvQXpbrACKtf2npB+k8i3
	b6ILCn3BN6HupV3c52Rn75pTdLHFw+OGNWyyoHtviWNFgDY9n/T3DWKR/U60v0km5jUf1h4NLsj
	IJGpfH9z9o9X2swYe74znrRWRszGY6jQgxI7wZ9DBDFnnpM5X5vWcB1oTBzJq4fVnsKUo80ke6h
	NOmwyd0Eg==
X-Received: by 2002:a05:620a:258e:b0:93e:5312:3c96 with SMTP id af79cd13be357-93f29d0ea52mr332946985a.26.1792216026928;
        Fri, 16 Oct 2026 22:47:06 -0700 (PDT)
Received: from Fujo.tendawifi.com ([142.188.41.221])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f2fa1f798sm43923985a.18.2026.10.16.22.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:47:06 -0700 (PDT)
From: fujo <hooyan2024@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	oleg@redhat.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] pidfs: don't report autoreaped tasks readable before exit info exists
Date: Sat, 17 Oct 2026 01:43:56 -0400
Message-ID: <20261017054356.7874-1-hooyan2024@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pidfd_poll() reports a task readable as soon as task->exit_state is set
and the thread group is empty.  For a task that is going to be
auto-reaped (CLONE_AUTOREAP, or a parent that ignores SIGCHLD) this
happens before release_task() runs and before pidfs_exit() publishes
PIDFS_ATTR_BIT_EXIT.

A woken poller that immediately calls PIDFD_GET_INFO with
PIDFD_INFO_EXIT can therefore get an answer without PIDFD_INFO_EXIT.
For CLONE_AUTOREAP this breaks the documented use of polling the pidfd
and retrieving the exit status via PIDFD_GET_INFO: the task is
auto-reaped and cannot be waited for, so the exit status is lost for
that poll.

Do not report a task that is pending auto-reap readable until its exit
information has been published, and wake the pidfd waitqueue from
pidfs_exit() after PIDFS_ATTR_BIT_EXIT has been set so that pollers
woken early sleep again and are woken once the information exists.

Reproducer: clone3(CLONE_PIDFD | CLONE_AUTOREAP); the child creates a
thread that exits after 500us and then exits itself; the parent polls
the pidfd and immediately calls PIDFD_GET_INFO with PIDFD_INFO_EXIT.
On current mainline 18/300 iterations (SMP 2) and 78/300 (SMP 1) return
POLLIN without PIDFD_INFO_EXIT; with this change 0/300 in both cases.
The in-tree pidfd_autoreap_test global.autoreap_multithreaded case
fails without and passes with this change.

Signed-off-by: fujo <hooyan2024@gmail.com>
---
 fs/pidfs.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index a6a643f15..5245131ea 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -320,8 +320,26 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	task = pid_task(pid, PIDTYPE_PID);
 	if (!task)
 		poll_flags = EPOLLIN | EPOLLRDNORM | EPOLLHUP;
-	else if (task->exit_state && !delay_group_leader(task))
-		poll_flags = EPOLLIN | EPOLLRDNORM;
+	else if (task->exit_state && !delay_group_leader(task)) {
+		struct pidfs_attr *pattr = READ_ONCE(pid->attr);
+		bool pending_autoreap;
+
+		/*
+		 * A task that is going to be auto-reaped reaches EXIT_DEAD (or
+		 * carries CLONE_AUTOREAP) before release_task() publishes
+		 * PIDFS_ATTR_BIT_EXIT.  Don't report readable until the exit
+		 * information is actually available, or a poller can observe
+		 * POLLIN and then get PIDFD_GET_INFO without PIDFD_INFO_EXIT.
+		 * ptraced tasks are not auto-reaped, so they keep the old
+		 * behavior.
+		 */
+		pending_autoreap = (!task->ptrace && task->signal->autoreap) ||
+				   task->exit_state == EXIT_DEAD;
+		if (!pending_autoreap ||
+		    (!IS_ERR_OR_NULL(pattr) &&
+		     test_bit(PIDFS_ATTR_BIT_EXIT, &pattr->attr_mask)))
+			poll_flags = EPOLLIN | EPOLLRDNORM;
+	}
 
 	return poll_flags;
 }
@@ -790,6 +808,13 @@ void pidfs_exit(struct task_struct *tsk)
 	/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
 	smp_wmb();
 	set_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask);
+
+	/*
+	 * Pollers may have been woken before the exit information above was
+	 * published.  Wake them again now that PIDFD_GET_INFO can return
+	 * PIDFD_INFO_EXIT.
+	 */
+	do_notify_pidfd(tsk);
 }
 
 #ifdef CONFIG_COREDUMP
-- 
2.53.0

