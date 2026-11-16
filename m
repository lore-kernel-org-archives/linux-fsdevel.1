Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794803610;
	b=oiWqBUGDyfkWcwraOEJQpW14rFLd78vrTT+fh4caUwY8HLY4EN71VGYWBk2Wj552vtvC
	 Tjy1qBGkr2ZlagN+ZFu2IF1LmFBxiT9LXsfMcMGF4T0a5ZNqzdvGUZVZKB3c1d0bwpmJV
	 U6ipnj0sNB4aj/U1zY2tK9ATeBlLmoWk9iwrKrxBdAHSVfq4KEXiSwPPDnKkpvXQAmNdF
	 CaPgGGUC7DJ7qMXCChWGZTOfKuJMTGJ/rp1unXoUfPHF9jDX9XedSRYBp+YhzEwnfhR9w
	 M3O4yZ4v/uCu/x55V54eW4rlBoZ6ps2aVUavDdbPq9+MtymiFfLMoc/Gj87VJCcuqkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803610;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z3LalrofPDIIeLTWNYB/CEjeg90a8F55VBmkKs/2tdA=;
	b=hMTBGOn7RRNCOEhn+cjXfVW5vTxCruEXVosBKNh4yZj9H6H49RkP5jaGcNNBWZHzW/DO
	 5zQriUy8zV98peCPEehFdcCN0MnxszFEm/ZvZxTToFhf4T3bVPaky/WJ0DU0wr0zdIGC1
	 TfqhwhHH8SpySL6D+ITLxUaiz4BbqojDeQb3+fdZwIAIoC+Hmtmbtaij2PEr726RUmhuT
	 T64ieZMSWBO0V711zlT9Z7SkkwCm71cIeNUhvzOxis9y2LRnvycBltlCkPbJbA00fkAP+
	 eTVfEp/OslO/7Oq1x2OoSVcNdUxYCdiuO1CocyxD0TeN1yL+18igVZGCEnf5E0QSplA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=sqBi3acz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4EA606A31F;
	Mon, 16 Nov 2026 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=sqBi3acz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2781F000C4;
	Mon, 16 Nov 2026 04:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794803609;
	bh=Z3LalrofPDIIeLTWNYB/CEjeg90a8F55VBmkKs/2tdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=sqBi3aczOohYNZ2MSlWIKayDu5xpw0W3F7wwOlDpL2OK0VT5465nvxRWt3IMBF9Pw
	 7j+GMTaBKKub8rE8LhwYRwuwrJ8BlH7UbNjNgkzn8D1MNRpGAjV93+RHJ69Na3BK+1
	 89PJisfvxODwTNxETHKr/w/nSp/ksk9oTaVyf6EQ=
Date: Sun, 15 Nov 2026 20:33:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara
 <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: look two windows ahead for the hole on a
 marker hit
Message-Id: <20261115203328.f98ce9a068849c2f2fb32a41@linux-foundation.org>
In-Reply-To: <20261022-bug-mm-readahead-async-overtaken-v1-1-c05b8d8bd2da@gmail.com>
References: <20261022-bug-mm-readahead-async-overtaken-v1-1-c05b8d8bd2da@gmail.com>
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

On Thu, 22 Oct 2026 23:24:33 +0800 Qiliang Yuan <odys.yuan@gmail.com> wrote:

> When a reader hits a folio marked for readahead that the readahead
> state does not expect, page_cache_async_ra() starts the next readahead
> at the first hole within one window after the folio. If that window is
> fully cached, it reads nothing.
> 
> memcpy() in glibc loads the end of a large source before copying it
> forward, so a loader that copies a file mapping out in pieces of a few
> megabytes faults at the end of each piece first. mmap read-around then
> reads a window centered on that fault, which reaches more than one
> window past the readahead marker the copy has yet to hit. When the copy
> reaches the marker, there is no hole within a window, no readahead is
> issued, and the next piece faults on its end again. Every piece then
> gets a synchronous read-around of order-0 folios, and threads copying
> parts of one file also contend on the i_pages lock to insert them. A
> copy from offset 0 avoids this as its first read-around is clamped to
> the start of the file.
> 
> Look up to two windows ahead for the hole, which reaches past such a
> read-around, so the reader keeps an asynchronous window and its folio
> order keeps ramping up.
> 
> Copying a 16 GiB file out of a private mapping with memcpy() in 8 MiB
> pieces, read_ahead_kb 8192, cold page cache, 32 vCPU VM, mean of two
> runs:
> 
>                                   before    after
>   1 thread from offset 2 GiB     7.62 s    2.00 s
>   8 threads, one range each      3.26 s    1.08 s
>   32 threads, one range each     4.05 s    1.34 s
> 
> Random touches read the same amount, and pread() copies and copies that
> interleave 7 MiB chunks across threads take the same time within
> run-to-run noise.

OK, thanks, nice numbers but there are complications.

Readahead is all about contiguously batching physical IO.  So it
matters whether the device is SSD, NVME, spinning FeO2, SATA, IDE, etc.

And you have QEMU in the way, so reads can get served from host
pagecache (depends on QEMU setup), which also matters.

So I just don't know what to conclude from your numbers.  I *suspect*
the gains are from reduced CPU & memory-access times which is of course
good.  But was there any actual physical device access involved?  This
would probably make the before-and-after numbers even more impressive!


I tested the patch on my LLM-driven test setup, which is similar to
yours.  The results are...  ambivalent.  The things which you want
faster are indeed faster, but other things slowed down (wall of words
appended).

The slowdowns happened because the present code misses the gap beyond
mmap read-around, so each 8 MiB memcpy hunk can need another
synchronous read.  The post-patch code finds that gap and keeps
readahead going.  I measured both costs: a full second window added
about 8 us to the access, while a gap there caused 512 MiB of unused
reads across 64 accesses.


: I tested the patch against the unpatched kernel with matching
: configurations. Both booted a 32-vCPU, two-node, 24 GiB VM. The test
: used a fully written 16 GiB ext4 file on the same raw scratch disk,
: with guest read_ahead_kb set to 8192.
: 
: I ran the author's private-mmap test, copying the file with memcpy()
: in 8 MiB pieces. Before each timed run, the previous process had
: exited, I dropped the guest file cache, and mincore() confirmed that
: none of the tested file pages were resident. Medians of three runs:
: 
:                          unpatched    patched
:   1 reader, from 2 GiB      6.87 s      2.12 s
:   8 readers                 2.18 s      0.70 s
:   32 readers                1.98 s      0.76 s
: 
: Every paired run improved. Buffered pread() and 7 MiB interleaved
: copies changed little. A shuffled mmap copy was about 1.3 times
: faster with the patch in two paired runs.
: 
: I also tested the cost of looking farther ahead. The kernel marks a
: cached page so that accessing it can start the next readahead. I
: timed the test process accessing that page at 64 separate locations.
: When both upcoming 8 MiB windows were already cached, the median
: access time rose from 20 to 28 microseconds. When the first window
: was cached and the second was empty, the patch read about 512 MiB
: across those locations that the test deliberately never used. The
: median access time rose from 17 to 470 microseconds.
: 
: A memory-limited run had more memory-limit events with the patch,
: but did not establish a repeatable slowdown for a competing reader.
: 
: The guest file cache was cold, but QEMU's host cache was warm; host
: NVMe read sectors did not increase during the main runs. These
: measurements show the effect on guest readahead, not cold-drive
: throughput.

