Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712210;
	b=XEA56zmbLqagiBvR5JEjhLMbq0iaZlQCnavEXdHmtNHtw8tf2r05TRkYh2KHE1GP3gxi
	 Cwv5zAK7yNSosEv8pA0n6QxT/8LcDezrb1vKzYjpLhOQz+y4D3iSgaz2XFwVRK30TkQ4Z
	 hKdoi7VOEEhKKUAe5f8bnS0unuqG9BoAYM6mMRF8nYPuSyMqRQd7dwWp+qv4xEEFt37gG
	 tnPlYo364LrGQuNGksxH/zSVsiygjL1wrwIRk0+Z2fXtdR1wl1pS3F8hmCNr26l0r8kmn
	 CrmWZQ/WPitkt2mcp4M21fr+kJIcMDSldOojx5J9UWRtQWEKKHmJgNDgudI56Xz4BlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712210;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mjdrsIJyKFIFnzAMatvSFy1r3GvrnGD+/8dSv9ZNaA4=;
	b=fkgg+Fg8abgTf7XlHiVohVVs4PaJyiKQGJoINsJ7LIc6tHjvWrGloIdj7JDs4gJaXc8g
	 C29EaiMf/PUQoPewLh+62FKD4/PI8YlQ9bb7su5xV79lw8+7JXGTXzqLWj6Fnm2s/M5Vf
	 J5ApDw3TxuBjiC3zAv9TjXSKZ6OZ1vQuwjKQrhijK5heDcDuaTH3+VYjIuPwe3r1+QEHW
	 vuutehCIsPsbnb8GjofpgqC1mZAYZLQK6jDtRpzlWUIyudS36z5/YILmYK1d2Uibr0Gva
	 ETPuIxQO/RwMZFtmb4OctuZhMOnfMqyWcqw/ieTgDxfUBJOjkFZcDT5qGiMMxWI1y/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Mko85Vxn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26319606A327;
	Sun, 15 Nov 2026 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Mko85Vxn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435271F000C4;
	Sun, 15 Nov 2026 03:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794712209;
	bh=mjdrsIJyKFIFnzAMatvSFy1r3GvrnGD+/8dSv9ZNaA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mko85VxnD5M/cnGfWtpnKAiOaW810jRtHcqXz54OIn722p4lzVvDQ8LYBV0J/qJoQ
	 xOXiZAPu64MmB9Gs4uYvUKNdfRpEWLURaQ+Cb3nma3rj/c/+742xKVrBbwaL1ibLK3
	 w8hMLrIgz+hFZy2TEY0/pP/slQLx+ru+nfRcqGPU=
Date: Sat, 14 Nov 2026 19:10:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shardul B <shardul.b@mpiricsoftware.com>
Cc: <willy@infradead.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dev.jain@arm.com>, <david@kernel.org>, <janak@mpiricsoftware.com>,
 <tujinjiang@huawei.com>, <shardulsb08@gmail.com>
Subject: Re: [PATCH v4] lib: xarray: free unused spare node in
 xas_create_range()
Message-Id: <20261114191008.c6a23905a52c6f4f918c0d33@linux-foundation.org>
In-Reply-To: <19bf8d68cdb.ae2c0d37126486.8380742359510867201@mpiricsoftware.com>
References: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
	<b2b99877afef36d9c79777846d19beeb14c81159.camel@mpiricsoftware.com>
	<19bf8d68cdb.ae2c0d37126486.8380742359510867201@mpiricsoftware.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 26 Jan 2026 11:16:08 +0530 Shardul B <shardul.b@mpiricsoftware.com> wrote:

> Hi Matthew, Andrew,
> 
> 
> Gently pinging this patch. I’ve checked the latest linux-next (next-20260123) and the akpm-unstable branches, and it doesn't appear to have been picked up yet.
> 
> 
> The patch has a Reviewed-by from David Hildenbrand and fixes a memory leak in the XArray library identified by syzbot.
> 
> 
> If there are no further concerns, could you please let me know if this is queued for the next cycle?

I finally got onto this.  I prepared a test_array case to demonstrate
the bug and confirmed that your patch made the test happy.

I'll send the 2-patch series separately.

Thanks.
