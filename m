Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564117;
	b=tknOVaTmPOHCmTLVrvLsDzEqYJRItcsoJPZDR69LSpTE2wVIzdCNmXfcxZ4QbIfjzkws
	 e5SXPuHQt/wQ5GxgvffkF+wZT5joSRAj1pwR0dm5wxSrEMqXWpfo0TcDZMZ9FEKaWEHqX
	 yJ6jZrNSBSkZ2WtCdnrHDBMrSKD0aX7uG+Tdci2PylKAlGxylTYi9oYsYKTFrJyM50fkM
	 9+tySXEpnI1mnWcNAN+xUzRCABmmFpTDBNtG/VXDZeAk22f5DTZhXjY7fBgaxrQsYUyh3
	 pYikaTKeG3VNTcGwi19PpZ4qtlEofHBTTT5WH30enuQbqXV9RLOh2vWrkLUkWyjHy7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564117;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=OaSwW75K1sBSQ7OOplk4eWN6EoGH3fG79Md5WcQLjjA=;
	b=0jYBtVVrNRli7H2JWLvaeTQlUZwCdXUOSQxya8Xmpa9CZGQqt19yEgHNLiFQRtu8n4Z3
	 cabIySvsRmjuLqo+p1wnMYHu4KgjmK6PsuOMj6Bn6IjXhVKPEB0lGw8G7mpBOZLnCkixd
	 PW0pEAA30xtWBdW2RcAf0oNlExPZlB7jbPIO3xKY78BaMhh+xjCvSvQ/GUmNA3bye3srW
	 tgdBa3aZ9LIq3mFV3JYuwoIaNdBNOA+IAF5/GyatXTj6OFyQg1TNxiJPEm3ONgtV2GQ7F
	 txLo1Ta0ZUEHXYg3qoSb1XCbstxWwqawjUgKgJSAw8nfslmPxDKPXCW20n2OgkBy0iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b="IvqlCND/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=y7cqy8zb;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535ED606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 23:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 535ED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=IvqlCND/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=y7cqy8zb
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8358B7A05F5
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 18:48:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 24 Nov 2026 18:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1795564115; x=1795650515; bh=OaSwW75K1sBSQ7OOplk4eWN6EoGH3fG79Md
	5WcQLjjA=; b=IvqlCND/FNRCdz5bI6M6hI/fg1+PKKVbS6iQvScAHjRwvfNYv8O
	W0vZOyQaMm6zNpgokVOLorEXA7QSdlwRYzkB+ebbs1rUjHtXov1wbrmG9S5+wmlB
	KgtwI9Xa9SDwCTWudayi+PKoCoNe5Fj92iGmhTPg41kSftmwXdAnF3gMl6OMQuG9
	YkfiCnkcj6MoMGBQ4vOxqZVAljRP4EhQCBvJSVnagSZfhnUTdXa+Pa9CbfndUUIA
	CvU6W+R+DbwAb2U6a8qdJ/aoQW6W9N9dZlINGU+q0Wo2CbyVbPnCfkI90/+3EbBk
	0TWAJX4qepTyfH7bl6ZEMckCiIRHyLsuBFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795564115; x=
	1795650515; bh=OaSwW75K1sBSQ7OOplk4eWN6EoGH3fG79Md5WcQLjjA=; b=y
	7cqy8zbPKH5ds3WlTKSMRbJ7vISIhi3depMvNYQGz7XKIO+QkFuq/UA9DRVwn66v
	CwnJ3s0gZx1HvV6X+1xrRdcdKixqOpycckBtttUx2n5x3QFYOD/Z3xY7R9WUQzgI
	ub+RtvRew/p9lxTuxRec/hj9+Gbui/4SoZUeLETB2CtzOZZQ7dY7WmH6xx3qP/j/
	w7iZJYVtFGuqRww1PBexbpLWab5kZMaVKC+bN7CHRHP8Tnb0QlsqInMs5bN2Kwwg
	0/kEXB42uANqng/OoBZtEkT0JdPWw63Ofqj2SvHPpLfARY2FcQuc6xzLtRGkW5AV
	P+/gOXXCOgU0f01p7zU3A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795564115; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:ucfD+4skdUQrZC/uu9/AE2pugl8f3HpUxkFgyEdENQDGmUb
	2KrtWhmPP2dk3uXTnlus6hp+r3ipzniH0U1hkjcLcfTj1bcFjY3mQWy0K/Nj3uvo
	625v08+tlbkv7fCO5nK4sl7QbFxZW8se5bLytrDG/vklIasfxzkD/gq1T5VdeBqd
	1gP0niESquVzm8nzRw9Uecvht3RrK43BlG0yIw0DXQd2gEZaX4rH1akM82Uu5lg8
	uCTGDN8Xl6w6w3m6d06L2lS/xw7CySyEmuRMPNbvlsohW1vghSUl4yz7dnYssEHw
	WsESfm5ilAFuRFGwTBhqMC3cl4ujrNGqocxuFLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:p2mxV33t6IVFqkg7OknE/PAnwYywOcITOVAuNLgUdqs=:GMngJe12GtGMxt4Pd8GFxwsJmpbIdOps9I7zpcTeGh0=;
X-ME-Sender: <xms:UiIGa5uB6qwDjb8MDqkzVWEY93xkidWu3KtvHupEtF3__SebX6N8nQ>
    <xme:UiIGa1BR4mfkNv8XYyRCv_cLlAwu_Edm81-xMsioZuYVliJnPZrvYrhZdS47OhnIA
    CMjpb2PvYpaK-knSOCPQ8vK0ihSaXOPYUccvP0kuAFP9SfVgEs>
