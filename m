Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B18382379
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368351; cv=none; b=EoDFY47JaBhIWvh/svP4t6ss6+dBmEo5YIvWbdBhl0etlbPLLWKl4VsaE1R17U+UY9w72sBZQC77MhvrOT92ai+GTDsbqGkux4O4GlBXWKV/p+oHVxZU6gJbM1cRe+0jDTfhDj6g6u/Um7ww70ApzXoUDam8mU385N9EISopvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368351; c=relaxed/simple;
	bh=DjVCYOPtNVDTjkP5Brysi8bZnWTMngWe90G6zxDmOY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ft8eRh0XFPb4Kftht7DMSBVfnIrjN+tIuic8x5fbleZvdjLCYaLRcfZcmlknY3OJlhc6Gpf55+tXXHtulnu3Qb4DzBZXOLYixpoMExlkZPQYb0pCtzunj3P2T7Jf42H/ZuOHfE1bMwuH0pv2PlR+b7/f+eVZ/6cKfKaXC3FlpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Iu0oPlr3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fls0z5nI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Iu0oPlr3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fls0z5nI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E7E2D1D00103;
	Tue, 24 Mar 2026 12:05:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 12:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774368347;
	 x=1774454747; bh=lL19ey7EMgqiegK3vHIZE0J4jGrU5JHDT5lI1y7Ludw=; b=
	Iu0oPlr3vaVpgzIx00X5xpJaYUmYsjbv5STRVPJ/7kEQg9BF5CrDPjOE5VshXWcN
	U+AnDbwwHyfstxLN7AgpNBayAeJoHlOboDnt1OzJ9tGsc9YU+v70Yq3njb5FqGkF
	RFTE2R8KWgP4w1k+P0ZvpVV+ut1v2MX0468BTjIFPOf/ph/MRKn9d0vTIuw4Awjh
	TJRk0qus5Vn/cGd/IZNu8WPl/nFl52EipHqwgfZ3vqZ+LWBftd+0phW4pjZnd3pY
	9LnrQIT1npFjeCgs4TBoIS74SM4q0Ffv9VpeQ9JEH7I7zjTA33wBOxEO9pAEQ/yL
	fYFrfHExtqLj8PxxbcBvig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774368347; x=
	1774454747; bh=lL19ey7EMgqiegK3vHIZE0J4jGrU5JHDT5lI1y7Ludw=; b=f
	ls0z5nI31BylNBpknr6hgb6FcXEs54fwyTxwMSw7g0Vmu1BIbpUPGqeeDBguGOfl
	J9h+4ZXsByGjvQBiRd/guwrffn0H9Pch4surtozy+mgwrYsoheA3pWfD6k2MVroB
	tj+fw+CjQPh03GT5QAjBr/OgvcPbpq9phAcbjRm6dPeLx+2zjoxGlmCXElbh78oo
	sA7MXZokVuGEEyKTp5VLhSD4NmCbs1UqOsAA9LqqrJun6SdWPXwrG/5G90Sqjz9Q
	FxUkkjk5XL4RZk6HxekFbcMDpswEyFOapDcMkX+oZtFYc18VH2xW0awYa9CtFgza
	1R4yT2cR6ZnXBzidelUSQ==
X-ME-Sender: <xms:W7bCabELM_SobSnBQtAh6G3HiQzLbVPvGgTLg-J6SGDzm_KBT2aZXA>
    <xme:W7bCaa7gHE7bsMqpDdwAfNbfPy4yx21tFAKAg8NOv0hUzETWtMY8v6v-h1t_YVo8c
    juekpx-nsiqPkYrzvPwp4IGggVqtfaKShGeUbGI-jPzTtfaaCJC>
X-ME-Received: <xmr:W7bCaQzTrb-6SqnOZbtW_xRm8eKYV6j7a-2piLMC_IwwXYESP7f1Bptl_8sJKuDApA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepjhhimhdrhhgrrhhrihhssehnvhhiughirgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehmghhurhhtohhv
    ohihsehnvhhiughirgdrtghomhdprhgtphhtthhopehiiigrtghhsehnvhhiughirgdrtg
    homhdprhgtphhtthhopehkshiithihsggvrhesnhhvihguihgrrdgtohhmpdhrtghpthht
    ohepghhmrghglhhiohhnvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhrvghith
    iisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:W7bCaZNZPM11co1iTRw5sugMcd6iFgD9pn-7Ey9d41Jmao1qOu4uCA>
    <xmx:W7bCaWllMCp1JHKHlN7jrcxeEI09aF9YaraUPwH4cejfWPcYvamoQg>
    <xmx:W7bCaeQ5JQ7zJZFQQArumXkTnRiJOdTLR-JqBy0jUvrp_6CBhiIVGQ>
    <xmx:W7bCaVV6E1eb6CZEwUoMlkqyQEZvANsCwUj1pLEufV-x2V94plxljQ>
    <xmx:W7bCaXpq_FaSgC01TZUCGEwMunRiQmQAktA_PYmPsbkh3e-6CYnNOexI>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 12:05:46 -0400 (EDT)
Message-ID: <30a271bd-eaba-4248-af66-df18a61864ca@bsbernd.com>
Date: Tue, 24 Mar 2026 17:05:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse: buffered reads limited to 256KB regardless of negotiated
 max_pages
To: Stefan Hajnoczi <stefanha@redhat.com>, jim.harris@nvidia.com
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>,
 Konrad Sztyber <ksztyber@nvidia.com>, German Maglione
 <gmaglione@redhat.com>, hreitz@redhat.com
