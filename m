Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646956;
	b=GN9EOudwMApcJRS6Sa4gpSCmfr2ofZkSaKkHTQR8ioVoGDYo1bSJUAs+kGXKgttisY+j
	 REBk3aAPZdWbGvfbnSGzxti4NYsA13YDJbUbneYvxo3byw9wgaPBMsYiXYwU4W8vIN9At
	 30bbNuICWwf7lxNLFq954o05w5UeXU8Ruxz23g5gmVW8K0ou9DWoe5b8m0FJzkWRkyv/K
	 lSNAthT4CRMzF9fi/MhJ1dzFDC/KjtphbI9OAGgcjGQ4zfQXVj65nCUMeMH4umEhMN6OQ
	 7uheBi4O2y9UR1NtgISFAwpWq4zbFS3iFc4asWud8k5ZgptjIZJjgfA6VKzhDk9DiEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646956;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PcbHN39bNWWbkdcjeJxDmeD0qc1zW2q+oJX1vCZ0XVI=;
	b=0ImarpoBpZVyIlZlVKoZVzINdHN15g8pNertIjOMmJyduXNY7LXL3XkknFTqX1KOUMtL
	 NakEAKGNJe+kckXsSZDG9+Jq64W19mMcO482Swsz1FD03tGoJ5OhVbTwLWXHEO/HHoYkJ
	 R5/BupI8LaDB4Xf3BWxgzR2hFovZz8lBlIIXmVIfZfPYRbbsbxIffjWdUzTvZ1lDIntGG
	 BV0lRqjA64jkil67YeXn++/O2GqwPuDXVs/bbEz8tgWs2NwMRUapOd40HFExgwQNA8l+d
	 WmmueEcmr/+1a6nGFoL3uA5gThf6qDhkyK+y14e/FRx7Sjx8AxoHlM5DOwhasD+gZrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=p4EEjsWU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C91606A324;
	Mon,  2 Nov 2026 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=p4EEjsWU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBA91F00A16;
	Mon,  2 Nov 2026 19:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793646955;
	bh=PcbHN39bNWWbkdcjeJxDmeD0qc1zW2q+oJX1vCZ0XVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=p4EEjsWUt3MhEpUIjyLqzo7WSphxnduiMFMxPf2nUtQftKt6+8J2muQ+NicZohSCO
	 F7rbgElz8NIWQMbuaBTSQHD/+sq7+IXuDa1D72zQJ4SAXGDcu5zQqO0OPtSvf/5kMw
	 DCvQui3dtzvkQFZhE9fFZkIbsc3sqjkQRUJVSAZ4=
Date: Mon, 2 Nov 2026 11:15:54 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: daejun7.park@samsung.com
Cc: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: keep at least half of the async window
 when aligning it
Message-Id: <20261102111554.535bd2c6d0520877ea3342bb@linux-foundation.org>
In-Reply-To: <20261030-mm-readahead-async-align-v1-1-109dea6851fc@samsung.com>
References: <20261030-mm-readahead-async-align-v1-1-109dea6851fc@samsung.com>
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

On Fri, 30 Oct 2026 12:52:57 +0900 Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org> wrote:

> From: Daejun Park <daejun7.park@samsung.com>
> 
> page_cache_async_ra() trims the end of each new window to a multiple of
> 1 << ra->order pages. A window that starts just below such a boundary
> keeps only a few pages. With read_ahead_kb=128 and max_sectors_kb=512,
> 1 MiB reads after a 4 KiB read at offset 0 hit this on about one window
> in three. They issue three times as many device reads.
> 
> Halve the alignment until the trim keeps at least half of the window.
> 

Thanks, but...

> ---
> Tested on mm-new in a QEMU guest with XFS on an emulated NVMe,
> read_ahead_kb 128 and a cold cache.
> 
> - max_sectors_kb 512, median of 5 runs: reading a 512 MiB file this
>   way takes 0.247 s before and 0.180 s after. The device sees 3329 and
>   1032 reads.
> 
> - Other reads with max_sectors_kb 512: without the 4 KiB read, and with
>   64 KiB reads, the times do not change. Random 4 KiB and 64 KiB reads,
>   two interleaved streams on one file, and 2 MiB reads at random
>   offsets also take the same time. They read the same amount from the
>   device, within 0.3%.
> 
> With the device's transfer limit at 2 MiB:
> 
> - max_sectors_kb 256: 512 KiB reads after the 4 KiB read take 0.626 s
>   before and 0.322 s after. The device sees 6147 and 2056 reads.
> 
> - max_sectors_kb 1024 or 2048: 1 MiB reads are not trimmed.
> 
> - max_sectors_kb 2048, 3 MiB reads: the device sees 343 instead of 271
>   reads. The time is 0.120 s instead of 0.118 s, the median of 40 runs.
>   The interquartile range is about 0.10 to 0.13 s for both. The window
>   stays at 3/4 of the maximum, off the 2 MiB boundary. mm-new reaches
>   that boundary by trimming deeply.

The whole objective of the patch is "speed things up".  So a description
of how much the patch sped things up is essential changelog material!

IOW, please summarize it heavily and include the performance testing
results in the actual changelog.  Low-level testing details can be
retained below the ---.

