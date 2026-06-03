Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66C2264AB
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445756; cv=none; b=paMX0ms7BGtQJu78nZ3e4/eXWNQdHHAyl2yzasTpARpon8p212LLW+NfvOnpFIhyhzpTRQSfZMdplQ1JKE2Hbq7PXESPoaSBINaEfZYeZ+obShowccrrrmLmhaY0F8JymZU/w79QXAHvw9khPv4lQvFhGGy9jdT6LmZojlhjcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445756; c=relaxed/simple;
	bh=xEgKsYpFD0rYCFq46nAHAXIxry63+1Lgv4f8cs7eujQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk+D0Mo6cvBfxWL0atjtDPhLM4lMZTdRtOSLS/ti+f34Nrpf5vJLSbiSR6Xob14P0EZjuYHxl+QlRFa/CipQesFdc9NuLgAGYeUzFC4A0sZdXA8a6n+MjRcZPJ2fl2UeoefscDTmyVjk/GmCA5GV2pI2KVYi5skyXkueqW8JvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l45NIJ0T; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l45NIJ0T"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-306f36df4feso107405eec.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 17:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780445753; x=1781050553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oON4zbSTTzgNWnnG9rbhICs7omxqe0lLo/xR/Pj5ok=;
        b=l45NIJ0TqabPKUFByjw5mAtnR+E/WvupUzyNWopLr4expbkVPeZ9yxUOMahnjaakzd
         CbrhDpNTJ6eHtYpuNbnN4/grvDF2srmASwdJjtp3g6GnX75rVYGUXoyY6SWi7obJOBeR
         W/jm5BhBQXHCMdtLXUVExJy/aGu0dDofOQ3YoZIgqlJ98j5ciaZLmOkWG+2R18VESM+a
         +jawiKSwy+jf2IS+WUWWE72Cj8DH+GiMmm2IdEalrXoo4fzC2VCQ0SUddDwY2DB75WgC
         1pvRZlDOpcQGlaAZJne+YRTg5Bzu4DJZ281S+qkmfwHgX5UuMiGmnkcgiFlqANJx8te9
         vpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780445753; x=1781050553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6oON4zbSTTzgNWnnG9rbhICs7omxqe0lLo/xR/Pj5ok=;
        b=HcxysI+mLj0fcAU+2vQaKTywdn1oGjv46vCOWiXRjmATlOTTm+5XaQolOFWrhgX5Zl
         ysW1gMZ4IfaaQDxz6cidFpNqOPZd62wfeVXbB+AnXr2rmRSebabOMvaDqfFK7D7Udy1s
         Vy+1IKnbyVx1khxeRyitNMSswgaFAiIQC9S9l6Ft2gVOjRMh19cuYIM2PfhXEmiNZc7a
         WnsmNpNV5bh0IicxTQUtrekBxHEvWwpwURpXK/suOdS1c3Rym96yv7+C/06AiBZsLe5r
         lxrFoQ2+SOoS393G4+hh194Q6tGBS1wUaR9d4N4xyjK8o+PtkVnP4PA++eoaBqeXAmL0
         Oswg==
X-Forwarded-Encrypted: i=1; AFNElJ9L/jgFgivSrUBFPzP/4FzqZdw8qpL2I1h/2lK8LX+Oj1nzUdc95/qwC13JgqcelmGNpTu6CJe3lVr5o48l@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6ma2ViZUNVjSWjlwM+Zw8+6eFKrJ7WtQwc83olo3m337FQEO
	UyUIM03O+wS4o6RgUHfpU5Q9b8AZDhPpUZfKelX/1FM3xVt2cVE9/Us9sHMpfmir
X-Gm-Gg: Acq92OGtqMg3ZugXftcLKDuWjtxYpuefM/lTeq0vuiOGUIPajIspB8TefKb7QexJijg
	kcsfWLpaH7ldr8pk6XLQSbUHLHPLww4eWw/lN0teN7ksB6y/MdVqW9L29wfkKVMNqHL0JzjdCea
	UOq+SMXzHwD5BIknOyb8a0v+thQTLRapSLfnVhKJFlQAZSxfDJQMKvi6vt9/OOCu+SBJWCdJr0W
	qCGNfeBRLKQVPqyQvPUkrHFqHyJvpw0SS9tcUtZ8ysLKFsZL4iBu5p2sT4BS9MQE6AZAYmmq8/i
	HG0KI5HQ2pfU8UU+BfEbK3U0sd7jz1l7RvXCacRyNinp2kHkcXBblrN2Fq+yUzB5I4zj+ld72pL
	TWTCLH+5ARRMll6aNi6e59jqSAW4UGzi4yca9ZR51hIgY1Oql88LHZENK+mO9lNiENOlg/Q+I9n
	mcRBJ2ROyxHTsjFC/n1cPiz5vT2qA+wA==
