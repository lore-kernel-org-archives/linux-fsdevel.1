Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793406527;
	b=YkDFiFg03zl3rREtPPsDlvq5m5hwPgbPvxrtbHYSwR6wKZq+uAmD55n5j/vOrW3Z17+l
	 Pw97A0VLwDFQn4Zz4BjFml6cVDkIZoznlpRHFRKuPQvt2VoxcD5L4I2VxwZ9KP4NwSnYm
	 f1W7HxYmEthszAkNawro/sxcawiVmwrIAPkrxzrbktJudHLJlq0uIck6H8z35BOq+4KxZ
	 TunrqnUVGMxJjG4LWmmN6LzD1C/Ucf/AvdncLsV9n4arfoCQV8HJDk+1zwXYZ77UIXvoB
	 f0+AEnGg5DK7JkXzGs4SbDqTk8oRH3KSn2/DLqA270g1HlJC6ef8U53fXfOtYNTwi1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793406527;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4Kgr7iIBf+e/RiJRNbVgF9y5Ui+JHkbb2EGgp3NIfYI=;
	b=lvc5r+UIZ9s9P5xE8cFtqlqiLb+1/FgfpCT29I2nuEbPf4yFH9Z3oJo9PINT7up1/AaW
	 TwcVdsNePbGgeJgHJ/rLWaRzz99UyEkK3IeOZ+ZUpGq2yIq47dTbnVKGFGV8OeAEP1ln6
	 gPKX7k7etxLi97kLgNnD9Pkme+cs+7tTkQxPhvLktgUc39s2N5jhnaaImcl54B+TLaNCA
	 7X3gfEWX9vhs7hrKlxMjf6p0MvyF1uAdCh7aubYFDCX5XdM0sbxDC8w8X54XuhnA9vLJf
	 ctepfkrOVx52MMbaoccN/jHqJS7pAet0OvZFOfs1lmK60brnhm4HmdGkm7AY5OK/6mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=M6nCSZJy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D20606A31A;
	Sat, 31 Oct 2026 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=M6nCSZJy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D3A1F000C1;
	Sat, 31 Oct 2026 00:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793406526;
	bh=4Kgr7iIBf+e/RiJRNbVgF9y5Ui+JHkbb2EGgp3NIfYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M6nCSZJyXD8WdsA7wq46Z6BC0ixlmiL9huM7TP67rWisx9PKqzWRx99WCMRb4byqV
	 gvnkKidSOqqkbDCPYyG0YbV2zTGbsmhHU7nUtYM81CJN112R2lygBILiNrke1BGE2W
	 aRQYkskoeKXrt1hRDiTAEDVkXjeho2PN4n2PNVrQ=
Date: Fri, 30 Oct 2026 17:28:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown
 <neil@brown.name>, Thomas Maarseveen <maarseveent@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/2] errseq: fix lost writeback errors in
 errseq_check_and_advance()
Message-Id: <20261030172846.a3221ec351f24784370a819c@linux-foundation.org>
In-Reply-To: <20260927051726.71337-1-jain.sm@gmail.com>
References: <20260927051726.71337-1-jain.sm@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 10:47:24 +0530 Shashank Mohan Jain <jain.sm@gmail.com> wrote:

