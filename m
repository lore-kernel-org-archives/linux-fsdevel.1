Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066423ED5B
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773356654; cv=none; b=HgOoMtOlylA0x+Fij4H7oA8YTpAgiE9iWYcU0APJpV6UjE5Iq1zZ2IyK7DFEU5DrUjMjd1gqOEEJTnp2lUQTSHLwQUB3WKSWNfNJYsQ8CU7pmMs6jjUMUUeMzmRdgsyzrgK6UhXbbipeg+IDoL9ZV95eluVYYAhGPMfG8iaEL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773356654; c=relaxed/simple;
	bh=wHOI8PVjhgv5zJ9Mk+1CzDG2I8OevpxRN5v3Ygbd8BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BvVa17RxGhxLEb2nZRAyS2+S1WXimLWexbbrWbv1FtcW/W59q4XfQg1Unb2XCpKfovFFWoDqFxIuiF8seBAKj4xwYYsDqdBlTJ9hb+mAqa+vC8F+xXPV6ASR+jtOdlq1gT5BSg7uz6r3LDfcpM2VMMqRj9efKE+vUW1Y5ksn9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=UYEPOvvu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ry5wj7Ux; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="UYEPOvvu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ry5wj7Ux"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 866927A006B;
	Thu, 12 Mar 2026 19:04:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 19:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773356651;
	 x=1773443051; bh=ZkwyZUKRQYiJKfMWbU0DPkAo5Uii6f9ISsrKZBrJDsU=; b=
	UYEPOvvu5AwIbrps0N9llDqsvasLQujMC1aBqF2KuxynJsOVbTvp6VibhxVSHVdQ
	HaIrF3aHvCkmNrFMYfFk+eEHdDOcEy6NbhqGj5G7P1wkBvEA2YcHDxKyLMUbL6yB
	5o6lsutvYJyuo17nz/wENOn/UudYQiCphz1lX8ZEPjTcCamVFS5sezZtVVnCEm0L
	HWVZjNzvn9s72ACgyzRIkCPPCncGbAljLjDpGpCrb+J9Qz2MV4X3PSMeVnGOWHWa
	uRrhY90rLauji/YGWF/Q8zGo/3LZjvpoepZiv63iNdVgGLkjSPUf+HGAPy+tGqLp
	dpHAOVfMgGkJ8xTh40A9Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773356651; x=1773443051; bh=Z
	kwyZUKRQYiJKfMWbU0DPkAo5Uii6f9ISsrKZBrJDsU=; b=ry5wj7UxKJoBNEIUd
	HLxxjySTlkYlaDNk5UW5UejLaYIoKXiZn0UAv0w0EfsUO9DCCDzkfZFFCEA58z1G
	oO9DU66CBSlnTvHFXvBVnCba89Rg74je5QAyGiZvoLlo7szg4GNB8frVGztG22lP
	xZ42+yU1slZawXeaLkDxq06fHZSUrLIs97q1bo6hhtnsSRnvZsoTwhE+a88Et8oZ
	shwmoWDE/hNxtgfxzwrh0NrLaIpowXHEvxlgEoTf12CW/9BWtvWp8aEwQPHr7WT8
	TuwmE5jyPPz7WaPo5UHv5+L501ELuMzIKHUJt/eQDLh01W6d0U8bvEjj6V1JBy/t
	e56QA==
X-ME-Sender: <xms:a0azaSRgVUWAWYPMcxGNxyTe7BXjBznFrpSR8TY8LE7kyO9gjndcvQ>
    <xme:a0azafM-vMRpd0bN1KRIVSZJQpADBTQ9hpsi1w8WBObk-vU5MF4b6ly2I3Ym4uEgl
    yO-vaSH7KthPq1jKl4c-V1JQ2Q1oaQgO2sBjj7jEMYxmyoY2So>
X-ME-Received: <xmr:a0azadMnN9u18lnNjuoOlSQPIX7xtKZZnnvFaMItYGqwUyuCxckGIFX1vpcCTMD-4j90BB1518-YV_L1uamG45pEXFyV5W4CpTGM_S4gcCSbjUE9WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeektdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepvdellefhuefghedugfefteeuffejgfethfeuleegueethfegffegueffteeh
    geetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgthhgvnhesuggunhdrtghomh
X-ME-Proxy: <xmx:a0azaXsKkn3poQg8krahsxC5FJAc1wjLXnOGB7oWkNp0_PBzfswH0A>
    <xmx:a0azafVzXmqTNkLwLkvA4XPJhH_31eBtIsKyz3ouLkzxiHVD7WOY5Q>
    <xmx:a0azaXv-0owwo4CZktOMhrNKtDBwib15h4sPrlgr-MYxEvhOoUd2Tg>
    <xmx:a0azaTXmrzdwoHyiMDUxzyO9jdNSVj91lI7gl4H50EBPNPycr0am9g>
    <xmx:a0azadzexP-EPqm0fsgBze4Bi-bTKVJiFuK8z9l9bu_-pIPKECFVB2Rr>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 19:04:10 -0400 (EDT)
Message-ID: <4d387608-61a6-47f5-801a-3f8cb40c80f9@bsbernd.com>
Date: Fri, 13 Mar 2026 00:04:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] fuse: fix hang with sync init
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 Kevin Chen <kchen@ddn.com>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260312194019.3077902-1-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/12/26 20:39, Miklos Szeredi wrote:
> This is better polished, still needs more testing.
> 
> ---
> Miklos Szeredi (6):
>   fuse: create fuse_dev on /dev/fuse open instead of mount
>   fuse: add refcount to fuse_dev
>   fuse: don't require /dev/fuse fd to be kept open during mount
>   fuse: clean up device cloning
>   fuse: alloc pqueue before installing fc
>   fuse: support FSCONFIG_SET_FD for "fd" option
> 
>  fs/fuse/cuse.c       |   2 +-
>  fs/fuse/dev.c        |  89 ++++++++++------------
>  fs/fuse/dev_uring.c  |   2 +-
>  fs/fuse/fuse_dev_i.h |  30 ++++++--
>  fs/fuse/fuse_i.h     |  21 +++--
>  fs/fuse/inode.c      | 177 ++++++++++++++++++++++++++-----------------
>  fs/fuse/virtio_fs.c  |   8 +-
>  7 files changed, 181 insertions(+), 148 deletions(-)
> 

Thanks a lot Miklos! Will review it tomorrow and also get the the new
mount API done.


Thanks,
Bernd
