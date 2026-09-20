Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC702DECBA
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789943964; cv=pass; b=AFwK7xtR9cZChFUeB+x2O1iPBerUhVhSGIjpVfpy9yeMyNi19xi1AJQON3gsMOatsE/C9O8nRDP0eBTvBsvebgBknVjXb3xXmmezlPA48UcDRC7KbjnRbVebVohGtjc3MTStOGUbAmb/6A74UGbbNLdreaNKAnAMwgKYNDxz2lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789943964; c=relaxed/simple;
	bh=WtJ4ZTd+8k6LQGnxavaDmIp6OwRZVXdyPN3V6KIUn6Q=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1wGxdxvk0mYiWLLNNDr/OraQ1HddAH58lFFKMTxT0H9g2B5Cexv5taYqYqwS4r48j0wQWi53LKbt/wA5jt8ohUYbzL4+yL98YpE2pdAPCrAuDO4I2nCEIB9T8V9V3nxGqxsC8yZq8FCBhpHujFyGIpUhejOmHQbUph85J+6jlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo02oinT; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo02oinT"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c20ce3c118aso362684966b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 15:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789943961; cv=none;
        d=google.com; s=arc-20260327;
        b=C0ZEMXqCxCkmBAz821b6nbhZkNuhAbswYNIv2uAYP4UYzYQPw6QS4eV4PDec/6vdUF
         gkUVBVI7UkHSuACb4v4qV7R/Qw77/NWFG8GyqluPjVuqcSO5gDbs2w1EjOZRDYBuqON7
         NdyExKV2VbrSDsFJ8Lyu09UaAqnuqvwpgHHzsWc7mQ+a3pmBwDcrqBYDBkpRhqCFsKBM
         avYFyLJ72X65PSDBXRtncJVZ0/PLv6SNtY2GrCrJynk1YyD7LdHbbZXbYBIu8HFiUZef
         t9bkm7Bfa+wzXk7B3NEN7pEW3GcREO6R2gLAT7rHk0iel2uF5kg1j+ji8vbkwuX2beD4
         bIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=KpJKV9oL0BlyVbCMHmeY3GdCnj0W6bhLkcjPYkX4BAw=;
        fh=lwTk00GAkmCb5WtiZ2A6Udo8DNMYa61eB16aMEsCurU=;
        b=P14ZmGzHxzXiRWvHiLqMvJCOEORFmqCWVe6iTln6dwCglH5mvbYJM03sTY7cszO2KC
         Hy3g3IDGQEg5uTY/Qn+EAt9rufz/JBarES8JIlkBVD6r7A6dBgJZvJ6gaXZKnj2LgLcB
         Nj1P9MwGhBa8wI06FR4NzxKcHNhvZfWgJSKDSwm8PEWqvirtU3/ns0PqDgFj7lu10qYF
         0hI4mnPLNTYB2CTnQ/OalhqgcG901SE34LfDT2yh/9TlVWapVH8PqU73/fXhnVmqbomC
         ftp8EqqxadIUSl78RLu70ikdet1AeN0jhsA+4ehvuaWXOM6+Pw12Hz8PKv9dripQ6dSm
         5Jlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789943961; x=1790548761; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KpJKV9oL0BlyVbCMHmeY3GdCnj0W6bhLkcjPYkX4BAw=;
        b=Qo02oinTMvO2Fgj8T/2UkrOGO8Gluotrmqm98huofPWiTqmjv8GvxSrwPVo/31z9+E
         pnGGPm3xvJp5EHNM/H1/oS64PX4usYU4e2btfb68sTcVyo5QZb7G/YmWDM4toqEpf+iz
         louTriEOZE6v2yUgADiyrL6VvrjFIjTp6bECk5AfcGoIjPcurH8oRumVa2SULV+kvhGR
         JlgXGEv0SZ7GPm+dpxxnFOl88EooQi+FQmixwTYKzrnb2zpxF1ZV2vdquKFPLsW720Ey
         IdNnmVoHxQSCEO9n051pUbK9+cFBTuaHhWK1/C6wb4OSipk05xFQRNF8JUXK/k3ZOmDs
         MGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789943961; x=1790548761;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KpJKV9oL0BlyVbCMHmeY3GdCnj0W6bhLkcjPYkX4BAw=;
        b=HeREXrUJwwADSwxoXkuafl+D/QshivsNmKB+bT07zJo6vZfnlJu3xSsr3JcR86nqye
         Q9N5Rdr9Ksu/3/kSqoGDCieKVMEyHL/xGAVhcZZ/7iTYxE0RIFRIUPx7EXPBfH6IzF4i
         cTUbYMUuNfes8UGU9jAGvcu6cYYdywhy2GGMabNHws5wqlKDKwfsG4RxD1CAH3nPkqGN
         dEgM0AIxWsL3b5qoZ2y/WU8iz4BrIrbih5r2IXHLn363PHGkePEoWd+OvpFsP+PXfjeb
         8ydYHONJhnuKbgNSgVUHDbhp7R9vYAJZ4T8wL+9dtKCEpPSi66HrtIYuBjzZ/pKjRHji
         94ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBytBNn+FCVf4B2WTOj/Mih/M0D73cqzjwlpRHB6ZXRe7VLB7DVH3pHos6hDgdqW1WndEIQC31KAV0ppJ89B@vger.kernel.org
