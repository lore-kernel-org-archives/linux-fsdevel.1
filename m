Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253772;
	b=AaL0HFn+ANu0k+wVyCIFnlKuJkTnkFdFkU9PUNaYWwEX1Ce6d2MrRjiyubinRDmndtuR
	 CX9C1+2GOxNV03nBKAmvJqMrBUTJWxL3lT25EfhNkorfOOzvmVbH6skDKRw40dvj7dHve
	 BZocAzVYDFhRdYhqJdQQkdkZ01GvUyNOt0j0MSSc/WHK1kDvMIjWvlz+VnCpVQEFwqxqJ
	 VSWkV7fpPhbJN8Toql+NucGMtE6VVgsACduOEKxFDMFsHNmZG7JbwXmUKClbdziBdh4eh
	 REwc0qhvCiupaAVEc75S/qmOscTlEUF9+aARqYon6m7oT8oINd9xrsnPQfPCResDBbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=uAhDYlvK2+3qASZfUSpUAqvVOjwzZmifCoWceYJJL+M=;
	b=FSjBTEb41zNAXs5m6ZxRvlOT4xo2TzKpyO+Jxg27+XAKLHSCJMzjou3E4qaMMC19vhKu
	 KNSojR4tsUKtSTHmsvX+FxntJKuiMEBkVYELfKra/lKA81eCyjjuHpOKRL0IlQWl+KmOx
	 QzmhmyA/39stVD+mxSfIktfMKHy+zNE7XfVz+Tjd2DmH/p+xkh9o3rJKjDsfWaVdx+tgb
	 TAbgP+n6WVANYnbvpXEL/H/Y9IMfOdYfprRO5k95W88P4SSxbUSwlCdqQsRJoRPzTUFcS
	 E/P1FrOfrDGz4el+nBEAN1sDbkAGj9DGo5Su4zvRKBdwngPuxrQDLeY0Wzt3ZMQX1YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kLJWX1rn;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6F60A2611
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 19:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37A6F60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kLJWX1rn
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5366ae57896so13107291cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 11:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794253770; x=1794858570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uAhDYlvK2+3qASZfUSpUAqvVOjwzZmifCoWceYJJL+M=;
        b=kLJWX1rnQ4huf6ru90hKR94H2MqoKMZQcLtp76N3m8CiAgzT9SoQmLSZFX3ANeltSP
         a0pC4kHpj+YUiKTTqalVcFKVjLdBTd5Yifmjld/3iG9UHYdkpkU6mr9sb1eRuSMxXcNU
         +VyF4Ofs0bWCTVxmC/OKXAweMbee8q1LPfgV4wcyP4HM8HJnW2B3HZInJDReW9bVKUZE
         Dpb/NUCKucpgfYwzJIr+8mc9APTETTGtZBQb0Zs8n7IHmHjK0lsE9HPKrXkiARRwHSF9
         GynzBH18Ec7hrszmXEtIMfJOvwIqivK/ZDqUrZxO85oEglZp0LKjEdJYfOZHyNUxdvti
         Zd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253770; x=1794858570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uAhDYlvK2+3qASZfUSpUAqvVOjwzZmifCoWceYJJL+M=;
        b=zZSs2XkEbGGsQqChtI69sChsl+hJuJWob42eEtyhH/B/tBNtnW8Xlz868utHFjaffW
         CBwf8Yo8OOPHbnEy/oCH1qYx/IkoDHL8cZSPe58QIwtbA8KtL20NAoxwvwrDcXOGOzxE
         9emPCcJWhLvmkOZgJTmYxa0PPB/OqmNyNEeUezz6abCSp1v9kUYTWfHD36JPdFUn1o0b
         hKxUL+T7lpLTO9aOTB5PFTZW31OJ5jhNmmLEKQfwQbjzHfuFou77G22Yj5nF8eC0dR/K
         R5LPc0Pa5XbRSkrl1qMJpCpA4Z5OWzp272+WM+p+LRXmVssaXOIfG5rqXTMRufmVmmna
         o4cw==
X-Forwarded-Encrypted: i=1; AL+hErHIgmZwCo0zZi2FWY3p/UE5kzm3j9z1cdqX4niwWsRtm09qK5xXb7BEspqBT/Bu67kPtYslP9mXiVySRQNW@vger.kernel.org
X-Gm-Message-State: APuU4Z8OrF9Fjwi2KDh9cgzXNt30DV9nOY2aZXCFxw5r4JvcE14j14WU
	ZJ7trkm3zGxcqVIMZ6mhJbNFyQAaRznlTB8fojUd8Y5S3XsqVcyfbF+eT5uMhHJu/4c=
X-Gm-Gg: AYBFou1ZJqIrn8/RLLFi/5HE6L1wh6rA0UGB+8i1EH6EgOglz3dQWJtQp21G/w5PF7p
	B+yPOwI4haWq1t4OqQdl2iReJIOUsR1SsdOINT1sBb/vD7OZnscmp5nm6SevTQD3JUWOugvfmvs
	L+ST2BeKhWlylQZVXu97OE7s7OSIZvILQWy1xoHqjtAHiO6PyAdXUt7m5nIRdWcF1SM1GbdTYy1
	+M0YvkO5wbuQHjAxEpJOFzKeAOv+4JpTCTM6NPbr2Shta+3CeZmnErpSbe6D4ONBduvyl8U90X5
	2y/SVFe/SFxvI5IchCYUPA34zxqQyawvZ+HSnsQcbDW2ApmahFsHVtwaCdKyssnLHZ0E0mScDSJ
	zl8mXuI345JZTo9lJNExIoPMLoAd8b9edk/IdGkqS+Bxz8tF4UED0zVY1ZhYRfMHfnYTncAzBbq
	74ocB4kLqE32FDkt2LiNXT8TF4RPiLAojftdzq6oaT45CAfY+QP1Q2UASH5XkskiBhedrQ3n7zW
	JxsWx6lr2JufTUI4fjSIxC/CPfgQmrxg2ZmB8gZldRRrIlY3coG26+Wt88EXNu9+bDpkiSEDeGR
	9/ZJvCR0XSbWzMTjctV1X0gZSbCogK7F4S2poHsE+VJgyg==
