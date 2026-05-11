Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680C4C042A
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527039; cv=none; b=uIB94dceD9pFRnrOPQFll3gvRWQjWwwRQK3TR/gCrQLQlWbpmCnPJdacOu2DNcXrd8BkO2ywYYSdWl9/85wpu5gYUVnDp4TBHBZVERMJ6XeGhCqd7EmfUdvrmbTxdhSlAdIrOwi9jVVrsMnEOluRAS60uCoTNpi76Avuom4Qedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527039; c=relaxed/simple;
	bh=KYy9Y8SAEwJ4AJCIWKO8FPfnwtwZU9Jxhmx57vboXzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc2Sgc/7Y6zT4HC0F1Rzc8WZbnk8LlnPzgsQm4KrU7ybv5yadyijYuJtbvtKy7thyw5ReBvISI5J6WKkK3vAjbr47jqdFDs+e2ZCZ7efkWLYMyC+jng96Hv/fQ3OvDEZUj0KboBPYcsEl8fJa2t6sXk1cBIBp3VHDXk8aHTnjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (139-140-067-156.ip-addr.inexio.net [156.67.140.139])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 3E1C7E043E;
	Mon, 11 May 2026 21:17:09 +0200 (CEST)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Mon, 11 May 2026 21:17:08 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	fuse-devel <fuse-devel@lists.linux.dev>, linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd@bsbernd.com>
Subject: Re: Re: [post LSFMM summary] where is fuse going?
Message-ID: <agIqECaAKFuqdi-i@fedora.fritz.box>
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <87pl313ni5.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pl313ni5.fsf@igalia.com>

On Mon, May 11, 2026 at 05:43:46PM +0100, Luis Henriques wrote:
> Hi Miklos,
> 
> On Mon, May 11 2026, Miklos Szeredi wrote:
> 
> > Please let know what I missed.
> 
> Thanks for the summary.  It looks pretty comprehensive to me, the only
> things I don't see listed are the FUSE discord and the monthly/biweekly
> call.  But that's probably out of the scope of this email.
> 
> Also...
> 
> [snip]
> 
> > COMPOUND REQS: let's add this to fusex.  uAPI is simple, kAPI needs refining.
> >
> > FILE HANDLES: same: let's add to fusex.
> 
> I'd like to clarify this: do you see fusex as some sort of staging area
> for features development that would (or could) eventually be merged back
> into the "traditional" FUSE?
> 
> I'm asking because I got under the impression that file handles in
> particular was something that would be desired to have in "traditional"
> FUSE (and that's where I would rather have them TBH).  This would, for
> example, help unbreak nfs exports.
> 

I'm not that convinced that this is as easily doable as it looks at first glance.
Imagine you have a feature done in fusex.
The interface to vfs is the same and the interface to user space is the same
(to some degree, since there are those new opcodes)
but the inner workings are completely different.

I think the porting to traditinal fuse will pretty much be a rewrite, unless the
task was trivial in the first place.

Just my $.02

Horst
