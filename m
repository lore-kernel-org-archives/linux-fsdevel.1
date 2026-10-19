Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05463353A8C
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375150; cv=none; b=uoBkYSVb9c19kDPmWc1+gCCJ/GLpKh93h/J5Z2HawB2qmj4Dg4tGioLzMzZgi/c6PHZUlf9sQuUPMgsBQd5NGaZSz9XLplqaRDM6Gl+HbOIuq2he84emWnp1YRP/jFw2ATvwmJLcVMRZg5l9kTiN0jFrP5zGNIFs1rSkNyTvj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375150; c=relaxed/simple;
	bh=Si3qx/laftTYJ+RacUVnTVoPA350XVCs5qAtOZjp2HY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jyzgKMcfCEghuhVzb+83jpGe5bFBPZjHmcreprLfxZ35Lk2tz2ml69GpzokAnDCuCliQm2hK5xwiIGCe3r7S0zH2RPcFA8LDDi7Lww3IlUm5fCBdzA7HgVKIlZHmkMuKPlL3wUV1Mn8ej1oBLTGa2R6+WBXZVty2C0EYcBvishU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=imZrchW3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KST25SaB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="imZrchW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KST25SaB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 310681D0015F
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 21:59:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 18 Oct 2026 21:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792375147;
	 x=1792461547; bh=Si3qx/laftTYJ+RacUVnTVoPA350XVCs5qAtOZjp2HY=; b=
	imZrchW3anuR4ZvAYbqx4v339+BNQMmtlXOGQP+qSlK7jOWuv3NhmmN2cB596FAT
	HNL8wioamGNmPVP7RlY/XsO0jZEO1LhRqpUJeNHNIS3l6ilZs/2gX5BYwPzLhHbh
	4xjPqnFlVtsa/JG0SVZXyV0GNNttrCRQ6ipcllG6HO0HtKoANw+62iaLkOTiKoYW
	x4y1zfozMmd83DAB9+rCKilUEYAvgYPoeS7iUvdSJM2ieqoXhsDmxXTnAthANFNY
	gNW7JutB7740t1pS90KaoiCJr69ebFbbwKReAmWRxBJKgbig1eMlpfpFjRal6y6w
	qbbrwE72UsZ1iyUhLxTL3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792375147; x=
	1792461547; bh=Si3qx/laftTYJ+RacUVnTVoPA350XVCs5qAtOZjp2HY=; b=K
	ST25SaBNBp58EzWmtUnoNF39hHKBANS47D3GBVdCE4WzABKJD557tCJ9hywn+gep
	3VFTtvo7sSAo8hrp8eUTCUG+3uqbf4UUVIt1vGvpBYdOrZkd58pnQXyVSVz/U8S0
	ciSnMyt8yJQepICn+wrd8f2xyWR0Rq7/CcRiMeo7/hylLFe0iVLyYsbsj0Yjcyk4
	L5dplvYIF00UXtCHjQR/ljCLGY+afJV03OIWY6BBo2weHIUeNGSCoE7i9osyUr6l
	ua8OvCCKO0Xs1b8o7mAqnr6B36EHk9iYv4vQjryH4gZINpwJkLOm8PH2+wno8DUt
	evD7Z6K1zwHveLnuvev9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=themaw.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792375147; d=themaw.net;
	mf=PHJhdmVuQHRoZW1hdy5uZXQ+;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:eVkfTbYCDuXu0HtIEX0A/q1dCCaS2vgEOV2MJF26gpmPk34
	2i505BnjahFdYp339iXwrPH1FdvGb/N+9Z7++M2DIrTulV6t4WujMDk7Br9YfiZ1
	EHw1GTzhivweNRnltbbYq+LIsopt/fzxQ6OvbbYfyuT389ASx2AKbORZWQ3nPBPw
	nTRGLPP+abmv+QK0IJGvVQ1KddkkgTn9jf6Y1jScWenzpbOOaT+IYhPvTB46KCSQ
	ef21k/OS6TpvXl2nHEbbbteHHLTMUC+IrXmo8Wd0QPrxkkVpcyHp0EB77L0jbl+D
	RHkqS8HMO+KTeT0OTrm8xnmGqOLtpYUzzXfCk2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:IXGdCl/HQgICm++E3ct2bHAOlGPo8AK4fy6wnykcFBA=:Si3qx/laftTYJ+RacUVnTVoPA350XVCs5qAtOZjp2HY=;
