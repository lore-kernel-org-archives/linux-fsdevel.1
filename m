Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530B3D6CCE
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225672; cv=pass; b=H+RbTrUxAcmCGHZ2DWYIiyRdseaoBrMs2o3+xKQ0WFk7nKRTBnzF+HaXtxVpeR3XJ1xl4lvuftQW1ybmtt5s7O3abTi2y1BkIdcH1p/IlvKOEMSQTxq0ryfb1fHUKkPUvlNKZDzA8vHl0UtvZ6YHEr6TNywNIdt5+IB/LHWT9DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225672; c=relaxed/simple;
	bh=LKszkDWfkGJAJLUggUdSbhgfkrrzHmIAYV9+yMzIDZs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l3+BkpYJGkD4ltUq6RmY/RjPjJpStjdXqcHSVv2K3NyrvaQM2LLHOHRgS79hU2SXUHNAMWJLOXeQteHe4eTjYet5qjkMfH96xkO59TUbCcoDNHyH+QSV9n8XtvySANALWIvO4PPsolvDlgXORaeeHh/EbYJOelM0hEyEUZV6xO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=TinJl6Kb; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="TinJl6Kb"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c83acb86eso31522631fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 01:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785225664; cv=none;
        d=google.com; s=arc-20260327;
        b=p+lEaRSAvd07FJEeSwZHXm99fdR+pX2Ktfk5WIFrqOQJ3ySRY0cpZCfGc5Wm9xtC3F
         q+rZ/60CGmEQG8jTKURDs/l3LkEIXNAql8TYOEraumaCEz4i8czdyXIDKusCRx3bg9US
         EQaDMDWHulcNs5KxFe6PfI0Go6Giwijy7uzah4H6KNum3IbxthrFF8kfY6FuNcxXMGQa
         KYXidRX3zqxKnx0dbemj2Ek3dVkmxWHn69xbTgLSdTLTYMxq1tc27X3PlRl8NtRA93TC
         yr+qvGL+cUPIaZ+JDyJGEwyMcRiK5ZzTal/s8I6vK2emXu3Ph5vqPetisvNGFbcfi6Df
         jgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=N4tsddQ138nwXyOBt9e1Qujj9MSvZXgMjN1YehHjpaA=;
        fh=R85m5X851j37UUcrptNdlXA1IkDDioM9JoYs1aS0/Nw=;
        b=jlH8Yh021HvUdRaIG6ZMhTJDwJDI6OGbpSk6PpfmZgnxF3WvpgUYLyE7+wL6xxi/Wv
         CWb909/WHQfAYe/yWoNDxK+3vDcf6cdHe7cnI1uh/+A0c9Iun5n5IDVuqrla9ZjeQGrH
         OQ46aShhX9cshk3yOyGr9reboQSuV0jbxmcYJ9LQqUyjxJsvjrk22CaoIWGymffFbn1N
         bcTW5O5UnIK1Qk9UjU9VG2Pt1oPnlCSS1IKLlBuVhdQQMkqtZyrbqnW6A+t+CtlQSuzw
         9McCdGH22jhoGuTJ32YZacgMXotwdu540Vme00xNRbxPf73UsCThwLIzgzI9xk/dB0B1
         Ke6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785225664; x=1785830464; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N4tsddQ138nwXyOBt9e1Qujj9MSvZXgMjN1YehHjpaA=;
        b=TinJl6Kb9JSSpo3FW5qnG5oWhWJ9NZSjY4A52gCVj5okeE2sIoCCpk4Z+P/KEaxLAo
         b+ci4+k30U7ogWSqv7/HiKBTfidyYBE8VxxCwmd4vNX9f2DoVapaDvD7NNDgCylMs4yN
         RYQYJ4FsvOYp6erkebQl5wD1/dSJJilLKZadQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785225664; x=1785830464;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N4tsddQ138nwXyOBt9e1Qujj9MSvZXgMjN1YehHjpaA=;
        b=h5cB+sAmunWlKja2qPaVOqAwTjGzMA2UDO5Sqn6CmGJzqUGgJIZSw7qQsAyXAJzbGX
         vSeJ0qnTB17veGVai423ytDWfPogfS1MUcIKQQ/tHSB0C0TdcHcdDJH0R2xn1jfu/HDm
         RV+jmvT1MAdoownDSa7fMcHzRxlRVg3DPPBy4GDK51T7xYvBkykN4W8fC1p9ndjNurb3
         H1urmeMCJL1Su5GLD9UNkfP7/2x7vXY046FOCgYbzAuvj2/VPycUJ5DWTLUuUY4wZxvv
         FzL/Q5twNCgDWIVNJ/1jOmbR4Kc7dRzs33A5iEAlwfgg4fR3GYoIfJuEeTNlhFJKsjZh
         4B+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqMlj/T56X+SG3D1Ift+H7qAY0PAUkr9N/bfqH3T8MVFkERHWDsImfC0wz7ymgZqemguROtsS0kzdkQZxIG@vger.kernel.org
