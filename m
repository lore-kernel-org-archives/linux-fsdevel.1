Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4D34CFCA
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020076; cv=none; b=hVb8BRJMNoQOD8KKzK8DZhYE20iVmDXAJuyzp+Scso2gEtEd9efuZNKZH9Rik3maLRjs60owgUE2Wy1t1gA7f/WLBwTciDonAb8wZGvOEtTPNW7Qxn8Q0QbK4X1TZ2LwJPWMeJCF39HR7tyXuQNsdh/cvFuebHStZxvu5gUivZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020076; c=relaxed/simple;
	bh=NSlApGxbM5wb+5Cvd4wdXDhv6wVAUpLYQaKdCfgZjq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtXOZQQHq/iTjycIsupD+7DCLTCN6CR+HOylLK0G9iEZgJi3il5epjqMtqjmsSZ2R0wl1AHI0P6M6vuS5fWMgW9EOUvK7Leo5SPLNB8RXUPQMET4EYCuH8uKb2fsBQd4ZD3LiU8NQY6fqa+tyUNCedOzGtohr2u9XZdPNGTK0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmcWyLSf; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmcWyLSf"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-132830d8281so880573c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 19:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780020073; x=1780624873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IzqEcZZW6Ni5x3xFqs4GNiWd+yExlx9lPD7PThYV7c=;
        b=SmcWyLSfu7Un37rKeXUhIqjHf8zbRB69aZe3M/+f8+IgDYeoXEGhysSS5qSJgexOjv
         g5PjHyk1YBfUZIn+CuFl/ovQsv3Gt9x3v+EsqpzfmIpmC0HozLIA+TSH2eYdXE714Pgn
         Bt6bKNhlYGZLRrZdTrn8ZKoKJypdFxVr3O+uDa9wBimz555P0VHYjjbaRy89kldNr0m4
         Y2PDHcSS0HiVjfgEqIzrEe+f+ImQ8vXmjuqxP0poLACrh0vkDX3WvbvSO7Vi/crhNy3k
         Ak0uRuaBIyie5RCFMeuLYbeXIDSKmg5jmV0Xj19ltwJorgpBQUi454UsgXnE8N/4fvqv
         PqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780020073; x=1780624873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3IzqEcZZW6Ni5x3xFqs4GNiWd+yExlx9lPD7PThYV7c=;
        b=TMay7OPxUGJOaI7NZgatA2HDNW+e2rRtU65BclPXFCu7hIi0NAICI4mPds8XKgWPE7
         ZMpmPVjeAiOcFRoVybOLCZ+KPWLOsjh4VM32sTrWkvPQd8uYTVuYfYIMwcwvcLzTuFni
         C96yonHCEvat9VKBsshondOi4/h5S1R5h6t4jwT+xa4EbvHMQL/tmclyCWIbCvmJRFn7
         vfWrqf/RkK9EnJ1k+HghLSzAX/ZV1Eo+VKjbQzHuXxaD4y9x+m6YHSEE6KSmay/HKocx
         +mIpFTNIuN7k3/ugyg6LZdu6FrWHowo5kttKpnm5o8JO6MdC8vugAGlR7dPQxX93mnmg
         rshQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SmM5v3Tu9zj5uplYTCYzgV69oCgdD3xAWEzeuo2Hm1L0d7rm6rGc/LaB888tQ7DP2eY3FVvhpstys6RP4@vger.kernel.org
X-Gm-Message-State: AOJu0YzqaZCm77Cg5RiS05OPZvvjFySXkwhix4HHhlRjABDnZOWVBkzX
	qzA5HoM3GweoRfD4qstF8W7ETWIBMBg3FDUp8XYpxUbbBBEQIWjdQ227
X-Gm-Gg: Acq92OEmtuTzEbgFJOUBfqonQ9PV9YKpwu/nlptaRtJd6k00IqtN8rJZYt3ZyAeVm0A
	qcRAeJjwgrH9qNYUeowzAjJPNLZP5eVwQV8+5LL12DbK91L4SlvLglg24m0o8ByfzOsann5P76H
	YFeYqcKgF3FTitpSU7sfDJKL0miQzljsEUn8/XmpmL42xYwe+3Mx8YZZNRoWdk6evOtOsVN7l/e
	tXwDS/w1qCkNW88SNBfwBFGPIITuXyhDaQxOR0LTXq4v8Pg3b0s2lYcafVYl+kgV7soNnRkJBWI
	/9GA0/zC906sADKWLvosK57WC7xMUL7RwNpe40tXzWMc36/xfeDEDkVnEoKBTqm9kSbkrMguSZ2
	LhsyhW/XHe59O9TH3au4EZlGvJ4bdbli2P43/jIHZrIQK1LFKjGPLyR5ULu8TTUP1O50mJq8NYe
	WloEbHLvAJbscxJd+OBlErpOMI7gepfQ==
