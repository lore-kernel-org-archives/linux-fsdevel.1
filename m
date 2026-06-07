Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01A202C46
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780792451; cv=none; b=VDFGRSrSCCJUJZBmv2J++Dc0pAEcJvM2sBMGQrvFQZm59m+ck2Bx06pJ48G6W+yn2CHxwwk64v0g1NR2ICVIjkQZmtQsMTD4N1ErtTteBPtzD8pmrsgq550OBq78mCcQdiJqFRulo8eZaorHvk25qv1S7+ZVExeh6HUedUrbMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780792451; c=relaxed/simple;
	bh=ydHyg/yHgbQBSF7WWPMXrPO1fho5KdGEiISM0UJVrLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoYLHslid1auDBiVdKr5xkZ3ZbN+Fz8cRpVGxLAf63+45hrPIvSKw8aZM53H/6Q46TGaBD6CQKMChEelBCmauKux1eSt4jxdW0KFwI6EobgQQoLrzUqwl5PobwoiPWE/H+Ue4yZqimltuF6B0zfPxGhlpZ2G5QZsAYSWyY06zAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0GNYZII; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0GNYZII"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-137f27712fdso1637216c88.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 17:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780792450; x=1781397250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKXpsUK4JppanynxEZ3suyCmjR7j3BpgdIBDoN7gy84=;
        b=m0GNYZIIsAnyPZWsrAq0EPaP7V2LzzTBQyCF3Vt3Z5CPjGVT4kHnvRUCK15pJG0A9T
         l5Lrkv7jy97+9hgHDihcZJmm3VmzFK1Pp01ILpYDb9koXo5cmYyT7IYO62zo8lrOuqSK
         JDISlirPF6mCSckB7iUPWElV0BXzSHwxo4zJ2tATFhrTipUqMZwcF1adXfFPswcKtO2I
         bJmnpNkh7xuxnUNYy+21bue/CdSyrkozQKFnFvmTdoKiFQwnUi5dI1xN2kHT1z3YsEwF
         OHBghUVlo3joNILlKRbrdK9o9D5748uCLJ34tfuEN+KRYmtNmPUElbtMzsI+1QLk8TEQ
         SlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780792450; x=1781397250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKXpsUK4JppanynxEZ3suyCmjR7j3BpgdIBDoN7gy84=;
        b=IZLlXqJ2+nLr1MeQs1HdL+04i0wUMFIXV1aETbIUaxFY06zuTm6FDC+tU7AjyxJaxW
         0PcaVHb+eXNaLV8Ck5F/QITqN9cIaRnwfPkx2HAAF7tBRbazVv9s1ygQ1IxxK0lNeN5E
         5vhrXpcSTbpOONSpT3mpRCtuvTnHeSSNIpuN9XlSb1bf3ja8f6p997Z4fIFB3DGrHZ/c
         wd+0pWDgfdtz/8zN0rlfQn5lmkmiQO2CATGb5ghF6dWBpVrwOmgJ/Zw85eBiz3gLm7LP
         1JjZsolJcqM7LBKgj9ZOMwKcs+xs/pStxYPm8z145CPnfUr1Ht9F2LSKy+tLEiNOWyiv
         G32g==
X-Forwarded-Encrypted: i=1; AFNElJ+QXVXxBSSOZvnOtCp19j+XO8wSrvRxLwfHLrbwIS+hmLMGRamN0vWoePhGEwifbEpxSTPZ0kCombVWl4BL@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQLV9VcXtSjmoWiLIvqbMUj5NcTuADIxrG9QEHuSTae3MKPL9
	mORpYmjbzNUjMXZZ5uN/Z/INNJ3E7wcLi9dHJYu813JTuP4OBwLiiW8H
X-Gm-Gg: Acq92OFrvpLqidYf++80tk1XR6xCxcNRxsZY0xRdE0o/p/tYH24TAPIjSQlzzeVAWaU
	uwnfC2zaO/lSCuAU3CGOoFXVU/j0R3xWhG1BwUZXNLtIVAoE4dNNb1drO9n6vfikKlsDvzsVKrY
	GpTpqQGRmgM0OcakhezO0Q2u6O4uQ+IVQKB9/congrJp2nz3bL8t0Ukov7x3QoDWroEluxPqgFd
	S2lDHhjgjTzr63BCYW93B+BRP+vA/Bxw3FtO3Fstq9U4Jel61NW4neFvYmczko3xvqNODoV6nkF
	lQUkv8iHwhchn4Yszuf4rgx8apvpYVhKKwIWrzZFZktyEbwCpzyAvBdQMqUNxWM6+vvfwTOoTYX
	u0+02nG7D00k1oWMLbEXme9JfYvTqa92SIUFmG0AIrvLH5ytNDG3k3WQBWACOmQcrzgGGntuG3S
	zHeUvL8RbCZQ3CxDB4wBNjlvKtZfkMsw==
X-Received: by 2002:a05:7022:eac3:b0:130:aa42:167b with SMTP id a92af1059eb24-138067319f5mr5198147c88.36.1780792449701;
        Sat, 06 Jun 2026 17:34:09 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f716017esm13451383c88.15.2026.06.06.17.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 17:34:09 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v5 1/2] fanotify: report thread pidfds for FAN_REPORT_TID
Date: Sun,  7 Jun 2026 08:33:42 +0800
Message-ID: <20260607003343.425939-2-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607003343.425939-1-anonymemeow@gmail.com>
References: <20260607003343.425939-1-anonymemeow@gmail.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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

