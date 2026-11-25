Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602570;
	b=zerb4Ms0NzPTSBfd+3KXLeLIQn+FAK7Ca5bLnTAWjaKgw8mMsHrljbTbM6bGaoupRBPw
	 C0tdCUJUXmFgi7sJNxZQtx9Q7hlovzo9FCKjxsdIKP/BMR7lOm2EhFECQIQFmdauihQFi
	 LYY5kbRO9cYPE6PDxIdKigd5r108X/tSalTGZkvl+5j0w2rjSHG+SG5/8Hm6nBSa6uA2c
	 7XAADhbbn1POUzC5vAmiQ88ulr9xrbteQ3EzM/IY3ZeQqeh8WnvhpbjMjgTmnkxMWDeh5
	 Fql9GW5dOxZyzx+tAwqF9NEfUeU8gYsEjjgMOnV4eCEXQ7laQ9RYkyxGTmAUGGFVScQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602570;
	h=DMARC-Filter:X-KPN-MessageId:Received:Received:DKIM-Signature:
	 X-KPN-MID:X-CMASSUN:X-KPN-VerifiedSender:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Priority:Importance:X-Originating-IP;
	bh=5lWskPpxSpVBM0554F5pOSMgYG3IHJbd4zdoMwkKnx8=;
	b=5FEoSrdeK+rFpl/k8B+ncThXD6Phi094tVSq55VbQyrRFLItuyXwmd0A7ThvPH3oKcq5
	 5ZyIpfPl2EcdzYZ41mUiaidpa4d/NFUk8GV1Z1JEh9SSbpJhgTXIByodtR8XBFjI6h68y
	 hRNumPDPDwqYDCHw741SkFKK4VZDQeXsSkDVxZLN8Hf46MnqV7Jj6bwbvesNtSsKFizjY
	 hfetkZwUwnHtidJFJ6B+iyWOz2krB8w/WqLoHrzc00OTAxMg7/g2RoIVC9sUbtuBOnAiB
	 fluCaQzt8PCv7aln+jWJoIzgSbxZv/nawCc7H5bPrXaOjUbd0aZLzI1EL7ZJalEZNIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b="SV0tuq3/";
	arc=none smtp.remote-ip=195.121.94.184
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42FC606A33A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 10:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A42FC606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=SV0tuq3/
X-KPN-MessageId: 16c790c5-e8bb-11f1-98a9-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 16c790c5-e8bb-11f1-98a9-005056994fde;
	Wed, 25 Nov 2026 11:29:26 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 16c649de-e8bb-11f1-b790-0050569981f5;
	Wed, 25 Nov 2026 11:29:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=5lWskPpxSpVBM0554F5pOSMgYG3IHJbd4zdoMwkKnx8=;
	b=SV0tuq3/iY9XRnC+vVoYya735NtiSTNQN/wVmfBKVY4splmjcRMXDR8MoO4nI9qp6q+Qt1zSWnClY
	 wxH8ljoJKSIXOoNE2Teo6KblKlKHtyQrdD1MiJ88VA3/WYA7q9rjSzQFSNrjQPkT/7YuwgDLrbhR49
	 sV4ra55XjXQ+8bUodSOmKPvxG7JJ5PZ5koky2bZkZJl08/PkUOV0tg0B2WAy7BBhc76W9PmNRyhfr9
	 P6PXOS5kmoXHXITPEzD4Xafla+0i/niB1hQTo7fwIQApSHJgd83UiuLd1athY6grnnKSpEzdpT5Bub
	 oZvMviyij7e4UIL0PXV7ZOJDX58FzYA==
X-KPN-MID: 33|abuoIPfUh3YDIVibj50uBK0NhQsvAnjouC1eafIocI2xFVzX4ozsyhxPVRFEoWz
 LZMHTp2LUufuqtX8zeucRpqeOfejvk49SLjIuHwBBrUA=
X-CMASSUN: 33|hhJwsfS/sAWL6fRjrpSZIKKBBUJkfKcer9nfdw4faiI6b9jYTRd83LZ+aHzHFsx
 2auc/avy5F2ZnlDhj+kDAXw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 16bc5e5e-e8bb-11f1-94bb-005056995d6c;
	Wed, 25 Nov 2026 11:29:26 +0100 (CET)