X-Gm-Message-State: AFuF++lcOJirP34l/g/7E7dYRrf2ymYjnLHJhsPMU7lDP8qmpQ2MzgVh
	ntWrtMAt2A8Xjv+x5vDi9U2hMDbqq6ZG7LIrglCPS61v7QiDJ+0sI/LP9gwNsJNK+eXZxfG5mdL
	j/SvIM/0r/7G6RGPJu1rCgy2z8ubUMni0nLhX3dE=
X-Gm-Gg: AYBFou3k2XFpolizdCTMfQ9mxlBM53FOU9ej9f1utUScpqPTDH1mssGshxHndKV2zng
	V82HoumtfdV0gs96pKIrqJ+drNE6iIPw8fo0kXVuR446wYnAF9IkoV7rRZNB2ySRc4/BQ+HGIXg
	ihe4S1KwoogiVqAzV+DrXmSUE/PG2dpcdie0oDy6QE73A+g7lTKln5cmLEIIH/h9WERxGdWur3r
	QSK4SX6XqNAOPrPbySBDW7amBivlgXac0xOiQC6LLKX6f8N1q/o8CBluA9U+gpb4dmPXCHPaflE
	JgO/gLEszn5hQe3Ak+2yxPq2WkdxzLl+P1wWUnUJg7ft2h8YUfKmB3Tv2Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:907:3ea4:b0:c29:6bf0:eb73 with SMTP id
 a640c23a62f3a-c29f5228f5fmr1121776566b.1.1789943961258; Sun, 20 Sep 2026
 15:39:21 -0700 (PDT)
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Sep 2026 15:39:20 -0700
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Sep 2026 15:39:20 -0700
In-Reply-To: <<o5ihhfa252cjfspqlag65xhnmehz3a5feyclmlyy4xlrcmceck@njmhyu7oom3d>>
References: <20260725182628.221603-1-nsd.project.dev@gmail.com>
 <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com>
 <anlByPDZmvEhWeXI@casper.infradead.org> <ffcij36vnozf3rginqd2opd2dwqyki7xhtdo4veuty734hhgba@utjav2k263o6>
 <nsd.1787001235.35928@mail.gmail.com> <w7vte4itudtkw2yf4vbmuofiumfffmp2y52dpu2bqvqtdgjvpd@5femyiozss3e>
 <CAFLp9PGkVYZcQT5qAx-RKFOF-urZ92m417zpAeF7ZQempbS1HQ@mail.gmail.com> <o5ihhfa252cjfspqlag65xhnmehz3a5feyclmlyy4xlrcmceck@njmhyu7oom3d>
