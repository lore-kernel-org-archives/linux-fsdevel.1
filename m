Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585577;
	b=FlrjSd64H9agHWdVHknKrhiAFD+F1bpqO7faCuam96P6QpUWZ+OVimW78tnzAH3g0Q8o
	 qw5hqxUW7CN4TpE1yEm1uMq6AtXEq3VZDS0g6uttL6Pbcl6plDbdAmhrKlZJPxO56rhHp
	 3RhEWx7GT2RwxTtzPmhoyUyySCr/mB4JJr1KcriJlv37Hri1U+GGw8mDP5MonaTkTxeAZ
	 PxN9eUGyjJCF69HtgdnLAxiJlKPkV7owk6A1tCBOlAabxV4RhA3vLrMKVEAP7tLsizRKa
	 P+rKukByC0dyEe9BKcSkGz2GjQqS6EizjLeIXfimNPMYAvPQRGpYmoVVoPixO6W3R3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=H6i391iVh1dQ0VMmEwYNJCCdz9XRHgnpnKzdqGscyes=;
	b=cDkwa/cqJ0eg8/RPLkwpO+y6jqbQKai799L2ciE9Onc8plQ8vdWV1jc83SBNUhoKustV
	 YuHPOe9OwQInclGZsn2GXca4X9K2/It00+fZOa5usWqNMQqKyH8Cezma9Jkh/tu+qKhR5
	 zHp+RJOhhQqUQEI6l4jZZZkXruNdRi4kPVqtsq1mCPFd/Vq4eoEYNFd8LnRce74XxCjnD
	 BRBERNE0Acq1mGT4J/SIpUQy+Bp5V+LQOZNAISRkLQwNvqGxQgiBI9Hp8tqQe9fX4uU+9
	 hHGrxXALH096wmdqwrxN3EzuldmlzfMrn8/K/cg2vK8kuMIFz0M2l5yUVYJqoG0xMKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="HTTHA1t/";
	arc=none smtp.remote-ip=209.85.222.197
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7603606A32C
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 12:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7603606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sadrul.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HTTHA1t/
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2c0e6653so137234985a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792585576; x=1793190376; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H6i391iVh1dQ0VMmEwYNJCCdz9XRHgnpnKzdqGscyes=;
        b=HTTHA1t/UNSB9VHcvbJrpVStFT9Odk53nzsQzxE88A1yTOvr5uHkBFp8z15z2vQUNo
         4nzP5BjVA/n1AdXynVCGxWhr8Jc8iUBSzcPhGIpThrEtd+l3mJIzHUosr1aJmt9QUWlT
         c8LO8/+FEjtogkt+bfj2QT2BIhAPk4kZGBGOxf4iROjHGuUHvuPTDdjvgihvIloTGz3A
         PtEDJBC2uFE4jukeF05KCzZoXHQ2NH3qYfNxg/yql+n4wi3koVUnmXbwLkW316Fhx2CY
         SFpBdxYdEGy5rhmen7loauYM5kP5fRhQozIDCT3F4d94MXwkP8CkA4Gc/DPlsqX5AEDR
         eKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585576; x=1793190376;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H6i391iVh1dQ0VMmEwYNJCCdz9XRHgnpnKzdqGscyes=;
        b=MdjEjUizQrWyYPKds2IKnpumJjV9qnASOusJYaxtYslhgFRy3WwUwl26XaDOCqkKZj
         IIbjegODbarmqbMrRnnazilHgu8q2ZBmgSGf0Qr482ny9lkNBR4PTRG7/qu8WMcU9lri
         NR3Snxuivs+oWPz0h9ohtSFqKwELvFcid4wehlMYcdMkvHou3Ga0hEG9TLi3eCiPqWPX
         2Az6bG8jIcmvYZVH14LQszAexcW9Lz/LeE4pucV4lR3jyr7bXQoqeqVDOIiXdPyIZM4J
         LUdpxKhKqymHEC4VuXHSgpgKs6oiJfmnty0klQvNcozbxjw0VhiBweL8OdGf3XwJqtUp
         xtLQ==
X-Gm-Message-State: AFq9FYLlMHfjBAbcDDCWcdxets8Qc1HCvqJYLGL3xJOtUW8Wk/V0JkVM
	f6xN1nBSefgsIkENcTmQl5geVjyaNRjynVCtJwQnp8S6T3DNKFDKYXrTp3NXHdnYlZqxwIripHq
	nqTGePA==
X-Received: from qvag18-n2.prod.google.com ([2002:a0c:f092:0:20b0:919:5a9b:414a])
 (user=sadrul job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4493:b0:93f:22f1:97bc
 with SMTP id af79cd13be357-93f57f639c0mr361670985a.67.1792585574428; Wed, 21
 Oct 2026 05:26:14 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:25:43 +0000
In-Reply-To: <20261021122543.3547778-1-sadrul@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021122543.3547778-1-sadrul@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021122543.3547778-2-sadrul@google.com>
Subject: [PATCH v2 2/2] fs/select: mark select and poll tasks TASK_FREEZABLE
From: Sadrul Chowdhury <sadrul@google.com>
To: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Sadrul Chowdhury <sadrul@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sadrul Chowdhury <sadrul@google.com>
---
v1 -> v2:
- Rebased against current mainline (torvalds/linux.git master).
- Collected Reviewed-by from Jan Kara and Acked-by from Rafael J. Wysocki.

 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 95d76531015a..03318d678187 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -600,7 +600,7 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
+		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE | TASK_FREEZABLE,
 					   to, slack))
 			timed_out = 1;
 	}
@@ -962,7 +962,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 			to = &expire;
 		}
 
-		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE, to, slack))
+		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE | TASK_FREEZABLE, to, slack))
 			timed_out = 1;
 	}
 	return count;
-- 
2.56.0.212.g129ede20d9-goog

