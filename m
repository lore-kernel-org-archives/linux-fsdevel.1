Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793421196;
	b=5mpGTL0l8d5nPJv0aMRGTzrNhVlJ+QxXbulYZ5y/UwyLEewcMQppje32wTk5k/hcjqF8
	 zjf67F7EezTJrl2t65I9H9YWw+jluAwMLNcAaOXWZxnUE4W8cPKiTUTh+FTyNQlyYrDlG
	 FUOLYnp8NGV/BU9Zt3yZ/nJwUs6kdk8rk9Waw8qWT193/9yb46YVKJb5s3pl3OAmdVLEH
	 3KGjpJ7XdH/Kpf8rrRANZitY+8AIb0GoNfrPJIZ33UQSMieOayJlkMTogvBYgsktmRLWp
	 4IRngeSbZQvQ4EG4etgigj1TWivdJ9autxVxQym84A9GqhKm04UT/pBGYyvF5P2zgvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793421196;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tArUjAi7RyNIs44mDcDEd1/onmpGhyZQLsYyXwL8Y3g=;
	b=BvAizNFOqgcGG88dOL+YDN5MhIta8Dl0Ysw5I4dEpM+/KMrM5+s0qURb+7MNZ6cMzIit
	 S3q2If6cZOLHY9YEbZNmZJt4EP9+r2gIrAm7owiADIU04YiNPDKldHDbVWSKf/2HecREo
	 jpgYZ8G+epVyd+iji1yt5mA/hCSFL3X/84AITlbum4FGUvtfbmWrpxDr0OYPXV41Nu4CT
	 Fow2LWIwQDFPub8gvSPgl/q/UkZuoo0/aG+iDtOiHJp7BNKYL7uK8sF46HMEgzo1z5WNq
	 +N0OXHcNVFdha+pQzI0xw5eQF0ufN7ot7FxD/mWy4AsW9AvX5up10uab0jEfPL+9ebQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Rc4KYIC9;
	arc=none smtp.remote-ip=91.218.175.51
Received: from mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56E606A31C
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 04:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC56E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Rc4KYIC9
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tArUjAi7RyNIs44mDcDEd1/onmpGhyZQLsYyXwL8Y3g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793421191; v=1; x=1794025991;
 b=Rc4KYIC9owQQYp1axLtKtu6ytYWTfMvKNYNUub/cy2ph/TXFumz2vQ6CYqrK6QVcbicEDcLA
 Bh/VEkrn/qSnWAGE694BRT2khCHiB5WXWtvl2XjZmiI9yX8UO/tNsVAcADFoCV8bUBGj6P/DcC7
 koJOWoyWGGNT54l1o7TfdgqQ=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea78379c5260a3be;
	Sat, 31 Oct 2026 04:33:09 +0000
X-Mizu-Trace-ID: ea78379c5260a3be
X-Migadu-Flow: FLOW_OUT
Date: Sat, 31 Oct 2026 04:33:06 +0000
From: Jose Fernandez <jose.fernandez@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Krystian Kaniewski <krystianmkaniewski@gmail.com>
Subject: Re: [PATCH] mm/filemap: stop fault-around when the walk steps back
Message-ID: <20261031-jf-mm-filemap-reply-r2-7d4c1e9ab350@linux.dev>
References: <20261028-jf-mm-filemap-map-pages-lower-bound-v1-1-0bf126e876d4@linux.dev>
 <0a1ad7d2-ff0e-4248-8f03-2a64a9134aae@kernel.org>
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
In-Reply-To: <0a1ad7d2-ff0e-4248-8f03-2a64a9134aae@kernel.org>

On Thu, Oct 29, 2026 David Hildenbrand (Arm) wrote:
> Only read or also write? I assume only read.

Both. KASAN only reports the read, but once vmf->pte has stepped
outside the page table the loop will also call set_pte_range() on
that slot if it reads as pte_none(), so a stray write is possible
too. I'll call that out in the v2 changelog.

> Sounds like we want a Fixes: tag and Cc: stable? :)

Yes, v2 will carry both.

- Jose
