Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792719168;
	b=V7nrsgmai306pvp1aM7zPPU8eIsPXTqnmyyiIOxWKSsZx0xEJzcC6rM0LyUGpQ/H+kDL
	 5eOvj8SmqSNZDmln1u6OUlPnogc21B/8nPMIKMRyRYpIuzIngpyS6haB3EMNkPW8oplQI
	 k/jlSBB3X0Te+ejC/d0wz+pBHuw6YpqzPMmmW2jc+N8HvCUsT2LZkGUuGyQvTP0NA24eR
	 130DafjlXJr5ya+Oneb/aJ7VuRaUkyq9HlPO0uAww7SYNonfesJnaGAL2xIjDPfNQDfrZ
	 mYNNYSX/v+v7vyonWekw46NVIXDOfg29guP1VkxXF2Ftr3BqlcxXSWP4rUEt2TSXyXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792719168;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=K8N36CYulDX/mvOaE7QuQvIdZJ+qAIabawlj/o+pdbM=;
	b=FdeJWsMTZHhAJvv2LKG7WEHTpH+2+C+Zd0xRd9l+AB14zFf3iOUyTn1Xu4OUuCnq2S8H
	 jSQK4HrRv1BL/EBq6PHuf9R6R1G1HsMjeCqPV80CCuGJ7eDdxkBimWq++VCX37zDUKufZ
	 M+pkKaNtTtjwFFs+32t53UZV3j8JHMEwF2TY/98cTHEOlUWtq5Y3mDFfuXk5bSD+7ULQr
	 UpUkd6ys3cylu1CfcrE0NW3yjflZjWYW+tVfgH+NPVZZwsBrdAv81HQWGw7ZQfees3geC
	 Bou585shdXlQLD74+BfdG0mExmrUur5BAC0XTKvVqAzrmKS5D4nXvr8BjDol0WCAzIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=JYr5JL0W;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=oOvOcxEW;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4DE606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 01:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF4DE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=JYr5JL0W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=oOvOcxEW
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 57F431D00208
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 21:32:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 22 Oct 2026 21:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1792719166; x=1792805566; bh=K8N36CYulDX/mvOaE7QuQvIdZJ+qAIabawl
	j/o+pdbM=; b=JYr5JL0WrBdLIgrwIpQxQlMMpgYqmoNxzWAtTrKWPq+OIeoolS8
	fdeIC/EPMNhPL1Dcyk21i41C8sqT/SRzzYjbplAq2bWrU+HVoW6gmHeXcikIYw8E
	AG2u6V+rdZB2xo+enSDmX+Iec9pPxqJYfMuCTCmwfIRAJZbjzIGwsLCEsoaGLYga
	0B+L+DEtLyQ3sjWTNWzkODE+eaaeGEM7oOZpGubF+YRlSTXAo5LcDIdmyCnpHhcT
	6CArEdRqKsEUC5bF4VSrwnFw7QhiBLy9ALmgrEmhSR1/7Cr03PVYdmFwkbihYPGB
	cr1LVmSlJmnAGc2Zs8f4rors5blEnRKMp4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792719166; x=
	1792805566; bh=K8N36CYulDX/mvOaE7QuQvIdZJ+qAIabawlj/o+pdbM=; b=o
	OvOcxEWQpV4nk8NTtqB5R+x/guaplCvqziMdXChuHrmqApCuLwmRIpzWMqJ8yqxD
	FTnxYHOPJE/g5Ei8I02/feX6dollb9ZQIUYfoNLZ1tYf21Dy0Z0c1N9QYZNTYmxd
	/K22/JtpYsPRYwi9Pn2n0b/69h+Uu6TjWy1EWM/z1xLDenQI1Xqh94gUD5iq+YI7
	PowaCEIggL2HuyDEdM5sqPJxStucGrL/oQOBJgyQdn2YnDWwOLVIQxQ32QX1TwHQ
	kwSso4N4HFYKIy78EeTOTjxBmTNHIwNat/ydpvsrtuoLDXH7gwz7W9ol/oyAnbIr
	BtFl7HK6kD6rmlMuFWVKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792719166; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:LpUPzKXLV0ZrOdNEHFvUj8iBi3VZcutMfYlfsnimG+S9IjW
	rrcPr61cUA453ryctN8AsOPeAI0aQmIOsHvyIf1Wh7ixEDwtLUpfG91lpmSY5qnE
	fUILG6xOn/Pl+iXmbWBuHOyyZsYyVQ7YA1HIEbj1J/p06SxTKbQG96HDXogUo5h/
	e8oycClviKQZr136uu2OxJBDWhCiXoMldxjqdeueUMOqj+pX5cCXMXadQ6uBA9ad
	N1+vtVHPhFXCWy7nxHv8tXfoLQblTkjTrr64+9TjeFbngorv86PrZFd74bRZa+TD
	D+S6c5sKTcuIDQt2UomelkrFHhHBTjofhePmlow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:XIxinh98LrcUMlBqqu1+nEpTJYYCLjRyChA8Oy5yB9E=:9Jw1eH3KuDaGsq4lIMiviughjgykboz+B03vzLNRtCA=;