X-Gm-Message-State: AOJu0YwZT/L8NGQaSG0pJJqCPjcuo6hjSs7NnrEcOHZuCWwW5at5Nqi/
	C4qsyrV0NlkfEdOzpVF2K7f/erueDYGDsSY9uzPQHRQBaNG+zPdjyUD6LFQwF2vfHMBh3XRwICX
	xOXuKlr4L+7Jt5p0Gjc0nDeNZ7cc8EVmqc9pA8LslJg==
X-Gm-Gg: AR+sD10Z1ERDbEvt5QYs42Ql62ZRRbu6xosUrGj0xp1hgqJcLSp35z1Z+J6rSQHUvt/
	jADGD4fjjmo8ywLHOBWVWbBtwZFjwvSJ2Vq/svQ/vt57j79y+Gi77y+N2ik8v5Wb+81+HYANlxF
	pKcoBVzzjTeqPjHjc7t17feDa+SmRA5af9oTFPeJiQq4//5pvtzQrtAyp7wkf57Nnb7vasr7kf6
	2JKyOBNUb7fSUJ+N7ahESQBLVnRLYzydXbIb4eiuz+HY3l9DizIOY+KhFSh59t1T1XDQK/lHZB/
	mRl6WtVSAEJPdFxN/zmCDOB2uchY
X-Received: by 2002:a05:651c:1504:b0:39b:b6d:59a1 with SMTP id
 38308e7fff4ca-39f51c7e974mr2407801fa.3.1785225664373; Tue, 28 Jul 2026
 01:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?wq3qtozsmIHsnqwgLyDtlZnsg50gLyDsoITquLDCt+ygleuztOqzte2Vmeu2gA==?= <yjkwon0026@snu.ac.kr>
Date: Tue, 28 Jul 2026 17:00:53 +0900
X-Gm-Features: AUfX_mxg2_4oFXKIYmNrV4XwHpJy4ipfrnjmjqts9nvNgNd6x2jIWSeu0W8zUtg
Message-ID: <CACwKKmCZdiZDoFuYm6LZhQ=XvHPk0fNKH=X3LmoXMqakYqJaNw@mail.gmail.com>
Subject: [BUG] fsnotify: concurrent mark updates can publish a stale aggregate
 mask and lose events
To: jack@suse.cz
Cc: amir73il@gmail.com, repnop@google.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jan, Amir, and Matthew,

Concurrent updates to marks from different groups on the same inode can
leave the object's cached aggregate mask missing an event bit that is
still present in a live mark. An operation started after both mark-update
syscalls have returned can then be filtered by fsnotify_object_watched(),
so the matching fanotify or inotify notification is not delivered.

