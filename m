Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74733655F1;
	Fri, 22 May 2026 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779479031; cv=none; b=avT+WeiOH9mshEo9mRD8ddvDkj/kqQSTBvIgRbJ+QR9BNXtNk+sjDAE5Xmbeny7aMlafLbKVtOpYWDd93GCHNIwOOK0qwgzVkRWtkeEHnvDpxYulXliFWf6srHibRtTgrXGglA9uv0xtVgbwNR2YfRMg6UNedQEfivtNs4+iqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779479031; c=relaxed/simple;
	bh=aQrscosaX/SWgi2yUuQVWGozRU+m/4b3LcYPuaOg8H8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRzOPa0Zhu4z84tj/5QZWAZecH7QazZqhvz6vWx1XKGfd2Czg0xojwKjqtoBAkpvSu9yVP+AhxyV6lXNykOFu+F6yCFvV3J8MiAdoFz1R0OVtvobavXKKRhxzooZbM+B2xDo6F6E1/oOUh7VA4am06OYl58n8jVT7yUfNfdtdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4+SO5O2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4+SO5O2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6A21F000E9;
	Fri, 22 May 2026 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779479029;
	bh=LCMsWYweKeQIaDa+1CygcB8/DpjcoB4C7NMTyWbUNpA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H4+SO5O2o0zXW4iUZCvJ3XIuAbCmGf+4TTEQDoWu0ItxH6/LfzWv3oF8ksk10fdeZ
	 kxq1SH1DqP1DvuLSN9RmgjtKdERiHGwjV5lE9joWqER3yneofwUDKzoqM3TJciLtTx
	 m5Tf1DXm9sZyUBHvzYxrF3vB9062DY9ZWycgufd7APGJ8PcTcq5bL/MR/udaviMftj
	 W4bYSMy0wAUs1QDJ0a0sDMhqX6ibbJfWOSlVwIpCCEtKTeiIcK/1++gdS3pz7OIrsa
	 KJs6PUIjDX2OXSO7bhze6OFVw6YDyaDTiHeG5CNQ6LeknKqlNyOXu24+FQYaBqza05
	 bzbYR4pSCTDPw==
Message-ID: <330fe57736b44525aeb3f9d127a1361b18038fd9.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
From: Jeff Layton <jlayton@kernel.org>
To: Breno Leitao <leitao@debian.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner	 <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>,  Mateusz Guzik
 <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, oleg@redhat.com, 
	axboe@kernel.dk, kernel-team@meta.com