From: =?UTF-8?B?YXloYW4gYXlkxLFu?= <nsd.project.dev@gmail.com>
Date: Sun, 20 Sep 2026 15:39:20 -0700
X-Gm-Features: AcwNN1Uij5l810gjQSoNTyE4DLMXLaa4cmXOi_eWZ3R4ZbTL0QkRJm-CP3x26yU
Message-ID: <CAFLp9PF+6KUY7ZAGQZ_X9AN4VYbkdW_aDk1QSth3ZAVVqLTqsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Neural Storage Driver - learning page cache prefetcher
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Honza, hi Willy,

First, my Aug 20 follow-up bounced on the HTML part. My mistake, resending
as plain text. Below is that content updated with six more weeks of
measurement. Two self corrections first, before any numbers.

What changed since the RFC (same out of tree module):
Automated prefetch never exceeds ra_pages now. Overhangs get trimmed
or dropped, all counted. The only exception is our own measured
willneed ranges up to io_pages. That follows Ming Lei's RFC direction
and the MADV_POPULATE precedent. It is toggleable, Mod A means strict cap.

Fault path first, as you asked in Q3. filemap_fault hook observes, then
prefetches with depth capped at 2 and bounded by the cap. One more
thing on this: the fault path stands down explicitly at 1M windows and
up. There is a straight s_bdi->ra_pages check in nsd_process(). The
  parity we see at 256K and 512K is a different thing. Our code still
  fires there. The kernel just catches up on its own at those sizes.

A sleeping in atomic bug in our fast path got found through a stack
trace and fixed. vfs_fadvise was called from fprobe context. It now
goes through a workqueue.

A len==0 fadvise footgun got found through our own counters. Len 0
means to end of file, so those sends preloaded whole files. All our
earlier big mmap and SQLite speedups traced back to it. Retracted.
Sends with len 0 are now dropped and counted.

Narrowed claims after all that. Interleaved A/B, drop_caches before
every run, checksums verified, 500+ runs in total:

  sparse mmap scan, about 64KB stride, 512MB to 20GB files, 128K window,
  SSD: ON ~47s vs OFF ~88s median over 30+30 reps, no overlap.
    The threshold lines up exactly with FAULT_AROUND_ORDER=4 (65536B).
    Below it the kernel fault around covers the fault by itself.
    Above it, it does not.
  same setup at 256K, 512K, 1024K windows: parity, kernel catches up.
  dense mmap, rand 4K, seq read, SQLite, THP, and HDD sparse mmap:
  parity everywhere. The early small HDD lean got remeasured with
  current code and traced to the same len 0 accident, retracted too.
  No workload regresses. dmesg tracked throughout, no new warnings.

So the scope is sparse mmap scans at default size windows on
SSD. That is where the fault path underprovisions while the read path
is already saturated. Dense, random, 1M tuned and HDD cases are parity
by measurement.
Separately, one thing that might be useful here too: p99 tail latency
is about 4x worse at 1M than at 128K regardless of NSD state. Another
practical reason to keep windows small.

Open questions, updated:
  Q1, fadvise beyond ra_pages: we stopped doing it silently. Only
      measured willneed ranges up to io_pages, and that can be turned
      off. Acceptable shape?
  Q2, ra_state integration: we prototyped window steering from the
      module. The kernel keeps our window but wall clock does not move
      because there is just not enough volume from outside. Real
      integration needs in kernel changes, so we drafted a minimal one:
      2 stream slots plus stride state in file_ra_state, every window
      bounded by ra_pages, read path only. Want me to post it separately
      for direction feedback before any boot testing?
  Q3: fault path first as described above, with timely versus correct
      accounting running underneath.

For Willy: backward patterns get detected near perfectly (strides with
negative deltas, counted separately) but they do not move the wall on
SATA SSD, so throttled now. Fault path is covered as you asked.
PG_readahead replacement stays an in kernel question as above.

Full data and the retraction notes are in the tree. Happy to run any
counter matrix you ask for.

Thanks,
Ayhan
