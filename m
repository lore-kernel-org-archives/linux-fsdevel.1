Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16243F8B6;
	Wed, 22 Jul 2026 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757472; cv=none; b=F/S8LcW9HTBX62MCtqgkMQy8kEjASMYe7d8dKH3GnA4a/X1mmy4VpGMhrngzmEH6E88Tt9HW/raCKEegz4+KWSWqm4Sla47qbqvj34u32gXYhUStppdjozNr9ahcs5pMWPAcvveIRIFOvJ/WSQotuJjKhZ9gvoyKBb2VwByZt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757472; c=relaxed/simple;
	bh=TkZ9c7rjARJvnzVDvuyB/BQ+pw6OZzvOXUXBSjxbIAY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hkpnjr4l4ql0C264wf9oVYnjXr1OLFZUR0c4ceeKlv7N11MvLnbQ1u0nrEs/nJRYlf+HLGo34XQAwdSC40NFYJCWEeaYOOPT8Vq42k9n3SJdqQH4XB/BYExiFc8QlRvO0Br6QgsacpAxEkWfkrLsKFw9fXi3zdHuSZZlP5nz7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=V/q+/RVa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zp+qqnBA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="V/q+/RVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zp+qqnBA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7AAD5140015D;
	Wed, 22 Jul 2026 17:57:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 22 Jul 2026 17:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1784757467; x=1784843867; bh=GoL4Jq9ylTA23wl2pouzOhmglNgHtMoEKuh
	iGS9+3RU=; b=V/q+/RVa39jxoE/6IUctC9WU1iV+lzYiLXj4QbSfk0xxHVoGOmt
	1d6efWvnBg+9RCFNDv6vRXlGgGWnFnNhbnQndOyKuBWdSiGS91+tAo++lDFTkSfo
	xZ15mW37YDI5bntZQYDXv1yC6yMF2Mlbnwdii0o2v3Hvfx7sb0RA6RKhbhg7mrdA
	byT8FkhErsir6jKo8wlPGJcGJe8wkNl3x++j6zhLDXtryWL7cFZg72BeZIibvvIX
	0Z+bue7Esku/FpOpGVQCIw1TftCkcaQsv0MlBQ6uJ4f66JA1ZMEUpNoDIn84ECbF
	W+xs2qRjThc0Is576AX6Zn+ms+DABO5e4nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784757467; x=
	1784843867; bh=GoL4Jq9ylTA23wl2pouzOhmglNgHtMoEKuhiGS9+3RU=; b=Z
	p+qqnBA4Vasg4fRAS2WKjRYK8wd3EGT3HpVIBSaLMezIdRfR8T1LVU2owtTIrzof
	iKrKLeKFLdH2jMs0HyWO2jeQx0dy6X8zVY4yVy/irT7Wj26i+HrwuOsF5eWl/p8+
	1o+UlzaM3bhmiAPTgtHHjH0Wcwk/FX8OlsxGTI0/G2Lb6CEaahucq+B8OVsT18Vk
	3oauQMGyxk2fsMIKqVfoLdLgZLGVD4yjQsVWCDo5X732ahQFt5C7os5BmcG+3AHX
	p80OUtjwd32seEOV4k1TymcgfjbhM0/9l1c8LDsEDkgvdRYz3SKjmmZDpNqOoeg+
	gRazrqeWk5v729lFluFIw==
X-ME-Sender: <xms:2jxhauoN3BwxRecm9xcJ_AUAq_0g1ibRqXcQ3ZdNUUuGZRWifu2ipQ>
    <xme:2jxhaoeTG3u8PlY_pCwuezxcqB-IcYzCryP4yDF_GUmOe-AqWLTSBTEKflng3QZqH
    mvI9FXLWmnOuduS4So-oQHTWW5zkutU9MDxS0uUB4hzyaAAWg>
X-ME-Received: <xmr:2jxhaulTDgwsOQH9unzSWbsRheuhJI-FaKx-xAz-q80fRZPqmelsYLmTJZF39O5HsZ5HlGuSdzDHRatT7Znz2eZN1qNdWL8>
X-ME-Proxy-Cause: dmFkZTGqoWNOYiraT70FRPF9K/H8uenxraszFi00nHjFmBdHPNC2F8C6AxoauUmjBJuOVk
    F3Pzvh/X47gf+65u8lCDqY2g97tm+TD3xkvMlTCmbyo4wwYF+fxpDwrLRIa6kPEteFFHwY
    wNTVViDOzERSho9aucLVRtyLOx6irR/Xn9f4/iiWwKGUq5Ewxtp5RlW3JncLsOY5m5sekn
    z/tqRTt/nN20RfCUJK1f1KzDkCeYDmLA6ySxMYnJ1yygSLrzGFYtCuBnqni+yJKd3xqSgd
    edbWTG/2FIwEO28EWmYPMUIBNpTkfj1LhyR/wbSg2s+A8fkxzOXeyC8NP9rkVk6smw3jEp
    oUckcLWCFsmcUWfwME1bJQCs3UbQHfkxFKayy+is/pVZ+20D1G4pRI1LK/EPTpp+2MzcSC
    3BuSBiN28lkWxUVMYKpG1ql5B2g9YgrAjPnAyInrHOW8w4klPLm9pw9gIp3cnx9jMVZWJF
    ikQqFgCH+8c2RN/yV4mLFxzIxDj5LU4bKLfDtClT0E3ql1QqR98rpMNW5JyiBdadJZnDnU
    Hil5yUwnCa6nKQuiNdIZoM784fE/v80EcCytHor9xSvX7celeodUTqyS8s3ujrXmm05Lw+
    QTI+GjX9pWWa4K27OFn/FIzH54LH7aaginsfoq49sBdEmMZ5KGg2RtiGM/cw