X-ME-Received: <xmr:UiIGawZUSG1FbaosACiajTw9C9AwO3V4bB4mW0OSllZyAGSTlDAAdHbnVZEKlUwWFQ>
X-ME-Proxy-Cause: dmFkZTFVlHVhw0Qq63K21mlXD4ArUYv/hlGS9UZt4KbCHDdaSoLk2Dc8T3K8oC/RQyn8ND
    HAAC/TAchZtxDfydZRTqUxW6aWzSU5rqBL/UfJamwqY5QnCsqh1OD3U1wt8+uw7YyOqDLu
    i7eqs2gi1Rx5eI7scsg2PgLEu8QzSeRn8E+DOoElR8e1szfSZ9sUwLepwM6XLsyKI1uqrC
    62QNiHCiPWDeLYI9pLeP5v2R4Dk2HNdDnwakbCZbB5h1A0ZxsQE97TswAjVIzGJJr7ZG99
    D1MlNsUDxsR2H8QMlrQKtb/0xVCxoxSWEx0nTeqc8MRneUfsxJzsRK/vNTdDvxfMbSWOGZ
    X/6VQ9Zzwshzo4rTYutsbei9PyPMSKpm5muOolFQQvsb8fi5eEU6OazhPZ8QD3ym5YLxuW
    xJbDBdcorha8XqYCZerlmQKAaDF9ZB8aRnOAAGei7cOtGq1wwjdSsLVdQXEYDbCjS/cnc+
    dxure9jrIigkCee9k/Q5AGAGTNZO+T5l7sEJNeFF6SNHtBX4v/nESWlNxQDCuJ+2Di+wrt
    yukzcG787kCfOWbQiWeF1yrr1aM9/SI0qfAS/ydDq7FNd6KNc0wlZaLOxjMB4Hc+GC9KVN
    Q5S1nrBjWO4rgpyxSqLWPkOCgrnyK+IsNEHV8Btm15c2RkwSAvagh4f1dWQg
X-ME-Proxy: <xmx:UiIGawXgXTruUjhLSry1aRs7vLZ2B9rwEJDMUE-a2YRkVYYobdjnNA>
    <xmx:UiIGa_MPWY1Bdtt2-coO47wzuJSkNuX_CURRLDIsaD9UWdg5x0jVkQ>
    <xmx:UiIGa6bS5bJ1pOW8SNGuq5gXG8v8-CVIiD3qEJAi3e1tTPPigjcjqA>
    <xmx:UiIGa-_QKpWa8if0zktlaUW3mLG9twgyFkhHzSGXiQYiNIZyfbltzg>
    <xmx:UyIGaxd-0pA_a1IJLEJfoSuwGHXK733bcu5HGKqBXJNtqwZBKH0_U472>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 18:48:32 -0500 (EST)
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
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Ian Kent" <raven@themaw.net>, "Jake Edge" <jake@lwn.net>
Subject: Re: [PATCH v6 0/5] Fix easy bits of the negative dentry problem
In-reply-to:
 <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com>
References: <20261123221410.3328780-1-neilb@ownmail.net>
  <179550252639.1728055.4014817916838632741@noble.neil.brown.name>
  <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com>
Date: Wed, 25 Nov 2026 10:48:28 +1100
Message-id: <179556410827.1728055.18249797874781608563@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 25 Nov 2026, Amir Goldstein wrote:
> On Tue, Nov 24, 2026 at 7:42=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > On Tue, 24 Nov 2026, NeilBrown wrote:
> > > This v6:
> > >  - fixes the autofs changes in 1/5
> >
> > Sashiko says this is racy.  I think it is but the original code was just
> > as racy.  Maybe the race isn't relevant.  I haven't properly understood
> > it yet.
> >
> > >  - updates d_duplicate() in 1/5
> >
> > The fix was seriously broken.  Sorry.
> >
> > >  - uses a new version of 2/5 from Amir
> >
> > Sashiko has something to say about this
> >
> >     Can clearing FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN and dropping conn->lo=
ck
> >     before fsnotify_set_children_dentry_flags() finishes allow a concurre=
nt
> >     watch-adding syscall to return to userspace before the children's
> >     DCACHE_FSNOTIFY_PARENT_WATCHED flags have been set?
> >
> > Thoughts?
>=20
> Sashiko is right, but this race is not new.
> The same window exists upstream: if another thread's recalc observes
> the 0->watching transition and does the walk, fanotify_mark() can return
> to userspace before all children have DCACHE_FSNOTIFY_PARENT_WATCHED set.
>=20
> What changes with this series is that the walk is sleepable, so the
> window is longer, and in some workloads it could go from rare to
> plausible. OTOH, skipping negative dentries may shorten the walk.
>=20
> The more important question is whether a child can be left without
> PARENT_WATCHED permanently. Upstream it can: the transition can be
> observed by a recalc from the mark destroy path, which never walks.
> With FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN that cannot happen.
> Every transition sets the flag, and every caller that can add a watch
> consumes it,
> so a walk that started after the transition always runs and fixes the flags.
> What remains is the transient window above.

Thanks - that helps.  I have added words which hopefully summarise that
to the commit message.

>=20
> I think a proper fix for the transient window needs a sequence counter
> of scans in the connector. Each caller would wait until a scan that
> started after its transition has completed, no matter which thread ran it.
>=20
> I think we can live with this v6 patch for your series and deal with
> the remaining race later if we want to, but I am not sure and would
> like to hear what Jan thinks.

It appears that we all agree to leave this race for now.

Thanks,
NeilBrown



>=20
> If you want, I can implement the sequence counter for v7.
>=20
> Thanks,
> Amir.
>=20

