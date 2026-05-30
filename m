Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1236DA18
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138284; cv=none; b=qR8mYlEhjuwLKkk08+ECW9PR5eXj2G742UJCtBG1IisspOEGjogJu1lNa3qbfYzlWQ00yKrGewcrYCa2t0ZLcneeP1VZ3YSqugcd9ZoHIyQiULEfoAXFV6Nu2dgTzMMuXeQca5+OU/8q7t6eyOGgm++l4GZwnR5Y93oVkR/B5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138284; c=relaxed/simple;
	bh=/+1+lZ9YS5HjmLAOWU1Gb2rtgqEauNFXeqweFhA2+C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqrP5byqAryzAvgESpWdyfKsrEwM/DH8w10AVO+xyL7/0F22dZ4AwGmElK8lrAUZdXg17AEckFGSHC1k1BLMfa6dCMJpEWWJMVDNzaOr/H7MpDaHLsBAiA/2UN+Wjkq09vzZf43aYMMazDxsVadJzTUm+p5AgjOrTgac5+Rv9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJbV301A; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJbV301A"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-304c520fe9aso7011116eec.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780138282; x=1780743082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iheNwFPT6VXXyqKSS6/OjeYfCgrEDkZZRTM2pKQumvc=;
        b=SJbV301Azp0wPIoJV+96jA0I4ylpoiYi6WdSA2DuXVV0ib5Nv/Tbog7SuLd4+Pn3S8
         UdBZNzEfNSzRGkFD2cinIPzYJScZcgYWCaJ99AbsLXWBlXHim7N92M2I4bkDoczFyrPy
         Z3FqxKl8ZpdfDYr0TKzZXNqW/ezaAr2zuX0GXhu9TvhsQ+O4a93FNtnZ3dyzoZfcMnhq
         73wYgvjuu0WPjxlYj2TRtMpPABhIdTwcfE0uylyn1O2ipp4UEokz6vtpDISkDBozPV/U
         e6VYrbHt7Hue0pKZlJL4UR5zseXlhXj2UjHnZ3RPj6J6aUbAAVEJoNGto8N8654R4Clw
         7yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780138282; x=1780743082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iheNwFPT6VXXyqKSS6/OjeYfCgrEDkZZRTM2pKQumvc=;
        b=IxpRkSia6osQKEZQeWHPUvYrNSVIX52h5+gDDrziHF1526ItNWi7lzQepRIvmnhDRb
         Il7N0/+cSFxWaER0qtOfsTCUc9F9aCQM8sLs4su1DnAlYTNisJijkPShtOQqclmBDRkP
         B3hVGnuW5dL1EpKAjYxoJLVZVgjPOw6NANfU015F1YF/JlIkjf9l0NzuWRQGk5GHPoD5
         u56SwG3V4+6kfEiFhNh3H5SyKRJ7vMjoFmEBVQoFwpp5vsIJ55/S3w11Jzb5JHMY/wjs
         To2DDxHD969t8BaIatCXxQ2OXKOVtZitdAC4tzLYX8jrvrUUNQ+3UBEV28oeuEa/Y3zm
         0Imw==
X-Forwarded-Encrypted: i=1; AFNElJ9NX3XM9rQpN3ACUo0nmDdoDJo2+nEt/NmksSAuctTok6inrr77wDs6Bq8ALaBH1H/0dFSYIcnIuK/aM5gg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Y1VLTnilXWl3naJEESM7BixI15jeO24mefTBMrmw9WiB0LTE
	geXtUow6c29sn4g4xSVNWiZDkiLL/mZvlO8dqnHGIFfG8qB3zl7wrZ8tgNy90yO2
X-Gm-Gg: Acq92OFilhfMK5qQmsJw6s+lHgqhZBgravTjo4sNXka02dq8NKsG+XqoM0p9D6CPoFv
	i3MBa94GzUjTedUSS28JinskzTuhsMznxRLxX/pe1Vh9IyKRsOjzQKSsKo6jUp6oWOgqt+XEtZ7
	VYBeY/1is6/glXRWrDmecnc18oH/OgkRux2BaHO/gk8LuI2CaUlqKQs47Jy35iXVhtVbstfysDJ
	ig6mbqHlFNzYhkTCkrxbH1u1IgmqZPoWaEcl6IowndP41VEXwc586ThaakPeiX3U6xV/FSgl7P1
	ai2PVUu/m5LBA7aTAoqvkv/TCQqZyputTqA3FlA9ACLjOOgNxK/Y9xMQ51Oy/jPGEmbCRkCHtem
	J3SCzIM6brUXAmMH5g/6gFYKp2Q3hMuy1WOTpsODGFTFI5OIgJMOtSV8hnGt/qYGJVPW2SfIuyG
	FVKatbTHSoVF1R4D7jWn2eQZI+q5+OyA==
X-Received: by 2002:a05:7301:7213:b0:2f1:496c:94bf with SMTP id 5a478bee46e88-304fa5ab148mr1741836eec.16.1780138282318;
        Sat, 30 May 2026 03:51:22 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a114dsm3814007eec.24.2026.05.30.03.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 03:51:22 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	jack@suse.cz,
	repnop@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [RFC][PATCH] fanotify: register event pid for pidfd reporting
Date: Sat, 30 May 2026 18:51:17 +0800
Message-ID: <20260530105117.45792-1-anonymemeow@gmail.com>
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

pidfd_prepare() may still fail if userspace reads the event after the
task has been reaped and the pid has not been registered with pidfs.
Register the event pid with pidfs when creating the fanotify event if
pidfd reporting was requested, so pidfd_prepare() can later create a
pidfd for the reaped task.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---

Hi, Christian,

I tested this patch set and found that fanotify still usually can not
report pidfds for reaped tasks, because the event pid may not have
been registered before it exits, and registering it after the task
has been reaped is not allowed, so fanotify still fails to report a
pidfd for the event.

This patch registers the event pid when the fanotify event is created.
With this change, the current LTP fanotify21 test fails as expected.

But I do not know whether it is worth doing so to improve fanotify's
ability to report pidfds for reaped tasks. And, what should fanotify
do if pidfs_register_pid() fails? Should the error be reported to
userspace through the pidfd info record, using the raw error when
FAN_REPORT_FD_ERROR is set and FAN_EPIDFD otherwise? But the event
struct in fanotify does not have spare space to store this error code.
Or should it just ignore the failure here and let pidfd_prepare()
fail later in copy_event_to_user()? I would appreciate your feedback.

With Best Regards,
AnonymeMeow

Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/

---
 fs/notify/fanotify/fanotify.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 38290b9c07f7..24b2af397126 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -14,6 +14,7 @@
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
 #include <linux/stringhash.h>
+#include <linux/pidfs.h>
 
 #include "fanotify.h"
 
@@ -868,6 +869,15 @@ static struct fanotify_event *fanotify_alloc_event(
 	else
 		pid = get_pid(task_tgid(current));
 
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD)) {
+		int err = pidfs_register_pid(pid);
+		if (err) {
+			/*
+			 * What to do here? Pass this err to userspace via pidfd?
+			 */
+		}
+	}
+
 	/* Mix event info, FAN_ONDIR flag and pid into event merge key */
 	hash ^= hash_long((unsigned long)pid | ondir, FANOTIFY_EVENT_HASH_BITS);
 	fanotify_init_event(event, hash, mask);
-- 
2.54.0

