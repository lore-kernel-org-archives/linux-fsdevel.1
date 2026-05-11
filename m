Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499AB43CEF9;
	Mon, 11 May 2026 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517842; cv=none; b=gLtCXgQPX1o2mfEpJZYT9ORDJi/3sRhnacb2hL49Zy7dlZAjxGn3rfwqpoKW4KlCQl1GhDF19t3R0e7C5ga+YNsp8mTQQhCPIthkVQaiga6ueUSHn0bUfT505og8wdjY6z0XEwDlkKEIeKAHBQc+RZCdFaE0zdTRaQTE98vhImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517842; c=relaxed/simple;
	bh=f66GCG7rWnniXQayboqX6Xu3Qs1oGzmGh3oPzwMIfLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zhapd5bmRoGid4J9e+cj7r2YJKoBvw450DhFCFnnBJ5LQmtKgj1SntWLSRyaQOqo9f0+vvJxkwQufkVWyLVIaj7L6Yj3gBXZ3IYe5iKSV2M9bizhio24lSu2z01Zwjq/lwN9257NbDy7xw79vw3vK6E10R1CVShL8264q1aEeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eLG4jAgC; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eLG4jAgC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XW25oBEXGmhaN5pcDWMqYvaQ/CK+wUNCTWmWle6uc9M=; b=eLG4jAgCzPPB0FFN7u9fTDhVUc
	sf1CVwpRR6zEMA39lsBfxKHh9q6DGtkcAv2FgXcCz9/g9CJUGzcxuUTSPOUyw9YM6pjqWFjXY2Fdq
	+cKWyGIrIn4AAn7L4hOjvECtjCv8pnEwdi538c/I8hAlPark5vKnrZJ5txhFfw5b5WxhneJtB6OuL
	jTpJp+9ox2IRKambfzI1uBQmbsL4Rb4gxZOlXdwB29mk6qluv+xrXrdxx+CGQpT2irBIk9W6sViDZ
	zjWOC+yf7tlBtmTxGI9Pd1DZ5WyIElWYPPS+Qnu59jaDsgbHtjWp4G47iHYwfKEscQ3bogp6V/wkx
	FWOX0tdQ==;
Received: from bl21-120-122.dsl.telepac.pt ([2.82.120.122] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wMTjP-0094QE-P1; Mon, 11 May 2026 18:43:47 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel <fuse-devel@lists.linux.dev>,  linux-fsdevel@vger.kernel.org,
  John Groves <John@groves.net>,  Joanne Koong <joannelkoong@gmail.com>,
  "Darrick J . Wong" <djwong@kernel.org>,  Amir Goldstein
 <amir73il@gmail.com>,  Bernd Schubert <bernd@bsbernd.com>,  Horst
 Birthelmer <horst@birthelmer.de>
Subject: Re: [post LSFMM summary] where is fuse going?
In-Reply-To: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 11 May 2026 17:12:42 +0200")
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
Date: Mon, 11 May 2026 17:43:46 +0100
Message-ID: <87pl313ni5.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

On Mon, May 11 2026, Miklos Szeredi wrote:

> Please let know what I missed.

Thanks for the summary.  It looks pretty comprehensive to me, the only
things I don't see listed are the FUSE discord and the monthly/biweekly
call.  But that's probably out of the scope of this email.

Also...

[snip]

> COMPOUND REQS: let's add this to fusex.  uAPI is simple, kAPI needs refin=
ing.
>
> FILE HANDLES: same: let's add to fusex.

I'd like to clarify this: do you see fusex as some sort of staging area
for features development that would (or could) eventually be merged back
into the "traditional" FUSE?

I'm asking because I got under the impression that file handles in
particular was something that would be desired to have in "traditional"
FUSE (and that's where I would rather have them TBH).  This would, for
example, help unbreak nfs exports.

Cheers,
--=20
Lu=C3=ADs


> URING BUFFER MANAGEMENT: there's a disagreement between Joanne and
> Bernd about this.  I think we first need a very high level description
> of each solution and why it's preferred over the other.
>
> LARGE FOLIOS: depends on !strictlimit.  I don't have a good enough
> understanding of writeback throttling to decide whether removing the
> strictlimit requirement for unprivileged fuse is okay or not.  Need
> more analysis.
>
> FUSEX: there was approval for the idea of using this as a uAPI major
> version update.  In other words fusex will gain feature parity with
> legacy fuse, but with a more consistent interface.
>
> MAILING LIST: we have a shiny new one, there was agreement that it's
> sufficient for normal fuse discussion and patch posting, and usually
> there's no need to cross post linux-fsdevel.
>
> Amir asked about how long it took for overlayfs to go upstream.  Well,
> I looked up both fuse and overlayfs:
>
> fuse first release: Nov 2001
> fuse merge: Sep 2005
>
> ovl first patchset: Aug 2010
> ovl merge: Oct 2014
>
> Both 4 years =C2=B12 months.
>
> So don't despair! There's light at the end of the tunnel (and
> hopefully not the oncoming train ;)
>
> Thanks,
> Miklos