> errseq_check_and_advance() advances the caller's cursor to the value it
> tried to store even when its cmpxchg() failed. If errseq_set() stored a
> different errno in the meantime, the cursor holds a value that was
> never in the errseq_t. errseq_set() does not bump the counter while the
> current error is unseen, so recording the first errno again recreates
> exactly that value, and once another subscriber has marked it seen, the
> cursor's next check returns 0. For fsync() (file->f_wb_err) and
> syncfs() (sb->s_wb_err) this means that a writeback error recorded
> after the previous call returned is not reported. The race is rare: it
> needs two different errnos, an error recorded while the check runs, and
> a second subscriber consuming the value. There is no user report; it
> was found with a model checker.
> 
> Patch 1 retries with the value found when the cmpxchg() fails, so the
> cursor is only ever advanced to a value that was stored with
> ERRSEQ_SEEN set. Patch 2 adds a KUnit case that races errseq_set()
> against errseq_check_and_advance() on two CPUs.
> 
> Two behaviour changes are visible to callers, both intended. When a
> writer wins the race, the call now returns the newer errno (still "the
> latest error", as documented). And when two threads race on the same
> unserialised cursor (syncfs() does not lock f_sb_err), the loser may
> now return 0 where both used to return the error, so each open file
> description gets one report.
> 
> Dependencies: patch 1 applies to mainline (fd179f8a05be) on its own and
> carries Cc: stable. Patch 2 extends the errseq KUnit suite from commit
> b52f5c1605f2 ("lib/tests: add KUnit tests for errseq"), which is only
> in mm-nonmm-unstable, so the series is based on mm-nonmm-unstable
> (e8d6475e77a7). Patch 1 could go through mm-hotfixes and patch 2
> through mm-nonmm-unstable.
> 
> The bug was found with a TLA+ model of lib/errseq.c checked with TLC.
> The patches were prepared with Claude Code (Anthropic), model Claude
> Opus 5.5 (claude-opus-5-5).

Thanks.  Let me cc:Christian.  errseq is only used by filesystems, it
was all written by Jeff, who has approved this series.  Probably
get_maintainer should say "send this to Christian".

> Tested:
> - KUnit on UML x86_64 (kunitconfig with CONFIG_ERRSEQ_KUNIT_TEST=y,
>   CONFIG_SMP=y and CONFIG_NR_CPUS=8, run with --kernel_args seccomp=on
>   --kernel_args ncpus=4). Without patch 1 the new case loses the error
>   in 21,957 to 116,003 of 2,000,000 rounds (1-6% over 8 runs,
>   depending on host load), in 44,886 with ncpus=2, and in 30,353 on
>   UML i386 with ncpus=4. With patch 1 it loses none (8 runs with 4
>   CPUs, 1 with 2 CPUs, 1 on i386). All other errseq cases pass. On a
>   single CPU the new case is skipped.
> - A userspace replay of the unmodified lib/errseq.c, with a hook before
>   the cmpxchg() standing in for the other CPU, loses the error every
>   time.
> - TLC: the current code violates "an error recorded after a check
>   returned is reported by the next check"; with patch 1 the property
>   holds exhaustively for 2 subscribers x 3 checks and either 1 writer
>   x 4 errors (1,364,445 distinct states) or 2 writers x 2 errors
>   (141,055,253 distinct states).
> - W=1 builds of lib/errseq.o and lib/tests/errseq_kunit.o for UML
>   x86_64 and i386 without warnings, and checkpatch --strict.
> 
> Not tested: fsync() or syncfs() on a real failing device, weakly
> ordered hardware (the model is sequentially consistent; the fix adds no
> ordering requirement beyond cmpxchg()), and architectures other than
> UML x86_64 and i386.

fyi, I usually remove the testing info from the changelogs.  It's of
course important, but it's development-time stuff.  This info will be
terribly out of date when someone is reading these changelogs in
mainline two years from now.

I just said "Testing info is at the Link:".  So our two-years-hence
reader can chase it down if they're particularly interested.

> Shashank Mohan Jain (2):
>   errseq: don't let errseq_check_and_advance() hide later errors
>   lib/tests: errseq: add a concurrent check_and_advance test

My AI review had a few nitpicks, I think they're ignorable, depends
how enthusiastic you're feeling ;)

: The lost-error case is real, and I couldn't find a functional problem
: with the retry fix. The Fixes tag is correct and the stable Cc is
: appropriate.
: 
: A few details to fix up:
: 
: - The cover letter's "each open file description gets one report" is
:   too strong. Concurrent syncfs() calls sharing an unlocked f_sb_err
:   can still both report the error. This patch doesn't serialize that
:   cursor.
: 
: - A concurrent update on every failed retry shows progress elsewhere;
:   it doesn't guarantee that this particular caller will terminate.
:   Also, only the next setter after SEEN must increment the counter,
:   not every later setter while the value remains unseen.
: 
: - In the test, breaking on the deadline skips the loop increment, so
:   printing round - 1 undercounts the completed rounds by one.
: 
: The test also doesn't ensure that the two threads run on different
: CPUs, and its five-second check is between completed rounds rather
: than a hard timeout. Please qualify those claims.

