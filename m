Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D39384224
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563250; cv=pass; b=Jeh1FM/VKeTpZvCobwyq+2eLsmaNyHts7DVE6w13C1+cEKsUkJpSIkPmdfsZaTTrmUfyEvPSmYQEujehxzY3b/htodVidvKFhh5kECI6Ghjw33JU9cWvABxxgyUDKKil7UtkU0jzkd16MUMmH3CInvu5tq/J1k5C+Nsq0z8x/JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563250; c=relaxed/simple;
	bh=5Xbtz/Av6bHkE96U4IBoQl5A9uLRqp5aeHgjDtdNOrA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lMnPngxlhX7hkgG2wHUgiyUJBfnSkTtywtLWIfCFcPrgZhKbhMP+LDp8toBGrgQrIDKYQLpT6B/37VEQiu7Xcw7dGJOFRn06Kzxjmrws1kgEs2QzHpltdZDj9LwdHcgFUjBI86Ma0Q64tfF01RcD/KShV8eXeBmkAXcP8jk+5fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av5IQNWd; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av5IQNWd"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aec201b582so10279537e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 09:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784563247; cv=none;
        d=google.com; s=arc-20260327;
        b=mRRifG2G6WKqdql1fRRx9zCt1teDOwqnK3oiHiwFG1XawkRfcl9SO5B7R15bWtzOcB
         YlS4lLlscoBMLGL1x/cXz/X+ieimu8CTV66cFPN3nJFDvFsRaE4lpT2myQXM3SU18MHc
         N8tIrLS8d+lSNStLDuTn4iBJWk4fNM/sFkx9jFAKyYKN5PsrS0CJhoKXapBBrgnXg3bh
         Ie2TfzOsvXIj2kiK6sPmExI1JBukrffKGLlq4wMPspg2/k20cFNa1TmGKIMoMMAsqXCJ
         BP2FfHJd+nr8slYjBttZa7ciAMxaFKj0isws+DxxaXLFOiAneTCyNceptOtNgk4ITSDZ
         tnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gOqp80OGxHNHpl1a0k006+fhM1SsculZu3NHpvxX72g=;
        fh=8VdRkheC88JuYsy26tsDZZSRCwYFq4JhviggrD3d8Pc=;
        b=m8bAtSxc+UviAuhxvVTWZ0WJ4AUohA+tX4Tj1Q1OH7heNu7m4lVL9BrIw5VD3e4nVg
         yRoJiqpoqXCjH8YG1Xgs0RJrK35EnxAjrssFe+pbU6GdEjOMhwtD2Zme1HeNGGNXjXtS
         c0fO8m1JRvghhgt/fRhjtofLWBo6yrWRNqTFQiXi/arr75sb7QdRnTamYeRHgSR7I0Li
         RGqTSErsnZQNpK5AQ/Nq/pbzgaqmZMUYl2Cujwquz13Es6Afip1YnBu9+FecUvGtlalA
         IRtBvqgUssuKAB5tkkeYiu3mmH0b9/iw5pdcxeZ+F/v/pI3rWqBgMdgUvNfNea0THaeh
         fZGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784563247; x=1785168047; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gOqp80OGxHNHpl1a0k006+fhM1SsculZu3NHpvxX72g=;
        b=Av5IQNWdFEXNC5HwO/MjZQ8YFTCawvJmodSahKtQpyX1hDJ1ZCPIITzZ7zd1h/+n7l
         SzIrqN14qnj+xK30kpefs3UGXObjGjoQ+N/GYVhjVId7XAOQyNZ/YqS7VQl5iT85BkQI
         vpAgItscISp5tAM5p1+6+M/KOCepSHdK9QlRBVpPwBgJjCYyZlFWzYyhO+IQnY9oq/pj
         pYFaFNAIXY+l9TRvDItdcwHizlEv6478CqtFEiL0lBVktmg0gqSAnLYRzaz7me/06cVx
         sjb1rw9bkT6+KSgfCFZjyywbnrtggYSUvq5iG+wEhvn4Ygwd354+VJtzhr9VezgD3Fel
         qICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563247; x=1785168047;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gOqp80OGxHNHpl1a0k006+fhM1SsculZu3NHpvxX72g=;
        b=c4E1KheM/rSvBYA2D9IKeU3P8SD+xWpvvxncNWbWfQuwWUp+YExyUtoU4OYp/cmaQ0
         aWOVsNdyoC9iMIj3Jr3jIJBMRajfsrec0VJwurAbKkAoFbFlLCF7T6p3mzZULWBJ1xue
         sIpSQkBrjz4dGHclvkJ/erylcSRFQ9n1DreLElUsy5Lni0l5qhsA4iFDwHU/G2UMyuA7
         mhtKaWQ6UndCxzRFwpIT86gs9FHSsKWQbtjiQ/nLTryFtElSmEFe3E7fwHz5QlN3J7id
         XDcchUNYJJGxs8HkrnUGpoNK7JXRBwNN+74N8dGKdv1EaDQZGmxkvrSpSyNU73PyhSDS
         qT2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpkTuBnEWS/YkQIZdOL1jzNgZgo9vuurJ9ncEqNJ9eiWJYp20wvGCq/PRd4ePaYK8S6E9wkNhnr0YT5v38k@vger.kernel.org
