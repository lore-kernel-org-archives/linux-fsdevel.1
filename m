Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C1283FCE;
	Sun, 27 Sep 2026 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524109; cv=none; b=oGu+O7jgp7Q0W/xWVX+7d2BUH4YfudxeUqVhmEZ5dXsLFACFGuJjUC1vkvlT/WvYF+qLkp+RcjbezOPGG0NL/GqlUemjbt6q7r9uIInxmlxxTql0ToBJSewYmOlO7DvrhyKrRkYBYL8sqdOzXGlUNmGFurDvVJ77zDYE6W98fe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524109; c=relaxed/simple;
	bh=X6xQLrnHsZaprtQnr79dy2oW31BJVWnUrHXxuS7ohdY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c6hAUBatGjL60+R/0cD0R9Nfj3mwwuWKIRQsI3iiH0+wygd9NDZFlXd9asQrHspDRkI2aeKmS9c8sh8puqvJRJ9daKilZK/+g8+f4sQ3wsky0yB+FZVCNZd2oyJK5WElbibwM0KYDqJewvTCIsUbnVVdRzTtv+KNQHCe61LJ9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbtgXqCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbtgXqCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C707F1F000FF;
	Sun, 27 Sep 2026 15:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790524108;
	bh=xVaCfRSdHXbgH/NmMqUFgOds4tgdD0LQ8PbXE94VPpk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bbtgXqCaTVQQW0yyYHYQR859Tb4gkgnFylntryjjaBe4RwDcoVMZctnvGkZqiJ//s
	 fBAHP8gcfZ0HK+AYKKC68tBZcEXwZ+RE48+QRiGvghXGFatBweRFQs+IIHpkxT37+S
	 WP8eXbVoXZdgkz+Z/eLbG0+1o2rdlbvQojFp0Mzwsul7ZliCrq5MGSpgZkpbm5aSvg
	 25EfEI9XsrsMTWzaIGGJTMh/Y7UQnTqoDHkGFLp1NOs0Wm9vosbrhqJ1k7fDQBOIym
	 7LHT3/Y+z/b6rXrXv4jVRKPC9K6FvJ2AKDJTabpPaH2hxtxNxqWZB+Emaqv0nhgmeH
	 /V08A0rzTvz9w==
Message-ID: <0c8ff34adf831b7926468c83a2df8c67062ed3bc.camel@kernel.org>
Subject: Re: [PATCH 0/2] errseq: fix lost writeback errors in
 errseq_check_and_advance()
From: Jeff Layton <jlayton@kernel.org>
To: Shashank Mohan Jain <jain.sm@gmail.com>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Thomas Maarseveen
	 <maarseveent@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 17:48:24 +0200
In-Reply-To: <20260927051726.71337-1-jain.sm@gmail.com>
References: <20260927051726.71337-1-jain.sm@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-09-27 at 10:47 +0530, Shashank Mohan Jain wrote:
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
>=20
> Patch 1 retries with the value found when the cmpxchg() fails, so the
> cursor is only ever advanced to a value that was stored with
> ERRSEQ_SEEN set. Patch 2 adds a KUnit case that races errseq_set()
> against errseq_check_and_advance() on two CPUs.
>=20
> Two behaviour changes are visible to callers, both intended. When a
> writer wins the race, the call now returns the newer errno (still "the
> latest error", as documented). And when two threads race on the same
> unserialised cursor (syncfs() does not lock f_sb_err), the loser may
> now return 0 where both used to return the error, so each open file
> description gets one report.
>=20
> Dependencies: patch 1 applies to mainline (fd179f8a05be) on its own and
> carries Cc: stable. Patch 2 extends the errseq KUnit suite from commit
> b52f5c1605f2 ("lib/tests: add KUnit tests for errseq"), which is only
> in mm-nonmm-unstable, so the series is based on mm-nonmm-unstable
> (e8d6475e77a7). Patch 1 could go through mm-hotfixes and patch 2
> through mm-nonmm-unstable.
>=20
> The bug was found with a TLA+ model of lib/errseq.c checked with TLC.
> The patches were prepared with Claude Code (Anthropic), model Claude
> Opus 5.5 (claude-opus-5-5).
>=20
> Tested:
> - KUnit on UML x86_64 (kunitconfig with CONFIG_ERRSEQ_KUNIT_TEST=3Dy,
>   CONFIG_SMP=3Dy and CONFIG_NR_CPUS=3D8, run with --kernel_args seccomp=
=3Don
>   --kernel_args ncpus=3D4). Without patch 1 the new case loses the error
>   in 21,957 to 116,003 of 2,000,000 rounds (1-6% over 8 runs,
>   depending on host load), in 44,886 with ncpus=3D2, and in 30,353 on
>   UML i386 with ncpus=3D4. With patch 1 it loses none (8 runs with 4
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
> - W=3D1 builds of lib/errseq.o and lib/tests/errseq_kunit.o for UML
>   x86_64 and i386 without warnings, and checkpatch --strict.
>=20
> Not tested: fsync() or syncfs() on a real failing device, weakly
> ordered hardware (the model is sequentially consistent; the fix adds no
> ordering requirement beyond cmpxchg()), and architectures other than
> UML x86_64 and i386.
>=20
> Shashank Mohan Jain (2):
>   errseq: don't let errseq_check_and_advance() hide later errors
>   lib/tests: errseq: add a concurrent check_and_advance test
>=20
>  lib/errseq.c             |  29 +++++++----
>  lib/tests/errseq_kunit.c | 110 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 123 insertions(+), 16 deletions(-)
>=20
>=20
> base-commit: e8d6475e77a75b7a84e42c9d23e238e002f2758f

Nice catch. I think your analysis and patch look correct to me.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
