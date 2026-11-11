Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794387748;
	b=Nx4TWoxPeAwW1WTwz74wLuAhfvmil/FTX2s+MVoOd7czDXIM5ngyOFX+z/mTJg0ime+p
	 vMRauy4sxwl7l7gmSrtiUdjpE20Vm72xJFEqhq4t36EKcBMXncKhlWMvdIH08sHwD9izu
	 5+k+wnXvrjAlbuEQvsl7cfDaupNqffXVV1sQzicr1v+JVBoJvZLFzd7u8jZOjt8CQ2WqI
	 3rBSTVQE1i81v2P1QNnhJqtWppKjhYbzjbvWS0S1ShVUiUw6t44K9MBJAPVCEVAPHlcqf
	 X3MhslC3Nqzpk0v44xlCfOSlnwRdfXunB14DYlT8ZgXkeaDLc2n5LcGZwrGPkLiFPVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
	b=kjPf7XcJ/k1dkwHuGuxErLTtCod21YM7pM2+Rz1otrOhNhBhQrSp/Jkgo/SEH2HwQPhx
	 ZafVeWrOU18F5nyZuhr42nsXi7wqMnzitNVZR4yomqcwE4/49ZvY6H3nsqh3KbbiaONhO
	 kG2eNzuBA6lEwyFrAWNkLQ5dtDGX6mX5YuXtWYD+KJ69P71L29ib1O/pv5gAUQDTMc6Je
	 nIidkdK63PS4R/WQVTvCIbAWrbGy02u9zaswwL24wwKU3Ldhyups9OaLmC5tg3Kh2qGyg
	 t4xYwYoOxC3e/91D95/MYqH3jYc4mRwO6PnQD0cjnl3iEaDNTdZWcXau+96whlPa+6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=ZG1wV17q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2179606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 09:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2179606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=ZG1wV17q
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-54f873cbe2aso29821041cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 01:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794387746; cv=none;
        d=google.com; s=arc-20260327;
        b=RY+7143UyDh9iHAXIiqv1RFDjJR0pU8hZy4hYW0czQRUZRQgLN722EW0AF1rsIDr2U
         2u8kCqavjY3uRVVN+ZUys1oEz+tQzJU3a3n9Ba9s9feBJK7UotAOSNrFeElbpINYdyjx
         3Cme9WPDyrqMeewNeIl2dGVjR8UzL3mEHpJdZ7O9KnGgNR51J/VxMUn+heJT283CO6wI
         tHMHkBd7tq4c9AJsHoD5/yikn+goGN+0Jhis5aKyHUDTh9d7cUU5UFRMKjlfFVNHk3SK
         7qxcoSRTTO+AgxS8oq29nz8X9I7kE7sqFM5FdrIPERGF0JFidUsgm1IU2ryqzHa51uYP
         8lhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
        fh=wqPIZ0Jm//z4pcF0VWLlRa/3ZQtiLmhr5797Vcp0PcQ=;
        b=Ck61fNq9syXCYX9rvKhc/FgMBFYa3H84uh5nMhEN7or7xLrmwZLEas9UdFlSGKvwDF
         vH1vrxVVuYErzuiXAlredhqx9vJ0ks1g4TlHEsSAiz2FLlrhkMdKVGqBUaW1FgUtoPjZ
         A6Z+eO6U7oPTwoXm7bYu9cgcZHzgL4ZissSIOk7oMjifNHCAwhRK5iEaNv6dguukuZqw
         DTsUfMaC3i8i+tmdZsXqpJbT/lfM1tNGsVrXeEuG1xZ3fEyew6BI/QPNCnupZuvx5m67
         g8DLg/v72XP7Evzl4gqksGIZ+lP6V6CDSDj53Id2V/nreBkCsHqXwJVGyRPsnLhzyP63
         lXbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1794387746; x=1794992546; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
        b=ZG1wV17qi7k3y+OgTB9oJ+Iq3qqKdjhEB6Voe1crPeuwQy0wcDNfv/bdudwdrfdRw3
         ADLgOcPbh/kgKQc9CUfDrcimVHeDxii9BVyDhy8gtwLRFQrYbBk+hajpv+6KgFLrz+NI
         al6FswZ2+KsdhNnysas3fU0YuIKpHZj5CWMcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387746; x=1794992546;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
        b=ZTXetp2DKoCvZRC3K9Rct4iF8H/Zwu2oOxO3fLpFeyEbkjUhjbcILX1owmsIpDe8R4
         K7i077vl5vz3m77db929PsRS2iyHXSOIbJG2iDtcF0BJ19dxYhBTxdMN8kVhi8bws6Mt
         47fjymRLBZR7s0mVFeoRmrNemyhNt/w60J+SjD23ma5pjj/eycr6uaypE3ajN8LeqYEA
         lkHrwb7xPn77u7p1NET3o0eURhXFOZug440tbIxNRXh313TYJPkZFBiTKYIaai3OOJpl
         Z6Ul9oPnDyboh2td4EpHX5ad1QbrD/1g13D4UhcFLLmKoqvXWh2tcS7gDnjjbSxhWoRx
         CNcQ==
