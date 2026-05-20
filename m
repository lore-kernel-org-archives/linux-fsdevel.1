Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E53C364EB0;
	Wed, 20 May 2026 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296957; cv=none; b=XrUeXMAnFFaPbVfU0xn0F+Rl1Pg5SrLmQtPBTLUb4tkxOOSCg2Z05vavQkaMnV889wbsH7P2r++HR+M899aUE6hsr1qvdP/OECI1FATwRmE6zHDpeTTWxPk8bBcvNARTt09xT9lYEc768iDPwFSdq2w3eQwBjBXgo8+FBPRaExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296957; c=relaxed/simple;
	bh=gtls1X2Rs9kKonLOXi9NdQFIdY9my6iOmOGcZmJtvA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKgevMn+8DZVV/Sf/ehdro2yyj4s7FcyTNyq+v59GfA0DuxZmskZHm/XK4jJ0U88Dk1c8jcwfR43l2S7nhWrEVVLn9b0ajBSVwHRXAZFJd26QuHq/oexLD5rGhKM9NCwbOohK40e5Nq1UXuSVkHrDI+uZS3k2Eul2KV3qh24Bcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gu/wDQDQ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gu/wDQDQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nMieEGrEA39u1aFDAtD9lpPrEieW9TGT3AQb5KNw4rs=; b=gu/wDQDQVoTSB4Xvxdhbs9Du75
	6Q4uxTURqnnkanXxB6hxBKxdAMu0dbpYUy6AHl43/ZDtGEA8VocNMFeFhRwZu151GWN1oqYoOnGiV
	dzcPTAVwbFnytYyMhzdyMC40ZTcn37sUcbyWPxg1vfzVVlJidbneZl0J6DDZ21fzB0cBp+tg1hjLt
	smEqvpu1B4VMXXuGqccBOPLfPrTknzcFeNXpN1VRwsf2laGjZNKz0CuY6QO4PwL3eY5ir2q7WnM1d
	aysNaxUZaDzpRaw3Kap4hZOaJRmWTFL3JLdCg6Js9xa4riwcprZARAgn0vHaHiMiT8tYiCwq2enRd
	qExNKXWw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPkPo-003FzR-1k;
	Wed, 20 May 2026 17:09:04 +0000
Date: Wed, 20 May 2026 10:09:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	usama.arif@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 1/2] fs/pipe: bulk pre-allocate pages outside pipe->mutex
 in anon_pipe_write
Message-ID: <ag3Ty3T24wjn1aFw@gmail.com>
References: <20260515-fix_pipe-v1-0-b14c840c7555@debian.org>
 <20260515-fix_pipe-v1-1-b14c840c7555@debian.org>
 <q37bmptbjr2gysl2g67bqo5axxqor4lsrrnf7ajixxjdrumbup@tgu3kz6kien5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q37bmptbjr2gysl2g67bqo5axxqor4lsrrnf7ajixxjdrumbup@tgu3kz6kien5>
X-Debian-User: leitao


Hello Mateusz,

Thanks for the careful review. Let me address the points inline,
with data I collected on three Meta production hosts: two aarch64 NVIDIA Grace
and one x86_64 Bergamo / EPYC 9D64, using bpftrace and perf lock contention.

On Fri, May 15, 2026 at 10:18:19PM +0200, Mateusz Guzik wrote:
> This change is quite a hammer.

Are you seeing any downside/trade-off with this current approach?

>
> Do you have a real workload where there are multiple processes issuing
> large ops to the same pipe on both reader and writer side?
>
> The only workload I'm aware of sharing the pipe between more than just
> one reader and one writer is anything with make, but that is mostly
> operating on 1-byte ops.

You're right -- most pipe writes really are tiny. On Bergamo, 120s sample of
anon_pipe_write, 299629 calls bucketed by iov_iter_count(from):

    size                writes      %
    <128 B              293602    98.0    (merge path, no alloc)
    128 B - 4 KB          1108     0.4
    4 - 8 KB              2149     0.72   <-- patch start helps from here
    8 - 16 KB                3
    16 - 32 KB               0
    32 - 64 KB               5
    64 - 128 KB              2            <-- up to 72KB writes

