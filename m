Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795399734;
	b=24rgb93cylKrnjCqKuZ17MVScTziAKetT3IKM5CpzanC83w9WVDXxvDpmVwPlOHHCLhB
	 nQyAGrWN5/FYLMTJUgFjTu8lfsCWij9WHRVgaVP//hj7ZufLjbLVtIlK9zdZHcdWTXDmg
	 /ZaXWzwP+rw0ycGcC0NHg4jMC39lPwyuUG0u+ft2B27IZanSFkamAZEQX5iKwg3Kn+7rh
	 syX4U0ms+lmlVSTIZqFS8ZHPPAupqWkV1hbrKqwEY5rmmKv5QERBJPzMlJQuK04Usr05Z
	 Hxg8nn/tSZU5rtewh0zWRQ61aFoWor4LsMgnmlJHRJCfAOhJlr2MzbUheBckyUcFjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795399734;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=ooxMvdZXMju3msGTAmKvtfVxQuizzxh7ftVHrTzzQ/c=;
	b=bXRe9YkgWUOGnSBp5+ADSVj5n7V3pqpOfyIDnPdA/Sq6yWsM2Noycy45ZCOF/uh4Ofjg
	 AJLwxF2+L1kHg0QSeeOGU/XuAsPQ/JIynG4ZgYx4LpfUrlcBV/Hce3JSnnNXo9GxInTXR
	 vPqgdNeVCtSsOFwnCOW8auNcwtRYLn337lmD5CAl0BDZvlc2IEVdsgzbbaojfpXQw6qeg
	 m9k/AVoYwfp5uR9NrWUmYo05FkWzYKyseZoPgVIU5LLUe/pckdRyTm3WQk0RrWY9qEasg
	 0tKzSWTOE9B1OXPuT//4qS2Cwvx2d1U7GcpY6WVAXpbfExYPM65e5fO/88DRX4gEeQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=n9gueB8s;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=czXj2zpV;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8C606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 02:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C8C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=n9gueB8s;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=czXj2zpV
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3C5A7A03A9
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 21:08:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 22 Nov 2026 21:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1795399732; x=1795486132; bh=ooxMvdZXMju3msGTAmKvtfVxQuizzxh7ftV
	HrTzzQ/c=; b=n9gueB8s+iA5PrAg5jMelWY8XRukOio5KrRUwwI9Ud2G7rTSwpo
	RzczQNwexLuZmOEYHUpEsasseI9sgfLWd8ZrRICcDI6tISgtbQzoQCMlAm9R+I7B
	bipBFkGKektYI8X7qh1Nu5TmuYIx0/BOsevC/0/err2z2LqFwP6mk8wQ2sXgm4bQ
	NBa5FjMZEPogS5RWH9va/sHX5QOVVFbunyIn2BmybaFfuP5LDqUOKFaH4PK1bwnj
	JOgefS4JVDZEc0lDCpxTrBIOnN3gI4QR+znrbVUb5drUxwR9KEGZDplCPpI2ELnP
	ENZQmWoTKIEve0hU4/MVZWfcEFDRoaN3IWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795399732; x=
	1795486132; bh=ooxMvdZXMju3msGTAmKvtfVxQuizzxh7ftVHrTzzQ/c=; b=c
	zXj2zpVAFo7XiFvd7wg3JGx1iWKro9ncdau6Eboa/p44ZNV2lZYai0Jyv2qVztNq
	DTr5Qg4ClFTNVrpB7LYxeHI3jh9EuGNnljzbLcFJnJQdJWrFdcMXG5IsWM6wjYFD
	m0pF0Nkf7hmfpmW9PmAIZm7OBWopX4VMKmu3aTStpTNxPvcGTPnnublfrCOSTIos
	Bd7A94a2vdaV6qLrmSfxv+yF88kqkq6Qas6ANx+o1M4wyu55G88RcyfIFz2C9ds7
	iWPo8FowLbszC1nPoRxJ+muXRvozZ60sMP+1F53Ma9SqCheCv8mXlCxKVfVRYsXY
	Cck0Nnl58LhoDBsk/X85A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795399732; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:hDrmLwCVKOpw4hIuFG1gFtqbilpu5UhHv76mdowpfb0j8Al
	ZbLdOkkJO0GtGPg3AWQNN8B9oOOra+7vLLi6vv4kaiY8eEy7bTso4RAyprbsqdEg
	mnfAoCq+/0fDBHk/ZnH8eAfL3dPz6zIe/mQUhxfGYaMOPIkEyUYQSdCN3qBAvcGf
	pRjjAfJVnjC/BGG1kVnZu7wOzZSjZGVtxNME8gSkB5AgPXqI0LTiZSX/hLbpCS+Q
	HpiEG4ZdJ2XdJVaa/tP7QqSdLWSxSgeySkABCos3zrrFNCCOW5fIr8d4Yhmla6/D
	PIsLMW518Ta9x59zkmDc+xLtlmQ8HEiIjCSmrhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:fSkPfXsYE/29bpqoux9Sb00xe2WdRT5y5ocHkmMVaDY=:0B0R4a0Uxs8mO8xU1NS2W7JyQlf1V5qQb/qqBvheRXY=;
