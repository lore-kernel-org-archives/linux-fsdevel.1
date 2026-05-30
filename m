Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF592FD1B5
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780105071; cv=none; b=ssdpca2L8rEzX2HRzTHg0j8CwIG1duLsvSNPVHIBPKTRa8BcVlrAxUs3L6QT4mtnIJ5o2pB7nzjqHRyjIGlhm1PlzGVVtU1bhQULc5mXgJO7/5otp/ESAs9+xGicr2LU0V10+BmplrlsPXjR8VHaqVsFJIM/v6roOeG3kUklULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780105071; c=relaxed/simple;
	bh=OzxvXiS7gZrNxYNXj9poA0um2pTBU84WZQnPOJzbptA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TytdBtfvk4R9B7mRI0zng1zhH7gJC4HkjVwiHN+HNA+05mPcPYDVHZdifCI8gW5yjV4AuHG+wUT7GzAM1K8q8R75xix8v5qWUxJVT409A3eMws5Cr4IdJjmL3cXksdqQuifGLB0tmvtMCo4Z9RteXjZitXV3lkkPlc3VAQ6FAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmeSLqgY; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmeSLqgY"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-304d8e3bb72so1893639eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 18:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780105069; x=1780709869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30Zmw8a16oaljA7WTVadlHqTZXIGr1FxDCtkAmoDkcE=;
        b=cmeSLqgYEz9uG//mSUedBUh3pW8TkWgMqn/K8YfwWtuebB3vrXSgMuCAoZGXyKvPIF
         y5UqMUOmqwuiDo4EZnPN+0GXCR4zQ4MDf62duMNleuDDcPp3gD+Z/7Rser+YiPuvAI2J
         nZiu/VsE5zjek0djlMrQhxgEIgbfMYyTMMWu2oXK+yg1M84Uy6DaP0XvurHDxy2PZExl
         vRZKDf3wajPxOc0EG1lLCa9AFwc6h7LXby9+DfilmkffnX01U1TJsSIWgmKUF1ee6kU2
         1nPLXAiqWA1mLi1grxwHHvak6nw/JNRHa+kKehTU6BhZqxmcXX3EPxvbaZUdvOk36lDg
         40lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780105069; x=1780709869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=30Zmw8a16oaljA7WTVadlHqTZXIGr1FxDCtkAmoDkcE=;
        b=a4DR+Q0runKXByATy24NDiNHChutbofamn4lF2uXg//tvIHjcBUDk3l4f4pBrigKoV
         TBtLsRFnH+5qA1n0nLF6KBitnxwIlre/GZ9vWufQHPJnmfJMgyNB/Dp4lOFabcYTI0mM
         nKOUVWKSinsFaidRI3XziLBl3VGG/aizj4EmDGDzvDLjz/epDAHLCl/EuS8qDmVWbQE2
         8WPfwta4uvdsqlZ3my2h9AUdMeAs1Qc4q6k1/xGXW673ny9jcYZVMSUDfG48gkR/HpRu
         hcD4SKNJS63V/iQhniCEzb7eYIUAFJcO7vyJEBISF7KU7dolJSyAU8Q5P8FXFb018xt7
         4USw==
X-Forwarded-Encrypted: i=1; AFNElJ+BeTEZlMgsmV329Eatnm++AVTBPS582MVIsvriENhuCw/GKM9zueVOZLB0ILlq3F+rVcVjDMX+0+OU8PWw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IdLfaBfvgY+zSIFqaFnwc8ILe4m2wfMkHhITi0ZqR5Yx5aUV
	3j2CSiwqdMkC4lS1AWaGlHz01LyV2n59f6lDwbte9BXu63ADS4QpU+ys
X-Gm-Gg: Acq92OEGbESzFbTLwjc6O7HxqHVoXLy+ZfLPS+09V/FS9RdVkpepoTLAh5KcdWaqu7M
	OuAXXXXGtI017CsTlzjpM2vM+tvhQwNrFv/6iGVpoJsx6Yuusgfobq9IfbXO/5QoIL4LXQrKVcu
	bGESAzpSMyDJ1S48qubByZf0/xn0i+oM/Yijo2XpAM4i/S5UT6sOpu3eGw04tUX6DZCNgNSSsNR
	pITPNM8S4rvndRAidzLoZqRiO8stc0m7+dLxeFGY3ogJ5kExw4SGJzqw7EvIcwoJ+sqkVhUJbiO
	S0jYlBA9mQJfsNDOFAu3nPAftrDEeWiHf/Pxbz21mzsYJq8cNeSXgEY+zUIrUfFypNpmf4hRiCr
	UO8V/XWXLXvnV1HPQ3LvYhUn7paNSOBF5zRBPzE7OgqQJpPOYFxuVMlFvwc/E4RlhM7r6y+VJ7S
	pbn1Assu/9JYnV30PmPUiSdg+ktZbFPA==
X-Received: by 2002:a05:7300:6427:b0:304:d75b:f5f4 with SMTP id 5a478bee46e88-304fa67e9c3mr1186278eec.16.1780105068778;
        Fri, 29 May 2026 18:37:48 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a114dsm2881199eec.24.2026.05.29.18.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 18:37:48 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: amir73il@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	repnop@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v3 1/2] fanotify: report thread pidfds for FAN_REPORT_TID
Date: Sat, 30 May 2026 09:37:31 +0800
Message-ID: <20260530013732.50811-2-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530013732.50811-1-anonymemeow@gmail.com>
References: <20260530013732.50811-1-anonymemeow@gmail.com>
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

