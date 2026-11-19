Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130944;
	b=kPil9w1H5u0Bc7tYAnYcj2LqamcMUvZ5SYgk1o2dduPITlWzPzEFi3fdGxBcyVYCSnjo
	 v6sKY6SF/WbwC+lNDpjq4qlXMGuw9UxjDxkRHaBRdRhLavLYTxPrpONA9uYJ/8Y6/UY0D
	 ZYu1B/7HQYdwp5s4PBrEpHCKZhvCrEd1z8wLpoYZEn3eBFYHDVaIZmP2X45j8yBHdQ1aa
	 8XPpv/aSmAzVRaxTvdtMlUt4jWt4kINvUPE1WfyrHl1fB4zK3482Tn2OYr+UraT2PC5L7
	 IyIM422WmNrehnYo2mA4QFiPiGeFJHGzUgkjvn7U/BRVDGqoyKBvEo6k6m93hXlKZIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130944;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=nV770Y5+ls6kyvkMU7FuB9vsMQeJ/HbkmEK0Zyh4MY0=;
	b=u6jmktSwGh85iJ9A9EQYO1J4hVsFF/QNj5Epn+DTVBPreXDVrewC6D1piZtFskpEg0ez
	 9hLr0RW8XPXMpineSdIrchkRUIIlyLOlfM24Isk1+Iemka5bxea4pBoaFpWVkJS2Z7OwP
	 Z5Db5xha+RST5NxC5nbuwHltH+s4exgGEmofNPWL7DmgQ0YhN4wPiAZIjyGj0ngmvoi4C
	 qYDlnkZV1FPjTdRdqDMokEXL2oGChxP2yOEcbTC71RL5545vH3TANR8y7KadfBppBd/9d
	 RAvmiOiNpnQhZuuQ49js7Y/nnOsNZDZ/1NhBzvXqCFm7vGyz0KB6Yllcy0FINT3mXTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=D0b8EKRV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1dBv9NU4;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1648606A326
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 23:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1648606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=D0b8EKRV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1dBv9NU4
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 21E601D00240
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 18:29:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Nov 2026 18:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1795130942; x=1795217342; bh=nV770Y5+ls6kyvkMU7FuB9vsMQeJ/HbkmEK
	0Zyh4MY0=; b=D0b8EKRVEFxGf30TJoHX5Lv4/lCMc5d9/UTf4/8HYHHgwXZ6B2v
	yNrO5E77nNhEn76iNP3RPjl+kIKCnAoauh8+eCESDmAJ3QVBH5hPXjn7nxG7UacI
	Xk6A3kM8WVo3Kaql5qt0R/gh07qoGgw3CQbxT19WY0fEyUNQPNROMcu2A7lNvt4l
	22aR0aw0nIAdd0+0+9Wll3Yc3B+eFltmTJ4t2otk+2nFuSXtB/tydFfmJi+NdWqo
	RgNVjLyc+ai42PTKqVxiZWKzmjHa3MFDbWdNgWRantQc5q/VReYUIzm2/bw7nT0Z
	3oPThFjki0bS8dSWAmm2PuSKB0EYP8y5DJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795130942; x=
	1795217342; bh=nV770Y5+ls6kyvkMU7FuB9vsMQeJ/HbkmEK0Zyh4MY0=; b=1
	dBv9NU4fG4h9uDPxohaGPfCdOV3x+r6p0FzQ2eP0i6Dk6TuyD3fT+rqB5ci9z1I0
	5MfqYn++W2IePO6WAP/9GqmsdR7vPA9RFsK3kZakvgLQIT1AiqpAFJWSdpl8xFhJ
	A6wBJCGVQTbvlWzbU8iusILtejf6IBuw/XZMg8wr6Mdr8GwJKSLJPHssoX1GBF/D
	gYGybfXuuZHKcDoVB12FcZymERJAmTcvDajwezw3fR7163hodnS8HFVEmfj1bH3K
	10yubAJIye3PHYPGfL6A4ADoBB8beYmhI3RDo/XVJ3pTd1t5ABgnFHrc5hG69FxV
	2P32cNA5wxu6sEr4zVHUQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795130942; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:jdOUIflg6StVOtm1kYyUOe3K0p5jvpLCpKymf9nfpKauuAM
	l8EpwHS91TB3jZyFKqROsfwV6mcDKUmLfAZhOMhLxOVniSmBz4JGaR9SshoVKCU2
	EcPXfbzR8bMYeTSwz6gTUa4PfBSd83S7gVW5IGOZyl6XBeLxLy90pWDOfKHsoLS0
	3slKJC8fTuOcvY7US/3F5slGtNPW1wJkoLzszh11r1uemyV2c1v0/SyDIASNsuK/
	PwxB/vfwjztmGoEZ1XUj8Y3PfX2KBSIckLX4mes3ytefeK+RMlM4KcmaHW+cKwie
	D+FpPJLuupVurlz3ifamWGgm3TWjPFBG1ryHXRA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:PmTxIsN271fo4Nvn8ZFdNJKs8NEuuK9lBD3s24RFk2E=:7szfggsi1fH4qDras4xNp5mLLpsAhKaKO98jQjIkBRI=;