X-ME-Sender: <xms:M6ADaz-D_um56qWNVRdxKN30k79sV_iKSs-NFcJpaZrKh_4_yDsEqQ>
    <xme:M6ADayRcEB6m7TXohpNNDK3sUgGxN8r2VnqZBm__lEhBRDtSTcq3MYl9ViU7HOMm8
    7pKs43jwLB54StrpVYxainx1l2BsIWnctgLErqx_AG2XJrXklQ>
X-ME-Received: <xmr:M6ADa0poDTA0vo-yeUGL-WEteC_sQ_1GQYVEADdtGb-mRH9XxjXZrF_zGTAe69ZgiSBuVeKDvgUGC5bxnyEx5dv6a2k3bTQ>
X-ME-Proxy-Cause: dmFkZTGZpma1LXTEdkMh92n9ALRzM3tfBPhC16pjSbsHa8ntcNq6/iu1QYyKVgIRZnL8AQ
    9FPgZC5un1n7N8IyLHFWo4O0ZY0vUbzbSVAuOYxyM8uZzPGSqW+z+pedlPQJ6dFOUtjcT7
    MmNPrfqwhsPqiAO9I6CZ5EzdkBqbcZz8lGd5d9pDzEqVuYBDSLcuM8GXMDEcvHWbJ75zCa
    RoT9dMREvK9wYnKfls6MmDH/BaiIr76vcpSIR5zvpQkc3Hy5zXXn5+lC/s8tQIcOr/GwUb
    WGQxO1f4FpGKQfxWQ+pN7AI4mLv/R0txYCiy7H1U/smXSpicCMZh+xVLNsVyMvx3GG0sXL
    tdMu5rXD82dAUcZaQrkJYmBcKOYxu2tFl2J4Hid/z1BXGg6kAPEtk2ZPGiMgraEyWtBns6
    V94C3evkxsuL4BI/TVI6RpYPH6JNH/1f8UDKNGak9syxmYnHU/PaY0JDaV7Vl2zpmzN05x
    K7/tDVpp7YP/LYG0pireBRmhM3MeiYQuqQXFSxMHAHcIjazhQgjdtspBmSl7oqclQoX1d6
    475BCn0cgteeYJoMKSJ3NAnfuUyvPCKzIO3MsH1o1Fe82OUVLNLcUfu8TJlIIctLf+iNqv
    G1CSZs55B47/GVbvmuAWzfB1u37eycJcE2DyZ7OHJeA8kHTv+DDsgsDwuIhA
X-ME-Proxy: <xmx:M6ADa_mYLN_N7btLPMlFZYMGnEFqqz7FFBnGjSLYS3kRvBYBpBdktg>
    <xmx:M6ADa9cHeYwanuJr2aFP98v2Ot2rcUX6dYKkfcKzu6ndUdBGiA6hlw>
    <xmx:M6ADa7o2aUoM_craC8bz0ilazehW-VPwZdl2Zq2ajzl9CUrH01H63A>
    <xmx:M6ADa3Nldr6lsNU12PlGlFXnXljmOeHcFXiIF63ITP21g6FuzBiX2A>
    <xmx:NKADa1taq4Wj8x2Evp11SNBmAnzr4JPTi2wJbltVwb40xFGMfPFnq6zf>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 21:08:49 -0500 (EST)
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
To: "Jan Kara" <jack@suse.cz>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Amir Goldstein" <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Ian Kent" <raven@themaw.net>,
 "Jake Edge" <jake@lwn.net>
