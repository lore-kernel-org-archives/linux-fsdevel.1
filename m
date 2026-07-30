Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82201426D13
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419017; cv=none; b=Tq5v0Uu5Gd+UW9Ss4v8gvYJ3GXm4YChWyMI4txwe2CugyagkFK2hp1xHpYXTXSdHxAxjpRa6liF8MgBGN4PPcJyS0MF4lh8bBuzJwRWUIFjIQuTSIBgFPYZqJLtMoLHZXuUpUDVukiXxxs1PauUGeshVey8mH6L/1BPKEt1rUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419017; c=relaxed/simple;
	bh=ICU4Cuyi6ytS/C4R22lJlFCUuo3uGHTm+woWo/XXcS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4cTTALCiopz09xUKgRAo0I1MzdUgQWdciC9zpGj6fNlkgyNpzfpGGpI7sJrrW/fF68arBUF3uxNE2uI7uGbzVp1uXdrhQYeWLYHfhCKwatNHzx6y4EnY3wMj7o813Ba7PzHvQf2E7ED/N2pTzT14wu+qbWSvp0OH5we2INLFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myIpUrHs; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myIpUrHs"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664b8b65192so290890d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419014; x=1786023814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G5magtKCCWYCyBY9UsWRVwfIoO8WQamQTvR+dMBS3YI=;
        b=myIpUrHsYWw/2Snt6z5XHorCEs3hbHOnRAF560re03cOJ5ce4K2pXYmr5uK6EfAEsT
         MSVTj6IdsNVBaUkD6J0RKzcHazt8J1SuzTO07hjC7j4R9oN2EfvPrXF5wBetuOPYKM+u
         YlvsRc8pv/VSCzy3rwXuz9S9kTCPqVtI/GFrxPiQkkc8Sn0IJoC4mnOSgQINE23AGpJC
         kCQufftdcRawOfnsdaH6MoNi2+1O5cXOlQCT+D+8qL6i5tJflaBUG7IqjkoWw8t7oi4S
         aTrGePL0yv8TPtmNI3PHE03P2Bps0VCuF4MYkKzX1FBlqeqVNSZQRLcv70DUlf1/ZJhS
         GmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419014; x=1786023814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5magtKCCWYCyBY9UsWRVwfIoO8WQamQTvR+dMBS3YI=;
        b=NTc/BN2YI+gIPyA5vQRJ4PTP4sYe4AAZx8D8qTGeKbN0aVdcZ8oQkZgx1znzWD57JR
         UMiPMoePms+D1EeoSuIcz45AA7OqQU5xve5KttTPf/BWZAIk9GlB68Gq3ks3MyByXEIH
         4mmFF6t41xZTYaRgBSL0bJTFksYlHw/nYxxSC4OF0iNI5+aoWyvuZFhPaz30Fmpd/EOF
         RSul0GCgAHXmtHRHAHPWED+dhqqUMwr0LRyeXTvo0sdI3EchoZOntyx+n7wQHzeAtqTx
         8lvtvbITFCpV74mUy2Tm6VaKfbrbkHwjLEysaVQH1Q70U3vbQg7ptOLERosIggJWGaAw
         VC4g==
X-Gm-Message-State: AOJu0YzIdUmtM5UH9McrxrfRclYIrzZ2qYISJoCrBzvdhoMiRnoRvFTh
	rssTC97E+WZKmNViNe/vgp2JKP6zd3iWGCMPx90CAhq8/b9CzrjCfw6f
X-Gm-Gg: AR+sD12BUazLCSotW29vMGV3gaO86HuJGFeOeq9yngPNMQtF34AXRK4Uz9oakwLl8Ae
	8pe6gtOjpDT2c/4BszGPxrpxsHevm69fc+GFKgiTD5SePpTPbpG8Epw8ut2kcHaT1ayHDVos+Bt
	hRYh6ZpdGpCZrPOPkcBA4QsUjpi7U4bvQGRQmcXhBoBy6FfbXFPwb7iTzDvpdMUROOcwFvcdq2W
	Kw0TuJRK2thwUPLMSBBQWCnA8/RsZnQQaRi7XR1mC55CtN/Dk78CdFap2Yx1WJlySqsTtIVx6ZX
	64cS8Iz9cPmKq0Aya1JM7exEYwJt+qAVR3GaTKXw3iuLwd2UBC81xF6+VUrR+SybrHW6YuG5UtZ
	Hciqe4+npvbeJAbCJh6Nz4giD2kCgWwJ2FmYIizDDHJFmtoV4LYGgrSzErj5DfzANaQ/YVBSzr5
	KhyfHhMwP9bE1PfdiUodhu+rvAemP5RtjfgGxNXx1Bv0sli5MoW6h9UzbXb6iCshHptu9BBtxGr
	eUqkaowICjEQh2V1Ld+ubME+y3rd2yGXl4Y07+ayj8T+i3w+zUQYBk=