X-Forwarded-Encrypted: i=1; AL+hErHGmXJMY7dPhDrAEG8rVNKo3l1jhdrrVUVOHKUnlY6RMBi9bVeqBMJO8sbCZiyFd61m7P1DEBi3oo7biZE1@vger.kernel.org
X-Gm-Message-State: APuU4Z+r1vCprQAR2ws7mdwYSQ6SlHJpINkGiLFIjdsyUVMrCvNenJ++
	4K8vAkQnFj3R8GdIB98kb0TG39Yp1SYG3YilOR5AjGLEAt1IDO8bixvr9XZSrEwqQzTzmm0ExAC
	5eWpzegtfZiS5nYnrJF4zrtAi9sNmi8SDnLv0YQpqpg==
X-Gm-Gg: AYBFou0gvrtWE57WSV51LEiFXv0+/rGOO73UAYbIG7OQYLhTn0eYcB4KnqtAd756hI6
	WzhcjDMBWKS9uatPGBXZdekOLgOJRwWJ3oxTv46a+JU4pB/b3P8lyXCGxSoPZsoIqwlAWgdDzcy
	vlOEGzPQWoFzxUqob60oLgkUMA+NBE8MrDftYtJjLfBuO7Nce4QJN9fDfw1/HaQgeckwSgMMOTL
	oSk354iRb9Q2mdFwFBctcIyCKLHDYICqgX/W8GtRd22nTjwVbYIVeieynM+TdEeebtBItbXYG2n
	QOR2GB0rlrrTgJzMIX19G1mcNQUHAoa0Bf17YOwePa1IGJ5VIot3lyjJBEHk4SY+R2grTOcYK23
	EEd1lN3TvM0b3Ard98d+G4IAtye7Q9/07+TpoLZXuqhNhPS6oPXJT+3Rz/tFWevgM8w==
X-Received: by 2002:a05:622a:34d:b0:536:8f5a:64a with SMTP id
 d75a77b69052e-556c222b82bmr24946931cf.63.1794387746372; Wed, 11 Nov 2026
 01:02:26 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-3-kas@kernel.org>
In-Reply-To: <20261110145241.536019-3-kas@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 Nov 2026 10:02:15 +0100
X-Gm-Features: AclHuK9XqiIqd0G6zWinytDup_EFg0rRz4_cn9sSXLX9jTiH3KRFdGlFPrXk02Q
Message-ID: <CAJfpegvEeGN073FbaCRnhMeX8RHrckSxmFjkpdoyea2EuRf+zg@mail.gmail.com>
Subject: Re: [PATCH 2/4] fuse: don't move pipe buffers into the page cache
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amit Shah <amit@kernel.org>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 15:53, Kiryl Shutsemau (Meta) <kas@kernel.org> wrote:
>
> A splice() into /dev/fuse with SPLICE_F_MOVE lets the reply to a read
> request steal full pages from the pipe.  Each stolen page replaces, in
> the fuse file's page cache, the folio that the request allocated.  The
> page can be a page cache folio of another file, a page written into the
> pipe, or a gifted user page.
>
> Always copy.  The server sees the same data, and the move was a hint
> that splice() never promised to honour.

Did some research and looks like this feature is not used by any major project.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
