Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599785;
	b=nK1ecqBbPk25oDmQlPhZ8pahiceAqxIfM81x5OoX+G01nMMbWpKlBUzAJ2FlOSMDTxxX
	 VpTVZMcceZGV2aAzVK4TyajZKQqHPWnNtojdbYuPBCV4jCRCRTTOVftxY2uROShpcoA2U
	 Kb7Wc5CiuwI794tlXcaGaD/bl3L8bxRDbd1n5fcuJwACO7M7Axh7uTSXkQikjsFYu7ont
	 ehGn2eGQWPHkHChyPB8NUeV4RqiBWdI0R0/MeOFp3Bfod/v0mR2Kum3+qVNwQTgQ/T72d
	 xGY/UXT8Ng2MxepDUlzHr6+6ywFFv/ZbpjXQCiZUiSQNS8ZEuJdQbW8ebMoN5awebRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599785;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=q481VDhZEcw4c6WIDWUz65RfwNEc4JNVc4TqgIZ6vPM=;
	b=g+LoXuXesXBb7dUgXrxB1BYFDjhf4+2BlgzQi+nRVEUDGp6WCSzHytRaQrsHrMGqa03X
	 Z0qh8bFepPsaFU/cH4vtuMgigoF/8LEyIMfNXwci9IbcLi9VnMqntjI3RTe/LKMMQij6z
	 KeNNCWkFaloQl35PzUb3zBnOhGlVX7hcAVV9BTAo84lvog8ximt2vZ1zDEsgrYlURTJY+
	 eY89eyN/WiPRnygGZ4c61ai33byCQS/etHfrj/ca0GNlAkXZJAYY9YlSeZJDSVDWkIR4j
	 y81zWQ8ZKjHTdsPew4PMCrHL/2le4kZNA7g82A+hLN1K47Tv64F8b6TNmk4Mxx1D33g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=enZ0Swn5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zrHnSnO6;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F2606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 09:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 885F2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=enZ0Swn5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zrHnSnO6
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FB4BEC0BD7
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 04:43:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 25 Nov 2026 04:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1795599783; x=1795686183; bh=q481VDhZEcw4c6WIDWUz65RfwNEc4JNVc4T
	qgIZ6vPM=; b=enZ0Swn5ojZvj/hk0iEuOtaZoIL3oyUIK2pdQ8RX+fqpHiMMeSp
	CQ1QCjZvRIXY7pxjZdorEpJ11hNDQdFilDnGAmHWXbFDm6qUTyB7S968C8dBB9ND
	93A+I75Ake7jdwPLwDoReWZ57ikjY/vy355h8Ox1zUKiojCdSz+ay4vRB1vKp/qJ
	SSaCTybAYr4fiEfWoRt+vipY/WkfVu9E/Ju/ey1bSOHSMVXbp7V+b6c7W+ZXztga
	n+dSDDpsSbvPlb5y2zMdlYflCjXaDozIGoP+xCGCK9ktMRwq5aBGOQhglW3575z1
	hC3x71l0nc4LF7JXP+AR82w7sMpaMk42j5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795599783; x=
	1795686183; bh=q481VDhZEcw4c6WIDWUz65RfwNEc4JNVc4TqgIZ6vPM=; b=z
	rHnSnO6eiA/wZ7BeZ/LBOkjgo+YhbfCpUJ305+ACCeFSAJqXwn5bpqEV1l8GwWCw
	a9eKVHMjDYS1orZK+9cThCe6flTH7TPWOXaG2HxUjBnmShtSVcge0K0GvYGaA9bk
	kD9HbmbOI9sNTh0gJd6Ok5DczSBWKLqRnXGzfzilvXnEUA3DJPWgh5OOIPiiutXk
	cK0R2MkIwnn53GUppU4e8v5zP7PFGALoho2ioDljJ02FQ7Lr1q2KTlHhvodoGW6k
	G7yvNnWQeiKzXtXcGAKrcmGDu6+Am7sSfISsenLFN76PKpVtXGzvshxMV+AREp0g
	v+/jHyOQtB7LNTf9U5mdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795599783; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:X5MVuKPdizRjfRXA20Q1dc0EYHIbUA9vDau76JIBxnRk82j
	h7vFlZBF5aVaZPRiUZ/THFUdEgA+vx6GnVo+BMpAV53tBTQKKKzM5Rnbn3Kji6dI
	QwUxX0HAncDMntZiAsdtV7ZcxiESoJL9kd8d9WXPQn+ip/dytS77YETJ+j3+nFcu
	BAoYg8fpGMCICmAjSJi9aVNPFwfudVfal9ABdguvc/3wdzghhocXC0+8CUhhoCNj
	P1ZjU2vki1NLlIUaMr7qwBne0Us8HLtKRdzJg28bGoflx+Epuo7BFCuuW3R3f/ig
	18I9pACd+MUC51c3jaIOnNVLU+Pxoju9S9SAXhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:1FZ2L6wcNHT10q1BDTmPA0+4/lCEdeaK4RrjjsqiU94=:P9Y0zxjMw3n++5NuGF9acER1t2vANIhfNr02E/IAfOA=;