X-ME-Sender: <xms:PrnaaqdCPXfXjgfwbeVmu17Vt4gdVz6jYEgHGgEiTKE1VmNjsjdV9Q>
    <xme:PrnaahlDCW-od294us1Bhfresr7t8sh7IzpfPR00aHQqBzouVzvIMSr4w3HAre3jC
    SSosqkOZcJmZ716-xQ3I-y62DFFu7HJRKiSfb1ihzQ5WkQ0Ymc>
X-ME-Received: <xmr:Prnaai1_SPvpHnwBd7SBA7Ta4AlTG31foCWI5l1Sn0ZiRSfvPWTqxq-6IXouneiagSYO2QER17Zu_H5foW-I1yyHkDm_Pio>
X-ME-Proxy-Cause: dmFkZTEF1g41ExZKHi3RiVPgeCw7rhuZ8CNRNnraoiZBe4tkBbbv4Yw4tQfzDeBIhF09RX
    NL0EkowSG8DArQR+fMt4Ey192gP963cLpIsbaL9idd+bDlKQqG7rlDx5kmwNyuj95/pvV5
    r2cv6gHm1m3b+BYID3LD+YROiCOAtrdhIANmQLRPmNOzPupoxBGEV6Thdvqstv13dumFPi
    adCZasEMNeN1jVu/2JC70xOqB8h5RR05EpsShbzfsfr5WBO7u/30eEk0laLPC5CYF5P8v9
    BeWfAUrumXyd/yxK2ItYHKSxwhAk1Xfub2RO2ZXHBl3kuaQBOfwOPz0OExCFrFjia3edTd
    sVpmSC91d+n0PHhv79iO3zQYp/vNkFrioDWjysDHRJaPH6pO+ZxB+ezrqLKUwhslbEAL3o
    W4L1bM9qM/BaNglCKwqaOlJmu2YrGf7TwsFhZoQ+8zQwuCD0TwbgJH7T7sl1v5Ypfz6JSH
    mDWk52YVSvMJ+lmqxQQabiGTPIl3pbhqMitdLe1nlozkc0dfDbd4/5eSikE9hIfvtQ8/t2
    hz13cxZE/Epv1ysakUPeCDVp6kR2Jt4+JmPsANlp+kKKe4idlfA35LRnNmD5KCXLSc1ZRz
    GWmWyw40tH516slGqzbh1nDtfTXTpGYQUC2Tz8l/6t/bB70OuxF6TGTO5Djg