X-ME-Sender: <xms:Pob_ag0AR91kFnoxilT0U-mJ-cEHbuvGDZsJH5OknzeR1cCDCcprDQ>
    <xme:Pob_atqT9oXW4O05rQuf1NKspH5CWB2Z5ELSjTn7NlLgmE3hWKYPDuqPgrgW1K9wH
    qtkOUJ4Z9f9InhUJm5OlF-8SpYgQ5_Ox4-zVfBwuOzPYXPGVRI>
X-ME-Received: <xmr:Pob_asik6HL4YFCX3fmHe88SjohSZhSzCAc0i2baAA7baAuanQO37YWTDCC7QyAgLQ>
X-ME-Proxy-Cause: dmFkZTGImlcKkHeXu47CsFQBmz38FjVRY5feclo+x1apGe4GxCQcsgYDX+SST3qnUmN3bi
    bqos8IVxv0EzcnVUTA0YYpo7xw32eQ6kzHm5pGoSyVZNXxxOlAHwwLYZOqTB2ILolQiBpb
    zj7euQ5T67T8ErjaingJ98Xt0h/BwZP7GIS/wnG0RLRMC9UUCaIW+Y82uCD3vz5G7HdXO/
    wlwgemI8jJi6uCUeQ+SW+MkEbsGV31OtkXL5ZKPz2hDlChZNcq3Ze2n3NbOE6WPcvQalNS
    duJB61RJWWH6WpMXytBX1fkTfqdHzb3XoRaw67N9PnzYPaJsK08PFxsjSgNFyJE+vqTCfq
    aixBprEiykJHAxvRu+SNW7XpgGZpWaK0CVElzsUXOTdrOpVM3r9G4v0OTZSs42/ippI9KG
    hTB6I+VHH46owhZ+EaMe8NiqCxlt1Tbmow5akfcqX1cHWQ4CNNymVgMMdsc8U1YzOVhGaV
    oy+aCfpL2WVZ84oKARxy6FK9XOqTk2EUgqEqIJmjSykVwacvIo8TXpJakKBxFl4PO6oWTB
    SHm7CrhimtU20TqgsK/4r6ovFosSx8A2FISQzx6xtxDLp3sUHFyY8hOl/HpniBUcNNyoo/
    bhaxiEsprQEWClSRQvyTw0SVy2u1qVsv6NZnDWLov8Tz4wyaC8MhY7cGEubQ
X-ME-Proxy: <xmx:Pob_ap-OBleb7q_2Cf4SdcWPoEBxc_Jy0Col-0unYkXeM3Dyk5QROw>
    <xmx:Pob_aoXDAdBr1Q7eLdM5lRYKPCMEIHSWs_Vy8H1Ldwpz_k97C4ZJDQ>
    <xmx:Pob_atBzp8wWJzgnAnxwP5OtllA3MJTPzaMGPlyvZOGPlUb6GRlXqQ>
    <xmx:Pob_atErIIIKEkTCWBFPGfPrh3e9wOGEuKA3-OWnjMWk4yNr9flGlw>
    <xmx:Pob_atnyi3JXxHWwVkFXZvYhpCUvaJogurHNWR5_nwZ69BpBetITlZiq>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 18:28:59 -0500 (EST)
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
Subject: Re: [PATCH v5 4/5] Add d_for_each_positive_child family of iterators
In-reply-to:
 <CAOQ4uxgan=mpQ9yHOyZwZZp8E69+oH3uaPJ5CBkP7Z5BCO-5jA@mail.gmail.com>
