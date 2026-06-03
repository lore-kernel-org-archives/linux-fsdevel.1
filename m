Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828A2264AB
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445753; cv=none; b=WRPz2WaqhrYFYrcvgyXc0fEoiXzV+El8t2aZpZgG9ujW9g8WFbY0oE5XipIfXV+EawXSd6iTrObKy1WRgNQmpRT6F1rQ0sM6qkSd8hV1x/f41nND4oWiPVpZl76TUmohTG6iEAVySlze/FzlptJkpOfSTdAgpCCo/2F+WY1qBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445753; c=relaxed/simple;
	bh=OzxvXiS7gZrNxYNXj9poA0um2pTBU84WZQnPOJzbptA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dr2MXafzLDSH/V2Z8sn3AlGxsiYwR2UInrsfcYRlQ+7rEnMgbNgpdhDoTcO+vrg8EgBVScYjNH5aFPRVQG3k/M9Gk9SOQ332UbDNuj7G7YfcActC6PAYvwsnRhEPu43BseFRIEAZP8g8aanNGfoKrxAs72w3NNdS3igPAIObBzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oKX9hQx6; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKX9hQx6"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-304d555293aso9227377eec.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780445751; x=1781050551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30Zmw8a16oaljA7WTVadlHqTZXIGr1FxDCtkAmoDkcE=;
        b=oKX9hQx65Ydl6FpV9E280E7lmwrQRxGADePEQGTDz5NwPwkXkM3W0EjoRJUKukzM/A
         9ssEkyWI60zzC/G+kYkv4h7ORU9qX4CHu/2M3ahNohJwaHHngtPMJ7J1n+vSEYZMNX2z
         +uZjJdWIJ0n4fUc05m9CpMhIkz839ftKfC6MoKbJC5a6EFSJs9y/ka6xsJCD3u+/L5bE
         h5AfGzvhd53L5IRxeAoJDvGJXvJ6knUy/6HLph62BtQouUNQhuN/GodsEJT9brW1CZbe
         xwWEChNGqkWkg/Lzs3v9ZMsxTVnw5pHaIGBX5fgYv2e9BvYqHaYMvZAj7hQ7aqWOlWvL
         RI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780445751; x=1781050551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=30Zmw8a16oaljA7WTVadlHqTZXIGr1FxDCtkAmoDkcE=;
        b=UViE1lpDAA4SnGcpXrGr+GX+miIIeTwwtK0+TMaNKRa9V63eATpGTXMnQcaJ2D4ZFG
         h4uj8oW2UNA4r1YwDWXLgm0824t3GhdIgTbm7Q1rYdLBsuRZoKPOYr8sULJU6mLD+0ZE
         F+1z+asQP7EJEYsdTxjYaNnPOQ9BXOmBgUbo+FKvTqOAA3b8MX+Ymq/N2UIpp7Cxp361
         jIgq6MzJan0fz5rr2KLhh0UifAOlcAnag/5TIFG6xUDyrOmZ3+YGdpljHYdG3DY6E6JJ
         Em6RKhnwZrk2AFl9Gs3f9/Mp/7OjWSwTDDOoV99z0FNl4CC570FWCTkJ+IUNLxdIj7Oh
         up3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9nn+R/PaM0j3Bug8VAHOmC242QsZtm2ssmtBmTCNO9clvVSyoJFZSRpYyeRmqrK182UJ5127wC4p1yOikN@vger.kernel.org
X-Gm-Message-State: AOJu0YyUy4ezD9hfQf1nfxPJ5C04kS4wimfZmB4d9zA2I/oHeL6HSP+b
	BttUimU47bOcmLDZwcJPbdaqnXS+pA3LMjyC6AamT5q5r4fy2mtuoefU
X-Gm-Gg: Acq92OG6LLCp7BQbMNHsNQ5gyUNjFGy28yWenyStE4J1I9jgRtNY5wiKFCw9rBQ0Km4
	q+Ifw77+pvForQVMzRtbbkGQC64dLIL8AY3YpZGHKIwwM8XWbCa1PsHfZR1DvP0pZiV1skyKaDu
	yLpBIsphMyGjv1J1xK89/jltaUQV7UO7A41smW1zLtsKeueL2YwSAP9QcmNaMM5Z7uK2EmXg4O7
	0g8kUURY6VNQB4rgKg+x4LHM16th8tSPJbmJQM8aZ11RxVjVi3lUUDVbYbTbwhaE8d/8VFxH1h0
	qfFQ70Hv2NbRseNxvIMyO9VRh9b8vDwA/LS8zb7Kn/cYCTQLhS8bGubF6boGctyuqXOiuCUCkgY
	xeCoBnTOkhd4k575K4ZJwPwsCPDMwpSUHn/Y+c59SZI1QCAaNVogkJmllWVmRI6kUNc7iao941V
	0QiTqQQSvcFkzhxwN0SgbQ7FcCsOCDKg==
X-Received: by 2002:a05:7301:1685:b0:305:56a:c38f with SMTP id 5a478bee46e88-3074fbd9cadmr545153eec.26.1780445751023;
        Tue, 02 Jun 2026 17:15:51 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcb98aasm829069eec.12.2026.06.02.17.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:15:50 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v4 1/2] fanotify: report thread pidfds for FAN_REPORT_TID
Date: Wed,  3 Jun 2026 08:15:15 +0800
Message-ID: <20260603001516.26234-2-anonymemeow@gmail.com>
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

The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
exclusive because by the time the pidfd support was introduced to
fanotify, pidfds could only be created for thread group leaders. Now
that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
this restriction can be lifted.

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