References: <20260316145435.BA2542605C3@ubuntu.localdomain>
 <20260324132149.GB668717@fedora>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260324132149.GB668717@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/26 14:21, Stefan Hajnoczi wrote:
> On Mon, Mar 16, 2026 at 07:54:35AM -0700, jim.harris@nvidia.com wrote:
>> Hi all,
>>
>> We have a FUSE server that advertises max_write=1MB and max_pages=256
>> in the FUSE_INIT response. Buffered sequential writes arrive at the
>> server at the full 1MB as expected. However, buffered sequential reads
>> are capped at 256KB per FUSE READ request.
>>
>> The cap comes from the BDI readahead window. bdi->ra_pages defaults to
>> VM_READAHEAD_PAGES (32 pages / 128KB). For sequential access (e.g. cp),
>> posix_fadvise(POSIX_FADV_SEQUENTIAL) doubles the per-file readahead
>> window to 2 * bdi->ra_pages (256KB), producing the observed 256KB
>> limit. A 1MB application read() results in four sequential 256KB
>> round trips to the FUSE server instead of one.
> 
> Hi Jim,
> Thanks for sharing this issue. I am CCing Geman Maglione and Hanna
> Czenczek who work on virtiofsd and are also becoming more involved in
> the virtiofs kernel driver.
> 
>> In process_init_reply(), the kernel processes the
>> server's max_readahead response like this:
>>
>>     ra_pages = arg->max_readahead / PAGE_SIZE;
>>     fm->sb->s_bdi->ra_pages = min(fm->sb->s_bdi->ra_pages, ra_pages);
>>
>> Since bdi->ra_pages starts at VM_READAHEAD_PAGES (128KB), and the
>> kernel sends this value as init_in->max_readahead, the server can only
>> decrease readahead -- never increase it. Even if the server responds
>> with max_readahead=1MB, the min() clamps it back to 128KB.
>>
>> Other filesystems set ra_pages or io_pages based on server/device
>> capabilities:
>>
>>   - SMB/CIFS sets ra_pages directly (2 * rsize, or from mount option)
>>   - Ceph sets ra_pages directly from mount option
>>   - 9P sets both ra_pages and io_pages from maxdata
>>   - NFS sets io_pages from rsize
>>
>> I see two possible approaches and would like feedback:
>>
>> Option A: Fix the max_readahead negotiation
>>
>> Replace the current:
>>
>>     fm->sb->s_bdi->ra_pages = min(fm->sb->s_bdi->ra_pages, ra_pages);
>>
>> with:
>>
>>     fm->sb->s_bdi->ra_pages = min(ra_pages, fc->max_pages);
>>
>> This uses the server's max_readahead response directly, capped by
>> fc->max_pages for safety. I think this is backward compatible:
>> existing servers that echo the kernel's 128KB value get the same
>> result. Servers that return a lower value still reduce it. Only
>> servers that return a higher value see changed behavior.
>>
>> FUSE servers can opt in by advertising a larger max_readahead in the
>> FUSE_INIT response.
>>
>> Option B: Set io_pages from max_pages
>>
>> Set bdi->io_pages after FUSE_INIT negotiation:
>>
>>     fm->sb->s_bdi->io_pages = fc->max_pages;
>>
>> This matches what NFS does (setting io_pages from rsize). The
>> readahead code uses max(bdi->io_pages, ra->ra_pages) to determine
>> the maximum readahead size, so a large io_pages would allow larger
>> readahead submissions.
>>
>> This is simpler since no server-side change is needed. However, it
>> bypasses the max_readahead protocol field, making max_readahead
>> effectively meaningless for any device with large max_pages.
>>
>> In both cases, fc->max_pages is already clamped by
>> fc->max_pages_limit, which for virtio-fs accounts for the virtqueue
>> descriptor count.
>>
>> Thoughts?
> 
> I think this is a question for Miklos. You could also send a patch with
> your preferred solution to expediate this.
> 
> Thank you for looking into this - it will be nice to remove this
> performance limitation.


We have this patch in our branch:

commit 763c96da4bd6d1bb95d8e6bb7fd352389f3a17b9
Author: Bernd Schubert <bschubert@ddn.com>
Date:   Wed May 7 23:39:00 2025 +0200

    fuse: Use fuse-server provided read-ahead for CAP_SYS_ADMIN
    
    read-ahead is currently limited to bdi->ra_pages. One can change
    that after the mount with something like
    
    minor=$(stat -c "%d" /path/to/fuse)
    echo 1024 > /sys/class/bdi/0:$(minor)/read_ahead_kb
    
    Issue is that fuse-server cannot do that from its ->init method,
    as it has to know about device minor, which blocks before
    init is complete.
    
    Fuse already sets the bdi value, but upper limit is the current
    bdi value. For CAP_SYS_ADMIN we can allow higher values.
    
    Signed-off-by: Bernd Schubert <bschubert@ddn.com>

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index af8404f539a3..417598bb3575 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1369,7 +1369,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			fc->no_flock = 1;
 		}
 
-		fm->sb->s_bdi->ra_pages =
+		if (CAP_SYS_ADMIN)
+			fm->sb->s_bdi->ra_pages = ra_pages;
+		else
+			fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
 		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;




Maybe we can increase the limit for non privileged servers, but
not to fc->max_pages, because an admin might tune fuse_max_pages_limit 
to a rather large  value. I was able to kind of crash the system
with >16MB read-ahead in early 6.x kernels (I think 6.1).



