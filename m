Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088943F0BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150541; cv=none; b=HlbgRMaW15b4Y8OkHZbskAqh1FU9y5u5S2sw93nyn1t0AXGwUoAFjJSYXtWdvORLUD8Uq/p0ftlSmsaq+XDqh/mF9cM+vEbe37SNrJJbSzwhpduxSMYmejIVtYb5UM2OcY864oJascwhDev/4aGZjOuCZmJgzwFqRcM/I+0fn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150541; c=relaxed/simple;
	bh=50poBoTud6wBU16DkUL7iT6x6+ZJYyeUldATTaYXdYY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DYhj2TEouC16ojrrds/cuWyuPjT1OTrETGAloTqVpNjAOuy56Td0eo4XoNajiqjyFK/5lMTwfMqJB4Y6Qs1zoxj4VmEqDFC78MWLkrinGAbYmm6UDV67HcSe8uAyTf7azCIIWo6xIQ33T2zRXuzD/qUzfLiYdrHEbcngWn6YchM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=C6IucCQ+; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="C6IucCQ+"
X-KPN-MessageId: 1758e90f-8093-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1758e90f-8093-11f1-9e8e-005056999439;
	Wed, 15 Jul 2026 23:21:06 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 17581469-8093-11f1-ae7a-0050569981f5;
	Wed, 15 Jul 2026 23:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=LBhVq4djpnixsGBXFV5qb8m4nFbwbzRupiZid57kH24=;
	b=C6IucCQ+1BeZWP6Ia2ewwH5ZvpOL18QPqu4R3Wwn8bT6ir28ClMJF4qe4rnyI1tw9UiRwJG1Z5nc0
	 k03caWUjTH7B7Ot74jCxunlVsMWKjnDLtvUcQMqYrSe5CWrTazaDJFIcchL6ukTxavAq6D4nRIX6w7
	 l29Nq5Cc4CX2REDhYMqB9hfLMFRzRdaT6aNLgHMISIDDv1MYKKG4tX86Sq+SknS3Q8gmuiuLL9HmXM
	 g22TP68YbvKJiiJU0l1Jj6oNNq8r3qzOGVsqvjldghWZ2VZqJBwmx3EsWa76rhWx0imfSHwQ05sr26
	 cSS0SkZHBhEINrlU+leTy8UHuXYaCZg==
X-KPN-MID: 33|XGmdIni2F8pvA8zUMxGTZE8EjzDYrFMS5gxziAQq9R7R2OqWBHzc096RMb7xv97
 3UGFuboumnyx/8E5SUG4PwQ==
X-CMASSUN: 33|rXlHwcukO6nk1APfBdjgrIY7ZLUD4n3zjC5zWnykReokeat7IKHSmPZoPDFu7/z
 zJenv6OZeTa8yxOIH8XIUPA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 1747b69e-8093-11f1-8edb-00505699eff2;
	Wed, 15 Jul 2026 23:21:06 +0200 (CEST)
Date: Wed, 15 Jul 2026 23:21:06 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Message-ID: <271981356.1167752.1784150466429@kpc.webmail.kpnmail.nl>
In-Reply-To: <178406989145.3371781.14103195631413999969@noble.neil.brown.name>
References: <20260713060814.2849-1-neilb@ownmail.net>
 <20260713060814.2849-4-neilb@ownmail.net>
 <1899194169.820712.1783939194879@kpc.webmail.kpnmail.nl>
 <178397971669.3371781.14361088370957076736@noble.neil.brown.name>
 <2091253759.1001623.1784032128121@kpc.webmail.kpnmail.nl>
 <178406989145.3371781.14103195631413999969@noble.neil.brown.name>
Subject: Re: [PATCH v3 3/3] VFS: add vfs_lookup_open() for nfsd
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


> Op 15-07-2026 00:58 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
> > 
> > Yes, sounds good. Keep in mind that vfs_open() does not handle truncate, it only
> > happens in do_open() in the open(2) path, so you must handle the actual truncation
> > back in the nfsd code. You are probably very aware of this, but just in case :)
> 
> O_TRUNC handling is a bit untidy (or convoluted to use your word).  Some
> atomic_open functions implement it, some deliberately don't.  If
> atomic_open wasn't used, it happens much later.  Maybe I could try and
> tidy that up.
> 

Wait, so for those ->atomic_open() filesystems that do handle truncate, how do
they deal with this? In do_open() we have

	if (file->f_mode & FMODE_CREATED) {
		/* Don't check for write permission, don't truncate */
		open_flag &= ~O_TRUNC;
		acc_mode = 0;
	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
                ...
		do_truncate = true;
	}

So on truncate do they just set FMODE_CREATED regardless of whether the file existed
before or not? Or does truncate count as create in general?

> > 
> > __O_REGULAR is also only handled in do_open(), so it does nothing in namei.c right
> > now, still seems good to include it. I don't understand why the __O_REGULAR
> > implementation is so convoluted, but I haven't looked into it yet. I plan to do
> > that sometime soon.
> 
> Some atomic_open functions handle __O_REGULAR, and I think it best to
> abort an unwanted open as early as possible.

Yes, you are right, my bad.

> "convoluted" happens when code grows over time and people work with what
> is there rather than tidying it up first, then working with tidy code.
> We cannot tidy everything all at once, but if everyone making changes
> does a little bit of tidying, we might avoid too much convolution!
> 

Haha, maybe this is math-speak, just like you have legalese. My professor at
McGill used to call certain proofs "convoluted" if they involved a lot of
seemingly senseless rigmarole. I guess the term stuck :)

Best,
Jori.
