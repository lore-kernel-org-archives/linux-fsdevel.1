Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08138480DCB
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328034; cv=pass; b=SHHig932IDYs/5OrNTB0A/lcZtRnlZ8VP5dJJ6SFE8xX6n+zfVlFOu577JuTFoeb5Roze1xBcxVgpoA3ioHbzF3eYv0sCAy3wjQE8b+pE/tDdvW6pPKEMhDKxckqc1q9P09NbXGyroDxkdw3/SwzMUx+sBiWOxSlHQUrnfjUZoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328034; c=relaxed/simple;
	bh=G8kFUhSD6mwmYZxeZbUQFBZz/9en6idDe5g+2iZdf30=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=C/i02UNXxJcKemtjn2YLJ2phEv0MpL7vJ7Ljgdz26qdUvXsE5fSPedp3SRquD3Tm6XrlANKGPa8WB6LzZ3RQ+JrVTwe9GWUXZPvZqcFHpNjC9jtZa4bilIP5DcKiYnecREUeABDiwG38rE0QTnz+j/3qGK4qrW30Cv5g26NAeew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc2KkTHy; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc2KkTHy"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso2967016e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 01:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783328021; cv=none;
        d=google.com; s=arc-20260327;
        b=EU02zz++QYTZFOqwGCaZ6pBSN+HTUasyvhj4oYVQct6Wts9lR0p9YgV/zabt/haDGs
         HkFuO0VYuWwbRviaZoypTah4tNT3kGjbte+MoK3xkm6v93sTD1KjapwXy3DIajUYBLiq
         SAF78X8R50/i8R24euo5LWMTP1YMnh1/qeR+6Q85b5znPht3VqyJFlwFzbxwEQWmxhrg
         guQYPRzRlwt1QDT/brVVVHI4XhbhwgMwCV4+LIsGxN3bcgNG3fB+al/LeWsQwZsgwraL
         fCdTf3LtvBxMPjMGlYSDIOtDe1VzosWFVfkd1O2cfzpzy1xmyOAHeH0H6u9PdVksPYIW
         uPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SMlqwe25h3RpyADH7goCEFp4DheUHmwSZ6Owz1SwkyM=;
        fh=unlXR7PTn7ECRD54vRJxylM6ytAMIPSVp+OBt9ana3A=;
        b=auXvkMaQ2fvaVhWqwtxeoMmuv18YVXFlKQApUFszBWqk9cvrWDoyMdQ3wu5Zr1CR3T
         q8xwirIgx4MXBJW+gRAtU7aSfaytjD16uD6ShI31YahNRczse+mxezD339Fwtq4LTPkB
         fPZztNVx51kIxnkPUFZow5dkLpvQHnHqap8JNqRf1G4D4YbX37RWAP62s66AsjWHyr0m
         RHaxKZl5aGUk6TINHkTZxJE31yXBi36wQmGTfdSRM+ZlbXxmPvjQfQr1UmpMubrysp0V
         d+B2vRmnSnI7CJ/umn5i6w+2TST6IRlx3KY2p+7vY91/NqYcnR7M3hvZ+fKss9P2fTzZ
         y6vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783328021; x=1783932821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SMlqwe25h3RpyADH7goCEFp4DheUHmwSZ6Owz1SwkyM=;
        b=fc2KkTHy3fD1zCegIx2An6xQKN8d2d0Ge8G5GOQprqjGSia1sU0g27nqddpixGOdZy
         U9kzzYKlqWf34A6DllJfL80/z+ljuKvXz5b2QT4lOyLjqX8uVAqLecdEcp/S/ksFiso/
         VOil2+Ze11cLV4oHfaMqVrEbqRVYmqi/Y6AQZSIv2gXldvjyQrCK3OXy3hQE2OQ04TjO
         vngk4PpNkPCERqz5MAHJ+cG3+vBKtUw80iCKt8ZnxeYh0ZzkEnUf8rzXZZfYL3cIa//U
         z/UJi4E9v0/RJcdO+/g1S2fwsTkopFiO723nsN+8Ue/N9lh94zQ475WCvj4MwCH4tR4L
         Gdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328021; x=1783932821;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMlqwe25h3RpyADH7goCEFp4DheUHmwSZ6Owz1SwkyM=;
        b=T/8oD6N9brMI3Wq41AbkhufBw2x69n4bQezWRgrMWtvLcOvW0J9o++Zlipt/IXsXe+
         IM5nSTczqX0tU+j897eaDgwxm/T2uEA3F5jFNb1QLBC3vMMzXmYtKXS4qqnintn9YcqB
         89bT6QWNqjjsU+8HITjRhgYyPZHkvET2YU3AU32xWx4/LSFgklElyE2/so59REZf6cbL
         WRk4WaeLZgHVGBw/2dZYsNyIQzj0/N1YoKYBhOK4A6bS4lZ3rSGXHwfK5Nf6WbHNdGLj
         NaGg+hHnYQ+2rAUx1l9x8Tx7Mk+ohXJymFBtzEKJafCgE3eWqPfBKS9V3Rqf+RXugVnf
         tvkA==