X-Gm-Message-State: AOJu0YyR508LZdKr5HKaxaJZ4qd/Vvv1bmm/UNce8U66A9tMb2zR4iR+
	7YEjLxCud+ReC1VLNkVf4L9RTi2jptcbjjah/oazU0OwNDHT7F3HL04W50aea4mqK5Giwm2sXtM
	P0Ryey7Tb6nIJ4c8y2HfgIzY9t4eQZ8o=
X-Gm-Gg: AfdE7cmVw049oi5KCQZxpp+mQijgerT4/bd6c1ebFyYA+pVq7qxfAZqR0xdi5uLjzaV
	NDI58J2xmPgTryD/YV7gy1J3XCqzxWtqTl8iCdtpZaQqKkgKubUXQTgLoYrZ6iPWLVcveNYciJE
	AB8xYlaCH2ZN+zXWc4TJ6xmsBJlpSfKOgRZyu5IpRI4nWi510fBXOSDv0axW1al3RES8CX/zlDF
	x8bC166xI05k5GzHdJfAeA1jlFjC7eLuEgvmGY/MFmmZsJDhJTl8XPx8yOq
X-Received: by 2002:a05:6512:3e09:b0:5b0:2176:69f6 with SMTP id
 2adb3069b0e04-5b28f9a4a5cmr3279364e87.37.1784563246327; Mon, 20 Jul 2026
 09:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chengfeng Lin <lin2530632123@gmail.com>
Date: Tue, 21 Jul 2026 00:00:32 +0800
X-Gm-Features: AUfX_mw7s-B5RFQiepxXY56GnETnBGDLw1NkaBnVDrpf0kTbCGVvQQn3VTL6hdE
Message-ID: <CANGjgd=RwMy=29OYG14b6kkoF1uBHz67jTGge5Nubb-XemMvBg@mail.gmail.com>
Subject: [REGRESSION] fsnotify: concurrent inotify watch add/remove slows
 after 94bd01253c3d
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Jan, Amir, and Christian,

I found a repeatable slowdown in a concurrent inotify workload. An exact
bare-metal comparison points to:

  94bd01253c3d ("fsnotify: Track inode connectors for a superblock")

#regzbot introduced: 94bd01253c3d
#regzbot title: fsnotify concurrent inotify watch add/remove slowdown

This is a focused synthetic microbenchmark, not an application benchmark. It
uses tmpfs, 96 separate inotify instances, and 96 files with different inodes.
Eight threads, each pinned to a different P-core, concurrently add one watch
for each instance/inode pair and then remove it.

The matched control uses the same instances and pathnames, but all pathnames
are hard links to one inode. A keeper watch keeps that inode's connector alive
during timing. The control therefore measures watch add/remove without
connector creation and destruction.

I used a fresh boot for each point:

  6c790212c588 parent A -> 94bd01253c3d child -> 6c790212c588 parent B

