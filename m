Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347011A5BAE
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780105073; cv=none; b=gv2GQrifdv+DLEGOXheC+M/EXpZ21gkXvVrEvuYUB6agylJwYo57lUaCLBf9uWIpqV8dKP+ZA4ngNi7pYoYucaN0kXb927sK273vszpR5yUeI5VILq1RT/Bx4BnL79udDjzvYhZApOwpobGStasZE32nOcZDxlCeyFjUYl86vKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780105073; c=relaxed/simple;
	bh=zp/O9C3NrfWRcoAYcVmLQslmY4MXAMaLJUWh8lNXlPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMHZCRNZBiQHuBK9zLjhTtzSZH/xZlfwEjBqEmyFtRBFT0EKwG6PZUd443vB/RimHF/wUDV3rdI5TaOTP/NFMWLlZe14MgBcC/TN4w6Rwzle3js7SLRwTBZDhil414M1rN1b0SoUTPaTdbu4K0e1DMQfJyzeoDkURs6P5/YzOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oq0QC1Qm; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq0QC1Qm"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-304d555293aso2090437eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 18:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780105071; x=1780709871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIx0nlS5Y68ho2QMjRaFjrw3/zH1pK3m15usRWzKhCo=;
        b=oq0QC1QmsvIc8asmV5pZtz+E1dO2sUGu/ovy0SOa1ETN/Ci3JO9vxs+84L6QAdeb8m
         0hpitpEKv0v1qd69MAWWIfy6wIY4fY66d5Ntiy0AttlQILmkS1xL9AuuJwHD3pfc3P96
         4t2g1zCAal8gg6q7FoeaD5J+7WN0+Sb44+3o0KC0AXgLvYwdKIKRBjwzVxYBlSniJqX+
         zD/aIEyuRLgOCty/2QVFELlKHROeZ67YnHWU/JgE3+KGn7cHZMhnZbb1eafDtk2pYk2O
         j5KJxmSBmQqxVdD1jakHeSprSdjKoYwlzZ76+oxRj/8KMtXygPST4bpL2baR46tO7D8U
         xJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780105071; x=1780709871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIx0nlS5Y68ho2QMjRaFjrw3/zH1pK3m15usRWzKhCo=;
        b=fE1mv125wIkXBpkFnXy2efOEJFCcShtE9kpuxbq9skpX5PM5s4KkXrj8EpThF0NZjH
         Xow0Ig2s8XjhPeDpIhYtslLfPAvjqGUxDyWp9v6Pexsn8FF/S8MxEtBylxBTKshZuquy
         EPZ7Vb27GrqV+m4phpGfRr/D2N4H2k6V+ex3iddBb7qJ6gELO7sUOsPbHYU6M2UJiEH7
         bR6gP/ifzFXPTGJui0/F7C4+l8HfAzalCw0hEW5eHUPLG79qGmbhySxmFCmULLHzV3RM
         cmNcpPMZau/ZSt5Lj8V31sxLn7o724NMYbFZfN0J9wpWAoOQgpg1P1Rt9wCOlz9uiaie
         om1g==
X-Forwarded-Encrypted: i=1; AFNElJ8HpgkyGggcUbvlzn9nXlNdV/5mppFpGD/q1yKtvEVWpNcYEvo6KpixxHSyyewYw5fOSL/zpFcQ+fWzxtfl@vger.kernel.org
X-Gm-Message-State: AOJu0YwJO33H0nMPrDUv00g9H+cwX2MfFE5/Bj75aIpFhn6VxVaODp3Q
	kvebo26lqR7M1J/0VzOTeFvenyNHTrLh6lCeBiQCNaH9T75KB6tNlZ1x
X-Gm-Gg: Acq92OGr9heXpzlE/EyaoZzlWfjv36arGDNG7cpGfAjgLn0Dv3MdL+NKNetd3sZvjMF
	A+jOzVyMHkwVxNm706UX4yURWa0555PCL9Lu5BXtu5UNPjGHTsjcyY+aq1RNFq8Di0wAK9s794+
	CANpVKjXUADwX1FTHpQHz5xRLpty5me+zBNHF44yAmZEA/eFAOs2OPp6UQYlt1SeXSmgOTVjWJ4
	dG347vPxWkhhRC+qOokVUsBr11EfEPS1noAjosbcSmaZtm0q/avTTPX7Ot9SLLjbZVybr/3T57Q
	3xshB8hWQWcisPEvRAM0PHsnw4CKf3gc+ay7ja2mcM5CXOWXqEgXynWNvq0/5xNYT0Assmlzz+3
	Tzoid2v1N3E6Eq3ZYnXlTyVXh51JNWG7ZjQkKsQdrkoEFJu5SIabn3C8j8lWWha2kc46CLXKu9z
	NWsK5MDUVksLGxqumVFlWC50UFEfag/Q==
X-Received: by 2002:a05:7300:3722:b0:304:d4c0:82ea with SMTP id 5a478bee46e88-304fa5e85b7mr1116536eec.21.1780105071364;
        Fri, 29 May 2026 18:37:51 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a114dsm2881199eec.24.2026.05.29.18.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 18:37:51 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: amir73il@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	repnop@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v3 2/2] fanotify: allow reporting pidfds for reaped tasks
Date: Sat, 30 May 2026 09:37:32 +0800
Message-ID: <20260530013732.50811-3-anonymemeow@gmail.com>
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

Fanotify used to refuse to report pidfds for reaped tasks by applying a
pid_has_task() check before calling pidfd_prepare(). This prevented
userspace from obtaining information about the task.

Fanotify events already hold a reference to the task's pid struct, so
the check can be safely dropped and pidfds can be reported for reaped
tasks as well.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

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