X-ME-Sender: <xms:annVavVNcoi7HMMETp7Wq40siNLDceQUIRU7XrNayAR2OxnlazJBJw>
    <xme:annVaqIvRVEDTUdvI91lj-obb95Jd3Z1TnfYw0Ns-IQR_59QI9nzD8HV-xZiM4RHv
    EQhQO2OWXZeTPQ-UE3eDRyc5JJ92W9y3LOJsAs98kNVysm2>
X-ME-Received: <xmr:annVavCotq82FIMpq7rxyxN0t1Bj1wQQ5Vz41CjcK6aJkwLe_AdzOMoJq3qK01DBCHqNWurNRMX5vynaCqp9NWB1VK6C6b1_CXI-FA2jOFrcZ6BuX9IhT-JcmEE>
X-ME-Proxy-Cause: dmFkZTEmBgOaIB2cYNDY3XWg3ZtDTpZLOd7qiHniQRmI/Z8IfwAqPOpFoD5Wz/pHShf/W2
    8q4AOomLKaRb8j4ZYgLzbV8yo+1CPOPiQ+GnmD3XADZLywC7Z+BazyuqadiVkvwSVifYzc
    xrWiqmQ2bowbH1U2Hai/9SHPJe42a+FIt7RlblresvWsPPRjrazoKiG6Ap3V9yYJI850hR
    NMofRyUuarbfM/VZx4j4Blj9FKzb+U54hA2Uqyp+REllKWT4+Dr0Yy8luHUOIX/TSwUbzX
    b2zaTvAbevSkd9dcTMmqaeOyaMFAjdNLdYTrD4oVVW7RiOWPUw2R1g6wdwC8ecKdedz4eF
    +t3aaUrfd0T4W8p4NP6YjJs++xqR+HCOWLaVMmknfCSWqfF43iwbeOZowGg50Q4ot6Jmzo
    jXHWx9sJyrqM49OyH2EdeR5hwyQaobeYJzEtQBIR9En6bhiqYE+Goy1TjdPK3iRdCORaBm
    kBaS3RKbcZUPaMUSHOKj9aEupPxtamOSTa/ojFJH4Glj/7tz5UofBWr2NMBRHLeaINqmCr
    ferqx4xWSNeceHdcy/XH0NdmuDNtfcv7U3cqr6JMWsOnLee3kOi2GVCPMekrRUnPz4LQfY
    xrIhEunFXfD4IMcGuP52eNAFwrHJpoNPBvDu+QH+73LVFV8Rs9v/Pij17Z3A
X-ME-Proxy: <xmx:annVaqdDWteFgxKw7cYyGGqIrZwXrVPfcPiNswCCUGvDs6YSmH6TeA>
    <xmx:annVau0Hq3sxYT5AV0IE-XBz1FyjVnAr1r8tVJzZJ1zrAKsuB3xzTQ>
    <xmx:annVahgEDze5mMgbAbCplFpLEwgsLMzrbwLKos3jgCBYthlOdhB66A>
    <xmx:annVanlKOU4V8XgkY9okJsgdZVdlL15l3gQK9KwdONOYnuCQBj8jtg>
    <xmx:a3nVaspT51FPDtHBtCpQs9dlvRrQ121XNvByf-44kVM-Na_D3eOSCAPh>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 21:59:03 -0400 (EDT)
