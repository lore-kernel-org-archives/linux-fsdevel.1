Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A962D94BA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290794; cv=none; b=ZPDOVwQ57IItosrGXYIp7X8sP0JcyH/lxZcHk7rgQ9XzwwjQEkkM1KniooxEu+4jzLCYV42jYLIylFKbhmdiAyykDwqkP2nnjXGkMrokvGiwnRx/eR7F7kN4DYzDNDzDYMWOSYiFm83W+t/+2B1uoFZSyC496BWYnRjP5zzw7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290794; c=relaxed/simple;
	bh=yqZYJcRE4AXsMDTAzZ4wzb4cO+UxhfgXpL30QKZxYH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0QuvVmwUZzz7jRZnxb3kkw+RxtnFs7TpPGUJ4j0mCbzDqYI3dBipTGT2y/cbCDB56mhUQ51myVfwppTXeh7eJpa0ftYrdqqDCyRm+eselV4mqVTNx/cGDhi+Me1M5nuIbWtom3fVCXwoy4BtGl5gBglTDS+zXVcopoFtmB1Rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=gyfs9Xs7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFlWst3+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="gyfs9Xs7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFlWst3+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DAA071D00189;
	Mon, 23 Mar 2026 14:33:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Mar 2026 14:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774290791;
	 x=1774377191; bh=MSjYq69uIWGVWEU0EkpEjmCouOEDuxu9DCxpUiT5A0M=; b=
	gyfs9Xs7xQ6vo4b9IYlGCu7GKBpaKJ1ogg6ZAtzu0SyGNimrB0409X43vwFQ3Mtc
	1QSTNvhKodSfhEabLbvuBRQoX5u1wQ+v3KmqPcdSyFvIvbPRRbzQKW/dvy9ftO9k
	kbK/WgIL36EDMUW6QMVTLGkaF0iel/k9b/SIJwrDAJ+RpsmRmcqSH2zf9BcWJ7cv
	PTVMiqIQs1ZV/XJVCySkpJJMvCJMip8FcH+KxmeezDf992y76No+SJob7HR080Tv
	56t2RFzxq9fMjYYsuqmTDKhLoowHJRVYBI2AdjdRneQzCpTb1m0ki6sOJq1ET9Xr
	UL3346zvOy1AtCrUEp30rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774290791; x=
	1774377191; bh=MSjYq69uIWGVWEU0EkpEjmCouOEDuxu9DCxpUiT5A0M=; b=C
	FlWst3+noZTv4spZmoIOQwq4xHqSLvPiZNj7smY/64C8ZuRNdENbC7EU7P/9mORu
	pB3jtQE+/A4U5hnKnc1i/6nRjHbWsvTCDCP4IGo+E/1I5+Mvq7aTftnvI6hHF5I9
	pA55VGiKfv8Zx7Kr5tcF4LRLGgEi5+AxTF1FtJ+K4FFv+WEK1z1IfZC2D0OfwWlT
	Cxi/MwR38sJarpf7zBYZhTCtMcZ+QIfe92COGIa0ZY6P3fGEbzmqHib1DGOkpKrd
	Wmel2ZPBvUQEFFDZmcMJZXZHIJsNZMb5vvYcra47LYKdvTx+kpW9xfMYT4qeBpYE
	XtULnpbCliHfLix2q6MVw==
X-ME-Sender: <xms:Z4fBaSTJxfj68MyfWRQ4AT6hFZof6-ooD5O_rzLUCRq6Wh0dp5FPNA>
    <xme:Z4fBafPz7vXSSA2WlzZWeSei7ace8o9ju7YWPhr4IsWpD1KWCgf0D7oT2naWZM7po
    bpReXzZQ30_GzGw2mA31MWGzgvS-QVhAijbDR4T_Cc4S6mlSMqT6A>
X-ME-Received: <xmr:Z4fBadM4bDj-TJWmCa2XYJxueKvyh1JXV2VnRGnB9FKQJ1odq0XlNxsgC7HE40ySH6iJk_DXi1928pK89JUuh6FYF7-83tJFlQKp7gB9AVW-BKotow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Z4fBaXtHcIYpISg0HUxQYE3xTsfm0uCvJ4_YhZw8qO6RuTfeUXFwEg>
    <xmx:Z4fBafVszBfppyxf4xwUskxlBHK5F2bhUYFp09gPQNDbnAagczcM1A>
    <xmx:Z4fBaXsDXL7Qtxlj3CJiEV_Y7ZIAVK-zZUKpUsiKYyO0DI_1FNV22A>
    <xmx:Z4fBaTUHhQX1tm667CULj4FimSJKbxgoKRoFXQe8K4X_a_OszlDzbw>
    <xmx:Z4fBaS-eykYxsYANXEvYb0P3V_Eulm-1DAw-PVAvtC7HoyXX1_V_QvLt>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 14:33:10 -0400 (EDT)
Message-ID: <a32528a5-0717-43ea-bfc3-ab61eba9dae8@bsbernd.com>
Date: Mon, 23 Mar 2026 19:33:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] fuse: alloc pqueue before installing fc
To: "Darrick J. Wong" <djwong@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
References: <20260316165320.3245526-1-mszeredi@redhat.com>
 <20260316165320.3245526-7-mszeredi@redhat.com>
 <20260323182249.GC6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260323182249.GC6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/23/26 19:22, Darrick J. Wong wrote:
> On Mon, Mar 16, 2026 at 05:53:17PM +0100, Miklos Szeredi wrote:
>> Prior to this patchset, fuse_dev (containing fuse_pqueue) was allocated on
>> mount.  But now fuse_dev is allocated when opening /dev/fuse, even though
>> the queues are not needed at that time.
>>
>> Delay allocation of the pqueue (4k worth of list_head) just before mounting
>> or cloning a device.
>>
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> I wonder if this is worth the extra complexity to defer a memory
> allocation?  If the fuse server actually mount()s then we need the
> pqueues, right?  How common is it for a fuse server to open the
> /dev/fuse when the kernel is so low on memory that the open() would fail
> with ENOMEM on account of the pqueue allocation?  And is it likely that
> a lot of memory would be freed up by the time we get to mount/clone?
> 
> I suppose if you had a very slow mounting fuse server this could happen,
> but now everyone has to understand that fud->pq.processing can be NULL.

I guess the issue is that people might abuse it and open /dev/fuse for fun?



