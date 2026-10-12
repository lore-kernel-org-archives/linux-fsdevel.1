Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C2C1A6816;
	Mon, 12 Oct 2026 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791784866; cv=none; b=knaCutcQoJEo2ypCgGXNwVU5z48VYoKcVqOj1UZXc2d4Vn1stbkMFjB5At6aIK8uQRQ1t2oghpWjm/sLeekSCL4FVQ1PRjRQiHhbCea66XOaz30O6Hzg/GgOa1qBEW8g5pNm3VZfS02iJnh8Hft4Q9YgPcnYo8nzo80+BdPDVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791784866; c=relaxed/simple;
	bh=Hu7HCc4nHxJfT3bADEOIg4AOj3Wh2n5Q/pQ7V7jdDl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tfGd+eLHErQw0RWVKpk62wedC5CsdNG+CB5GC8dbdlGvt8hkqd+z/I5PI3wxFEYvnG9u+6L1lqto4KQQZmDNJDeD3FykIwcL6cc+NVIHLM9pKGpPNov9LRMDX5eRM/mtVKN3ntEdLavjfGiwkFxCWg1lozn9ojjt2hC2KLeeitc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=mYVmOme7; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=pqsuOgAL; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="mYVmOme7";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="pqsuOgAL"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id EF7AB26F7696;
	Mon, 12 Oct 2026 15:01:01 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1791784862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjSHdLmFsmJo8/craiiu5QNtg5PTDvzbzLLcu9AI6QM=;
	b=mYVmOme7ytkrK2LwNtDe6TFYy8KCuchKiQ6M7aO74aKCbHZc7pXdwxSUWNPQ7oDrO/tv6R
	vnGn+cjMpkkHVqoiUwD2Bfly//y2fQKYnQgR/QyJ65qb3Ycw167QJ35uAWOXhM+v8dp0CA
	Lr9H9FBNFxnYmXqfvADv2p0X9vPCe4KkOHtCIxNTYVbGi/2eA7j27xovSMQJoRpAzEEVQP
	5yYV/fy/KLG/nUx55ksE/jtB4oeuMr2GkWiu/Xc7pVMLQ2Bf+9LYSewYqslC/qClyDegEV
	uTC7A5doyysv5QNp5k3gftgcoGHBjI/0aSrCW8dOBxNDvfP1BP2JcEvV5ruvNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1791784862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjSHdLmFsmJo8/craiiu5QNtg5PTDvzbzLLcu9AI6QM=;
	b=pqsuOgAL3M8eejQn7e+uiWai8zpq94mxuYDEqTMFhXUxFyU2Y6ZaM62U5/qCe/+1ZrDIAQ
	K6rGF+SbAtt5efAA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 56D3FE00070;
	Mon, 12 Oct 2026 15:01:01 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 47EB422000BB; Mon, 12 Oct 2026 15:01:01 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] fat: allocate multiple clusters in fallocate
In-Reply-To: <3b0bef1504539358bf049724329ced57@inf.ufrgs.br>
References: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
	<874iesm5hu.fsf@mail.parknet.co.jp>
	<3b0bef1504539358bf049724329ced57@inf.ufrgs.br>
Date: Mon, 12 Oct 2026 15:01:01 +0900
Message-ID: <87se2blaoy.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> Em 2026-10-11 15:55, OGAWA Hirofumi escreveu:
>> Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
>> 
>>> Hi,
>
>>> This series adds support for allocating multiple clusters in a single
>>> fat_add_clusters() call in fat_fallocate().
>
>>> The multi-cluster TODO in inode.c is not implemented, as doing so would
>>> require speculative preallocation or an iomap conversion.
>
>> Is this to improve the performance of fallocate? If so, what the number
>> by improved bench or such?
>
> Yes, it is. I ran a few benchmarks. Each run used a freshly formatted
> filesystem, with no userspace processes other than init (which is the
> benchmark program in this case).
>
> The numbers below are the arithmetic mean of the samples, with
> improvement calculated as before / after. The times are for the complete
> loop and not an individual fallocate() call.
>
> The benchmarks were run under QEMU/KVM with a virtio-blk device using
> cache=none.
>
> start = now_ns();
> for (unsigned int i = 0; i < count; i++)
>      fallocate(fds[i], FALLOC_FL_KEEP_SIZE, 0, bytes);
> elapsed = now_ns() - start;
>
> FAT32 with 512-byte clusters using count=16 files:
> length    mounted sync?    before    after    improvement    samples
> 256MiB    no               2.328s    0.175s   13.2x          10
> 16MiB     no               149.659ms 14.036ms 10.7x          10
> 16MiB     yes              747.993s  3.445s   217.1x         3*
> 1MiB      yes              46.63s    0.333s   140.1x         10
>
> FAT32 with 512-byte clusters using count=128 files:
> length    mounted sync?    before    after    improvement    samples
> 1MiB      no               90.873ms  4.686ms  19.4x          10
> 16KiB     no               1.287ms   0.241ms  5.3x           10
> 128KiB    yes              47.284s   0.350s   135x           10
> 4KiB      yes              1.98s     0.144s   13.7x          10
>
> FAT32 with 4096-byte clusters using count=16 files:
> length    mounted sync?    before    after    improvement    samples
> 256MiB    no               295.392ms 24.733ms 11.9x          10
> 16MiB     no               20.509ms  1.404ms  14.6x          10
> 16MiB     yes              92.489s   0.348s   265.4x         10
> 1MiB      yes              5.837s    0.048s   121.3x         10
>
> * it would take a lot of time to take 10 samples like the others,
>    so I only took 3 here.
>
> The improvement is large because the old fallocate path allocates one
> cluster at a time, while the new path can allocate an entire chain in
> one call. This is especially visible on synchronous mounts, where the
> new code can batch FAT updates instead of synchronously handling each
> cluster allocation separately.

Thank you. Please add it to the commit log too.

> Thanks,
> Matheus
>
>>> Matheus Alves de Almeida (4):
>>>  fat: remove cluster allocation size limit
>>>  fat: return only first cluster when allocating
>>>  fat: support adding multiple clusters
>>>  fat: allocate multiple clusters in fallocate
>>> 
>>> fs/fat/dir.c    | 20 +++++++++++++++-
>>> fs/fat/fat.h    |  4 ++--
>>> fs/fat/fatent.c | 61 ++++++++++++++++++++++++++++++++-----------------
>>> fs/fat/file.c   | 10 ++++----
>>> fs/fat/inode.c  |  8 +++----
>>> 5 files changed, 69 insertions(+), 34 deletions(-)
>

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
