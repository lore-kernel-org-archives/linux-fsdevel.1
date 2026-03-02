Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C437C0F8;
	Mon,  2 Mar 2026 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445713; cv=none; b=bnLscfpqXcvZNJ9jUWDCqCmK28r/fuzPzSFk0CD9A+iCyj1CKcWFlEWkmoqICBQmPhYnTmXnPrhb4dHnM/QWKGxrEnxB3CILOLq5c1P6ZlGsajGZwQ+/R1ETQaORvLU7r1IGmRUkPpFfBA/NaeyuSNJp8BgQ0br+tyWHWz1tndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445713; c=relaxed/simple;
	bh=IciqQJzhiVCjx00QC/4TH8gZ1mstpwjZXHhgqOwjoOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyX3IjWnZP0FDMAEH4EzmV4IVYkkbSjxZOUvi8bsvvX+8Q1jZwY27/2rcjiiXT6lmhRZ3nk08KAkqigvVE9hkUv/qndDolmGdmAFNw2+zKvSSgcO3CSLw28yYyCnwGX079KYiWiM3cHEDJTryTq+tqjwzpM1yVc1e38iUjs2dJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 8C91FE00CB;
	Mon,  2 Mar 2026 10:56:18 +0100 (CET)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Mon, 2 Mar 2026 10:56:17 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v6 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aaVcSK1x7qTr1dlc@fedora.fritz.box>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
 <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>

On Fri, Feb 27, 2026 at 10:45:36AM +0100, Miklos Szeredi wrote:
> On Thu, 26 Feb 2026 at 17:43, Horst Birthelmer <horst@birthelmer.com> wrote:
> > +
> > +       unsigned int max_count;
> > +       unsigned int count;
> > +};
> > +/*
> > + * This is a hint to the fuse server that all requests are complete and it can
> > + * use automatic decoding and sequential processing from libfuse.
> > + */
> > +#define FUSE_COMPOUND_SEPARABLE (1 << 0)
> 
> We really need per sub-request flags, not per-compound flags.
> 
> I.e:
> 
> FUSE_SUB_IS_ENTRY - this sub request will return a new entry on
> success (nodeid, filehandle)
> FUSE_SUB_DEP_ENTRY - this sub request depends on the result of a previous lookup
> 

Couldn't we just save boolean flags in the fuse_args?
Something like 'bool is_sub_entry:1' and so on?

If we have the automatic separation and call of requests in the kernel 
when the fuse server returns ENOSYS, I don't see the point in adding this 
to libfuse as well, since there will never be the case,  that kernel 
doesn't support compounds but libfuse does.
It's either the fuse server handles the whole compound, or the kernel does.

My point is, we don't need to send that information anywhere.

> Thanks,
> Miklos

Thanks for taking the time,
Horst
