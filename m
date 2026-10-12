Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12043AD507;
	Mon, 12 Oct 2026 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783840; cv=none; b=Z1hqjTeI9wT9pTpevbGlSZceI3/Qm+D318kl6tjzikqggo9ju8bCLYvb8ri50gqJajUuiOyX+r7Hl6I//HkjB7/MsB3SggKp40swL4kog6JXrU4SbHlAaRikPcnFGgbzmp5FHuBy30veLgLtILQuiwPuIIFDKNcdft1uB/dv5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783840; c=relaxed/simple;
	bh=D8XF8NrMW2gK0eTke1CnLPaendq4DLcgKIBB+Jm/3ds=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=IMJydpl+d9JLB0oGGv17zsPYSRIO5xyN3KulJsAdv/A5q2rF+l3sZdXZzw3r/BXO+nVYX35LBiQ/YWO0vQVsGjYHvl6Dzmn17Epj9Nqglns8lc9N5YxjlW3iyri+sQ+M8Zb/5qKtJcjVscPKfpSJ/W6TZdjl1zazvV4/DGlgXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=kqCs2OjZ; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="kqCs2OjZ"
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 8EE01121113;
	Mon, 12 Oct 2026 02:43:46 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791783826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vg86jNz1esPLXPOWct4bvk16TgMkacXdiKmrusySEvk=;
	b=kqCs2OjZ1OXJc7PzQCvTJl4JvFuZ3CQlLFqTkWZ0Ipk0UrKoeOElx5naeRwnA7f3PdCq6i
	huZJo7moHId3qImeIf/Xtrc/OQVLlStoWDZdZHSk5LpqGJzKo2/amQ+ZOqhbTJZ3hgOs19
	Esl60MEsI9FETka5FSud8ez29c0ZWdEuQPl3u4QUbahb40vLhfV/VOIKHFMzcjUm6WDTE0
	vyTls5TdRxYLNhFrEALbRTkfLXLcEGZ33k07jRjru/NWIYtjcqeSTobGIU968d3WYIMfe3
	jh8tpT/ih4s1uPOdK7SUttyDUw+pm+L8LnXSwGk0zxq/MMjM16scVgA6e3aBgg==
Received: from bd06e904.virtua.com.br ([189.6.233.4])
 by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Mon, 12 Oct 2026 02:43:46 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Oct 2026 02:43:46 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] fat: allocate multiple clusters in fallocate
In-Reply-To: <874iesm5hu.fsf@mail.parknet.co.jp>
References: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
 <874iesm5hu.fsf@mail.parknet.co.jp>
Message-ID: <3b0bef1504539358bf049724329ced57@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5

Em 2026-10-11 15:55, OGAWA Hirofumi escreveu:
> Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:
> 
>> Hi,

>> This series adds support for allocating multiple clusters in a single
>> fat_add_clusters() call in fat_fallocate().

>> The multi-cluster TODO in inode.c is not implemented, as doing so would
>> require speculative preallocation or an iomap conversion.

> Is this to improve the performance of fallocate? If so, what the number
> by improved bench or such?

Yes, it is. I ran a few benchmarks. Each run used a freshly formatted
filesystem, with no userspace processes other than init (which is the
benchmark program in this case).

The numbers below are the arithmetic mean of the samples, with
improvement calculated as before / after. The times are for the complete
loop and not an individual fallocate() call.

The benchmarks were run under QEMU/KVM with a virtio-blk device using
cache=none.

start = now_ns();
for (unsigned int i = 0; i < count; i++)
     fallocate(fds[i], FALLOC_FL_KEEP_SIZE, 0, bytes);
elapsed = now_ns() - start;

FAT32 with 512-byte clusters using count=16 files:
length    mounted sync?    before    after    improvement    samples
256MiB    no               2.328s    0.175s   13.2x          10
16MiB     no               149.659ms 14.036ms 10.7x          10
16MiB     yes              747.993s  3.445s   217.1x         3*
1MiB      yes              46.63s    0.333s   140.1x         10

FAT32 with 512-byte clusters using count=128 files:
length    mounted sync?    before    after    improvement    samples
1MiB      no               90.873ms  4.686ms  19.4x          10
16KiB     no               1.287ms   0.241ms  5.3x           10
128KiB    yes              47.284s   0.350s   135x           10
4KiB      yes              1.98s     0.144s   13.7x          10

FAT32 with 4096-byte clusters using count=16 files:
length    mounted sync?    before    after    improvement    samples
256MiB    no               295.392ms 24.733ms 11.9x          10
16MiB     no               20.509ms  1.404ms  14.6x          10
16MiB     yes              92.489s   0.348s   265.4x         10
1MiB      yes              5.837s    0.048s   121.3x         10

* it would take a lot of time to take 10 samples like the others,
   so I only took 3 here.

The improvement is large because the old fallocate path allocates one
cluster at a time, while the new path can allocate an entire chain in
one call. This is especially visible on synchronous mounts, where the
new code can batch FAT updates instead of synchronously handling each
cluster allocation separately.

Thanks,
Matheus

>> Matheus Alves de Almeida (4):
>>  fat: remove cluster allocation size limit
>>  fat: return only first cluster when allocating
>>  fat: support adding multiple clusters
>>  fat: allocate multiple clusters in fallocate
>> 
>> fs/fat/dir.c    | 20 +++++++++++++++-
>> fs/fat/fat.h    |  4 ++--
>> fs/fat/fatent.c | 61 ++++++++++++++++++++++++++++++++-----------------
>> fs/fat/file.c   | 10 ++++----
>> fs/fat/inode.c  |  8 +++----
>> 5 files changed, 69 insertions(+), 34 deletions(-)