X-ME-Proxy: <xmx:Prnaaif9XPdSKu21OAkXXz7aQJs2oEu17LThY3r8xGosEzaiiofXjA>
    <xmx:PrnaakbkbtLDQ0Erw-zMj_C5d7zsFPQTd8dvKyA3gqiFi_CCGM0yjw>
    <xmx:PrnaavHXUOhzdanqmEy6QlrFiOGYPF5ZFoaiwPhq0YjuZ0bBGdy3kA>
    <xmx:Prnaaqn9Ev-FsWuluKquY4oOg2SrFrWyG-zkZ6PF69AEGsFWE0KPAQ>
    <xmx:Prnaamg5r7_57V12ZYl_-WRiR8kky_bAgKwvMgaDbaWi5JB7-JDYrYb0>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 21:32:43 -0400 (EDT)
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
To: "Paulo Alcantara" <pc@manguebit.org>
Cc: "Namjae Jeon" <linkinjeon@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 3/3] smb/client: Use d_alloc_trylock() in cifs_prime_dcache()
In-reply-to: <8b7c86a805f36b8556e742c76eaf0a1e@manguebit.org>
References: <20260929024352.1433257-1-neilb@ownmail.net>
  <20260929024352.1433257-4-neilb@ownmail.net>
  <8b7c86a805f36b8556e742c76eaf0a1e@manguebit.org>
Date: Fri, 23 Oct 2026 12:32:40 +1100
Message-id: <179271916088.2068970.6748308220146383713@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 23 Oct 2026, Paulo Alcantara wrote:
> NeilBrown <neilb@ownmail.net> writes:
>=20
> > @@ -77,36 +77,34 @@ cifs_prime_dcache(struct dentry *parent, struct qstr =
*name,
> > =20
> >  	cifs_dbg(FYI, "%s: for %s\n", __func__, name->name);
> > =20
> > -	dentry =3D try_lookup_noperm(name, parent);
> > -	if (!dentry) {
> > -		/*
> > -		 * If we know that the inode will need to be revalidated
> > -		 * immediately, then don't create a new dentry for it.
> > -		 * We'll end up doing an on the wire call either way and
> > -		 * this spares us an invalidation.
> > -		 */
> > -retry:
> > -		if (posix) {
> > -			switch (fattr->cf_mode & S_IFMT) {
> > -			case S_IFLNK:
> > -			case S_IFBLK:
> > -			case S_IFCHR:
> > -				reparse_need_reval =3D true;
> > -				break;
> > -			default:
> > -				break;
> > -			}
> > -		} else if (fattr->cf_cifsattrs & ATTR_REPARSE_POINT) {
> > +	/*
> > +	 * If we know that the inode will need to be revalidated
> > +	 * immediately, then don't create a new dentry for it.
> > +	 * We'll end up doing an on the wire call either way and
> > +	 * this spares us an invalidation.
> > +	 */
> > +	if (posix) {
> > +		switch (fattr->cf_mode & S_IFMT) {
> > +		case S_IFLNK:
> > +		case S_IFBLK:
> > +		case S_IFCHR:
> >  			reparse_need_reval =3D true;
> > +			break;
> > +		default:
> > +			break;
> >  		}
> > +	} else if (fattr->cf_cifsattrs & ATTR_REPARSE_POINT) {
> > +		reparse_need_reval =3D true;
> > +	}
> > =20
> > -		if (reparse_need_reval ||
> > -		    (fattr->cf_flags & CIFS_FATTR_NEED_REVAL))
> > -			return;
> > +retry:
> > +	if (reparse_need_reval ||
> > +	    (fattr->cf_flags & CIFS_FATTR_NEED_REVAL))
> > +		dentry =3D try_lookup_noperm(name, parent);
> > +	else
> > +		dentry =3D d_alloc_trylock(parent, name);
> > =20
> > -		dentry =3D d_alloc_parallel(parent, name);
> > -	}
> > -	if (IS_ERR(dentry))
> > +	if (!dentry || IS_ERR(dentry))
>=20
> nit: IS_ERR_OR_NULL(dentry)
>=20

I'll fix that thanks.
We should really try to get rid of functions (try_lookup_noperm() in
this case) which return a NULL or an error - but that's for another day.

Thanks,
NeilBrown
