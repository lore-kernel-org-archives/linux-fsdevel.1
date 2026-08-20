Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8F343F0B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228796; cv=pass; b=OCW/lulGIs1eEWK0c+fOGGiB1wKzBJkpS7JDzMso3WO6X2aNgZO+1jwW9RfARSNmUbo3CTZUlHR4nZZH2qNegX+ne8xOY3sPo8SNvij9PIPkyysZgYcWYq2oLCUczfjwT2Fqffh08k24MV6s+lbrX0srgS9EuJYGo1S3ZnL7xU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228796; c=relaxed/simple;
	bh=lnLteCAqZRqSdgWNfTM5ZPPJ7z3TIqznmF/DBvDffvc=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RofF9LJylF77EUw1fjna0UWRjbVUmG+S8FFJH7oQmPUwNddInTDhWLCXJzJPo81GCCO925s3g4rcOPOT4PDXklCwqsMVpR8NqTG0dtRx0QQlKlYJGFT37xb2g254OneCEilR7lkEHYdkzzkN4UDmBqzpC5/QmQGkERfAHjGC0lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REsKHx5T; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REsKHx5T"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a422090b14so315061a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 05:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787228793; cv=none;
        d=google.com; s=arc-20260327;
        b=TaeDo+aR4fUeLDPQJs6G1+GU0ji1c6G+u4oasJXfqb4UqSSyq21qed+Qh0bSqAD+qg
         kTgItK6hIM8Zlm7nRbXdIMtfI1U84N7JXjUoeW3o3BiyLtsrPxWZlUN1ZbR8n5CoF7hk
         aBh+iPwnrMZf6EpBdnSU4Fa8YDDiTVGD/SdNXTrEc/vc6ktkIOTcKip0Q6qsiFoR99da
         9bNfHAvuh6P7GfSS5FS5/1mv6C+MaxYTgD/vgo1aiBDnbt7T6cMpcmmohcsv/erFYPBS
         mSEQkAlhbrgtfDB5dwbLxAJD9EvAtmAaMN15dm1KACtZxNS1Ro8mzm5lmn1uXLz/RAqQ
         Gc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature;
        bh=0xmgl9fug7nRyKGHgKexZEf2hsDIWJMU7TJaw/LGlYs=;
        fh=oogRyrzmlOT8XxdkzUiIpQ3Lt1E3CgG5Jf+wqclab6w=;
        b=jw4lTYaYC0eZ41x8DCHzGsTztxBHgVhxmjcWzrGhwBs17gpTwrSHCvohGODpMZWQE+
         DtVGZdQ9Z0qzZHlGsD0T5KAsybOmAPBWH7gZwnSDUCAsqg8p65UsMY4us3c9OrtpIyXT
         DdmXIs4o/DYvjXWFlY08joMARVMr1fuZhESE5H9rmo/g2igbw9z0wzA2LHDciWx7kBSZ
         GAXa4Louow3WsXmeoJMHfwbUPrbFd9CMNJt+fIZBW/ygMiIIrlL2QsThZUdmFoW5zxHi
         2CMstKyqhnfXnO0krtq4WqsRaKqIt2PsTmk6F+0mGDC2ejcz+NfTZmY6smrEeSpgezu4
         eAtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228793; x=1787833593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:references:in-reply-to:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0xmgl9fug7nRyKGHgKexZEf2hsDIWJMU7TJaw/LGlYs=;
        b=REsKHx5TzxpCGChuPbSgD7W5UEFOMpQyGEljspHujcupyb0XSTyBWxn8TFrbKS82Jm
         lhKidFivi+MGDbuC4XnhV6TM3viXxVid85bng0IpME1JtCJ5H7vk936Tcftyzhq/qykQ
         0L9McQXenjuldUv5W33w1Ay9Zc2tHUV7m19DmBJD40zZ7OQ9Vo2jYj6jbqJSDgc/RyJH
         Yu0hRIXsvANPXVkUhGN0MmZz/mzRaB/kfBpueptnclZZKKHVFN/xlb4Qblre7VZG7IJx
         Ks1aLxh8lJs5BDY7Yb8db0zjVeDVJzvTjIIauu36+z0D5bi2AWRhtvVBYZY488xw40H0
         LLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228793; x=1787833593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:references:in-reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0xmgl9fug7nRyKGHgKexZEf2hsDIWJMU7TJaw/LGlYs=;
        b=jSOpRbMySSBspzCp7DW0z3I5J5yvHRjzJf2ER+x/rGSidR3eEAzRlTosXR56uRJ4r9
         ZU9BVVZT+BY/20fOFTHgOJsnTWDEQMlmkPfxOvcDZT6yugc9h2DCQXpxbXg5BUus7xdJ
         OmJvS/V7lXN5YAq9C/Zu5c8rKOCq7SN/vAz9ZbeNiB6lid0nVD2yz158XIvuKF7/vDSl
         txtRrmy6d81hMIZkZhZkSyuaI9JupZ9u8g6JNK80ULeQfcxJVibgle2dCiFabIPaHjWP
         dN5xpXmFb62wLz3SVVtCF5uVFtfPZCW1zrJdTrjdgBKy20Cbn7Jya4fhJB6PRtI+wneQ
         7abg==