X-ME-Sender: <xms:pq0Ga0gvnMjsPNn7hFxM9tm5ZSh_uk6tKvOr1ZKk7TV4adAT9wR2-Q>
    <xme:pq0GawvFIGGEr3kRpgl8S4ThN5_YGsTm3fmVLdRG3CyG9DDC9q6wprmUQElRN3sV6
    KSQOfWE6m0E27aKpivNnXiosnBf6S4lavscjqrW3n8cWHBTWg>
X-ME-Received: <xmr:pq0Ga0sVl8O5o7v4aPBLT8589BnZUPe-h-vDKzMr6gAIhEoG083UerUinHm_oumKH-odmv_xvw1ND0hfHip92beX_oE_Sy0>
X-ME-Proxy-Cause: dmFkZTFyuWDnb16KytKZXuWsHKw3qfQNPsUWbn9XFgZbAZXVvLcXDxvEW/qdDl+iETJmtK
    9FJLxVLCuQpO6dVhqnNzyV8JdgbNsEtdGMW7A8ec7gwh2leOOnOIAs9x2csr/W5VdqnchR
    7Eac9XLEkhajGCQE4qLIAGLBjELBdEiKylaQfvxElFLAeatxAgtbPssOqODSrCcf5Qen4i
    aPBHufUrP2HcIeque251pHcAkZJlMVwjJOXA4HZkULmtwhQnHop5Xql5SrbDk16M4iErl0
    20l53cnEhdSpwfyZ3UcqAUZPiTKH+eoPl68cK8WgpIB4EQG2bXkhVeC692zDftk3kQU0Au
    Dosq+Qw5polpcy+1uX1XIoDjJXP3iEVFq3yV1FQSYed8KwelLB+HSxSZ9RSHAHNubULuWe
    ZGPLEunk1LYbsviMTDJFcphOylrVj5X/y2s9fpUCWF6jHuT7mkr/zZaJqSNyDNqiMKBaDl
    +9I4zNcwTZb85mf4VlbrFsc6QediR4xjzQj+ivXeKH8YC7hMUjC9RxO7DkwuZRW4VRD/GP
    AmCY5EGXl7RYqoZQm3Yo3+FGEqKVoRNaLZ6jkr3qazZQZDy2cEpNimrFCUhNk87ePTY+5O
    VfLH5AYhZ47qkhVoJLDfi803oVQ5b3QR+zJSm8tRouwLhauCXwyl2QRsPLIw
X-ME-Proxy: <xmx:pq0Ga2q6GeDNe-CkLwNhGOtslys55g1A9mJbMqdwWVQxh6LqJuzCOA>
    <xmx:pq0GazIjkm3awJrDZaYHjOHlVBScZFMElKA1KYJv2XMDl-uI3rEeRg>
    <xmx:pq0Ga2snDl9LNPBLG7P4nkcEz0XP1SACK_K-tuLpN03zGUkDjVpQpg>
    <xmx:pq0GawB-kDNfxdV_cRgiJa7XNB9v-kxwa9ykhNdzYYi4BgA9Ck8Nlg>
    <xmx:p60Ga2qvuDqYzCaTO-yvtMuSIbrDOeLZ0HNv1jxJycbihqLepmHX6C3g>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 04:42:59 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Askar Safin" <safinaskar@gmail.com>, amir73il@gmail.com,
 brauner@kernel.org, cyphar@cyphar.com, gregkh@linuxfoundation.org,
 jack@suse.cz, jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, tj@kernel.org,
 viro@zeniv.linux.org.uk
