Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3D12FFFB8
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374052; cv=none; b=nux7n+QGzonQ+F1i7GJ904P96/UwyMrcsDjpXzC7JOuB065qRot1rsemthP1obyc/Tf1SzO3x9PLxhET1F+Jgvf+/U5NoIYELD8Bbrb32v4AjLWcPgVtWLaQ5XeUlvI33fcGk1rD84rRSeEWwlv18+1F50A/mvAh/YvS2Yqcf4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374052; c=relaxed/simple;
	bh=NHtXmq+Yp7hw9xcdbgPar8IwQrssdvVxj4dvilcnEc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1jHy75HPB6bFwHGytZA7PxULjHoc1zopXz9Dlm1DsLUqEUDU1DMoxKNi4AHdSsi0cI3oMhfT0FxkSYNlQTJMqHXJbMXZonQWg33uJu9IscPLRXtVMCMFgcAoGdVHviRBjE4fPCCo9z3p+2WmAdskoDoozmxJ+jC7XXb0khzpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=S/Dm9jfq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CoiZ8OPA; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="S/Dm9jfq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CoiZ8OPA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 41EF67A0148;
	Tue, 24 Mar 2026 13:40:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 13:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774374050;
	 x=1774460450; bh=kAucLmWlY4/dabtgjeZxI2DdtOG7QjFYfId14QdM1Q8=; b=
	S/Dm9jfqdcAsbFIsFBP31hNqlLtD56TN5yGgnLU0DAE2iZDH/mND2TxurD/7ZZJh
	XLLgYXsgWbiwQ3u5dTdnLHUC/8mQ1SlpWnZFAv2iy1jxZnS/rt1Wy4hixLW2ZfpE
	QhOk9xOzYHfKl6r7Ao8dZ3HOtO1poWrr39adCH+Y940jvf8XDfHdgwjj1cWJfUca
	0TH7ljsU1JwP+D+POp93TdHIzjztHDaBkFcLUhN5szC/v9rk98h+0j2SDb+G498o
	mhPs8/u4OM8Jy7FsPhdxa6ZdFCqe5yOjym/3uFyIFoE5GMY78wC4kBZDlDj8SKR9
	K4KD0/Bf5rBmcSeWSP6MIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774374050; x=
	1774460450; bh=kAucLmWlY4/dabtgjeZxI2DdtOG7QjFYfId14QdM1Q8=; b=C
	oiZ8OPAiq+jlc74+vT4eHRb2D5WF83r/KLG6yzk0v3YyZe48UxDDiOYX97icvvTc
	vBtfO5m7IycgiFodNQl6Cm9luA43Yc423S4Z68A5zdEfQ5wq6wfCu9EiMp6QcxsH
	2+azXm+d0vl3N19UkjFM+0wsgpP5cKL4LKaCfSiW30rB6bUFKky74YQqTh4vcGMO
	/Hm/2V7ynnKnXuUSNj2zrwHZjCmAhaupOSdlD6lOwWvSZ8uz+qq+k8foJHrn/9h9
	XLw/6uVvX5lvp8zSPUW61KAM0sXh1zAx5M6eSNTkuvp5Drd4ryq9KLHn27qK2p33
	368NlRGUUsw36raPkF1Eg==
X-ME-Sender: <xms:oczCaXDD0Lf_sX0pC26OvGYdLsTiHGTgkRY5PxHe93VCD8IYU8Yjtg>
    <xme:oczCaaG9hZZHUrE-31chMBS0B6jHrSYiA8Gz55Ct-IojTpg3LsZia0IOcsPPOEBQ9
    6f4EBSff27GmZE-RUq7hEeJx3pR67JNozpUe-WH_3MfQRDr7htT>