References: <20261119025942.2848130-1-neilb@ownmail.net>
  <20261119025942.2848130-5-neilb@ownmail.net>
  <CAOQ4uxgan=mpQ9yHOyZwZZp8E69+oH3uaPJ5CBkP7Z5BCO-5jA@mail.gmail.com>
Date: Fri, 20 Nov 2026 10:28:55 +1100
Message-id: <179513093550.1728055.17648674323193416652@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 20 Nov 2026, Amir Goldstein wrote:
> On Thu, Nov 19, 2026 at 4:00=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:

> > +
> > +/**
> > + * d_next_sibling_sched - return next sibling, but schedule() first
> > + * @child:  current child
> > + *
> > + * This behaves like d_next_sibling(), but drops the parent d_lock
> > + * and calls cond_resched() to avoid any soft-lockup.  A cursor
> > + * is inserted as place holder.
> > + *
> > + * Caller must hold the parents d_lock, and must hold a counted
> > + * reference on the parent.
> > + *
> > + * Returns: the next sibling, or %NULL if there is none.
> > + */
> > +struct dentry *d_next_sibling_sched(struct dentry *child)
> > +__must_hold(&child->d_parent->d_lock)
> > +{
> > +       struct dentry cursor;
> > +
> > +       /* always skip cursors to ensure we make some real progress */
> > +       while (child && (child->d_flags & DCACHE_DENTRY_CURSOR))
> > +               child =3D d_next_sibling(child);
> > +       if (!child)
> > +               return child;
>=20
> Why is this skip loop here and not after the resched?
>=20
> As this is written, if the caller passed @child which is another cursor,
> now child the next real dentry after another cursor and hlist_add_behind()
> below will insert our cursor after the real dentry.

You are right of course - that is the wrong way to address the problem.

I think moving the test into d_next_positive(), like with this
incremental patch, will work better.

Thanks!
NeilBrown


diff --git a/fs/dcache.c b/fs/dcache.c
index bacb218400a8..46aca619a9a3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2095,6 +2095,9 @@ static void d_init_cursor(struct dentry *dentry, struct=
 dentry *parent)
  * Caller must hold the parents d_lock, and must hold a counted
  * reference on the parent.
  *
+ * @child should not be a cursor, else two threads could potentially
+ * live-lock, each only stepping over each others cursors.
+ *
  * Returns: the next sibling, or %NULL if there is none.
  */
 struct dentry *d_next_sibling_sched(struct dentry *child)
@@ -2102,12 +2105,6 @@ __must_hold(&child->d_parent->d_lock)
 {
 	struct dentry cursor;
=20
-	/* always skip cursors to ensure we make some real progress */
-	while (child && (child->d_flags & DCACHE_DENTRY_CURSOR))
-		child =3D d_next_sibling(child);
-	if (!child)
-		return child;
-
 	d_init_cursor(&cursor, child->d_parent);
 	hlist_add_behind(&cursor.d_sib, &child->d_sib);
 	spin_unlock(&cursor.d_parent->d_lock);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 7150ecd81d72..c384b0f8743e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -697,7 +697,10 @@ struct dentry *d_next_sibling_sched(struct dentry *child=
);
 static inline struct dentry *d_next_positive(struct dentry *child)
 {
 	do {
-		if (need_resched())
+		/* Don't schedule on cursors to ensure we make some real
+		 * progress between scheduling
+		 */
+		if (need_resched() && !(child->d_flags & DCACHE_DENTRY_CURSOR))
 			child =3D d_next_sibling_sched(child);
 		else
 			child =3D d_next_sibling(child);

