Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B23D16EE;
	Wed, 29 Apr 2026 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468208; cv=none; b=dbYF6Rl6G3M3ri7pKOOSK0/iIesj0GCF0HMwGRyGINMi/pjnJ6EVLG09Nn6pt6iVRzaMNUGH1BSJrl3lBBJ6S7JYqqQlPv2pqgek1sVTXSmxeErIGhZKtpdcSlGDxiIhx5o9xYzEVNRD/XVh+wSetfmXyHMKZiQdTgfoI81epFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468208; c=relaxed/simple;
	bh=jM/IH8EGk8YBTvxYomCFRlziNoxfG/zfVtakC3ySAAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tOfKMm0yIVE7MUh16IUJLEQIFFAH42qW6pkUj0JjQqwduTgyQ+nokUfthze0iUjTiPUi8MOpqK6XSmYvzAQSPT87o5NyQMnbT7M1ghuqZXweJCDTFzJG+/0M0eg+E29ss0Vw2FHkNrZcm7H2bs0u2J5gLHNuR6WRU2wYosZCSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CiqIHIyF; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CiqIHIyF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=UXuuHBRP8owgfwIPvEe0xduBiSTsteD0ztA0DdCM02Y=; b=CiqIHIyFWyZ2GkBnwiX6T2oA+z
	2Chg7bLJMZTDzFm0tKWDBZFsqEkFmr22IblxZxqIIXWayHcGebq4ZWQd9g7FWyV3va7gjcr9z6Wij
	1E7KfJpWpnMXivzaLO9WZMbRcGROllQPOf0EbigWuEpdEUbFOwTyXsxMWGV9WmBDB2hRAsgQsqkzA
	Khlgv4JhPv+WQVYw4bXxbmi2VBOQoAUMcaIqG2rHTvNJ4T8CRRoNtu/kPegXBnf5c66OXZ+85mLXl
	0Sbn/ZDnTqstMKKEuJoHL5/+kJ5qBwaAcdzkbW09T1rVpFXJTXM9a6wixeKC8+qwzhzhLV8BY/8w7
	rZpmJYww==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wI4fp-0072u1-1X;
	Wed, 29 Apr 2026 13:09:53 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 29 Apr 2026 06:09:37 -0700
Subject: [PATCH] fs/select: reject negative timeval components in
 kern_select()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-timeval-v1-1-4448e2588bbf@debian.org>
X-B4-Tracking: v=1; b=H4sIABAD8mkC/yXMSwqDMBRG4a1c/rEBTYM12Yo4SM21XvFFYqUg7
 l1qh2fwnQOJo3CCowORd0myzHBUZIS29/OblQQ4gs51mRtt1SYT735UlX8YW4XA5mmREdbInXz
 vU938O31eA7fbj+M8L9aeHNZrAAAA
X-Change-ID: 20260429-timeval-8a3498dde479
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 clm@meta.com, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=4424; i=leitao@debian.org;
 h=from:subject:message-id; bh=jM/IH8EGk8YBTvxYomCFRlziNoxfG/zfVtakC3ySAAs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp8gMd6eZ/YZh+FO6ax9Us6QgbjYDKSBIomDhuR
 lOKIXGlx+qJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafIDHQAKCRA1o5Of/Hh3
 bUllD/9umOrXK7AZBUqiwDRGgWPgi+Os/o3rDHJonF0W1W3jMsh1z+CVfoIV+xuVqC56YPzdlAm
 2n+ta9QyESMXbQWBaA1NUWK7oAOcLHt+egc6Sd53uCFk7zDQHsrc43DnRStXbdIkNRG+9yqpfnQ
 tgSfkblW91oNr4J7xGHlEt/NLgm2/B35G9Qe6wU3FZ+mDMITj3Nu14hJ6rtU6/6jc3walngJXKZ
 sc0G4D0RnZe5zhDq/gNbZ1TJf4KxyxrggMfJ41fXWkySzXm430wSsLF/FvF2iidAW8piWwR0v3c
 xQR3+46Ax8wrg2R2eT9tJCl9if+IIeiUbTCjhWFzTzX04en6WD7aN1Drjbo9CJv+aXlXu9o0e70
 9Zm2G5vHbWAmUIPbCsS0Svb/nL44XU7vjfu9RC3xpS3fW4dzKEI88Na8wdqh40F2Wyp7EdMaQ8E
 7vs1wFc84AQo0gEX/DlPUsV7S7//Yxe7Kzn2qqE3nm0LNIRm20rb7CZ+sriMkj3SK1aIOOiuRrV
 V65dRg1R9p/IPwFNP6L1bfgq8pxLihHT802V2ii80s14dRDgDCzIwsDXc3P11Ink8l2WB/BFme4
 te8w1BDfmeJe5r4ZA9zUmoOjOS8JoPUMNrnP0BpztWsZa2M86PueCeneB/CqHIsdl1/GsjULHqQ
 rkkNx6b1NefvW5g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