X-Received: by 2002:a05:7301:730b:b0:304:ce0e:70d9 with SMTP id 5a478bee46e88-3074fa8511dmr359982eec.8.1780445753037;
        Tue, 02 Jun 2026 17:15:53 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcb98aasm829069eec.12.2026.06.02.17.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:15:52 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
Date: Wed,  3 Jun 2026 08:15:16 +0800
Message-ID: <20260603001516.26234-3-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603001516.26234-1-anonymemeow@gmail.com>
References: <20260603001516.26234-1-anonymemeow@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fanotify used to refuse to report pidfds for reaped tasks by applying a
pid_has_task() check before calling pidfd_prepare(). This prevented
userspace from obtaining information about the task.

Register the event pid with pidfs when creating the fanotify event if
pidfd reporting was requested, so pidfd_prepare() can later create a
pidfd for the reaped task.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---

To avoid having to destroy the allocated event on failure paths after
pidfs_register_pid(), I moved the pid lookup before allocating the
fanotify event. And I keep the pid as a non-refcounted pointer until
the event is ready to take ownership of it. This keeps all failure
paths from having to call put_pid(). Not sure whether this is the
preferred pattern here.

---
 fs/notify/fanotify/fanotify.c      | 16 ++++++++++------
 fs/notify/fanotify/fanotify_user.c | 18 +++++-------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 38290b9c07f7..f4e28e7d3d8a 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -14,6 +14,7 @@
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
 #include <linux/stringhash.h>
+#include <linux/pidfs.h>
 
 #include "fanotify.h"
 
@@ -828,6 +829,14 @@ static struct fanotify_event *fanotify_alloc_event(
 		}
 	}
 
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
+		pid = task_pid(current);
+	else
+		pid = task_tgid(current);
+
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) && pidfs_register_pid(pid))
+		return NULL;
+
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
@@ -863,15 +872,10 @@ static struct fanotify_event *fanotify_alloc_event(
 	if (!event)
 		goto out;
 
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
-		pid = get_pid(task_pid(current));
-	else
-		pid = get_pid(task_tgid(current));
-
 	/* Mix event info, FAN_ONDIR flag and pid into event merge key */
 	hash ^= hash_long((unsigned long)pid | ondir, FANOTIFY_EVENT_HASH_BITS);
 	fanotify_init_event(event, hash, mask);
-	event->pid = pid;
+	event->pid = get_pid(pid);
 
 out:
 	set_active_memcg(old_memcg);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ebdd48942029..b604e3da58ad 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -904,20 +904,12 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		metadata.fd = fd >= 0 ? fd : FAN_NOFD;
 
 	if (pidfd_mode) {
-		unsigned int tid_mode = FAN_GROUP_FLAG(group, FAN_REPORT_TID);
-		enum pid_type pidtype = tid_mode ? PIDTYPE_PID : PIDTYPE_TGID;
-		unsigned int pidfd_flags = tid_mode ? PIDFD_THREAD : 0;
+		unsigned int pidfd_flags = PIDFD_STALE;
 
-		/*
-		 * The pid_has_task() check for an event->pid is performed
-		 * preemptively in an attempt to catch out cases where the event
-		 * listener reads events after the event generating task has
-		 * already terminated.  Depending on flag FAN_REPORT_FD_ERROR,
-		 * report either -ESRCH or FAN_NOPIDFD to the event listener in
-		 * those cases with all other pidfd creation errors reported as
-		 * the error code itself or as FAN_EPIDFD.
-		 */
-		if (metadata.pid && pid_has_task(event->pid, pidtype))
+		if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
+			pidfd_flags |= PIDFD_THREAD;
+
+		if (metadata.pid)
 			pidfd = pidfd_prepare(event->pid, pidfd_flags, &pidfd_file);
 
 		if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd < 0)
-- 
2.54.0