X-Forwarded-Encrypted: i=1; AHgh+Rre7HrHzvFxyBjBwyKz5Q8vwOaUgeRdIxmfcn/ngdC8fYdobuM2D1RhHf6iSkGwepQk0WvYA53w/gkosF7Q@vger.kernel.org
X-Gm-Message-State: AFuF++k6FILzFNePkE5vSH+CkH/HQuyZpSK1Gww1oAFC7mCrWpfP44XB
	YMpV5futxYF0MFZFvCdklt8Bjf5zMExqVRUmA3mqEXQSaxINjQxrSo47gYKng5v1c8VtvRktuw/
	/+P6NPgaVdIXbMTGoZxpeNY6AN1QDdMo=
X-Gm-Gg: AR+sD12G8z0GksINP2NRJZl5+YskZPzVvWIosY76k6pBQ8APljwY7f6t2o2/1QnZCjC
	lii/8wRvoxo/mh+cWaE/S7lE2e+QFF6XU5aPnq/PnwNbq/jCbWZR5Ou3i86qUwN9F4bsK7iSd4P
	eQ7uvlALDJVGsuMNgQpyMv1Uxw/7OYXRbA95ofwXOQQAQQr4FIJZQE/KJx6fJ8ZN8Eu+IuO3JnL
	p0v/Pdi2fsYWNNgx6nkKvozAqszpfD2e9X720zQ4HFU7lfu/tkszjM46Dp+G8d87Ee4ADB4woEk
	C7Ak87jRVtViMvsZQmOyJNDnjYQruGo1zb+gkGAlKsv/t61wbe/2+K3g3w==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6402:1cc7:b0:6a3:849b:aa48 with SMTP id
 4fb4d7f45d1cf-6a4032b8158mr8565457a12.7.1787228792766; Thu, 20 Aug 2026
 05:26:32 -0700 (PDT)
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 08:26:31 -0400
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 08:26:31 -0400
In-Reply-To: <w7vte4itudtkw2yf4vbmuofiumfffmp2y52dpu2bqvqtdgjvpd@5femyiozss3e>
References: <20260725182628.221603-1-nsd.project.dev@gmail.com>
 <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com>
 <anlByPDZmvEhWeXI@casper.infradead.org> <ffcij36vnozf3rginqd2opd2dwqyki7xhtdo4veuty734hhgba@utjav2k263o6>
 <nsd.1787001235.35928@mail.gmail.com> <w7vte4itudtkw2yf4vbmuofiumfffmp2y52dpu2bqvqtdgjvpd@5femyiozss3e>
From: =?UTF-8?B?YXloYW4gYXlkxLFu?= <nsd.project.dev@gmail.com>
Date: Thu, 20 Aug 2026 08:26:31 -0400
X-Gm-Features: AcwNN1XrkA43dSJ3T3GbJGOoBaCnw6PG9YJBewyvsgjvqDFf-fdILOMtvA98jJU
Message-ID: <CAFLp9PGkVYZcQT5qAx-RKFOF-urZ92m417zpAeF7ZQempbS1HQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Neural Storage Driver - learning page cache prefetcher
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Honza, Hi Willy,

Thanks for the review and for the questions =E2=80=94 they pushed us to go =
back
and measure this properly. Since the last exchange we ran a full
window-size matrix with complete latency and overhead numbers, and it
answers directly what both of you asked. Let me start with the data.

These results come from our current in-development tree. We wanted to
share them with you before pushing anything, so the tree referenced in
the RFC (upstream-prep-v1, 2026-08-17) is still the earlier snapshot.
Since that snapshot we made three changes that led to these numbers:

  1. Jump handling =E2=80=94 when a prediction lands outside the kernel's
     readahead window we now always issue WILLNEED|NOREUSE explicitly,
     instead of leaving the strategy branch to decide.
  2. Kernel-window awareness =E2=80=94 when the kernel's own readahead wind=
ow
     is already >=3D 1MB the module detects this and completely silences
     itself (confirmed by its own counters), so it never competes with
     or disturbs a kernel window that is already sufficient.
  3. Full instrumentation =E2=80=94 per-run p50/p95/p99/p999 latency, per-p=
ass
     usr/sys CPU overhead, and disk-I/O accounting.

We'll push the updated tree to GitHub once this discussion settles.

