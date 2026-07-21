Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18344AB62
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669069; cv=none; b=ZLotvgDFE8H1meUho+qwE5tRxHeYLiyBZh5Wa3P0nKQlcwFe1KIPO4WURpr+gptFPVBJynJRN57rxoVFlStqhKWPGh9rpra/PIArAarlhe4Z9OKwp/pp4z2ZHvmnAoMdpsoIh7Yd64WfTjMDKDuJg/H+pwkSibkdnguD0nPEpv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669069; c=relaxed/simple;
	bh=cpuJoYm2eItJd5nrzbvZqR19BqyBNJYE4tMvt9cTkpc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jc+SltG8VyVpYUI4r0h9pdKjDcF0by5MBPMTGA98OvabK/RirB5w9y30jwReAiCgK3SnTs3A1NlRq7DiumBzO+VpqHde3ERzWFJ2Vuq2SUp4eBgSv5dWrlCgvLOBmTe6uJNUf1EH2VCXSCC1IVybwkf8JwkzgmzSMobg6K88Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=eGJ+bQrN; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="eGJ+bQrN"
X-KPN-MessageId: 8b4f7099-854a-11f1-a5a0-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8b4f7099-854a-11f1-a5a0-005056994fde;
	Tue, 21 Jul 2026 23:24:23 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 8b4e1c49-854a-11f1-9b0e-00505699693e;
	Tue, 21 Jul 2026 23:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=N5BLlQFEcRiE1Sde91BDObh+hNsc0KboCos3L6OKJkI=;
	b=eGJ+bQrNfE+lnX2lwy3A6cjSPsWibm3C1R90+qB+RE0aHEvMtMln5nkVY2gW+07gtSny8o/vfqr1g
	 aHzZGvFDKr+bBlgHXbbnSmHNXmQHJ2IPIVLlolF55NyGjfxL3PJV8MUo8ldB/mfUexK6uyHgTCPDq+
	 TdRdyzFgDXLLXloMinPV8HFH9+uDmfnSud3Z7kuulVOXjj1olXSOs8A4eXBYosQr7+CRVtNe2fDQoO
	 m497oz2uKpnug1w5zFxvKDG1VAZVznRgY6NOegkVm5ivNPkgMjwWmbsafdFfLh9JFLxNAG6H1KE6P/
	 4vojmFrEXR9UbzqYDDx0A6lSeoy3JRw==
X-KPN-MID: 33|ZkMYxmGLKQow1ZHrlMt/4NXuN6sfItdY0Pq6P/f52ZY/s4O9zEdp0H1Ux8AVduB
 39EQQSIDy4uBgb4XcoHmuqnD577obatO98yvNZwtqNPU=
X-CMASSUN: 33|tfIYyv0R8Tn4aO6L4RTGiFk8G1QeCE5FSRg6lQey1pL62/J8WmygtdT7CpZ9FbB
 8eTUs0ObHZZgREfBc4VIkFA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 8b412716-854a-11f1-916a-005056995d6c;
	Tue, 21 Jul 2026 23:24:23 +0200 (CEST)
Date: Tue, 21 Jul 2026 23:24:23 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Message-ID: <1490872085.93240.1784669063554@kpc.webmail.kpnmail.nl>
In-Reply-To: <178459188006.3371781.5620319924458142615@noble.neil.brown.name>
References: <20260714230534.776886-1-neilb@ownmail.net>
 <20260714230534.776886-4-neilb@ownmail.net>
 <21817263.1168614.1784151799976@kpc.webmail.kpnmail.nl>
 <178415489698.3371781.5121934606972521996@noble.neil.brown.name>
 <1697164687.1184851.1784159287934@kpc.webmail.kpnmail.nl>
 <178432915017.3371781.13946671241977454321@noble.neil.brown.name>
 <381790643.1478590.1784412802571@kpc.webmail.kpnmail.nl>
 <178459188006.3371781.5620319924458142615@noble.neil.brown.name>
Subject: Re: [PATCH v4 3/3] VFS: add vfs_lookup_open() for nfsd
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


> Op 21-07-2026 01:58 CEST schreef NeilBrown <neilb@ownmail.net>:
> > 
> > I am not so familiar with the audit stuff, but you don't init nd->name here. Will
> > this possibly lead to a new AUDIT_TYPE_UNKNOWN type struct audit_names for every
> > invoke of vfs_lookup_open? See __audit_inode() function.
> 
> I'm not familiar with it either, but I reasoned that as audit_inode()
> clear handles a name of NULL, then it is safe to pass that name.  And
> that is the best we can do from nfsd.
> 

It is safe, my worry is about memory allocation of large amounts of
UDIT_TYPE_UNKNOWN type struct audit_names. But I dug a bit more and
we are in AUDIT_CTX_UNUSED context, so the whole thing is short-circuited
anyway.

> > 
> > That is also a bit of a pain-point here in general. If ever lookup_open() was changed
> > to use more of nd, then you must remember to initialize the field here as well, which
> > makes this function quite fragile.
> 
> All the fields that I don't explicitly initialise get initialised to
> null where nd is declared "nd = {}".  So it should be fairly safe.
> 

I was more thinking of a situation such as someone refactoring:

	struct dentry *dir = nd->path.dentry;
	struct inode *dir_inode = dir->d_inode;

in lookup_open() to

	struct inode *dir_inode = nd->inode;

(or at least I guess that is the same thing?)

Or something else, where you expect an actual value is available, like
last_type (which in this case would be OK by accident as LAST_NORM is
the first in the enum).

Maybe I am being pedantic, and if you feel so, I am not opposed to the
the current form completely. It just feels error prone. However, you
have more experience, so I'll leave that final judgement to you.

Thanks,
Jori.