X-ME-Received: <xmr:oczCaXCcYiGD9cZMxcYFxGCA3RubJApYLz4eDdvbVdgg45KvqosIqilmyCYaPxeKRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhi
    mhdrhhgrrhhrihhssehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhlohhs
    sehsiigvrhgvughirdhhuhdprhgtphhtthhopehmghhurhhtohhvohihsehnvhhiughirg
    drtghomhdprhgtphhtthhopehiiigrtghhsehnvhhiughirgdrtghomhdprhgtphhtthho
    pehkshiithihsggvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhmrghglhhioh
    hnvgesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:oczCaQk9Plf0lOEEKfxRG_tHDJYt8_p_H9rCie1kHK-36RG2C3E4PQ>
    <xmx:oczCadPqv36C1AIHfdCPOgDZWEOcpFEghpdbXl0EdGCvGVcZLN8itA>
    <xmx:oczCaV8FN7KoKi0VifFe6eRY4kMKENJzBbfaQM_HRSZlrduLcB0WxQ>
    <xmx:oczCaXEMlTmorLaYU2N1iVgDBgl1A2CIRJ8RAiDV44EvPzgzPGps4w>
    <xmx:oszCaWJJ1xynujOCu2XuA1Q8RyIL1ge16FwBeKVR7jAnOJWAboy63X_P>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 13:40:48 -0400 (EDT)
Message-ID: <4f30eb00-59ef-4a03-9c63-4eb2909ba865@bsbernd.com>
Date: Tue, 24 Mar 2026 18:40:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse: buffered reads limited to 256KB regardless of negotiated
 max_pages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, jim.harris@nvidia.com,
 linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>,
 Konrad Sztyber <ksztyber@nvidia.com>, German Maglione
 <gmaglione@redhat.com>, hreitz@redhat.com
References: <20260316145435.BA2542605C3@ubuntu.localdomain>
 <20260324132149.GB668717@fedora>
 <30a271bd-eaba-4248-af66-df18a61864ca@bsbernd.com>
 <20260324171138.GS6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260324171138.GS6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/26 18:11, Darrick J. Wong wrote:
> On Tue, Mar 24, 2026 at 05:05:45PM +0100, Bernd Schubert wrote:
>>
>>
>> On 3/24/26 14:21, Stefan Hajnoczi wrote:
>>> On Mon, Mar 16, 2026 at 07:54:35AM -0700, jim.harris@nvidia.com wrote:
>>>> Hi all,
>>>>
>>>> We have a FUSE server that advertises max_write=1MB and max_pages=256
>>>> in the FUSE_INIT response. Buffered sequential writes arrive at the
>>>> server at the full 1MB as expected. However, buffered sequential reads
>>>> are capped at 256KB per FUSE READ request.
>>>>
>>>> The cap comes from the BDI readahead window. bdi->ra_pages defaults to
>>>> VM_READAHEAD_PAGES (32 pages / 128KB). For sequential access (e.g. cp),
>>>> posix_fadvise(POSIX_FADV_SEQUENTIAL) doubles the per-file readahead
>>>> window to 2 * bdi->ra_pages (256KB), producing the observed 256KB
>>>> limit. A 1MB application read() results in four sequential 256KB
>>>> round trips to the FUSE server instead of one.
>>>
>>> Hi Jim,
>>> Thanks for sharing this issue. I am CCing Geman Maglione and Hanna
>>> Czenczek who work on virtiofsd and are also becoming more involved in
>>> the virtiofs kernel driver.
>>>
>>>> In process_init_reply(), the kernel processes the
>>>> server's max_readahead response like this:
>>>>
>>>>     ra_pages = arg->max_readahead / PAGE_SIZE;
>>>>     fm->sb->s_bdi->ra_pages = min(fm->sb->s_bdi->ra_pages, ra_pages);
>>>>
>>>> Since bdi->ra_pages starts at VM_READAHEAD_PAGES (128KB), and the
>>>> kernel sends this value as init_in->max_readahead, the server can only
>>>> decrease readahead -- never increase it. Even if the server responds
>>>> with max_readahead=1MB, the min() clamps it back to 128KB.
>>>>
>>>> Other filesystems set ra_pages or io_pages based on server/device
>>>> capabilities:
>>>>
>>>>   - SMB/CIFS sets ra_pages directly (2 * rsize, or from mount option)
>>>>   - Ceph sets ra_pages directly from mount option
>>>>   - 9P sets both ra_pages and io_pages from maxdata
>>>>   - NFS sets io_pages from rsize
>>>>
>>>> I see two possible approaches and would like feedback:
>>>>
>>>> Option A: Fix the max_readahead negotiation
>>>>
>>>> Replace the current:
>>>>
>>>>     fm->sb->s_bdi->ra_pages = min(fm->sb->s_bdi->ra_pages, ra_pages);
>>>>
>>>> with:
>>>>
>>>>     fm->sb->s_bdi->ra_pages = min(ra_pages, fc->max_pages);
>>>>
>>>> This uses the server's max_readahead response directly, capped by
>>>> fc->max_pages for safety. I think this is backward compatible:
>>>> existing servers that echo the kernel's 128KB value get the same
>>>> result. Servers that return a lower value still reduce it. Only
>>>> servers that return a higher value see changed behavior.
>>>>
>>>> FUSE servers can opt in by advertising a larger max_readahead in the
>>>> FUSE_INIT response.
>>>>
>>>> Option B: Set io_pages from max_pages
>>>>
>>>> Set bdi->io_pages after FUSE_INIT negotiation:
>>>>
>>>>     fm->sb->s_bdi->io_pages = fc->max_pages;
>>>>
>>>> This matches what NFS does (setting io_pages from rsize). The
>>>> readahead code uses max(bdi->io_pages, ra->ra_pages) to determine
>>>> the maximum readahead size, so a large io_pages would allow larger
>>>> readahead submissions.
>>>>
>>>> This is simpler since no server-side change is needed. However, it
>>>> bypasses the max_readahead protocol field, making max_readahead
>>>> effectively meaningless for any device with large max_pages.
>>>>
>>>> In both cases, fc->max_pages is already clamped by
>>>> fc->max_pages_limit, which for virtio-fs accounts for the virtqueue
>>>> descriptor count.
>>>>
>>>> Thoughts?
>>>
>>> I think this is a question for Miklos. You could also send a patch with
>>> your preferred solution to expediate this.
>>>
>>> Thank you for looking into this - it will be nice to remove this
>>> performance limitation.
>>
>>
>> We have this patch in our branch:
>>
>> commit 763c96da4bd6d1bb95d8e6bb7fd352389f3a17b9
>> Author: Bernd Schubert <bschubert@ddn.com>
>> Date:   Wed May 7 23:39:00 2025 +0200
>>
>>     fuse: Use fuse-server provided read-ahead for CAP_SYS_ADMIN
>>     
>>     read-ahead is currently limited to bdi->ra_pages. One can change
>>     that after the mount with something like
>>     
>>     minor=$(stat -c "%d" /path/to/fuse)
>>     echo 1024 > /sys/class/bdi/0:$(minor)/read_ahead_kb
>>     
>>     Issue is that fuse-server cannot do that from its ->init method,
>>     as it has to know about device minor, which blocks before
>>     init is complete.
>>     
>>     Fuse already sets the bdi value, but upper limit is the current
>>     bdi value. For CAP_SYS_ADMIN we can allow higher values.
>>     
>>     Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index af8404f539a3..417598bb3575 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1369,7 +1369,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>>  			fc->no_flock = 1;
>>  		}
>>  
>> -		fm->sb->s_bdi->ra_pages =
>> +		if (CAP_SYS_ADMIN)
> 
> I really hope your branch has:
> 
> 		if (has_capability_noaudit(current, CAP_SYS_ADMIN))
> 
> and not what's written there. ;)


Oh oh! I had created that while being at a team meeting, must have
been very distracted. The branch is heavily patched - only runs with one
daemon and always as root. So not too bad for us.

Thanks,
Bernd