X-ME-Proxy: <xmx:2jxhanZN95wmLbzu6J1CO5F9XI2BBIPA3md7BSScYXWpdGsRYMJHBg>
    <xmx:2jxhar6VNgi7hjPRDkdpLj3XRnBs0VBVwYVaBEb3QYbJGGQEO8TLlA>
    <xmx:2jxhapBH7YMcqdmJdhcqlu90JyvLb4YaRSpMd0iJW750drxsx1gJPg>
    <xmx:2jxhah_mq_yNEmun8M_-biXVs_xMYKdYjPYTTfAugx1FYvnGHry1CA>
    <xmx:2zxhapZyVTmWgMUSxASvxUpQBJHJbvZ4uDj98TlEHEQIDbgmpUS28JrA>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 17:57:43 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Christian Brauner" <brauner@kernel.org>, "Pedro Falcato" <pfalcato@suse.de>,
 "Jeff Layton" <jlayton@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Aleksa Sarai" <aleksa@amutable.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <987276143.170754.1784726828216@kpc.webmail.kpnmail.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-10-jkoolstra@xs4all.nl>
  <akyyqnv9EpY7xVdC@pedro-suse.lan>
  <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
  <alS10NN_OduZEqvt@infradead.org>
  <20260722-mundpropaganda-vorwahl-funkverkehr-48efdde92a00@brauner>
  <amDBQN5lCGbRxGWm@infradead.org>
  <987276143.170754.1784726828216@kpc.webmail.kpnmail.nl>
Date: Thu, 23 Jul 2026 07:57:39 +1000
Message-id: <178475745953.3371781.2895727677996716858@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 22 Jul 2026, Jori Koolstra wrote:
> > Op 22-07-2026 15:10 CEST schreef Christoph Hellwig <hch@infradead.org>:
> >=20
> > =20
> > On Wed, Jul 22, 2026 at 02:51:54PM +0200, Christian Brauner wrote:
> > > > No, we can't rely on something being backport to old enterprise/cloud
> > > > kernel.  Doing so makes the interface unusable for actual application=
s.
> > >=20
> > > It's backported to all LTS kernels for multiple years and this
> > > nonsensical theory of using a software version with O_DIRECTORY |
> > > O_CREAT on a pre-LTS kernel from years ago is just flimsy.
> >=20
> > the kernel has always ignored unknown open flags, or unchecked
> > combinations and you can't just silently give them a meaning unless
> > it is backwars compatible.  That has nothing to do with this particular
> > combination.
> >=20
> > >=20
> > > Even just the mere fact that I was able to just backport that bugfix
> > > that started returning hard errors to all LTS kernels with absolutely
> > > zero regression reports defeats that argument. We've done way more
> > > invasive changes. This is a strawman really.=20
> >=20
> > Of course it didn't break anything yet because no one used it yet.
> > One we give it a meaning it will be used and break.  And if you like
> > it or not, a lot o Linux deployment is not using recent stable releases
> > or even tracking the -stable releases at all.
> >=20
>=20
> If you want your software to be compatible with any Frankenstein-kernel
> you just check what you O_CREATed is in fact a directory. If it is and
> there is no EINVAL/EISDIR, you are running a supported kernel,
> if it isn't, you're not.
>=20
> Or you just require a minimal reasonable kernel version.

Without getting all the arguments about how people should write their
apps and choose their kernels.....

Given how easy it would be to make this bullet proof by adding a "fail
if this combination isn't explicit permitted" flag to openat2 - why
don't we just do that so that it is EASY to write as safe app and EASY
to choose a kernel (i.e. any kernel at all with do).

NeilBrown


>=20
> > Just like we've always done in the past we'll need to APIs that don't
> > accidentally do the wrong thing on any old kernel.  We've survived doing
> > it this way the last 25 years (maybe longer, but that's about how long
> > I've been around) and there is no reason to magically change this now.
>=20

