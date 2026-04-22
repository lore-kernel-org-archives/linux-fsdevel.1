Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E329A9E9;
	Wed, 22 Apr 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874580; cv=none; b=gGVxQfnbuXPcA5gMn43hBFMx6RK/rzjm+7G29H5jw07/4wGqETsa1wzLyES9LmG0tOzxNMb51d5IgymAerC5qNxJwPFbapzTxEyWD8eNGK7Vkwg7pLle3OlyvS0epkOoc7w06xYd9gyLlhApIv84MtxLrqykSfLo6eIXclaUefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874580; c=relaxed/simple;
	bh=h4eanJxpXrlVIm1nqyyHsFboSSOCzHcJax3wSI6MyVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5isvBy8QBLO6t7aQNdM/n08GSaRySe1usbEo6wK1uNxLHALIwkEtimcm8d9X2a3rihHNlo7vffov72eDbsQHMseiQuSvhZOYfOmloSGDhgbmMxhOs7wOBcKkByEkK5Syj1j6j64qeB/H4PCFx6QW+NQSb5cIvjycf6n1BQwIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grwWin7u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grwWin7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A938C19425;
	Wed, 22 Apr 2026 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874580;
	bh=h4eanJxpXrlVIm1nqyyHsFboSSOCzHcJax3wSI6MyVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grwWin7uGtk1gv9Nd1Kir0V4xj0jvFveBwjVZTD3oGvKd49DvP5u6v8pEMgDFDEjK
	 8nYa2WCbvWrBg5cb74IPu+2P+U9wU/yhdPaOqzO5cUzFvd4PzavFN7L28PfJEZDPiF
	 oLViFud9JXn9Npa9J8F2Ld3c1PGSx5TEwas8y8pU98z9/7dYZBSIakuK52Nf4yFlCG
	 mQxzHhQt3J/6+cF0isxEoI5Mt2wE37hXmACmFH/xwAwXC6Hm1OvzorlgTf3QipY+1O
	 gOIhrL6N3RePh9Xdb1iRqXASSdxlfTFU4c25o88bdWKKIH5xF04Of98tB7atP/5Bdu
	 3Uczsh5tPB6AA==
Date: Wed, 22 Apr 2026 17:16:12 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yibin Liu <liuyibin@hygon.cn>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>, 
	"mjguzik@gmail.com" <mjguzik@gmail.com>, Jianyong Wu <wujianyong@hygon.cn>, Huangsj <huangsj@hygon.cn>, 
	Yuan Zhong <zhongyuan@hygon.cn>, "jack@suse.cz" <jack@suse.cz>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"alex.aring@gmail.com" <alex.aring@gmail.com>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG1tOiBBZA==?= =?utf-8?Q?d?=
 RWH_RMAP_EXCLUDE flag to exclude files from rmap sharing
Message-ID: <aejzSsiXZBK1emv7@lucifer>
References: <20260421020932.3212532-1-liuyibin@hygon.cn>
 <aeikm2e5Gh5reJ30@lucifer>
 <bc514883d6154420b3cfde4ab25a20c7@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc514883d6154420b3cfde4ab25a20c7@hygon.cn>

On Wed, Apr 22, 2026 at 12:51:06PM +0000, Yibin Liu wrote:
> First of all, I am truly sorry for not using RFC.
> Secondly, I omitted many maintainers because I wanted to “not disturb too many people”,
> and I apologize deeply for that. I will fully follow these two rules from now on.
>
> As for this patch, indeed, as Matthew said, the truncate part is not feasible.
> My original intention was to apply this to frequently used library files like libc and ld.
> Contention on the i_mmap_rwsem lock (which eventually turns into osq_lock) caused by
> these two files alone reaches up to 70% in the “256-core execl” case, as observed from
> flame graphs. Besides, no one performs truncate operations on libc and ld anyway.

Interesting, would be good to see these? And more details on the scenario?

What workloads are contending that exactly?

>
> So I wanted to try skipping rmap for them. Since they are small, even if they cannot
> be reclaimed or migrated, I assumed it would not cause much trouble. Of course,
> this idea was totally wrong, and I will definitely mark such insane proposals with RFC in the future.
>
> These ideas are inspired by Mateusz’s work and thoughts
> (https://lore.kernel.org/linux-mm/CAGudoHEfiOPJ2VGEV3fDT9cDsuoHB-wk8jg-k-EK6JhWgiHkWw@mail.gmail.com/),
> so I specifically CC’d him to seek more opinions and insights.

I think the best thing in general going forwards is to bring up this issues in
advance, we're more than happy to look into things and very interested in issues
with lock contention, latency, etc.

And that way you can discuss ideas you might have to tackle up front and we can
give you early feedback, which should save time all round and help get us to a
good solution :)

Just send with a [DISCUSSION] preface and cc- people you feel are relevant (use
MAINTAINERS to figure out e.g. maintainers of relevant things, like rmap, mmap,
etc.)

>
> Lastly, I sincerely apologize for the trouble I have caused the community.
> I will strictly follow community conventions when sending patches in the future.

It's no problem, better to be direct about this - it's more useful to discuss
rather than to jump to a solution without community involvement, which might not
work out/conflict with other stuff etc.

Thanks, Lorenzo
