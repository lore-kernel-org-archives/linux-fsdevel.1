Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2B3C1995;
	Thu, 22 Jan 2026 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070796; cv=none; b=eFwfvGEELttTxiznRkxpf3duTBhXOAyNK7oflU4cY8Mo1jfVRdnHp/FWTHcGn3Jw+pHlk7uwiF8oVZ8R3jEMJMIJTP1uH0MmfL7797U14U+w10TxTJhP2e4H2xxvJvDvyAazU9af35xAnpE5Iy3ywVLYWOqQ77rK7+fghADOJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070796; c=relaxed/simple;
	bh=cUoCZ/yPHd1Cmv2T8GhVS6WPmxJlXtwAz38Ylt51ijY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFU29tsbZuNlWkkgjsONRLxvTbPlstqQhBvrwN/QOsFcfgAjVYZdcD1lcnCs2b0RNh1ucvU9V9cUdzZxWhR2F+sr68Alo3iJlC3IDjSYUe3TcORWvSnOjsFb1BG+tMOmkBFRH7u9T1Ge00HFWyiwuT4XN7dq1PuAvzYSC0Mq5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A2E6B227AB6; Thu, 22 Jan 2026 09:33:10 +0100 (CET)
Date: Thu, 22 Jan 2026 09:33:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>,
	chao@kernel.org, djwong@kernel.org, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260122083310.GA27928@lst.de>
References: <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com> <20260119072932.GB2562@lst.de> <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com> <20260119083251.GA5257@lst.de> <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com> <20260119092220.GA9140@lst.de> <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com> <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com> <20260120065242.GA3436@lst.de> <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 20, 2026 at 03:19:21PM +0800, Gao Xiang wrote:
>> It will be very hard to change unless we move to physical indexing of
>> the page cache, which has all kinds of downside.s
>
> I'm not sure if it's really needed: I think the final
> folio adaption plan is that folio can be dynamic
> allocated? then why not keep multiple folios for a
> physical memory, since folios are not order-0 anymore.

Having multiple folios for the same piece of memory can't work,
at we'd have unsynchronized state.

> Using physical indexing sounds really inflexible on my
> side, and it can be even regarded as a regression for me.

I'm absolutely not arguing for that..

>>> So that let's face the reality: this feature introduces
>>> on-disk xattrs called "fingerprints." --- Since they're
>>> just xattrs, the EROFS on-disk format remains unchanged.
>>
>> I think the concept of using a backing file of some sort for the shared
>> pagecache (which I have no problem with at all), vs the imprecise
>
> In that way (actually Jingbo worked that approach in 2023),
> we have to keep the shared data physically contiguous and
> even uncompressed, which cannot work for most cases.

Why does that matter?

> On the other side, I do think `fingerprint` from design
> is much like persistent NFS file handles in some aspect
> (but I don't want to equal to that concept, but very
> similar) for a single trusted domain, we should have to
> deal with multiple filesystem sources and mark in a
> unique way in a domain.

I don't really thing they are similar in any way.