kern_select() normalises the user-supplied struct __kernel_old_timeval
with

	tv.tv_sec + (tv.tv_usec / USEC_PER_SEC)
	(tv.tv_usec % USEC_PER_SEC) * NSEC_PER_USEC

before calling poll_select_set_timeout() -> timespec64_valid().  Both
operands of the seconds sum are unbounded user-controlled signed long.
A crafted pair where tv_usec is a negative multiple of USEC_PER_SEC
drives the sum across the wrap boundary - e.g.

	{ .tv_sec = LONG_MIN, .tv_usec = -1000000 }

yields sec = LONG_MAX, nsec = 0, which passes timespec64_valid() and
then flows through timespec64_add_safe(), which saturates the absolute
deadline to TIME64_MAX (clamped further to KTIME_MAX downstream).
select(2) therefore blocks effectively forever instead of returning
-EINVAL as POSIX requires for a negative timeout.

Only the legacy __NR_select syscall takes this path.  pselect6, ppoll,
poll and epoll_pwait2 all hand the user's two fields directly to
poll_select_set_timeout(), which validates *before* doing any
arithmetic:

	/* fs/select.c:271 -- the validator */
	int poll_select_set_timeout(struct timespec64 *to, time64_t sec, long nsec)
	{
		struct timespec64 ts = {.tv_sec = sec, .tv_nsec = nsec};
		if (!timespec64_valid(&ts))
			return -EINVAL;
		...
	}

	/* include/linux/time64.h:97 -- timespec64_valid */
	if (ts->tv_sec < 0)                              return false;
	if ((unsigned long)ts->tv_nsec >= NSEC_PER_SEC)  return false;

	/* fs/select.c:744  do_pselect() (pselect6, pselect6_time32) */
	if (get_timespec64(&ts, tsp)) return -EFAULT;
	if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec)) return -EINVAL;

	/* fs/select.c:1097 ppoll */
	if (get_timespec64(&ts, tsp)) return -EFAULT;
	if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec)) return -EINVAL;

	/* fs/select.c:1065 poll -- timeout_msecs is int; >= 0 gates the math */
	if (timeout_msecs >= 0)
		poll_select_set_timeout(to, timeout_msecs / MSEC_PER_SEC,
		                        NSEC_PER_MSEC * (timeout_msecs % MSEC_PER_SEC));

	/* fs/eventpoll.c:2512 epoll_pwait2 */
	if (get_timespec64(&ts, timeout)) return -EFAULT;
	if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec)) return -EINVAL;

In every one of these the wrap-prone arithmetic from kern_select()
simply does not exist; the user fields reach timespec64_valid()
unmodified.  glibc routes the C-library select() through pselect6,
so the bug is reachable only via a direct syscall(__NR_select, ...).

The pre-validation negative check that used to live here was lost
when the syscall was switched to the poll_select_set_timeout() helper.
Restore it: reject tv_sec < 0 || tv_usec < 0 up front, mirroring what
glibc does in userspace.  do_compat_select() has the same arithmetic
pattern but is only reachable on 32-bit compat and from a different
syscall entry; left for a follow-up so this change stays minimal.

Reproducer (returns -1/EINVAL on a fixed kernel; blocks indefinitely
on an unfixed one):

	struct timeval tv = { .tv_sec = LONG_MIN, .tv_usec = -1000000 };
	fd_set r;
	int pfd[2];
	pipe(pfd);
	FD_ZERO(&r);
	FD_SET(pfd[0], &r);
	syscall(__NR_select, pfd[0] + 1, &r, NULL, NULL, &tv);

Fixes: 4d36a9e65d49 ("select: deal with math overflow from borderline valid userland data")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/select.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/select.c b/fs/select.c
index 75978b18f48f8..bf71c9838dfe1 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -708,6 +708,17 @@ static int kern_select(int n, fd_set __user *inp, fd_set __user *outp,
 		if (copy_from_user(&tv, tvp, sizeof(tv)))
 			return -EFAULT;
 
+		/*
+		 * Reject negative components before normalisation. The seconds
+		 * sum below is performed in signed long and a crafted negative
+		 * timeval can wrap to a positive value that passes
+		 * timespec64_valid() and turns into an effectively-infinite
+		 * deadline via timespec64_add_safe()'s saturation, instead of
+		 * the -EINVAL POSIX requires for negative timeouts.
+		 */
+		if (tv.tv_sec < 0 || tv.tv_usec < 0)
+			return -EINVAL;
+
 		to = &end_time;
 		if (poll_select_set_timeout(to,
 				tv.tv_sec + (tv.tv_usec / USEC_PER_SEC),

---
base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
change-id: 20260429-timeval-8a3498dde479

Best regards,
--  
Breno Leitao <leitao@debian.org>