Subject: Re: [PATCH v8 07/12] vfs: short-circuit MAY_WRITE access for
 O_DIRECTORY opens
In-reply-to: <1709003566.2632299.1795599064030@kpc.webmail.kpnmail.nl>
References: <20261024213539.1307600-8-jkoolstra@xs4all.nl>
  <20261125062146.940336-1-safinaskar@gmail.com>
  <1709003566.2632299.1795599064030@kpc.webmail.kpnmail.nl>
Date: Wed, 25 Nov 2026 20:42:54 +1100
Message-id: <179559977412.1728055.14071803405199089608@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 25 Nov 2026, Jori Koolstra wrote:
> > Op 25-11-2026 01:21 EST schreef Askar Safin <safinaskar@gmail.com>:
> >=20
> > =20
> > Jori Koolstra <jkoolstra@xs4all.nl>:
> > > Requesting write access on a directory can never succeed. Rather
> > > than performing a path-walk to determine whether the target is
> > > actually a directory (-EISDIR) or not (-ENOTDIR), or does not exist
> > > (-ENOENT), etc., we short-circuit to -ENOTDIR.
> > >=20
> > > Currently O_WRONLY for directories is only blocked in may_open(),
> > > which happens after we have the inode for the target, so after any
> > > create via O_CREAT|O_DIRECTORY.
> > >=20
> > > The advantage of short-circuiting is that we don't have to add even more
> > > logic to lookup_open() to differentiate -EISDIR/-ENOTDIR. Also, for
> > > filesystems that define ->atomic_open, handling this cannot even be done
> > > at the VFS level, as we can't know ahead what the result of the lookup
> > > will be.
> > >=20
> > > Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > > Reviewed-by: NeilBrown <neil@brown.name>
> > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > ---
> > >  fs/open.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/fs/open.c b/fs/open.c
> > > index e43f02ff64ac..4334f30bb7ff 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -1343,6 +1343,15 @@ inline int build_open_flags(const struct open_ho=
w *how, struct open_flags *op)
> > > =20
> > >  	op->intent =3D flags & O_PATH ? 0 : LOOKUP_OPEN;
> > > =20
> > > +	/*
> > > +	 * Requesting write access on a directory can never succeed. Rather
> > > +	 * than performing a path-walk to determine whether the target is
> > > +	 * actually a directory (-EISDIR) or not (-ENOTDIR), we short-circuit
> > > +	 * to -ENOTDIR.
> > > +	 */
> > > +	if ((flags & O_DIRECTORY) && !(flags & __O_TMPFILE) && (acc_mode & MA=
Y_WRITE))
> > > +		return -ENOTDIR;
> > > +
> >=20
> > Please, do -EISDIR here, not -ENOTDIR. You returning error here, **becaus=
e** user attempts to write to **directory**. EISDIR is natural here, ENOTDIR =
is not.
> >=20
>=20
> That's a fair point, and I have thought about this. The downside is that
> if we return -EISDIR there, that will also be returned if you open(O_DIRECT=
ORY)
> what turns out to be a regular file. So you may then get -EISDIR for someth=
ing not
> a directory.
>=20
> The semantics of -ENOTDIR here that I had in my mind is something like "the=
 thing
> you are trying to do can NOT be done _with_ a DIRectory." It made a bit mor=
e sense
> to me (but only a bit.) Really it should be -ENOTWITHDIR or something...

The problem is that "flags" contains an invalid value.  The correct
error for that (according to open.2 man page) is EINVAL.

NeilBrown


>=20
> > (I'm human, not LLM.)
> >=20
>=20
> Glad :)
>=20
> Best,
> Jori.
>=20
> > --=20
> > Askar Safin
>=20

