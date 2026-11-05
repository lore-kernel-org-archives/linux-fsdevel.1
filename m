Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892369;
	b=HbHVE/ViWY4culR4U6mJI132x7Vws9yRKBCBIkyhNCEvHllvkE2twBWJb4hCRjLxspKt
	 ao7Dl2op/6f5ecYB2FDM2iSdTvRd7Lw1CviHaU5KQW8gabiv4qKaGQWqSNmb1BIzbd6YO
	 kLVTBQrW9AJzlYC5UyJhyr2OpvUxqmy51wqJ1n3gcnww8ngDPAfUklBTq6mSIy3Km0qSy
	 x5xg30Li0UGoYo2MkqBX+ewlalCEziwZWGg9kION0EefE6LLuTtQZeLGFCOLklZRdQKxH
	 tkzkoeXDRbhpJnSBwCpARlRrv/HsQUKSQfle0bKwH5OeAFTu3m2PHXH/QMVRATdl7BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=o+noQtRrvCKww67q7qzZKfdfT00Jg550BlEFzFIvgS8=;
	b=eJybXy8X5I9ETlfioBk9oVRYtv1aAgfUOwDQTYcOEvJQ98+KxXtMBwu/d43wWcIYJApK
	 NV/dqeo/CzBEMnzF7LV4OjbcxcizEmStcYjnc+P8cG8u0iwN+I/GoyxX6o8cPcSIoHTDq
	 uvYobtQW9qok93uKNcV0R7Owobos9aANuEUhgF2MpXVEJAXzAuduzMrfqhxNOobjt4fAY
	 F2d88EReak6SSzo99Ro9u4RAJIpnFdUmWdA7+rCU8JIO34N7pxh9Ep5EznH8sSavcntzZ
	 57DY6vDRyrSUzTQ0fUEIr5kyVj0eK4AN2aHQyZ8kZMAzQIApK5Jbr6QZkA4Lp+mi1TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=p8Y65g9G;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEF6606A331
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBEF6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=p8Y65g9G
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91c763de878so15585946d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892368; x=1794497168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o+noQtRrvCKww67q7qzZKfdfT00Jg550BlEFzFIvgS8=;
        b=p8Y65g9G3ePwpsRpJ9ItMi12wjo0mf7uZTfKe3r4pZ9WQzZT/C4ffUFA6efeTBifhK
         apzefm0UxESeOfQuHsd0HS9AQjSwyGV+AgWM0j8DNaMWh4YjgST+hBGo3pZihU+0alVk
         uk7KAjsyEcV2tPMAGOxsK4v9AzaewVZijMQSHOMofPC5M1I6pyHwg3IxOvYZ16WI4hfg
         ulXDsTW8uIrDD4gLYiUF9/VdnMZ9JTbHZkxOb1tqSStyjUEGUwd5VQTa0t5v5zLCHolF
         tA9OgB5QejYaF2yXSvdOS9thF2Y20M3ASKchSzVXMdSc9+IoPQzY1wWwUAJtezmMdQho
         ypSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892368; x=1794497168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+noQtRrvCKww67q7qzZKfdfT00Jg550BlEFzFIvgS8=;
        b=U3XjCPOVYmk6NxXtNA4ZHrsVKkgd7zf57yLh2eY9vmQHDDXuEvrzvhyu7Ee+tmSsv7
         5KeYZr/3cyQjak+IiCtWwHZSQJZslZ7SNFWHWxcolnhWV2fueaiezsO0KMd6VHn3qilX
         fpy6U4tSpuQFvzTjuayfUtiyl5xA/G9t5RmNdBMJ01OhOwf18CaovKA8rcGf+yY2MAaO
         sjbfUbqavajx/pTsl+eRg9tJrej876dV2viqbtcW874tzW/bS6NbV5faVEQR2sH0tzFV
         rKk7P2I1TY0sPm39GhPiQgfEmzM6VRnCE0kq15ILD2YCvmHichqJZVK0ZAS6KcrLqpXE
         6TUw==
X-Gm-Message-State: APuU4Z8RyJOcJKgW7RKVLXdpIc+g+p/Drw/y1kyQkbTXBgV5rltJ0Xvu
	1L8VM7iHUOtZxCgRLro0Rj0ThChgHZOI85l9zmzymsrekoFiKQCTJ311ffI90LyrDc0=