I forced this source interleaving with diagnostic scheduling barriers and
reproduced persistent FAN_MODIFY and IN_MODIFY loss in 3/3 independent
boots for each interface. A control update that caused a fresh aggregate
scan restored delivery. I also observed the same loss-and-repair outcome
without kernel instrumentation on an unmodified v6.12.95 kernel image in
3/3 independent boots, with 9 strict hits in 30,000 attempts. I have not
identified a memory-safety issue or a security-boundary crossing; I am
reporting this as a notification correctness bug.

Relation to the 2024 KCSAN report
=================================

This is related to the 2024 report "KCSAN: data-race in __fsnotify_parent /
__fsnotify_recalc_mask", fixed by commit 35ceae44742e ("fsnotify: Avoid
data race between fsnotify_recalc_mask() and fsnotify_object_watched()").

The earlier change prevents compiler-generated partial aggregate updates.
The ordering here is different: one mark update suppresses its own
recalculation after observing the old aggregate, while an in-flight scan
then publishes a complete stale-low union that persists after both update
syscalls return.

Tested and inspected
====================

Reproduced on:

  Linux v6.12.95
  296aabce459470a4c1b68ffd0c0c0920e563aaad
  x86-64, 2 vCPUs
  diagnostic kernel Build ID:
    5ff2f3793d621e88dd49472aa21fc947214bae21

The relevant add-side decisions and scan/publish behavior were still
present when I inspected these refs on 2026-07-27:

  mainline:
    f5098b6bae761e346ebcd9da7f95622c04733cff
  jack/linux-fs fsnotify:
    a3aa899823dda059ab88a58254f9a605e03ec275
  stable linux-6.12.y:
    588b2d2beb4b3d1878a7fd9cdc876bab53326476

The race
========

Let P and E be marks from different groups on one inode. P initially
supplies event bit X to the cached aggregate, while E does not contain X.

  P update/removal                 E update/add
  ----------------                ---------------------------------
  remove X from P
  start connector recalculation
  scan E without X
                                  add X to E
                                  observe old aggregate containing X
                                  decide recalculation is redundant
  publish the older scan without X
  both syscalls return

The add-side decisions are not serialized with connector->lock:

  fanotify_mark_add_to_mask():

    recalc = fsnotify_calc_mask(fsn_mark) &
             ~fsnotify_conn_mask(fsn_mark->connector);

  inotify_update_existing_watch():

    dropped = old_mask & ~new_mask;
    do_inode = new_mask & ~READ_ONCE(inode->i_fsnotify_mask);
    if (dropped || do_inode)
            fsnotify_recalc_mask(...);

__fsnotify_recalc_mask() scans under connector->lock and later publishes
the sampled union with WRITE_ONCE(). A different mark can be mutated after
it has been sampled. Its add-side redundancy check can still observe the
old aggregate, which the in-flight scan then overwrites.

After this ordering, E contains X but the aggregate does not. The state
persists until another operation causes a full recalculation.

Fanotify causal proof
=====================

I used two unprivileged FAN_CLASS_NOTIF | FAN_REPORT_FID groups on one
regular file:

  P = FAN_MODIFY | FAN_OPEN_EXEC
  E = FAN_ACCESS

The workers concurrently removed FAN_MODIFY from P and added FAN_MODIFY to
E. The diagnostic hooks first completed the add-side mark lookup and then
forced the scan/update/publish ordering above. They did not change the mask
calculation or recalculation predicate. Hooks reached under a mark or
connector spinlock used bounded try_wait_for_completion() polling.

Key trace:

  FSNOTIFY_DIAG fanotify_lookup_ready
  FSNOTIFY_DIAG scan_e_old partial=0x1 cached=0x1003
  FSNOTIFY_DIAG add_done mark_mask=0x3 cached=0x1003 recalc=0
  FSNOTIFY_DIAG stale_publish old=0x1003 new=0x1001

