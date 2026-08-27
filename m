Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9482D249B
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806227; cv=none; b=F3JM8bP0JwIuNhoqAs1atPFXsI33eFpNMiLHyuxXgakjYaFET2SCistfi1mgzNiXNwR5jIXV1VtBlOf9aAEj6fCFbU+TAFNXUvH0OXPD8LOyJgBzdbW9AXHGfgm60VmAAuhOuR6eBfNJHJEGycVdUkjgjaa042GIVpfGjAz83Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806227; c=relaxed/simple;
	bh=tMAdPF5LtoelHEGmvxcAEdHKDhIRTlFKh4yWr6CohTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ON1D0PJKhLu0ZO3CKGYa8vAzccZ2PkpDWxT04Laho8/cV9mD5ygXTHbR0wPK0oaebylvNWmK/3pk+4KbhBCkRS0hJ5nOLoJ8Z3aYWn3VWdbGTHPaJiqseW/EX2XqT/sNOeCr6SoZXGq6cBIt0onHl6kTChAFAvuv7zIYLyBP3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okC1/v3k; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okC1/v3k"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so2125829a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 21:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787806225; x=1788411025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DWvwvcyUlBuNouA22nARMdoaOdKzUDmVy7DPNf2S7cE=;
        b=okC1/v3kgrH89NrYr4drtUAbxEa43LSevkgVftwfceFM5BIjpA1foaaijvZpkxi/uO
         YdZNkPqOXfCebTdG7u5Wm49b6X+e1hXqawCBrAJEdEIF53JUpoWQgizKEKpQlF6WmmqJ
         dDNVaRaeHOgnApl+JtDZw9O7EoVNHv/LmGNvM9hBrC8xQkLzW7SjcQpLMLcVf8zPxkbF
         ny/MGboYAeVSbSH2bdAH4vXjoSrfpCCpsISgHNe2aM0oj+X807r39Dd4wjYNalvc9PKt
         KpT6P+atWeowgO/yC1VWUO1e2eEQf685drxxVJEqZLArN0Hk+mrnT8o4AO9ogqRVP98Z
         xSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787806225; x=1788411025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DWvwvcyUlBuNouA22nARMdoaOdKzUDmVy7DPNf2S7cE=;
        b=lLrKpQMvUJ4XeIE3rSZmEnkqvW0HsowfxhfFqf8ADVS2uBkZFYP3Yie8Hm/lbkZqye
         KydMoeNsbFikUSYJa3777Rr3tp9u4mFEBTOJU483T0+V8RnE2Fj0hAAlmuoS2L50BIJW
         xYIVG+rq1ikR0T0YASCpe8N4Tjpmh7lQDjyzuW1LkymhS9FVcYRTJGtvkX+pTBsY0EUO
         mwYV7/o22XsTmETXPZ0ud7yr1GCnPLsv0s61mkBLkn//Aieu3fd4C4RgHhABxB/UffKe
         ucqPu9sCXrXvi6CNWRIlc9dp/Df2XqWTfwWoH9kM/SmfkzIXBSChUtHI+68/JVNwfr09
         cB/Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro2b7I2tf0hZrr20UIX2UZoMT8fQIZL002mCkVy9tH02Cj1RyYSrq38gx8hIrcagucPYTM3asgKZA/Nz0bf@vger.kernel.org
X-Gm-Message-State: AFuF++nwXRx8Xq9zT36pWpYLazfXsJTinjyIDudwyy8X6HNIb2TidA0o
	7W8Xvup/NkUilst4hQCeAgDOdLWaBIG/insbS9DTYCk7iO5UWP5uOwIMF09ndv+1
X-Gm-Gg: AR+sD12yV+1I169X4KSBg+ZglZZrwCtVKW9LYy3h+dq8AzQPGpNaS0ePwqC21SCvSZw
	y9vwp0iV/7Lb8NFDtdR01QkTM7FCLjH+DxD+BmFVMCZY8WFpqpka9r8KxkhoJaSj4hROiEnPBpR
	IVD7f7LxhgqgUDyYSYFTJ7VWQyHzy0szOxWz6Uclqj5m5vSQ6zXt7rIfK6PnXkK6lx2estEbG/D
	vPPqR7B66f9VhxKZJVjTfAyKrz1H3r2VnSaxRtV2w3kVHQTcqZPno4JDmYsX2lM4dQEsl11BKeg
	tIEey2KjFQ0gFnERQ7bY50TGvzDfNsDJ4CZvsurT1kKUDz+jdvaOawfHMMR8jm/YBtMq3z8yRBz
	8BIGwcp4n67jC+Mr7QM9VnsyigTllsMpaXQdwTAwnxIzQp9U+lf+UPQ26qBawH+/k7XHCyqXniM
	myEvyhsJX1lWIeYJi6qx9ASEedQKECEtQ4ENIqXgUUE9aaBNjHJvAcSgy4KRtK/jxhUifNKEuC