X-Gm-Gg: AYBFou2g4dZso3I0fBagv6IzTt0tdW7Irp0x722wX6CTdvLdbPEDtJhQg1K/CuEALBS
	+xM2IiGAaJDpSFfaqPP2+ATblxPGO6p2ygywH47gVkAzOMfu+URFJ9aa8/KXtCB0o8tXsw6yOyh
	WGBLSQ1W9Wh2Y2q+SgfM1M21Tyw/Lw0LEnuIojf9tL1JmJv6DLajDj23U59dNaAvU/E7kR4Brrr
	WyJgdMuFHvJ2mM3U1yCD/+rcNDqR8Aj9C0qgMrGDwJYnFiBmSc73A35B4GP1KQHJVtlYIo9MGRD
	F+h1AtHNRx/FqqHQ1RGHJHep7LjGMZZSXJkBunjWNQjtSQvuG2Rp73QBRicHmH2606rwBP6OkF9
	EQNyOmfy/Pp3sHUVSQdrCOpa8po8nXaK1sGlypHouS55x/Uq0ms+x3ysQ+b2cy/Yv0ZCZusPYR7
	/KKIZ+zeCsGyBY7SpbAx8EqnNrbBT7Oo/k+o7btu6dHMnJl3+Da28xwjy7mw2UIwODG81VtcGXV
	5R30doZ80ilGQflaGq7qhMFy07x/b2rVZOV2bG/CZ0S+Jedsddzkfil7KHV48tmKG9nqgM0hfoK
	i4b8QaQSm9ZS8natdaL960zTgjcqJdMi3cCRwDbVReo/IZtRSu17igJtCuM+1Ow5/Guq
X-Received: by 2002:a05:6214:5297:b0:91e:8a0b:c2ca with SMTP id 6a1803df08f44-91e8a0bc5admr72370686d6.58.1793892367804;
        Thu, 05 Nov 2026 07:26:07 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e950f53bfsm25613906d6.7.2026.11.05.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:26:07 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:02 +0000
Subject: [PATCH RFC v3 70/90] seccomp: let a listener put no file into a
 cell
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
Message-Id: <20261105-b4-cells-v3-70-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=1771;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=7eYOaRThtkUA9ByOJCuqUt94IjXJ0cwUOU3B59qhTG4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGv4KofqSrDYzxX7g0fxfHvjCeZyl0RgoeVNlZX90aawfIOm1cwAUhPdL+E+4AylW1MAn0wa3w6
 RjcWWiYb0bA0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Seccomp filters are inherited by tasks that are spawned into a cell. That
is intentional. The listener of a filter that uses SECCOMP_RET_USER_NOTIF
stays outside of the cell, with the spawner or with whoever confined the
spawner.

SECCOMP_IOCTL_NOTIF_ADDFD lets the listener install any file that it holds
into the task that is waiting for an answer. But once a task of a cell has
started, no file should cross the boundary. The files that
pidfd_configure() refuses to place, such as a cellfd, a namespace file or
an io_uring of the host, could be installed this way a moment later.

Fail the ioctl with EPERM if the task is in a different cell than the
caller. The listener can still answer the system calls of the task.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/seccomp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3eecba5ccdef..b8ade37dfcae 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -17,6 +17,7 @@
 
 #include <linux/refcount.h>
 #include <linux/audit.h>
+#include <linux/cell.h>
 #include <linux/compat.h>
 #include <linux/coredump.h>
 #include <linux/kmemleak.h>
@@ -1764,6 +1765,17 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 		goto out_unlock;
 	}
 
+	/*
+	 * Filters are inherited by what is spawned into a cell, and the
+	 * listener stays behind. No file crosses the boundary of a cell.
+	 */
+	scoped_guard(rcu) {
+		if (!cell_same(current_cred(), __task_cred(knotif->task)))
+			ret = -EPERM;
+	}
+	if (ret)
+		goto out_unlock;
+
 	/*
 	 * We do not want to allow for FD injection to occur before the
 	 * notification has been picked up by a userspace handler, or after

-- 
2.55.0