Date: Wed, 25 Nov 2026 11:29:26 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Askar Safin <safinaskar@gmail.com>, amir73il@gmail.com,
	brauner@kernel.org, cyphar@cyphar.com, gregkh@linuxfoundation.org,
	jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, tj@kernel.org,
	viro@zeniv.linux.org.uk
Message-ID: <1119017860.2578021.1795602566314@kpc.webmail.kpnmail.nl>
In-Reply-To: <179559977412.1728055.14071803405199089608@noble.neil.brown.name>
References: <20261024213539.1307600-8-jkoolstra@xs4all.nl>
 <20261125062146.940336-1-safinaskar@gmail.com>
 <1709003566.2632299.1795599064030@kpc.webmail.kpnmail.nl>
 <179559977412.1728055.14071803405199089608@noble.neil.brown.name>
Subject: Re: [PATCH v8 07/12] vfs: short-circuit MAY_WRITE access for
 O_DIRECTORY opens
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 25-11-2026 04:42 EST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Wed, 25 Nov 2026, Jori Koolstra wrote:
> > > Op 25-11-2026 01:21 EST schreef Askar Safin <safinaskar@gmail.com>:
> > > 
> > >  
> > > Jori Koolstra <jkoolstra@xs4all.nl>:
> > > > Requesting write access on a directory can never succeed. Rather
> > > > than performing a path-walk to determine whether the target is
> > > > actually a directory (-EISDIR) or not (-ENOTDIR), or does not exist
> > > > (-ENOENT), etc., we short-circuit to -ENOTDIR.
> > > > 
> > > > Currently O_WRONLY for directories is only blocked in may_open(),
> > > > which happens after we have the inode for the target, so after any
> > > > create via O_CREAT|O_DIRECTORY.
> > > > 
> > > > The advantage of short-circuiting is that we don't have to add even more
> > > > logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also, for
> > > > filesystems that define ->atomic_open, handling this cannot even be done
> > > > at the VFS level, as we can't know ahead what the result of the lookup
> > > > will be.
> > > > 
> > > > Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > > > Reviewed-by: NeilBrown <neil@brown.name>
> > > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > > ---
> > > >  fs/open.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/fs/open.c b/fs/open.c
> > > > index e43f02ff64ac..4334f30bb7ff 100644
> > > > --- a/fs/open.c
> > > > +++ b/fs/open.c
> > > > @@ -1343,6 +1343,15 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> > > >  
> > > >  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
> > > >  
> > > > +	/*
> > > > +	 * Requesting write access on a directory can never succeed. Rather
> > > > +	 * than performing a path-walk to determine whether the target is
> > > > +	 * actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
> > > > +	 * to -ENOTDIR.
> > > > +	 */
> > > > +	if ((flags & O_DIRECTORY) && !(flags & __O_TMPFILE) && (acc_mode & MAY_WRITE))
> > > > +		return -ENOTDIR;
> > > > +
> > > 
> > > Please, do -EISDIR here, not -ENOTDIR. You returning error here, **because** user attempts to write to **directory**. EISDIR is natural here, ENOTDIR is not.
> > > 
> > 
> > That's a fair point, and I have thought about this. The downside is that
> > if we return -EISDIR there, that will also be returned if you open(O_DIRECTORY)
> > what turns out to be a regular file. So you may then get -EISDIR for something not
> > a directory.
> > 
> > The semantics of -ENOTDIR here that I had in my mind is something like "the thing
> > you are trying to do can NOT be done _with_ a DIRectory." It made a bit more sense
> > to me (but only a bit.) Really it should be -ENOTWITHDIR or something...
> 
> The problem is that "flags" contains an invalid value.  The correct
> error for that (according to open.2 man page) is EINVAL.
> 

This is best probably. The counter is that I wanted to change errnos as little
as possible. Now you get at least something that could already happen when
you did a normal open(O_DIRECTORY). Were this designed from the start -EINVAL
is obviously what is needed here.

I dunno, not sure what other people think.

Best,
Jori.