Both fanotify_mark() calls succeeded. Three writes after both calls
returned produced no FAN_MODIFY event for E. An unchanged duplicate
FAN_MARK_ADD of FAN_MODIFY then detected the missing aggregate bit and
caused a full recalculation. The next write was delivered.

Inotify causal proof
====================

I used two inotify instances:

  P = IN_MODIFY | IN_OPEN
  E = IN_ACCESS

The workers concurrently replaced P with IN_OPEN and added IN_MODIFY to E.
The diagnostic barriers forced the analogous ordering.

Key trace:

  FSNOTIFY_DIAG scan_e_old partial=0x2021 cached=0x2023
  FSNOTIFY_DIAG add_done mark_mask=0x2003 cached=0x2023 recalc=0
  FSNOTIFY_DIAG stale_publish old=0x2023 new=0x2021

Both inotify_add_watch() calls returned their original watch descriptors.
Three subsequent writes produced no IN_MODIFY event. Adding an unrelated
IN_ATTRIB bit caused a full recalculation, after which the next IN_MODIFY
event was delivered.

Both barrier tests reproduced in 3/3 independent boots.

Uninstrumented fanotify reproduction
====================================

I also built a userspace-only fanotify helper that uses persistent filler
marks and calibrated two-CPU launch timing. It races removal and addition
of FAN_ATTRIB on the watched directory inode itself.

The helper accepts a hit only when both fanotify_mark() calls succeed,
three FAN_ATTRIB events are consecutively missing after both calls return,
an unchanged duplicate add repairs the cached aggregate, and the next
FAN_ATTRIB event is delivered. Queue overflows, unexpected records,
syscall failures, and parser errors are rejected.

Against the unmodified v6.12.95 bzImage
(SHA-256
cea96e20243be9b110ffc97235c9cf6b2e33f613b2b311bf899fb14802761c03),
three independent 10,000-attempt boots produced 3, 2, and 4 strict hits.
All 9 hits repaired as expected, with no syscall, parser, or
unstable-oracle errors.

Userspace cannot read the internal cached mask, so I treat these results as
behavioral corroboration of the barrier proof, not as a second internal
trace. The small cells show natural reachability; I do not treat 9/30,000
as a precise per-attempt probability.

Conditions and limitations
==========================

All positive trials ran as uid/gid 65534 with CapEff=0 on 2 vCPUs. The
uninstrumented runs used a writable ext4 filesystem and many filler marks
to widen the timing window, so the hit rate is environment-specific.

Fix direction
=============

For the demonstrated existing-mark normal-mask paths, a correctness-first
minimum is that every actual change to mark->mask triggers a post-mutation
fsnotify_recalc_mask(), regardless of what the cached aggregate currently
contains. The existing cached-mask test may still be retained for unchanged
requests, including fanotify's duplicate-add self-repair; it must not be
allowed to suppress recalculation after an actual mark->mask change.

Because connector scans are serialized by connector->lock and each
changed update waits for its post-mutation scan before returning, the last
such scan observes all completed normal-mask changes. Thus the aggregate
is restored once all participating update syscalls have returned.

The fsnotify_modify_mark_mask() helper in current mainline is a precedent
for the raw-mask-change part of this rule, although the fanotify and
inotify paths reported above do not use it. Fanotify ignore_mask and
aggregate-relevant flag updates would still need a separate audit; I am not
proposing an endpoint-only fsnotify_calc_mask() comparison as a complete
fix.

Reproducer availability
=======================

I have prepared a private source bundle containing the diagnostic patch
series, paired fanotify and inotify helpers, the uninstrumented fanotify
helper, compact logs for the exact 30,000-attempt replay, and build and
reproduction notes with hashes. The diagnostic series is instrumentation
only, not a production fix. I have not attached or publicly posted the
reproducers; I can send the bundle privately on request.

If this diagnosis looks correct, I can prepare a correctness-first fix and
regression test for review.

Assisted-by: Codex:GPT-5.6 sol

Thanks,
Youngjae Kwon
