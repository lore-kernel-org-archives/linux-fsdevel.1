Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305796;
	b=OBQtLRER4K2UlPEBaGGp6+nd1Zqv1Awk6tgBgV93g743yIycrTVEdb40j3Ratzw5MWIB
	 2rqxVFQsTLkiJ58UtU1qwlQRLx0cSylzFZCiUSDkNuCNra/CxT+ECC80jG+cV8r5n1yPs
	 h+3UdUww/ReNcncZzrddSANBQKLv4OZPudE9fMyf8DI/5i/1tgqIg9FbQnfi19cY0HANF
	 nMNb2ReHdSn7+13ckmOrfQsHXPhdxpaskCUI9y151a+oSrtiJXEFPcTT0nWr01DeWAYiR
	 09TAi5q5OuTUTF0nlfuXsc5FnNdjNWOFniI1QUdasEutkvL1VfKDhnvezWqf+Q/leBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305796;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=MDp3IqGPnUg5d4UvWr85er90NqjbtetB6LOR1Vib6ms=;
	b=ppdJOHD8RrTfW5O/1LqdrCr87r0hNVaxxI0CvytE9Rv8oEwIw/QOjtfjOHHX3yp4JFXO
	 7aXpyIB+5/7YxoMaTkcf7EOeAKA3NhVzoHoks22vrKZKUf6A75fIjgLyVlpTt04w+GnWm
	 6KyAb+1uRS0hYn5Fo0b+Mnr6jQKx5dhCIm34CO61g+e/uIY2uljYiMlyUu38vL0Iw/+s2
	 BXH83XsONiSFZ5BBFo9ZoSDrqMQUVCP3ENbd2uwB/FWszzsfwYGo09S/06ym9Rqbab2nr
	 /ZDcmY8Xq6JZdW0AyK/sNeg8+/HcfVb5e16rVaDi5Q65M/CLG9JJdgDIDPyvfsLfNNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sxzp+Vk8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB86606A326;
	Tue, 10 Nov 2026 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sxzp+Vk8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB011F008A1;
	Tue, 10 Nov 2026 10:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305795;
	bh=MDp3IqGPnUg5d4UvWr85er90NqjbtetB6LOR1Vib6ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sxzp+Vk8VglSZ5vV85C7ikwtPz+uz1IRnb3NOrd9Wun8KllMzb2LUbi+i6S0gLMcN
	 5jXugi37YSIvM3zftdxNZttbrWR8y604vZbxqGJdcnIz6gNkpmozDfKF1jHBgGboZ0
	 DcGcz+RSyCQJi3bdbkhFl4xPL+IMrYUIlHLE+CUR4GHE1DWdiu+2AsyFGSd+1Rmb6b
	 pmcE6nCVlxkLCoRYQDlfiqboncz8qtKqB3XFd0hUkPaQZ5jR35v1bgqtrOve73lm8+
	 rPRXSAbkTAra4IPA0HVOaQx4A0yI8AKrAzEBsuthbisPV/Z7UV7wlm7ln7PcMu+wBs
	 CPNwrHnTMpM8g==
Date: Tue, 10 Nov 2026 10:16:26 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: linmiaohe@huawei.com, william.roche@oracle.com, harry.yoo@oracle.com, 
	jane.chu@oracle.com, nao.horiguchi@gmail.com, tony.luck@intel.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, akpm@linux-foundation.org, 
	osalvador@suse.de, rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, sidhartha.kumar@oracle.com, 
	ziy@nvidia.com, david@redhat.com, dave.hansen@linux.intel.com, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] memfd-based Userspace MFR Policy for HugeTLB
Message-ID: <avLunMb-pVIigmkT@gremlin>
References: <20260203192352.2674184-1-jiaqiyan@google.com>
 <ahXI0cK9fsOByvKy@lucifer>
 <CACw3F51Q9TkMWr4WbnN07q60L6vj72-hFWwpqf0n6rf+drfb0A@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F51Q9TkMWr4WbnN07q60L6vj72-hFWwpqf0n6rf+drfb0A@mail.gmail.com>

On Mon, Nov 09, 2026 at 09:45:24PM -0800, Jiaqi Yan wrote:
> On Tue, May 26, 2026 at 9:23 AM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > Hi Jiaqi,
> >
> > It seems this series got stalled on review, wondered if you planned to
> > respin it at all?
>
> Hi Lorenzo,
>
> Sorry for the late reply.
>
> Yeah, I was stuck on the issue Miaohe pointed out for quite a long time...
>
> In offline chat with William <william.roche@oracle.com> he expressed
> interests in taking over this patch series. However, he seemed busy
> with something else and couldn't get to it.
>
> Fortunately we have more powerful AI now than we did six months ago.
> While I worked on [1] with an AI assistant since 2 weeks ago, I worked
> out a solution to the issue Miaohe raised [2] with the help from AI,
> and now a working draft patch series. I think by the end of this
> weekend, I can send out a v4 built on [1], the patch series I just
> posted for freeing high-order folio that has HWPoison subpages.
>
> [1] https://lore.kernel.org/linux-mm/20261110053331.2708996-1-jiaqiyan@google.com
> [2] https://lore.kernel.org/linux-mm/5e0fc743-eb44-b69f-01a2-da7b6f2eca8d@huawei.com/#t

Thanks for the update! Though do note [0], given the current wave of
AI-generated fixes this cycle is focused on that rather than new features (sorry
I know I chased this, but nobody anticipated how busy we would be with these!)

And since you mention AI, obligatory disclaimer: as with everything AI - please
rewrite all commit messages and comments in kernel mm style, and make sure you
understand every bit of the code when you submit! :)

--
Cheers, Lorenzo

[0]: https://lore.kernel.org/linux-mm/a2f584f6-e382-4876-aa6d-d5a34de6ee59@kernel.org/