X-Forwarded-Encrypted: i=1; AHgh+RoIwBv0rKwwgpLAxF26wKLvmy9PD1JbacRywrkhtqsrkRcV140MXW3a4NngrUZztblBFMaE2HWNNxnUcc8c@vger.kernel.org
X-Gm-Message-State: AOJu0YziAfRcuMwQaGXnb+pZT/r8BRwkwNTXcV00XQR8PMifweHzxzdm
	5hYnzZjKga9v0MR7GBQ7FR1FAIx1dHY8LpsuJK5QkSk8yuVRsLHjQKt4GLEuRWFqDBDFJPqF62M
	G4+L9+0nxorjUHfgjz8NI6UlnVSEOxgk=
X-Gm-Gg: AfdE7cn09F4bwurggiqqcJTUwIV2IZa2LdjAIjYKbos0ctomnkClTCe6yOUeNGlrb5y
	3Ru+qBeqS9PB8v2vq9F8MFDepvezgb3azSfnL6+4tRqGfbvEcI/3SCLrDNQgEKsCBMZ1J8L28BG
	qb3nDlbE0FJlJomcnTuaypStrK9bJIxefdTwYBRn0UaCBCpdUBd+KajghL8QFw7abYAK/7RnIXE
	zFfUBrFHKx6EJNYVx8PeIb4q52LkhcwN6pdgVHegW1E21q1iMHl4f6gZhT8gwMwP4rPGXywcFq7
	eirZXC8=
X-Received: by 2002:a05:6512:3a93:b0:5ae:bce4:b696 with SMTP id
 2adb3069b0e04-5aed5096974mr1926455e87.15.1783328020196; Mon, 06 Jul 2026
 01:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chengfeng Lin <lin2530632123@gmail.com>
Date: Mon, 6 Jul 2026 16:53:28 +0800
X-Gm-Features: AVVi8Cc_OfaHslnZme8xzf47fmyoGRsBqHSwSB2ST9Aa0oZI50Fn18GQQCYwEb0
Message-ID: <CANGjgdm=gbQj=tmakUipHz9wR-mUvMVECfvJbTm=sEufxOe20g@mail.gmail.com>
Subject: [REGRESSION] tmpfs: flistxattr(fd) small-list slowdown after
 simple_xattrs rhashtable conversion
To: Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I found a small-list flistxattr(fd) slowdown on tmpfs while looking at FS
performance regressions.  This is a performance regression report.

The scope is intentionally narrow:

  tmpfs + user xattrs + flistxattr(fd) + small xattr lists

The cleanest reproducer creates a tmpfs file, sets one or more `user.*`
xattrs, and repeatedly measures:

  flistxattr(fd, list, list_size)

The single-xattr scenario checks that the returned list is non-empty; the
count-gradient scenario also checks the exact returned list length.

The bare-metal test machine is an x86-64 Intel Core i7-14700 system with 28
logical CPUs and 30 GiB RAM.  The benchmark was pinned to CPU 2, and the test
filesystem was tmpfs.

On bare metal, the parent/child A/B around:

  52b364fed6e1 shmem: adapt to rhashtable-based simple_xattrs with
lazy allocation

shows a clear jump.  The parent has the rhashtable infrastructure but tmpfs
still uses the old rbtree path.  The child switches tmpfs to the lazy
rhashtable-based simple_xattrs path.  I understand that the lazy allocation
part is meant to avoid per-inode rhashtable overhead for tmpfs inodes that do
not use xattrs; this report focuses on the small-list listxattr cost for tmpfs
inodes that already have user xattrs.

