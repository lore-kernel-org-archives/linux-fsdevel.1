Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498350;
	b=xgB1i6nY0iIBmcItKI2xlHzmL5e/fR8h0TZKAtwpVysNywG9Y7cQyaelin2cBoschDPW
	 F7+5e9Bns5GduBnYmXiCDHTI1Dq40U/y7E9QwMp3QbP8svqoiRNQnhjnRUzWYOAahC6SG
	 9q4AVFhYmvLsNkoKI8Wp/s5Q3bMltqe8aMmCSu0QIjH2YZd/rjcMlO03OLqBXSI6Ho4HL
	 nFyTSiYHiP8ja/X+3fE435VSTRK7c26u6TE84e16MCvIWRiZe98O8G2f2vy8p+5z5ueee
	 nE55g8D+r0b93LOBBkfFI5A+tuQW2T7aAbMJfH5Ej5RamsNIEaHUWm9q2NluE2r0bwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=15y+rjAagndMWGwtM7jZ3FI/6ZLw41O6Mm1RADPXVig=;
	b=VEGsn2yz8U7VAz2ZIAhwye4W6Ko+aUTcFzqdMCSHoULPZ9Yms5VnB98DITes2hvwxs1G
	 g1sY5+IVfP6qoXRLb2TjIgq/3zMBtk7hFpUGZOc7R7V+oqtBrmdTnRnXyAKeNL3a5LWD6
	 At6/qw73FpiArtuwMzgRoHvy7pngo/bGQCTFp4M3csqaNoANGkRK6u5mWGDI3v3Oux7il
	 EOeJauhZQ2vGxK77LGWmPArOtVTdXdjGZWCWHxGURiH6PWftLPXGotjZ2+j8XkBbzvso9
	 0XsYsTxo8Ju4CT40gn8mUJSINIPoSaApN9Mzz+YZYAhTgrOjpGGhlCcNMBMk6B1bCdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PAKoiuvQ;
	arc=none smtp.remote-ip=74.125.224.70
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AB606A328
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 12:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 879AB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PAKoiuvQ
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6798fd97f3aso3579000d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792498349; x=1793103149; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15y+rjAagndMWGwtM7jZ3FI/6ZLw41O6Mm1RADPXVig=;
        b=PAKoiuvQQkkjHkOs6RfgGQJ+nnDlik4X7i6u61dIqwoIw8wnmSwygTSoMCH/cnLbEC
         PnAbGc5ep7OxEwUw1jUbJqyGNK7UnX6q9jAugMXaNpfYmdLbCE0by9Gg4oRjZjffIOhy
         nDIZ3BsJ8Jkf/atrremfB07vYT36J8ZhyCjeB4A6GsW/fOOvLyDYI8oUV5OeG7TqxBdy
         DLAMR4kt3sp7Gw/8NBWv2KmFezzjD6nO9xiDrYGDxUO6g/F8cDIE1CqAxxj5xVBMMQI8
         Jn6ZyOCxm9dKCksnIl4lXV/J5p6KCBt/XDOPLunLv1bbHwRIn1VHsFl3RoLUmM7046lU
         gCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792498349; x=1793103149;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=15y+rjAagndMWGwtM7jZ3FI/6ZLw41O6Mm1RADPXVig=;
        b=p1tov12xxxMKSt+oYs2Ghs0Fvx/nrMVpdRMGjA7bjiSdcJXtkhmMQD5xuvwIphIbbW
         Vg1NmPjrNpgqrl7JgfdxYzSXHPEzVayLpXM3XEhThGDdtBXHCU2iyqj7KkkFRFrVmmQC
         vB1UZicJq3K1cyoS4O86h58NZK4XYb+/7tG8TwtyXL8KGWcyzqlaJmoJIAVquO9NGuiH
         z/lkGw301O81t6U9+YqPhqsQA1gy+wPsSKEDZOYJG5Rl2rElesLL+3wLLbcQN0VEkMq4
         oqpDooS3HHoZs/HgbZ4mu/FPTa10t/UNhGsDcqg+kslfVKNloS7fKQexzxaLcggZFPDL
         D7AA==
X-Gm-Message-State: AFq9FYIi6ErTWu9olJirFVsejgkOttQR5lSJtsF3OZq+RnkrgEKdmfeA
	xy5VpFQnrN+jWHQZ+WmRokQ5isVDqfw3QiKD787wLvbyv2F9eryHg55kPqE6MeDMOeZQBYTI54g
	P/Lc3vQ==
X-Received: from yxrc11.prod.google.com ([2002:a53:c80b:0:b0:679:5b49:e5a2])
 (user=sadrul job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:128e:b0:677:d251:ccc6
 with SMTP id 956f58d0204a3-679f88d3ecdmr739083d50.71.1792498349203; Tue, 20
 Oct 2026 05:12:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:11:59 +0000
In-Reply-To: <20261020121159.2154649-1-sadrul@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020121159.2154649-1-sadrul@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020121159.2154649-2-sadrul@google.com>
Subject: [RESEND 2/2] fs/select: mark select and poll tasks TASK_FREEZABLE
From: Sadrul Chowdhury <sadrul@google.com>
To: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Sadrul Chowdhury <sadrul@google.com>
Content-Type: text/plain; charset="UTF-8"

Similar to epoll_wait(), threads sleeping in do_select() and do_poll()
sleep in TASK_INTERRUPTIBLE via poll_schedule_timeout(). During system
suspend and resume, these threads are woken up by the freezer solely to
transition to TASK_FROZEN, and woken again upon thaw only to re-evaluate
file descriptors with no pending activity and sleep again.

A previous attempt to make select() and poll() freezable in commit
9745cdb36da8 ("select: use freezable blocking call") was reverted in
commit 59612d187912 ("Revert "select: use freezable blocking call"")
alongside the epoll revert due to issues caused by the legacy freezer
architecture.

Following the freezer overhaul in commit f5d39b020809 ("freezer,sched:
Rewrite core freezer logic"), tasks in TASK_FREEZABLE are safely frozen
in-place into TASK_FROZEN without running userspace code or experiencing
premature wakeups before resume completes.

Pass TASK_FREEZABLE to poll_schedule_timeout() in do_select() and
do_poll() (TASK_INTERRUPTIBLE | TASK_FREEZABLE) so that polling threads
remain asleep undisturbed across suspend/resume cycles.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 8943f20e8300..5cbbe86135bc 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -601,7 +601,7 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
+		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE | TASK_FREEZABLE,
 					   to, slack))
 			timed_out = 1;
 	}
@@ -961,7 +961,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE, to, slack))
+		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE | TASK_FREEZABLE, to, slack))
 			timed_out = 1;
 	}
 	return count;
-- 
2.56.0.212.g129ede20d9-goog