Full metrics matrix =E2=80=94 methodology: interleaved ON/OFF on the same
machine, drop_caches before every run, 3 runs per configuration, 6.2 GB
SQLite database and an 8 GB sequential file. Disk I/O is byte-identical
between ON and OFF in all 96 runs =E2=80=94 NSD never issues extra I/O.

seq64 =E2=80=94 8 GB sequential file, 64k requests, n=3D131K/run:

  kb    | OFF avg  ON avg   diff  | p50 OFF->ON  | p99 OFF->ON   |
overhead (usr+sys)
  128   | 22.02s   17.11s   -22%  | 50->23 us     | 812->805 us   | 5.94->4=
.33s
  256   | 17.08s   17.22s   +1%   | 20->15 us     | 824->1129 us  | 4.07->4=
.13s
  512   | 16.81s   16.96s   +1%   | 16->14 us     | 1092->1903 us | 4.24->3=
.60s
  1024  | 17.25s   17.03s   -1%   | 15->16 us     | 1903->1883 us | 3.67->3=
.74s

SQLite Q2 full-table scan =E2=80=94 6.2 GB:

  kb    | OFF avg  ON avg   diff  | overhead (usr+sys)
  128   | 24.51s   20.48s   -16%  | +0.95s
  256   | 20.05s   16.60s   -17%  | +1.26s
  512   | 15.31s   12.18s   -20%  | +1.06s
  1024  | 12.22s   12.09s   -1%   | +0.26s

random4k =E2=80=94 100k random 4k requests:

  kb    | OFF avg  ON avg   diff  | p99
  128   | 25.0s    25.5s    +2%   | ~0.98ms
  256   | 26.9s    26.0s    -3%   | ~0.99ms
  512   | 25.7s    25.5s    -1%   | ~0.98ms
  1024  | 25.4s    24.7s    -3%   | ~0.99ms

random_repeat =E2=80=94 100k offsets x 3 passes, n=3D300K:

  kb    | OFF avg  ON avg   diff  | p99
  128   | 26.8s    25.1s    -6%   | 0.39ms
  256   | 25.1s    24.0s    -4%   | 0.38ms
  512   | 24.5s    24.4s    0%    | 0.37ms
  1024  | 25.0s    24.7s    -1%   | 0.39ms

Honza, you asked whether the difference goes away at 1M =E2=80=94 and yes, =
it
does, for both workloads. The 128k default is the dominant factor; at
1M the kernel alone already reaches this SSD's bandwidth ceiling, and
NSD recognises that and silences itself entirely at >=3D 1M windows.

But the 512k row is the one I'd really like your view on. The kernel
with a 512k window alone (15.31s) trails the kernel with 1M (12.22s)
by about 25%, yet NSD with a 512k window reaches 12.18s =E2=80=94 the same
throughput at half the window. Our block-layer traces show OFF@512k
keeps issuing ~512k requests, so the device is not the limit. It looks
like the kernel's window growth is capped at ra_pages, while the
fadvise-driven expansion NSD triggers is not =E2=80=94 which, incidentally,=
 is
why distros end up hand-tuning this value. Is that cap deliberate, for
latency or cache-pollution control, or is there room for the growth
policy to self-adapt?

Willy, on the architecture: hooking only vfs_read and skipping the
fault path was a deliberate choice to bound the first iteration, but
you're right that it's a gap =E2=80=94 filemap_fault bypasses vfs_read
entirely, so we're currently blind to mmap'd workloads. Hooking it
with the same fprobe is the next step. On replacing the PG_readahead
folio marking: the matrix above convinced us this is the right
direction. The kernel's growth policy, not the device, is the real
bottleneck at default settings, so we're moving toward a design that
manages ra_state directly and measures its own waste =E2=80=94 per-file
tracking of consumed versus expired prefetches with adaptive
aggressiveness, which is really just replacing the implicit
assumptions behind PG_readahead marking with explicit measurement.
Backward access patterns are already handled by the stride predictor
(negative deltas, forward/backward counted separately); a dedicated
backward-pattern benchmark will be added to the suite.

Two things we're still working on, for honesty: at 256-512k the
sequential p99 regresses (~0.8ms -> ~1.1ms and ~1.1ms -> ~1.9ms) as
the prefetch regions push the device queue =E2=80=94 the usage-tracking wor=
k
above targets exactly that. And the random_repeat gains (4-6% at
128-256k) suggest the predictor does help beyond what window size can
fix; p95 there improves from 296 to 243 us.

Questions we'd value your input on:
  1. Is fadvise-driven expansion beyond ra_pages acceptable as a
     mechanism, or should the growth policy itself change?
  2. What would a minimal integrated design look like =E2=80=94 replacing
     PG_readahead marking with direct ra_state control?
  3. If we iterate: fault path first, or usage-tracking first?

Per your suggestion, we'll cc the page cache maintainers from
MAINTAINERS on the next revision.

Best regards,
Ayhan