X-Received: by 2002:a05:690e:804:10b0:667:9a45:f7b2 with SMTP id 956f58d0204a3-6693a2f8f7bmr319263d50.1.1785419014230;
        Thu, 30 Jul 2026 06:43:34 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c74a27asm1273343d50.8.2026.07.30.06.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:43:33 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fanotify: fix use-after-free of file range info
Date: Thu, 30 Jul 2026 21:43:16 +0800
Message-ID: <20260730134316.2085087-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsnotify_pre_content() builds its file_range on the triggering task's
stack. fanotify_alloc_perm_event() saves a pointer to range.pos in the
heap-allocated permission event so copy_range_info_to_user() can report
the offset later.

The event reader can set the event state to FAN_EVENT_REPORTED and then
sleep while preparing the file descriptor. If a signal interrupts the
triggering task at that point, fanotify_get_response() changes the state
to FAN_EVENT_CANCELED and returns. This unwinds the file_range stack
frame while the reader still owns the event. The reader then dereferences
pevent->ppos and copies the stale stack value to userspace.

KASAN reported:

  BUG: KASAN: use-after-free in fanotify_read+0x293e/0x2970
  Read of size 8 at addr ffff88811434fc50 by task fanotify_inotif/95
  Call Trace:
   fanotify_read+0x293e/0x2970
   vfs_read+0x177/0xa20
   ksys_read+0xf7/0x1c0
   do_syscall_64+0xf9/0x540
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Store the range position directly in the permission event and use
FANOTIFY_NO_RANGE when range information is unavailable. The event remains
alive until the reader finishes, so the reported offset no longer depends
on the triggering task's stack.

Fixes: 870499bc1d4d ("fanotify: report file range info with pre-content events")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---

Changes in v2:
- Remove ppos from fanotify_perm_event and use FANOTIFY_NO_RANGE as the
  sentinel for unavailable range information, as suggested by Jan Kara.
- Read the event-owned position directly when reporting range information.

Link: https://lore.kernel.org/linux-fsdevel/20260730085801.2068723-1-nicoyip.dev@gmail.com/ [v1]

 fs/notify/fanotify/fanotify.c      | 3 +--
 fs/notify/fanotify/fanotify.h      | 6 ++++--
 fs/notify/fanotify/fanotify_user.c | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a3555bebad63..b05b6d3abb87 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -600,8 +600,7 @@ static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
 	pevent->hdr.len = 0;
 	pevent->state = FAN_EVENT_INIT;
 	pevent->path = *path;
-	/* NULL ppos means no range info */
-	pevent->ppos = range ? &range->pos : NULL;
+	pevent->pos = range ? range->pos : FANOTIFY_NO_RANGE;
 	pevent->count = range ? range->count : 0;
 	path_get(path);
 
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index a0619e7694d5..3710543dbf82 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -428,6 +428,8 @@ FANOTIFY_ME(struct fanotify_event *event)
 	return container_of(event, struct fanotify_mnt_event, fae);
 }
 
+#define FANOTIFY_NO_RANGE	((loff_t)-1)
+
 /*
  * Structure for permission fanotify events. It gets allocated and freed in
  * fanotify_handle_event() since we wait there for user response. When the
@@ -438,7 +440,7 @@ FANOTIFY_ME(struct fanotify_event *event)
 struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
-	const loff_t *ppos;		/* optional file range info */
+	loff_t pos;			/* FANOTIFY_NO_RANGE if unavailable */
 	size_t count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
@@ -468,7 +470,7 @@ static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
 	if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
 		return false;
 
-	return FANOTIFY_PERM(event)->ppos;
+	return FANOTIFY_PERM(event)->pos != FANOTIFY_NO_RANGE;
 }
 
 static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b604e3da58ad..bba92d691f0d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -675,12 +675,12 @@ static size_t copy_range_info_to_user(struct fanotify_event *event,
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
 
-	if (WARN_ON_ONCE(!pevent->ppos))
+	if (WARN_ON_ONCE(pevent->pos == FANOTIFY_NO_RANGE))
 		return -EINVAL;
 
 	info.hdr.info_type = FAN_EVENT_INFO_TYPE_RANGE;
 	info.hdr.len = info_len;
-	info.offset = *(pevent->ppos);
+	info.offset = pevent->pos;
 	info.count = pevent->count;
 
 	if (copy_to_user(buf, &info, info_len))
-- 
2.43.0