X-Received: by 2002:a17:90b:524a:b0:380:540:d499 with SMTP id 98e67ed59e1d1-3966d1ba7bbmr26160762a91.6.1787806225328;
        Wed, 26 Aug 2026 21:50:25 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5edbsm1066131a91.11.2026.08.26.21.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 21:50:24 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
Date: Thu, 27 Aug 2026 13:50:04 +0900
Message-ID: <20260827045007.3831259-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I found an unprivileged race in fsnotify_destroy_marks() that can leave an
attached fanotify mark on a detached connector. On unmodified Linux v7.2 and
v6.12.105 source builds, it naturally reaches the fsnotify_conn_mask()
warning from fanotify_mark(). On unmodified builds, the only observed
system-wide failure was a v7.2 panic when panic_on_warn=1; no memory
corruption or privilege escalation was observed.

Tested and source-inspected versions:

  - Linux v7.2, commit
    8d3ae59288f1e7d58d76558a6ee96d533bc5019f: reproduced.
  - Linux v6.12.105, commit
    14c37ff05f22da2fa7076d10f6a07c7ede330c83: reproduced.
  - Torvalds master at
    73e3f0710014fe6d4ed98cfc02292f6121db7558: the relevant destroy
    iterator and fdinfo consumer remain present. Commit e422777fdd47
    changed mark-mask updates and can mask the immediate warning, but it
    did not change this iterator or the detached-connector state.

The unconditional connector detachment involved in the race appears to
originate in commit 6b3f05d24d35 ("fsnotify: Detach mark from object list
when last reference is dropped"), released in v4.12-rc1. My unprivileged
runtime results are limited to the two versions listed above. The limited
unprivileged fanotify functionality used by this reproducer was introduced
by 7cea2a3c505e ("fanotify: support limited functionality for unprivileged
users"), released in v5.13-rc1; I am not asserting ordinary-user
reachability before that change.

Root cause:

fsnotify_destroy_marks() holds a reference to the current mark, drops
conn->lock, destroys that mark, and then continues the hlist walk. While the
lock is dropped, an equal-priority mark can be inserted immediately before
the current entry. The walk resumes from the current entry's next pointer,
so it never visits the new predecessor, but it still detaches the connector
from the object after the walk.

The skipped mark remains ALIVE|ATTACHED and remains on both its group list
and the connector list. At the same time, the object no longer points to the
connector, conn->obj is NULL, and conn->type is DETACHED.

Representative v6.12.105 output is:

  WARNING: CPU: 1 PID: 163 at fs/notify/mark.c:128
  fsnotify_conn_mask+0x113/0x150
  CPU: 1 UID: 65534 PID: 163 Comm: fanotify_destro
  ...
  do_fanotify_mark
  __x64_sys_fanotify_mark

The source reproducer ran on ext4 as UID/GID 65534 with CapEff=0 and
NoNewPrivs=1. It uses ordinary FAN_REPORT_FID groups and races final unlink
against fd-based mark insertion. Both builds used a KASAN-enabled research
configuration, but neither positive was a KASAN report.

With panic_on_warn=0 and panic_on_oops=0, the unmodified v7.2 run emitted the
warning and then completed 10,000 iterations and powered off cleanly. A
separate fresh v7.2 run with panic_on_warn=1 reached the same warning and
panicked through check_panic_on_warn(). The v6.12.105 run emitted seven
warnings and reached its 10,000-iteration progress line; it later timed out
during post-loop teardown, for which I am not assigning a kernel cause.

A timing-only diagnostic kernel also demonstrated that fdinfo can combine
the old INODE type with the detached NULL object and reach
fanotify_show_fdinfo() -> igrab(NULL). I have not reproduced that Oops on an
unmodified kernel, so it is not part of the impact claim. The skipped mark's
group-list reference keeps the connector allocated; I have no evidence of a
connector UAF, arbitrary read or write, information disclosure, or LPE.

I do not have a submission-ready patch. During fix development I rejected a
survivor-preservation prototype because it introduced a mask race, a
drain/restart prototype because additions could starve cleanup, and a bounded
retry prototype because review found an unresolved lock-order/deadlock risk
when generic callers hold external locks needed by cleanup. I am reporting
the root cause rather than sending an unsafe fix.

A tested source reproducer, full serial logs, configs, and diagnostic details
are available privately to the maintainers on request. AI-assisted tooling
was used during discovery and analysis; I reviewed the source and the literal
runtime evidence above and am reporting publicly without the reproducer as
required by Documentation/process/security-bugs.rst.

Assisted-by: LLM

Thanks,
Daehyeon Ko