Subject:
 Re: [PATCH v5 2/5] fsnotify: update children flags only when adding mask bits
In-reply-to: <mk7u4brorzgbyol7x4nyolufk3s3piqwqd5hnya3nhoq43d5ui@x5sdqeyrhde6>
References: <20261119025942.2848130-1-neilb@ownmail.net>
  <20261119025942.2848130-3-neilb@ownmail.net>
  <mk7u4brorzgbyol7x4nyolufk3s3piqwqd5hnya3nhoq43d5ui@x5sdqeyrhde6>
Date: Mon, 23 Nov 2026 13:08:45 +1100
Message-id: <179539972541.1728055.8282722306710793371@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 20 Nov 2026, Jan Kara wrote:
> On Thu 19-11-26 13:57:02, NeilBrown wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >=20
> > Since we only ever set the PARENT_WATCHED flag from
> > fsnotify_recalc_mask(), there is never a need to update children flags
> > when removing mark mask bits only when adding them.
> >=20
> > Add a helper fsnotify_recalc_mask_and_update_children() to be called
> > in cases where updating children flags may be needed (i.e. add mark).
> >=20
> > Also avoid update children walk with mark spinlock held.
> > This was only done by dnotify and can be easily avoided.
> >=20
> > neilb: added update_children flag in fcntl_dirnotify() so we only
> >   do the update when needed.
> >=20
> > Fixes: 172e422ffea20 ("fsnotify: clear PARENT_WATCHED flags lazily")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> One question to Amir below. Otherwise I like it.
>=20
> > +/*
> > + * Recalculate mask and update children dentry PARENT_WATCHED flags if t=
he
> > + * connector started watching children.  When parent stops watching, we
> > + * clear false positive PARENT_WATCHED flags lazily in __fsnotify_parent=
().
> > + *
> > + * The caller must make sure connector and connector->obj cannot disappe=
ar
> > + * under us.  This is achieved by holding mark->group->mark_mutex for a
> > + * mark on this list.  mark->lock must not be held by the caller.
> > + */
> > +void fsnotify_recalc_mask_and_update_children(
> > +					struct fsnotify_mark_connector *conn)
> > +{
> > +	if (fsnotify_recalc_mask(conn))
> >  		fsnotify_conn_set_children_dentry_flags(conn);
> >  }
> > =20
> > @@ -367,8 +383,8 @@ void fsnotify_modify_mark_mask(struct fsnotify_mark *=
mark, u32 set, u32 clear)
> >  		recalc =3D true;
> >  	spin_unlock(&mark->lock);
> > =20
> > -	if (recalc)
> > -		fsnotify_recalc_mask(mark->connector);
> > +	if (recalc && fsnotify_recalc_mask(mark->connector) && set)
>=20
> Amir, why is the '&& set' check here? Under normal circumstances if
> fsnotify_recalc_mask() return's true, 'set' is true as well. We can be
> racing with other updates to the connector list of marks and in that case o=
ur
> fsnotify_recalc_mask() call could be the first one that noticed the marks
> attached to the inode are now watching children and is thus resposible for
> setting children dentry flags even if 'set' was false. So I think it can do
> only harm...
>=20
> And for similar reasons I believe fsnotify_recalc_mask() call in
> fanotify_remove_mark() needs to be updated to
> fsnotify_recalc_mask_and_update_children() as well. Standalone
> fsnotify_recalc_mask() is simply never safe unless it is followed by the
> update children later - perhaps make it __must_check?

Hmmm.... I had thought that the group lock would prevent these races but
I guess not.  Maybe one mark can be in multiple groups???

Given that, I don't think I can form a sensible opinion on Amir's
revised patch.  It looks OK and I think I can see what it is trying to
achieve and how it achieves it, but I'm less confident that I can see if
that is the thing that needs to be achieved.

So Jan - if you could review that so I can add your reviewed-by when I
repost, that would be great.

Thanks,
NeilBrown


>=20
> 								Honza
>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>=20

