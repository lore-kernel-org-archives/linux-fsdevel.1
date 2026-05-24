Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726F1FB1
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779618344; cv=none; b=JtcLLSMZQKaDcVt7C2jl7CdILniXdKUmswGlh6QJF0UQrCAEeEK6q7ux/V9ph/PE0QxgQs2blFcT22gV4wPk76psF0pjOf8SnMurwCAS6OZGfLz/IN+C2UTmeADUUOiDkrS0pT2Vu/pyLYph6jDHco89I8Rt5ButQ7bTj4tX6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779618344; c=relaxed/simple;
	bh=Zkwe+FHjTnwCvOOjOCEzpofz4/XYgwXRVgWyjO2nKVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2T7e1lesBJh5aBzgJDq4SDqsCdMPhMyJSrbpifoMvkBE7jpFVtNpqRHosxpD9XCgse94X/oS03E8iuYbdTDqsj0JaUxo5eauD2dbnb8tD+e6WdTQkbns2lZjM2TAvSH1STxkU/+36vqH8+AUq60EGRU7wiKlFoyCRgJX62o8Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFDzvWhY; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFDzvWhY"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-13621cca8f5so6424459c88.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2026 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779618343; x=1780223143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt4h7VRnlzFq8oh7lDYohLF9u5YnnKlteE8zE4IEGK4=;
        b=DFDzvWhYpsETc1F/mjRXzw2yPBo5ZSdkqimCKnMJOkveMvNnMAk2bVonsxANO7MSac
         3loo223Q1gHZgDDu9AzesTCx9FgakTaMdd4oOtXsYsbbENBfqbPvcHq5Zl0Jm5POlzY8
         kekoUIDk+3GR1/QCVvKPSE65gb3wv356SsjX9h/wK1vEn8PiveK7/6lJ6zZTuaR7nO5B
         PVEBhJKlWoWh9N7712l6a+CSyK5sOgfCzH3Nq1JPyebX39ZIK9XgA3sx4iQ9GWMpUumi
         +OLZwCHuajfLTyjQ8eHTz1mSkHr5r6xk+pc7YfjIzsZdTUlvBIHdeymIYY+RBVeooapY
         BdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779618343; x=1780223143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt4h7VRnlzFq8oh7lDYohLF9u5YnnKlteE8zE4IEGK4=;
        b=jXz/haZf0sILaL5ti3eR0vPRnqf09GR18Y/HDCVLXoA+ACL8ga+ihFglJxqqokzojw
         o/cG+EXSy8639p2aFzw2Sw6a0RLbiJCPlet6B+Cb2TPEUgRozQTDfC5C3SdBSKSZki5k
         d6iWawQ5wQkALBGLIoQ0JW36tLa05hL1acZUprA5VBJWibzKgEXeP8SAIvblV5uaslZ5
         ESO1heqOzS/cLiHkF3khUE5RoZzWX0NiaVcabXFFW8JuYM/ajRl0IXBgXfN68/PLNKv8
         I1Od621kdt11j4CAy9lg4wYvddHo8eeWfD8N9P1lMw0zVRPHL2MIiuSf2P+eFrWWQ9ZF
         vpWw==
X-Forwarded-Encrypted: i=1; AFNElJ/EocMeRUFSzZPmFBcJckHn0YfMAgeNY7wOMmjBVwRGMWa59uYcwtkBnP2/UClaJq772o1nkWeYw2w1mGCl@vger.kernel.org
X-Gm-Message-State: AOJu0YwmeVtCzzkTWBQIGAxlZX/7OpT/rRZvkbgmrM84MCuHQlqJgswz
	4+L5uF722nhScRjNhrLW7yCEuR/KgboAO2Y87edDnyt73sPP7RaKE2eD
X-Gm-Gg: Acq92OGdm+shnKPbn2745OScpvHJ9yHkD619babFht0jqP3wgLBpT18RTt9cDegim5J
	BKy2VVzQg4m+RlbMDTEf2RfjEkY8K0XkUcriyFG2vYoqdtNz7031JzU2I5Cugde9IrQE5sGBsX4
	0dY5dHINNRRADc8Dnjl2L7Cw47vEdM+rbUwifv5bz0Bkm4z0lCL29fzu/NiMWz8PdA0TeG4TrJN
	1S0UWeioCOsn1Vo9RtG66sukj9rMjV6XWojk5jBYHtDzD9nkAO3rkpEhSRa2zpFULGGSAG5eNNI
	/ENSOrcKlcNTHHBJPNU9KFnXF90LdycCSR1HHCXXggZb9LTEvHx1oUM0g5Dk2F279skzZiHG7bC
	0zqPjZf7xJD2XYm80SGVngQ2IIXLDYk1dmCaOboJzVKE7Re6dDtdpjB9eHcTvMZue3ZMhoINOGy
	qR3wnesoy5DoVoj0UnxLE=
X-Received: by 2002:a05:7022:6726:b0:133:1ba6:f42d with SMTP id a92af1059eb24-1365f812ee4mr4507328c88.3.1779618342713;
        Sun, 24 May 2026 03:25:42 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88cffsm3847216c88.11.2026.05.24.03.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 03:25:42 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	repnop@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH] fanotify: report thread pidfds for FAN_REPORT_TID
Date: Sun, 24 May 2026 18:24:39 +0800
Message-ID: <20260524102439.44642-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This patch allows listeners using FAN_REPORT_PIDFD | FAN_REPORT_TID
to receive the pidfd referring to the thread that triggered the
event.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ae904451dfc0..ebdd48942029 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -19,6 +19,7 @@
 #include <linux/memcontrol.h>
 #include <linux/statfs.h>
 #include <linux/exportfs.h>
+#include <linux/pidfd.h>
 
 #include <asm/ioctls.h>
 
@@ -903,25 +904,21 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		metadata.fd = fd >= 0 ? fd : FAN_NOFD;
 
 	if (pidfd_mode) {
-		/*
-		 * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
-		 * exclusion is ever lifted. At the time of incoporating pidfd
-		 * support within fanotify, the pidfd API only supported the
-		 * creation of pidfds for thread-group leaders.
-		 */
-		WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
+		unsigned int tid_mode = FAN_GROUP_FLAG(group, FAN_REPORT_TID);
+		enum pid_type pidtype = tid_mode ? PIDTYPE_PID : PIDTYPE_TGID;
+		unsigned int pidfd_flags = tid_mode ? PIDFD_THREAD : 0;
 
 		/*
-		 * The PIDTYPE_TGID check for an event->pid is performed
+		 * The pid_has_task() check for an event->pid is performed
 		 * preemptively in an attempt to catch out cases where the event
-		 * listener reads events after the event generating process has
+		 * listener reads events after the event generating task has
 		 * already terminated.  Depending on flag FAN_REPORT_FD_ERROR,
 		 * report either -ESRCH or FAN_NOPIDFD to the event listener in
 		 * those cases with all other pidfd creation errors reported as
 		 * the error code itself or as FAN_EPIDFD.
 		 */
-		if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID))
-			pidfd = pidfd_prepare(event->pid, 0, &pidfd_file);
+		if (metadata.pid && pid_has_task(event->pid, pidtype))
+			pidfd = pidfd_prepare(event->pid, pidfd_flags, &pidfd_file);
 
 		if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd < 0)
 			pidfd = pidfd == -ESRCH ? FAN_NOPIDFD : FAN_EPIDFD;
@@ -1628,14 +1625,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
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

