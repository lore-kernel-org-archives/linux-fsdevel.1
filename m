Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916817;
	b=yzfW4I0JzbDvJFflMMkSkv8Zuzf26tjnuNduMiOqE4inZgJOsp5XNd6zYmg8vp9L/CNl
	 m52VhjiFYIoTNGhB0Iq6ioZe+/0hO0s2StfyO6NxkM5ZWmjMQWxT4bvmrF58kgyip5+bV
	 bDgSK09OexWv16feF8tAooUk7JFIw9WwqRD/HM6oeSU37IrEK0O5ren9iWFDQ7xhxcqSj
	 nk9gcJAlZSeZl8789Vfu2HpLGkBhdyuRqykpJLR4NrKmvOtmu3Eh0nnsxbMaEGrmgZD4R
	 +XnCMuj1Ngq+KwMgPdQsXNKOwLKAACE5JndJCftjGBLX1hkI1WbwGoGNAYZG5HZgN/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916817;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4KVE0mlIb8Pa60CBHZvDD8qqhUD9QNgg/6EGkqm9L1Y=;
	b=igw9nFRkkFPN0aLbYBv7viH866U5UILMbgFIJoMAMx2UjszDulXA0+9CyEshrZnm/YtZ
	 iGso4kr+KDSHUW2NLOJTvzxqANbvD25wcfoTFWgpg/zsGxslhuFwexwNQhVR5J6jUlcU7
	 2JLfuTgIM6DQdBws1l3SIFvtpAncxFnRzc8NlSGYLdSOydKHmhSrEdyywag+YXfH3IwYv
	 iMSlzn+N1ybkdCuuP/WuX8YRCHAoGH/6LC40JhYtgbBTjfw6jDXEP8h5+bFX7tv10YLe7
	 OJkmL8HDfLtIUJJViMB+dDEnJJ6cKUbyDJ5uLaKMVZdY/iHzSrJG9SqoLtYCkTw9+lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="FZL/4bYI";
	arc=none smtp.remote-ip=95.215.58.235
Received: from mta1.migadu.com (out-235.mta1.migadu.com [95.215.58.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114E606A328
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 22:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B114E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FZL/4bYI
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DkefybD1i8xvQ56jyQ09h/HTM19UexBk7u12ksvN4Ok=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793916813; v=1; x=1794521613;
 b=FZL/4bYIYtPOxgYb2t6NdTInSEADFu24zE8bVTWhV8d7DKiaTGawM60fbUJSi3opG7QUYT7r
 5UnBWjhj0KMKMEeoUUIC+NFwUUQIA+EkX4eLPy8KMDb4oSee8lfUntIzswfHl5C7tAwIKFlgRV/
 vpx80WMwdwnvpLm0xvNOTR/c=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c3dbcbf73ad53fc4;
	Thu, 05 Nov 2026 22:13:33 +0000
X-Mizu-Trace-ID: c3dbcbf73ad53fc4
X-Migadu-Flow: FLOW_OUT
Date: Thu, 5 Nov 2026 22:13:30 +0000
From: Jose Fernandez <jose.fernandez@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Krystian Kaniewski <krystianmkaniewski@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps back
Message-ID: <20261105-jf-filemap-v2-akpm-testedby-reply-r1-36ef39856b46@linux.dev>
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
 <20261102092750.e53073b2c7b872f9d70c0711@linux-foundation.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102092750.e53073b2c7b872f9d70c0711@linux-foundation.org>

On Mon, 2 Nov 2026 09:27:50 -0800, Andrew Morton wrote:
> Can I add your tested-by to [1]?
> 
> "xarray: fix index jumping backwards in xas_find()".

Yes, please do:

Tested-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

I ran it under the stress test from my reply to Pedro in this thread.

- Jose
