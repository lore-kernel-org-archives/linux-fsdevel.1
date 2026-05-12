Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C138B146;
	Tue, 12 May 2026 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575616; cv=none; b=iKJN4w8s73ZI5DnKEKnd6l2SxaKqwjqcv9U6Ddoa62QXnSsyJRSBdaXoUfr5TCbUNSvo1rcQa0J3xrr9bBGan90rLLxHnUIHqFJSHHMHq+BprPpx7fGWarZJlwGQUCJUJY+LkS4MDKO8Xbyo04MwUnAsTv9Ffmd5UX2lWd81M1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575616; c=relaxed/simple;
	bh=rP2rrbTYmtX0pnzwWAgx9Bk4AzyI1+98NEt+nJEMK98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JqU3BXssXYFCiWzshmfHOvZlIydHQX+j8WhZ3nRXPQMOuZUOxGYOso6FotZf3FMxuTFgKD1V1gU1yXKTlf+tXwEurFgZrwpa+FOCrd6LHnabzQG6BiYyLzTIdHwJ1/8UUGosLk2yvB8u2vVQs46Wh6uzZ5xUXMinQfQj00UxLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HKJZNwLC; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HKJZNwLC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MzWbgZ8j+y9pm/kcUkFawcJpiCfCIOigRuM4Qeo2eiU=; b=HKJZNwLCo5u/CvIOSg6YwSWhir
	FsQPWPn+c4Qo8wzbllzgKwTJW8ELi+MWCIzHe78x8TqIVUKcSXM82bEzUl1HiKk7S3YVwwRzIGwbx
	OTCTx3JVtaxfxiL1B5GiMN0tyhA6EdbAa0Gzf5qM2GxA2b1f2oV7i/dsPiOCcOMicxaWSCmhpwTh6
	xiWdPjMa7uRC3UfIvlP0Gc8FK1siLuzJJ7we3eU0tLAAYA5BqJWqnb8nsTLhbdToLvQ6fK5Erb+Me
	R7p78gad3WU32XV2ruvG9NLRL//oJo2gIVfAsdqobSAX5Rspc8xiCDokDQBtj9o3KPpfWqf3vkB+w
	kU+8He6Q==;
Received: from bl21-120-122.dsl.telepac.pt ([2.82.120.122] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wMilD-009NUY-JA; Tue, 12 May 2026 10:46:38 +0200
From: Luis Henriques <luis@igalia.com>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  fuse-devel
 <fuse-devel@lists.linux.dev>,  linux-fsdevel@vger.kernel.org,  John Groves
 <John@groves.net>,  Joanne Koong <joannelkoong@gmail.com>,  "Darrick J .
 Wong" <djwong@kernel.org>,  Amir Goldstein <amir73il@gmail.com>,  Bernd
 Schubert <bernd@bsbernd.com>
Subject: Re: [post LSFMM summary] where is fuse going?
In-Reply-To: <agIqECaAKFuqdi-i@fedora.fritz.box> (Horst Birthelmer's message
	of "Mon, 11 May 2026 21:17:08 +0200")
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
	<87pl313ni5.fsf@igalia.com> <agIqECaAKFuqdi-i@fedora.fritz.box>
Date: Tue, 12 May 2026 09:46:38 +0100
Message-ID: <87tssd5829.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 11 2026, Horst Birthelmer wrote:

> On Mon, May 11, 2026 at 05:43:46PM +0100, Luis Henriques wrote:
>> Hi Miklos,
>>=20
>> On Mon, May 11 2026, Miklos Szeredi wrote:
>>=20
>> > Please let know what I missed.
>>=20
>> Thanks for the summary.  It looks pretty comprehensive to me, the only
>> things I don't see listed are the FUSE discord and the monthly/biweekly
>> call.  But that's probably out of the scope of this email.
>>=20
>> Also...
>>=20
>> [snip]
>>=20
>> > COMPOUND REQS: let's add this to fusex.  uAPI is simple, kAPI needs re=
fining.
>> >
>> > FILE HANDLES: same: let's add to fusex.
>>=20
>> I'd like to clarify this: do you see fusex as some sort of staging area
>> for features development that would (or could) eventually be merged back
>> into the "traditional" FUSE?
>>=20
>> I'm asking because I got under the impression that file handles in
>> particular was something that would be desired to have in "traditional"
>> FUSE (and that's where I would rather have them TBH).  This would, for
>> example, help unbreak nfs exports.
>>=20
>
> I'm not that convinced that this is as easily doable as it looks at first=
 glance.
> Imagine you have a feature done in fusex.
> The interface to vfs is the same and the interface to user space is the s=
ame
> (to some degree, since there are those new opcodes)
> but the inner workings are completely different.
>
> I think the porting to traditinal fuse will pretty much be a rewrite, unl=
ess the
> task was trivial in the first place.

Right, I got the same feeling looking into the code.  But since the patch
description explicitly mentions this possibility of merging features into
the old code base, I figured I'd ask just to be sure.

Miklos, do you have a timeline for when fusex will be merged into
mainline?

Cheers,
--=20
Lu=C3=ADs
