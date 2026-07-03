Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE583CDBD6
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080286; cv=none; b=siJn982bIwDdI4Bq+Jtdz8rV2rmH0PITNoRDDjvi9Oq+GIQSkslUT7IklnL8l0lGjjbEhtbOssR4UT8/DSwAfxfxRABwUc0jvtH+2uvKXkSOg+oyzelO5CloCUfBPeCuM2rw8BkFVvNbZ4OmBfr9BdRLR3vROoWQHDW5+uZSM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080286; c=relaxed/simple;
	bh=QL/JbmM3C+Gj3wW0n+ny8fxiavIYHib+hONzQqSLcfE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=h4P25koYGfiyiFb+Bymgp9JB7AV6DoPdxlyB+gII8zH+emNptXjC3I+TNPvWvWBYyHWlVddsLVDdeLbu3LILTM/FanUT31J+DBHYwV1el+JoKDQD6T+YnbAZHXTp302cGmcsbF8mMheUQ9BzbM0KLKwcMfXYFBRukA2Ev8eUvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=R65ji+jQ; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="R65ji+jQ"
X-KPN-MessageId: 5c0e38d1-76d7-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5c0e38d1-76d7-11f1-9e8e-005056999439;
	Fri, 03 Jul 2026 14:04:35 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 5c0d1f70-76d7-11f1-ae68-0050569981f5;
	Fri, 03 Jul 2026 14:04:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=ShKuearSCixOYAeSxjNsXyZsTRzB90Z7PdTAP8O3Zdc=;
	b=R65ji+jQyBHXZuYMNGloUNd6hr3KUSK3DVSj7ixoLx8pyyzR0ZAeP2BUFFD7ciihipLr6fl+4tpIm
	 EhrfcIWJ7ZOOoefq04TWLKq6Nkf9jVUPS1l1BCGtHI4G3v1UtWQGRFVTxRoUXlrUdIaltDZRu+CDxo
	 QQ7pjY21v5uEd5Dp7gpZCb48PCNG4BF3DrmSo5kdxvcS5dSvvoQrIGdfWHbZbGB6uXymD1aTopFkG0
	 Rxs9tA7ZLRoDatLyuWp1BWgViudIEohOf7RzYbERcxsAgRmgI18tT2ZSPrN9HJxcuIZ1mFU6Al7EaL
	 oeIOR3xDZr/uY8dKWkm1G/U0DUj3wYQ==
X-KPN-MID: 33|i553sxXguCOuWlvSms49Rao/AC5ZGcUTriItsg+4v+Kq9/XUC5N2/8ZsrrzaSaV
 f1LQe50ouABx3MMhLgYW1tebxM0XakbYH2nwibPOk5aY=
X-CMASSUN: 33|maPTHT/kMkQTBE6kjGhKEgp2bFHu29e7whvnZBQDCFcnBWN53c5M4Z0kY8ItD5K
 x6Ah+lzf/1sAzdfs/HFoUVQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 5c00487c-76d7-11f1-916a-005056995d6c;
	Fri, 03 Jul 2026 14:04:35 +0200 (CEST)
Date: Fri, 3 Jul 2026 14:04:35 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Theodore Tso <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <1886933652.3937738.1783080275874@kpc.webmail.kpnmail.nl>
In-Reply-To: <akeaouJETPWpE838@mit.edu>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
 <20260702163215.GC3559965@killaraus.ideasonboard.com>
 <2026070350-drown-untreated-5835@gregkh>
 <a095d9b4-f774-47d9-affd-d519d8acfb34@kernel.org>
 <2026070343-copied-quarters-1e2a@gregkh> <akeaouJETPWpE838@mit.edu>
Subject: Re: [PATCH] Documentation: remove the requirement for LLM
 attribution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 03-07-2026 13:42 CEST schreef Theodore Tso <tytso@mit.edu>:
> 
> Another metaphor might be that people shouldn't try to evade paying
> their taxes; merely passing a law saying they have to file correct tax
> returns doesn't guarantee this.  But it was specifically the law
> against tax evasion is how US Law Enforcement arrested the Chicago mob
> boss Al Capone.
> 
> Just because some people might lie doesn't mean that we shouldn't
> bother to ask everyone to fill out tax returns.
> 
> Cheers,
> 
> 						- Ted

I think the point that some people who are more negative on keeping the tag
in were trying to make is not that we expect everyone to follow the rules, but
that having rules with no consequences are bad rules in general. And this is
illustrated by your example.

But I see there is quite a bit of consensus on the general needs:

- it's more relevant to know how an LLM was used than that it was used (and the
  tag is just a quick indication of this)
- advertising for particular corporations does not really serve any purpose to
  the community, so just say "LLM"
- the tags may be used to prevent arguing
- the requirement to be open about LLM use (whether by tags or whatever) makes
  it easier for maintainers (if they feel the need) to de-prioritize patches
  by someone unwilling to abide by these rules whenever the maintainer perceives
  or suspects prior undeclared LLM use. This prevents an asymmetrical situation
  of LLM slop being produced much faster that what can be reviewed.