Message-ID: <f1c42d0bd125c6b1c39f1ebaee41340b5f6f03f6.camel@themaw.net>
Subject: Re: [PATCH v4 0/5] Fix easy bits of the negative dentry problem
From: Ian Kent <raven@themaw.net>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir
 Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jake Edge
	 <jake@lwn.net>
Date: Mon, 19 Oct 2026 09:59:01 +0800
In-Reply-To: <20261019000810.1837917-1-neilb@ownmail.net>
References: <20261019000810.1837917-1-neilb@ownmail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-10-19 at 11:00 +1100, NeilBrown wrote:
> For this v4 I decided to focus on just fsnotify, as that is where
> I've
> received the most useful review, and that is where problem reports
> seem
> to focus.
>=20
> Other places that walk the ->d_children list (and don't already use
> cond_resched()) are specific to just one file-system-type.=C2=A0 fsnotify
> can
> affect (almost) any file-system.=C2=A0 So it is reasonable that it gets
> priority.
>=20
> So here we just fix the refcount overflow, and the ->d_children walk
> for
> fsnotify.
>=20
> If/when this lands, I can suggest patches to various file-system
> maintainers.
>=20
> Thanks,
> NeilBrown
>=20
>=20
> Original intro - revised:
>=20
> =C2=A0I was reading about the negative dentry problem in
> =C2=A0https://lwn.net/Articles/1079407/=C2=A0and thought I would have a g=
o at
> the
> =C2=A0easy bits.=C2=A0 Given how involved some of that was I'm glad I did=
n't
> try
> =C2=A0the tricky bits!
>=20
> =C2=A0So I didn't try to reduce the number of negative dentries or handle
> =C2=A0them differently to positive dentries.=C2=A0 I just tried to addres=
s
> =C2=A0specific symptoms.
>=20
> =C2=A0This series addresses two reported symptoms.
> =C2=A0 1/ refcounts on parents can potentially overflow if there are
> billions
> =C2=A0=C2=A0=C2=A0=C2=A0 of (negative) children.=C2=A0 This was the easie=
st easy bit.=C2=A0 The
> first
> =C2=A0=C2=A0=C2=A0=C2=A0 patch is all that is needed.
>=20
> =C2=A0 2/ Walking the ->d_children list can take arbitrarily long and can
> =C2=A0=C2=A0=C2=A0=C2=A0 trigger soft lockups.=C2=A0 I haven't addresses =
the "arbitrarily
> long"
> =C2=A0=C2=A0=C2=A0=C2=A0 part, but the "soft lockups" is relatively easy.
> =C2=A0=C2=A0=C2=A0=C2=A0 With this in place I would feel more confident a=
ddressing
> =C2=A0=C2=A0=C2=A0=C2=A0 the "arbitrarily long" part if that seemed worth=
 while.
>=20
> =C2=A0The core idea is to use a common helper for all walking of
> =C2=A0->d_children, and teach it to drop the lock and schedule when
> needed,
> =C2=A0inserting a cursor to keep its place.=C2=A0 This simple idea requir=
es
> that
> =C2=A0nothing should be holding any other lock while walking ->d_children

As is so often the case you've come up with an interesting and useful
proposal, ;)

Nothing stood to me out as problematic given the scope of the series.

>=20
>=20
> =C2=A0[PATCH v4 1/5] VFS: don't count references through ->d_parent
> =C2=A0[PATCH v4 2/5] fsnotify: update children flags only when adding mas=
k
> =C2=A0[PATCH v4 3/5] fsnotify: don't hold i_lock while walking d_children
> =C2=A0[PATCH v4 4/5] Add d_for_each_positive_child family of iterators
> =C2=A0[PATCH v4 5/5] Use d_for_each_positive_child() in fsnotify.

Did you have any thoughts on how to contain the number of negative
dentries, (perhaps) including directory entry counts, in an intelligent
way (meaning "as you go" rather than "brute force" when needed)?

A significant problem, particularly on systems that count their memory
in TBs rather than GBs.

Ian
