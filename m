Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197144CA792
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285296; cv=none; b=Ti+gJMiJ/3oJsHmOq73GhO8IC6tN5aIjD04Phhb16nh7RbOdIew0HeqhrkbnrzxlTv6Y5TFcd7ciRQgiyXwr7u0X2PZjHwFiXXn9yilYg0usCtDehHYx4ChXyEsPMFsW3JZsnBwEQqtCpK/BNF47QWV4/UnlJoG49RvJUsm6iPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285296; c=relaxed/simple;
	bh=RE+/mj0bs7lCnvdhq7yhsMLR469U1MbfMzDt7uOb8MM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Cy/YE+oyljcVPXILtQhLhhARBzRq8q0CmM6OKu5oGpXi/46+w7OhWOYMlI0DERynRIBtOK32/EJOwNhhzAlvfs4rRhrk1gibOvMFurfEZ/DqCPvC0B/ahiL3JXDs1QNHJnCDey+pgCMhcCWHmvx8pp4GlFhy4OsS2Hbt6o9bIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VwHSdknl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VwHSdknl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1645B1F000FF;
	Thu, 24 Sep 2026 21:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790285292;
	bh=XvxW6mT8d7ZwNs8y43DE6kGy175JV3A6s1NeHg7Y31U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VwHSdknl7xEP7b1FaEVkfGQvgzY7Bq9QPy8oz/e1NE3fFPK+E0EqmxLUxVD6E474Z
	 9jLHR6aIzNMQjPqFMytn8DTkkTYrzOe6CsCFDiaEE+onUHG0VnkyhRDtFb0iXKTCQs
	 aKjp+2GLv3gYu+5U2lMHWSihDZzI8HSxzxFXHdSk=
Date: Thu, 24 Sep 2026 14:28:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Jane Chu
 <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Christian Brauner
 <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>,
 "Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v9 08/15] hugetlb: Use the has_hwpoisoned flag
Message-Id: <20260924142811.ae18e0b9b741530f5991533c@linux-foundation.org>
In-Reply-To: <arVxle46OHWjL7Sk@casper.infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
	<20260805210557.1118966-9-willy@infradead.org>
	<a51a6236-8881-4479-8f04-39676e0e1f14@kernel.org>
	<an3uN4TAAZ2miXhe@casper.infradead.org>
	<7608c80e-645b-4d07-bba3-ef45ee36fba4@kernel.org>
	<arGidwZQrrWVPAoj@casper.infradead.org>
	<7a23511f-365f-436f-b934-6a520510409c@kernel.org>
	<arQkP2uEzog8ChN0@casper.infradead.org>
	<6121136c-de9d-4577-a30d-f00dbe244e5d@kernel.org>
	<arVxle46OHWjL7Sk@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 19:53:09 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, Sep 24, 2026 at 12:32:13PM +0200, David Hildenbrand (Arm) wrote:
> > > Oh, no, it's awful and complicated.  We could strip out the two bugfixes
> > > which are at the start of the series, but why would we want to do that?
> > 
> > Andrew usually wants us to separate bugfixes (especially stable ones) from
> > other work. Unless we all agree that they are not urgent and can go in in
> > the next cycle. I assume that's the case here.
> 
> I don't understand that preference, to be honest.  As long as they're
> first in the patch series, they're easy to pick out and don't depend
> on the other patches in the series.

It's a timing thing.

Backportable fixes go into mm-hotfixes and get upstreamed in this -rc
cycle.

Less urgent material goes into mm-[un]stable and get upstreamed in the
next merge window.

I'm OK with merging cc:stable material in the next merge window, in
which case there's no need to split the series.  But the decision "we
don't need to present this to -stable maintainers for another month or
two" should be carefully made.