Date: Fri, 22 May 2026 15:43:46 -0400
In-Reply-To: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
References: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-22 at 09:44 -0700, Breno Leitao wrote:
> While profiling Meta's caching code[1], I found pipe->mutex contention
> on the hot path. anon_pipe_write() currently calls alloc_page() once
> per page while holding pipe->mutex. The allocation can sleep doing
> direct reclaim and runs memcg charging, which extends the critical
> section and stalls any concurrent reader on the same mutex.
>=20
> This series pre-allocates pages outside pipe->mutex in
> anon_pipe_write(): for writes that span more than one full page, up
> to PIPE_PREALLOC_MAX (8) pages are allocated via a per-page
> alloc_page() loop before the mutex is taken. anon_pipe_get_page()
> then drains the prealloc array first, falls back to the per-pipe
> tmp_page[] cache, and only enters the allocator under the mutex for
> the leftover pages (writes larger than PIPE_PREALLOC_MAX, single-page
> writes that skip prealloc, or shortfalls when the prealloc loop
> fails). Leftover prealloc pages are recycled into tmp_page[] before
> unlock and any remainder is put_page()'d after unlock, keeping the
> allocator out of the critical section on both sides.
>=20
> alloc_pages_bulk_mempolicy() looked tempting but the bulk allocator
> refuses __GFP_ACCOUNT under memcg -- it returns at most one page
> when memcg_kmem_online() && (gfp & __GFP_ACCOUNT), see commit
> 8dcb3060d81d ("memcg: page_alloc: skip bulk allocator for
> __GFP_ACCOUNT"). A per-page loop keeps memcg accounting and the
> task NUMA mempolicy honoured uniformly without open-coding the
> charge.
>=20
> I also vibe-coded a microbenchmark to validate the change. It sweeps
> writers x readers over {1,2,5} x {1,5,10} with 64KB writes against a
> 1 MB pipe and prints throughput + latency percentiles per config.
>=20
> Measured on arm64 and also on x86 using virtme-ng (16 vCPUs, 64KB
> writes, 1 MB pipe). The numbers below were collected on v1
> (alloc_pages_bulk()); v2's per-page loop preserves the dominant
> "allocation outside the mutex" win and is expected to land in the same
> range.
>=20
> =3D=3D No memory pressure (10s per config) =3D=3D
>=20
>   Throughput in MB/s (baseline -> patched, delta):
>     writers   readers=3D1              readers=3D5               readers=
=3D10
>           1   1119 -> 1354  (+21%)   1132 -> 1195   (+6%)   1060 -> 1240 =
 (+17%)
>           2   1162 -> 1487  (+28%)   1034 -> 1285  (+24%)   1069 -> 1213 =
 (+14%)
>           5   1152 -> 1357  (+18%)   1021 -> 1164  (+14%)    997 -> 1239 =
 (+24%)
>=20
>   Avg write latency in ns (baseline -> patched, delta):
>     writers   readers=3D1                 readers=3D5                read=
ers=3D10
>           1    55786 ->  46103 (-17%)   55164 ->  52260  (-5%)   58906 ->=
  50370 (-14%)
>           2   107546 ->  84011 (-22%)  120837 ->  97206 (-20%)  116860 ->=
 103036 (-12%)
>           5   271293 -> 230170 (-15%)  306089 -> 268429 (-12%)  313300 ->=
 252232 (-19%)
>=20
> Throughput improves +6% to +28% and average write latency drops 5%
> to 22% across every configuration.
>=20
> =3D=3D Under memory pressure (--memory-pressure, 6s per config) =3D=3D
>=20
> stress-ng --vm 2 --vm-bytes 50% --vm-keep is forked alongside the
> sweep so the alloc_page() calls inside anon_pipe_write() routinely
> hit direct reclaim -- exactly the regime the patch targets.
>=20
>   Throughput in MB/s (baseline -> patched, delta):
>     writers   readers=3D1            readers=3D5            readers=3D10
>           1   1088 -> 1438  (+32%)   996  -> 1477  (+48%)   989  -> 1194 =
 (+21%)
>           2   1076 -> 1378  (+28%)   1007 -> 1269  (+26%)   1018 -> 1234 =
 (+21%)
>           5   1052 -> 1311  (+25%)   986  -> 1225  (+24%)   972  -> 1249 =
 (+29%)
>=20
>   Avg write latency in ns (baseline -> patched, delta):
>     writers   readers=3D1              readers=3D5              readers=
=3D10
>           1    57397 ->  43406 (-24%)   62690 ->  42272 (-33%)   63136 ->=
  52272 (-17%)
>           2   116121 ->  90700 (-22%)  124098 ->  98481 (-21%)  122754 ->=
 101217 (-18%)
>           5   297122 -> 238322 (-20%)  316836 -> 255095 (-19%)  321496 ->=
 250189 (-22%)
>=20
> Throughput improves +21% to +48% and average write latency drops
> 17% to 33% -- a noticeably bigger win than the no-pressure run.
>=20
> That tracks: when alloc_page() has to dip into reclaim, the cost
> of holding pipe->mutex across it is highest, and pulling the
> allocation out of the critical section pays the most.
>=20
> Link: https://www.usenix.org/system/files/conference/atc13/atc13-bronson.=
pdf [1]
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Switch the prealloc path from alloc_pages_bulk_mempolicy() to a
>   per-page alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT) loop.
> - Split the prealloc work out of anon_pipe_write() into dedicated
>   helpers (anon_pipe_get_page_prealloc / anon_pipe_prealloc_pop /
>   anon_pipe_refill_tmp_pages / anon_pipe_free_pages) gathered in
>   struct anon_pipe_prealloc, so the write path stays readable.
> - Recycle leftover prealloc pages into pipe->tmp_page[] before
>   unlocking
> - Link to v1: https://patch.msgid.link/20260515-fix_pipe-v1-0-b14c840c755=
5@debian.org
>=20
> To: Alexander Viro <viro@zeniv.linux.org.uk>
> To: Christian Brauner <brauner@kernel.org>
> To: Jan Kara <jack@suse.cz>
> To: Shuah Khan <shuah@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
>=20
> ---
> Breno Leitao (2):
>       fs/pipe: pre-allocate pages outside pipe->mutex in anon_pipe_write
>       selftests/pipe: add pipe_bench microbenchmark
>=20
>  fs/pipe.c                                 | 105 ++++-
>  tools/testing/selftests/Makefile          |   1 +
>  tools/testing/selftests/pipe/.gitignore   |   1 +
>  tools/testing/selftests/pipe/Makefile     |   9 +
>  tools/testing/selftests/pipe/pipe_bench.c | 616 ++++++++++++++++++++++++=
++++++
>  5 files changed, 729 insertions(+), 3 deletions(-)
> ---
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> change-id: 20260515-fix_pipe-c91677c187e7
>=20
> Best regards,
> -- =20
> Breno Leitao <leitao@debian.org>

Pity this can't use the bulk page allocator, but looks good otherwise.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