Each point had 2 warm-up rounds and 25 measured rounds. The kernels used the
same normalized config, compiler, Kbuild metadata, module-signing key,
preemption mode, and equal-length release strings.

The machine was an Intel Core i7-12700KF system with 32 GiB RAM. The workers
used CPUs 0,2,4,6,8,10,12,14. The CPU governor and EPP were set to performance,
Turbo was disabled, and the runtime setting was preempt=none.

The primary medians were (lower is better):

  metric                         parent A      child   parent B
  P8 distinct, aggregate worker ns/watch
                                  4182.614   4920.865   4274.895
  P8 distinct/shared ratio       0.248777   0.292725   0.240657

P8 means eight workers. The first metric sums the time spent by all workers
adding and removing watches, then divides by 96; it is not wall-clock time.
The ratio compares each distinct-inode round with its matched shared-inode
control round.

Relative to parent A and parent B, the child was slower by 17.65% and 15.11%
for the distinct-inode metric, and by 17.67% and 21.64% for the ratio. Parent
drift was 2.18% and 3.32%, respectively. All correctness and affinity checks
passed. Updating an existing watch mask and pathname lookup both changed by
less than 0.3%; the shared-inode control was slightly faster in the child.

A second parent-child-parent sequence checked worker-count scaling. At P6,
the distinct-inode metric increased by 9.03% and 9.56%, and the ratio by
10.75% and 10.85%. At P8, the distinct-inode increases were 19.58% and
19.11%, and the ratio increases were 17.62% and 16.80%. Exact P1 and P4 tests
stayed below the pre-registered 5% threshold. A 16-worker SMT run changed in
the same direction, but missed the variability gate and is not part of the
main result.

I also tested two diagnostic variants at the child commit in this order:

  full -> lock-only -> full -> nolist -> full

Full is the unmodified child. The reductions below are averages relative to
the full builds immediately before and after each probe:

  build       list updates   list_lock   P8 distinct reduction   ratio reduction
  full        kept           kept        baseline                baseline
  lock-only   removed        kept        14.27%                  12.70%
  nolist      removed        removed     21.43%                  20.46%

The lock-only result shows a cost from the list updates or the extra time they
hold the lock. Removing the lock recovered about 7 percentage points more.
This suggests that lock acquisition and handoff also contribute. These builds
are diagnostic probes, not proposed fixes.

Before sending this report, I checked v7.1.4, v7.2-rc4, Linus' master at
1590cf032971, next-20260717, and the linux-fs fsnotify, for_next, and for_linus
branches. Connector creation and detach still use the list_lock and
list_add()/list_del() operations introduced by 94bd. I found no equivalent fix
or matching report in the official linux-fsdevel and regressions archives
through July 20. The exact timing claim above remains limited to the direct
parent/child comparison.

As a topology check, I traced eight unmodified Ubuntu inotifywait processes,
each watching a different subtree of a Linux 7.1.3 source tree on one ext4
filesystem. They created 4,177 directory watches. For each process, the counts
of fsnotify_add_mark_locked(), inode-connector allocations, and
fsnotify_detach_connector_from_object() matched its watch count. Watch-add
events from all eight processes appeared in the same 1 ms interval. I started
them together on purpose, so this trace shows that normal software can create
the tested topology; it does not measure application performance or how often
this concurrency occurs in normal use.

I understand that a05fc7edd988 ("fsnotify: Use connector list for destroying
inode marks") uses this list to avoid scanning all inodes during unmount. I am
therefore not asking to revert 94bd.

Is the extra watch add/remove cost an expected trade-off? If not, would it be
useful to develop an optimization that preserves the connector list and the
current unmount behavior?

Evidence bundle:

  https://github.com/lcf0399/linux-regression-evidence/tree/245fec71aa05eb2dbd68f11e4c98729f22bbc541/fsnotify-concurrent-inotify-watch-setup

Standalone reproducer:

  https://github.com/lcf0399/linux-regression-evidence/tree/245fec71aa05eb2dbd68f11e4c98729f22bbc541/fsnotify-concurrent-inotify-watch-setup/reproducer

Thanks,
Chengfeng