X-Received: by 2002:a05:7022:f96:b0:12f:c7c3:f5ab with SMTP id a92af1059eb24-137ae975bafmr379758c88.2.1780020073032;
        Thu, 28 May 2026 19:01:13 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c7fd47sm255135c88.14.2026.05.28.19.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 19:01:12 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	jack@suse.cz,
	repnop@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v2] fanotify: report thread pidfds for FAN_REPORT_TID
Date: Fri, 29 May 2026 10:00:35 +0800
Message-ID: <20260529020035.17477-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528-schmuckvoll-heilen-garen-be77b4208671@brauner>
References: <20260528-schmuckvoll-heilen-garen-be77b4208671@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
exclusive because by the time the pidfd support was introduced to
fanotify, pidfds could only be created for thread group leaders. Now
that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
this restriction can be lifted.

Also drop the pid_has_task() check to allow pidfds to be reported for
reaped tasks as well.

Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/
Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---

On 2026-05-28 13:51 +0200, Christian Brauner wrote:
> For quite a while the kernel refused to hand out pidfds for reaped
> processes even if the struct pid was pinned like in this case.
> 
> But that makes various APIs - including this one - way less powerful
> than they can be. Nowadays the socket layer already hands out pidfds for
> reaped processes. It also stashed the struct pid. Let's do the same
> here.
> 
> Drop the pid_has_task() change and then:
> 
> pidfd = pidfd_prepare(event->pid, pidfd_flags | PIDFD_STALE, &pidfd_file);
> 
> which instructs pidfs to and out a pidfd even if the task has already
> been reaped. Reaped pidfds can still be queried for various types of
> information that is kept around even if the task is long gone.

Thanks for the review. I've updated this in v2 as you suggested.

Also, the LTP fanotify21 test currently explicitly expects ESRCH or
FAN_NOPIDFD for exited processes. I will update that test case accordingly.

With Best Regards,
AnonymeMeow

---
 fs/notify/fanotify/fanotify_user.c | 33 +++++++-----------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ae904451dfc0..b604e3da58ad 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -19,6 +19,7 @@
 #include <linux/memcontrol.h>
 #include <linux/statfs.h>
 #include <linux/exportfs.h>
+#include <linux/pidfd.h>
 
 #include <asm/ioctls.h>
 
@@ -903,25 +904,13 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		metadata.fd = fd >= 0 ? fd : FAN_NOFD;
 
 	if (pidfd_mode) {
-		/*
-		 * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
-		 * exclusion is ever lifted. At the time of incoporating pidfd
-		 * support within fanotify, the pidfd API only supported the
-		 * creation of pidfds for thread-group leaders.
-		 */
-		WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
+		unsigned int pidfd_flags = PIDFD_STALE;
 
-		/*
-		 * The PIDTYPE_TGID check for an event->pid is performed
-		 * preemptively in an attempt to catch out cases where the event
-		 * listener reads events after the event generating process has
-		 * already terminated.  Depending on flag FAN_REPORT_FD_ERROR,
-		 * report either -ESRCH or FAN_NOPIDFD to the event listener in
-		 * those cases with all other pidfd creation errors reported as
-		 * the error code itself or as FAN_EPIDFD.
-		 */
-		if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID))
-			pidfd = pidfd_prepare(event->pid, 0, &pidfd_file);
+		if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
+			pidfd_flags |= PIDFD_THREAD;
+
+		if (metadata.pid)
+			pidfd = pidfd_prepare(event->pid, pidfd_flags, &pidfd_file);
 
 		if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd < 0)
 			pidfd = pidfd == -ESRCH ? FAN_NOPIDFD : FAN_EPIDFD;
@@ -1628,14 +1617,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 #endif
 		return -EINVAL;
 
-	/*
-	 * A pidfd can only be returned for a thread-group leader; thus
-	 * FAN_REPORT_PIDFD and FAN_REPORT_TID need to remain mutually
-	 * exclusive.
-	 */
-	if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
-		return -EINVAL;
-
 	/* Don't allow mixing mnt events with inode events for now */
 	if (flags & FAN_REPORT_MNT) {
 		if (class != FAN_CLASS_NOTIF)
-- 
2.54.0

