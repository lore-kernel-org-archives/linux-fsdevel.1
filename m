Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599073;
	b=x3r9hSOKsOtxJZBLjg99ow2AYLSLDGskbRuXKgXOeXQKKXMrAHeQ3DqiukvDxGQIm5nS
	 ibD4pOl7DmgpEhXCn3US0mjdq1tJ9ayZ06ehy2qzk1zGbVDnCYpmG03CZ4v2WrT9tDFE4
	 S79ZbVJ2HiFcxKZIgQwv+fbXHk1tcDUl3JHX0ZoDPDQS69G3/BtfLRxKaN3yb2LvaxWSy
	 J0FaSglQn5NYnXr/mnVF7pqlj9/UWSa6WnATnKggIA6dzgLRULzzqQ2/klPbCOUU0SRMi
	 CfQ3L+Nvkon/lc9Z5Mx36LYh3z0m1EzYXy1S7j6UL12DbcFSM8dJuWmKLjmlN4RK5DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599073;
	h=DMARC-Filter:X-KPN-MessageId:Received:Received:DKIM-Signature:
	 X-KPN-MID:X-CMASSUN:X-KPN-VerifiedSender:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Priority:Importance:X-Originating-IP;
	bh=vYW0lwNtZZp4xMT2btYq2BWBULtTKydr9Jf0sny4QFw=;
	b=nMzcNC8n0PvqIE6+zwEb/WBBgpqXg3uGdBpnovgBl4b+vN7YyK1y9dhSSJ+e+8bRAbCK
	 bGeOQdOniqf9OH7XktXdwNw20ZiXafva02syHk903Gxy9xbEMvpI8n2aWRZFCg7hik2Nd
	 xZgu8TuCuBoju+K7debkaW9qzMbCK25x/FKfSyNBSzZaXoahzIFXm/Ch4UxyQXFPYS2k+
	 X8vrClCaQqldkeTd/eLilSk+IV3t2CSi486QJOvvlila7Qvrf6QIW1Uc3aQHjuXUXbjPG
	 8FO6hFc6+bvn/Pnld99x9Wt+88cuPTldVJyNDaBrM09+gveU9MdBQD+EKjFBJhF4NMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=B9IYqj7t;
	arc=none smtp.remote-ip=195.121.94.184
Received: from ewsoutbound.kpnmail.nl (unknown [195.121.94.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABE606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 09:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FABE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=B9IYqj7t
X-KPN-MessageId: ef456eb1-e8b2-11f1-98a9-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ef456eb1-e8b2-11f1-98a9-005056994fde;
	Wed, 25 Nov 2026 10:31:04 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id ef41f494-e8b2-11f1-92a9-0050569977a2;
	Wed, 25 Nov 2026 10:31:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=vYW0lwNtZZp4xMT2btYq2BWBULtTKydr9Jf0sny4QFw=;
	b=B9IYqj7tcmscv9KSkAsiO9t2Q5Z4gC6oTu2tMa92BR7tJDPkJpiygv4d+cymrEaZWCu7XjBj3nbHH
	 +3Re+xbFr2GjqgAVLb25aP5GPnTggSiwMmkU7+LaMDVgJL+puCNVXXE3ii/crNsCCq+C9mCYIAmCuZ
	 DuVc5m9E8miIzRO9ffJad8VApbPGvRVpIwnRZURQAXxxgCiKvlYWFaKEvhwOZjWArQ1AVVJnmCTttQ
	 MkM+K21YXpdhycvedKrM9qbhhSbQrkJq1qYrEfpKgnI8T4AzpAbnEp7326KTfN/CObwRgyHjYKD5TF
	 9GEypZOLG6HPOl78PnBsYxxvS0QUitQ==
X-KPN-MID: 33|MZfs89VgIfoUJX5X2lu9dngP4j3RU3Wytuy/Lq5JXjuWesmN2j2bIIbiN5/nPZ8
 jHrsvxnk9cVg6LP55kyafNw==
X-CMASSUN: 33|UKWRjPuv7sOoLQoEalkZh/lhDxaoITAfJMz4dawX254Bhx/9sWugtQscX8vqyD8
 dzeSSc5ojlTE1npcaQcmQAw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id ef366f9d-e8b2-11f1-94bb-005056995d6c;
	Wed, 25 Nov 2026 10:31:04 +0100 (CET)
Date: Wed, 25 Nov 2026 10:31:04 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Askar Safin <safinaskar@gmail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, cyphar@cyphar.com,
	gregkh@linuxfoundation.org, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	neil@brown.name, shakeel.butt@linux.dev, tj@kernel.org,
	viro@zeniv.linux.org.uk
Message-ID: <1709003566.2632299.1795599064030@kpc.webmail.kpnmail.nl>
In-Reply-To: <20261125062146.940336-1-safinaskar@gmail.com>
References: <20261024213539.1307600-8-jkoolstra@xs4all.nl>
 <20261125062146.940336-1-safinaskar@gmail.com>
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


> Op 25-11-2026 01:21 EST schreef Askar Safin <safinaskar@gmail.com>:
> 
>  
> Jori Koolstra <jkoolstra@xs4all.nl>:
> > Requesting write access on a directory can never succeed. Rather
> > than performing a path-walk to determine whether the target is
> > actually a directory (-EISDIR) or not (-ENOTDIR), or does not exist
> > (-ENOENT), etc., we short-circuit to -ENOTDIR.
> > 
> > Currently O_WRONLY for directories is only blocked in may_open(),
> > which happens after we have the inode for the target, so after any
> > create via O_CREAT|O_DIRECTORY.
> > 
> > The advantage of short-circuiting is that we don't have to add even more
> > logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also, for
> > filesystems that define ->atomic_open, handling this cannot even be done
> > at the VFS level, as we can't know ahead what the result of the lookup
> > will be.
> > 
> > Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > Reviewed-by: NeilBrown <neil@brown.name>
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/open.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/fs/open.c b/fs/open.c
> > index e43f02ff64ac..4334f30bb7ff 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1343,6 +1343,15 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> >  
> >  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
> >  
> > +	/*
> > +	 * Requesting write access on a directory can never succeed. Rather
> > +	 * than performing a path-walk to determine whether the target is
> > +	 * actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
> > +	 * to -ENOTDIR.
> > +	 */
> > +	if ((flags & O_DIRECTORY) && !(flags & __O_TMPFILE) && (acc_mode & MAY_WRITE))
> > +		return -ENOTDIR;
> > +
> 
> Please, do -EISDIR here, not -ENOTDIR. You returning error here, **because** user attempts to write to **directory**. EISDIR is natural here, ENOTDIR is not.
> 

That's a fair point, and I have thought about this. The downside is that
if we return -EISDIR there, that will also be returned if you open(O_DIRECTORY)
what turns out to be a regular file. So you may then get -EISDIR for something not
a directory.

The semantics of -ENOTDIR here that I had in my mind is something like "the thing
you are trying to do can NOT be done _with_ a DIRectory." It made a bit more sense
to me (but only a bit.) Really it should be -ENOTWITHDIR or something...

> (I'm human, not LLM.)
> 

Glad :)

Best,
Jori.

> -- 
> Askar Safin