X-Received: by 2002:a05:622a:299b:b0:535:70b5:806 with SMTP id d75a77b69052e-5552b15e49amr5380961cf.62.1794253770039;
        Mon, 09 Nov 2026 11:49:30 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555091eb7f5sm5387711cf.1.2026.11.09.11.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:49:29 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 09 Nov 2026 19:49:11 +0000
Subject: [PATCH v9 2/3] capabilities: don't let ptrace borrow CAP_SETFCAP
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
Message-Id: <20261109-b4-setfcap-userns-v9-2-0d3f00976ce2@toxicpanda.com>
References: <20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com>
In-Reply-To: <20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794253763; l=5442;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=lQ7qdUcZnQWLmwtfdxuLRnWVpPjrrhXHWgXwETwVEx0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGRzRC7SrJKU30VGPsSGvEfeY4y1dbq+wHdy6wOSjMoKv/0Mz2Vww/Nf+w56aBPHQqRQZSS0a6e
 AAvhgPwfF3gM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A uid 0 task that gave up CAP_SETFCAP and CAP_SYS_PTRACE can still
attach to a task in a user namespace that another root task created,
and have it write file capabilities for its root user.  For a target in
a child namespace cap_ptrace_access_check() asks for CAP_SYS_PTRACE over
that namespace, and cap_capable() grants every capability there to a
task whose euid owns it, whatever it gave up:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP,
  unshare(CLONE_NEWUSER)              no CAP_SYS_PTRACE
                                    ptrace(PTRACE_ATTACH, A)
                                      euid == ns->owner -> allowed
                                    make A write "0 0 1" to its uid_map,
                                    or set file capabilities

The same goes for /proc/<pid>/mem, process_vm_writev() and
pidfd_getfd().  setns() refuses B now, so ptrace is the way left into
the namespace.

PTRACE_MODE_READ, tracers with CAP_SYS_PTRACE, a tracer and target in
the same namespace, and targets in namespaces whose tasks can't write
file capabilities for the tracer's root user are not affected.

Fix by refusing PTRACE_MODE_ATTACH and PTRACE_TRACEME across user
namespaces when the tracer has neither CAP_SETFCAP nor CAP_SYS_PTRACE,
the target has CAP_SETFCAP or can get it back from its bounding set, and
setns() would refuse the tracer the target's namespace.

Suggested-by: Serge Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 0ece141c68a6..d550a4e5d36a 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -176,14 +176,35 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
 	return 0;
 }
 
+/*
+ * See cred_borrows_setfcap().  Within one namespace the usual rules apply: a
+ * tracer with CAP_SYS_PTRACE can take control of tasks with CAP_SETFCAP
+ * anyway.  A target that still has CAP_SETFCAP in its bounding set gets it
+ * back from an execve() the tracer can make it do.
+ */
+static bool cap_ptrace_borrows_setfcap(const struct cred *cred,
+				       const struct cred *child_cred)
+{
+	if (cred->user_ns == child_cred->user_ns)
+		return false;
+	if (!cap_raised(child_cred->cap_permitted, CAP_SETFCAP) &&
+	    !cap_raised(child_cred->cap_bset, CAP_SETFCAP))
+		return false;
+	return !cap_raised(cred->cap_permitted, CAP_SYS_PTRACE) &&
+	       cred_borrows_setfcap(cred, child_cred->user_ns);
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
+ * For PTRACE_MODE_ATTACH, if we have neither CAP_SETFCAP nor CAP_SYS_PTRACE
+ * and the target task is in another user_ns, where it can get CAP_SETFCAP
+ * over our root user, then ptrace access is denied.
+ * Otherwise, if we are in the same or an ancestor user_ns and have all the
+ * target task's capabilities, then ptrace access is allowed.
  * If we have the ptrace capability to the target user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -204,11 +225,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 		caller_caps = &cred->cap_effective;
 	else
 		caller_caps = &cred->cap_permitted;
+	if ((mode & PTRACE_MODE_ATTACH) &&
+	    cap_ptrace_borrows_setfcap(cred, child_cred))
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
@@ -219,8 +244,11 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
  * cap_ptrace_traceme - Determine whether another process may trace the current
  * @parent: The task proposed to be the tracer
  *
- * If parent is in the same or an ancestor user_ns and has all current's
- * capabilities, then ptrace access is allowed.
+ * If parent has neither CAP_SETFCAP nor CAP_SYS_PTRACE and current is in
+ * another user_ns, where it can get CAP_SETFCAP over parent's root user,
+ * then ptrace access is denied.
+ * Otherwise, if parent is in the same or an ancestor user_ns and has all
+ * current's capabilities, then ptrace access is allowed.
  * If parent has the ptrace capability to current's user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -236,11 +264,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
 	rcu_read_lock();
 	cred = __task_cred(parent);
 	child_cred = current_cred();
+	if (cap_ptrace_borrows_setfcap(cred, child_cred))
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