So only ~0.72% of writes are >= PAGE_SIZE. The dominant comm by
contention count is a Meta fleet workload spraying sub-128-byte
metric strings -- it does *zero* writes >= PAGE_SIZE itself; it
just hits the mutex very often.

But the writers that *do* take the alloc-under-mutex path are
real. Lock-wait data confirms it shows up:

  perf lock contention -ab (30s, anon_pipe_* only):

                                contentions  total wait  max wait
    arm64 (NVIDIA Grace)
      anon_pipe_write                 7660    4.39 ms     50 us
      anon_pipe_read                     7   55.78 us     17 us
    x86_64 (Bergamo)
      anon_pipe_write                 3154    4.53 ms     79 us
      anon_pipe_read                   817    1.72 ms     82 us

The reader side stands out on x86 (817 vs ~7 on arm64) -- that's
the symptom the patch targets: a multi-page writer holding
pipe->mutex across alloc_page() stalls the concurrent reader on
the same mutex.

  bpftrace, mutex_lock duration inside anon_pipe_write, 300s:

                  Grace-A  Grace-B  Bergamo
    [4K,  8K)      1090     2799      980
    [8K, 16K)      1785     1353      953
    [16K,32K)       755      623      530
    [32K,64K)       153      172      184
    [64K,128K)       13        8       59
    [128K,256K)      -         -        4
    [256K,512K)      -         -        1    <-- ~500us blocked

So the patch's value is shortening the long critical sections that
the 99% of small writers are blocked on -- the contention everyone
sees drops because the few multi-page writers do their alloc work
outside the lock.

>= 64KB, which are not common but existent.

> I'm asking because this would be better implemented taking into account
> how many pages are hanging out in the tmp_page array. With only one
> writer and one reader there is no concern someone will steal the pages.
>
> Preferably the tmp_page array would grow to accomodate more memory, but
> admittedly this runs into a problem where a pipe can linger unused
> indefinitely while hoarding several pages. As in, some shrinking
> mechanism would be needed so that's probably a no-go and preallocation
> is the way to go for now.
>
> Even then, this can definitely be integrated much better instead of
> being open-coded.

> This is some nasty golfing.
>
> Instead, you could have something like:
> struct tmp_page_prealloc {
> 	struct page *pages;
> 	unsigned int count;
> };

Agreed -- v2 will wrap the array+counter in
struct tmp_page_prealloc and drop the open-coded indexing.

> 	struct tmp_page_prealloc tpp = {};
> [...]
> This should move to a dedicated routine, perhaps:
> 	anon_get_page_prealloc(pipe, &tmp_page_prealloc);
>
> then it can also easily decide how much to prealloc based on existing
> state

Yes. v2 will have anon_get_page_prealloc(pipe, &tpp) doing both:
top up to PIPE_PREALLOC_MAX based on tmp_page[] occupancy, and
keep the policy in one place.

> > +	while (prealloc_n)
> > +		anon_pipe_put_page(pipe, prealloc[--prealloc_n]);
>
> this results in put_page() calls under the mutex, still extending the hold time
>
> you could split this into 2 ops, for example:
> +	anon_pipe_cache_pages(pipe, &tmp_page_prealloc);
>   	if (pipe_is_full(pipe))
>   		wake_next_writer = false;
>   	mutex_unlock(&pipe->mutex);
> +	anon_pipe_free_pages(pipe, &tmp_page_prealloc);

Well spotted!


> All that aside, I have no idea about performance impact on arm64, but
> there is *definitely* some throughput lost based on the fact that memory
> copy is restarted per page. I presume arm64 has an equivalent of amd64's
> SMAP which again will not be free and is paid for every time as well.

Can you say a bit more about what you'd want to see here? I want to make sure
I'm reading the suggestion the same way you are.

My understanding: anon_pipe_write loops once per page calling
copy_page_from_iter(), and each call re-enters the iov_iter
machinery and pays a STAC/CLAC pair on x86 (PAN toggle on arm64).

So an N-page write pays the user-access bracket N times instead of
once, on top of resetting the per-page memcpy and losing the
hardware prefetch streak.

The way I see it, is opening a single user_read_access_begin() region around
the page loop and use unsafe_copy_from_user() inside, with a labeled
fault-fallback path that closes the region and finishes via the slow path.

Is this what you meant?

Really thanks for your review,
--breno