With one xattr, skipping the first round:

  kernel / state                         flistxattr_ns_per_op
  parent A, tmpfs old rbtree path         135.754
  child,  tmpfs lazy rhashtable path      229.663
  parent B, tmpfs old rbtree path         135.335

That is about +69.4% for the child vs the average of the two parent runs.
The two parent runs agree closely, and the skip-first-round ranges were:

  parent A: 134.451..140.153 ns/op
  child:   217.758..239.498 ns/op
  parent B: 134.273..138.098 ns/op

All of these runs reported `expected_match_ratio=100` and
`unexpected_results=0`.

This run used 15 rounds and 65536 iterations per target, pinned to one CPU.
The parent and child kernels were built with the same GCC 13.3 toolchain and
their `.config` files differ only in `CONFIG_LOCALVERSION`.
`CONFIG_TMPFS_XATTR` was enabled, `CONFIG_KASAN` was disabled, and the configs
had `CONFIG_DEBUG_KERNEL=y` / `CONFIG_SLUB_DEBUG=y`.

I also reran the same parent/child/parent A/B with `CONFIG_SLUB_DEBUG` and
`CONFIG_KASAN` disabled.  `CONFIG_DEBUG_KERNEL` remained enabled in this
config because it is selected by `CONFIG_EXPERT=y`, so I am not treating this
as a full `DEBUG_KERNEL=n` build.  In that matched production-like run,
skipping the first round:

  kernel / state                         flistxattr_ns_per_op
  parent A, tmpfs old rbtree path         148.536
  child,  tmpfs lazy rhashtable path      223.866
  parent B, tmpfs old rbtree path         149.178

So the child was still about +50.4% slower than the average of the two parent
runs (`223.866 ns/op` vs `148.857 ns/op`).  This is a smaller absolute delta
than the debug-config A/B, but it still shows the same direction after
removing the heavier SLUB/KASAN debug options.

I also ran a count gradient on the same parent/child pair:

  xattr_count   parent A ns/op   child ns/op   parent B ns/op   child vs avg
  1             156.102          242.886       156.872          +55.2%
  4             185.109          273.756       181.206          +49.5%
  16            312.894          378.211       315.962          +20.3%
  64            885.222          934.356       870.759          +6.4%

So this looks like a small-list fixed-cost regression rather than a claim that
rhashtable-based xattrs are slower for every workload or every list size.  As
the number of xattrs grows, the extra fixed cost is amortized by the list walk
itself.  These are tight-loop microbenchmark numbers, so the absolute per-op
cost is small; I am reporting it as a fixed-cost regression in this
enumeration path, not as measured impact on a specific application.  I am also
not claiming that setxattr/getxattr or non-tmpfs xattr workloads have the same
behavior.

Earlier attribution runs pointed in the same direction:

  - the signal narrowed to flistxattr(fd), not fsetxattr(fd) or fgetxattr(fd);
  - bpftrace layer timing did not point at security_inode_listxattr();
  - the growing part was around shmem_listxattr() / simple_xattr_list();
  - a diagnostic rbtree-backend probe recovered most of the old timing for this
    workload, although it changes the backend shape and is only attribution
    evidence.

I am not sending the diagnostic probe as a patch, because it is only
attribution evidence.  I wanted to ask whether this small-list tmpfs
flistxattr(fd) slowdown is expected/acceptable from the rhashtable conversion,
or whether a small-list fast path would be worth exploring without weakening
the original lazy-allocation goal.

Evidence bundle:

  https://github.com/lcf0399/linux-regression-evidence/tree/f0a07aa70b79219bd9f47f577357d673b3a06dae/tmpfs-flistxattr-small-list

Bare-metal summaries:

  https://github.com/lcf0399/linux-regression-evidence/tree/f0a07aa70b79219bd9f47f577357d673b3a06dae/tmpfs-flistxattr-small-list/bare-metal

Standalone reproducer:

  https://github.com/lcf0399/linux-regression-evidence/tree/f0a07aa70b79219bd9f47f577357d673b3a06dae/tmpfs-flistxattr-small-list/reproducer

Thanks,
Chengfeng
