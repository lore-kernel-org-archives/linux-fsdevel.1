Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074CB328616
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154205; cv=none; b=QD247Rmt7dKrSaB5sZIZNaNOOvORFFKtPb8cypeW78Bug49Xvs7OgigQREEcMyn9vsbQ9ql5iy3ae5oBytNDRVPk7pazPDmdhnmQp6elrHQ2Z5JarBmkZrI06KeZB2zkFKmlKJ9hgg4n1eMsiGN9NjTWwX2EeUse22Leg6SwJ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154205; c=relaxed/simple;
	bh=Jq7NtpA8Dqw5GGwsoxCcWqkhtgpX3dAzabxM8WdgfFI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Je6g8gRIfEqV0mhHbJQqQi8neX9TDuMVRGf7B8Py0alGRr3DAQI5i2Hr3uYM7o/BZMdCANw9fV8nfLffy+ERSFaIB7T9yYzwYth/hiag4J/JPM4c542ndWOj7oEB/uom9OQKAtSyaR40aWGQR2oXp24JnN7Qlhh3P4Xp0vyEtWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=l3gZ1xKL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lpN3oFiF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="l3gZ1xKL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lpN3oFiF"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D049EC0189;
	Wed, 15 Jul 2026 18:23:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 15 Jul 2026 18:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1784154203; x=1784240603; bh=GQl9Sdx6toO6cwaNOucXIDNcZNMyv2gcJis
	SS7eyKdo=; b=l3gZ1xKLj++ntK02vwmeIVWGuKMUs1VL1u/J8lrASYKZJtjCYzR
	3FV2eFtONg1S9H8SjT7zmvDLZXa6J2cZ3iCtyiBasOsUZAFulxrOt6UH5/unbcV7
	aeU0Cqrkcl2TxrjkF+5AIx0QV1edoVMMuiG6vj8/PpbPFxKeQHNLFOTp3OqHpH3L
	PDUumITNZvbVAOGmBrqUsDC6WiFhUKiPdaiUCFz48xLDeLu/mZ8fv68bXruCaALX
	I4CCABJQV7+JM7Z4KfLpC64DrR2GOHVva++zdyoG6eY6+4X8w0BIHTwEaqBBhnWq
	qvM7/2XEuFzj9MYoeu+9T0hlEK1Ufrp3DBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784154203; x=
	1784240603; bh=GQl9Sdx6toO6cwaNOucXIDNcZNMyv2gcJisSS7eyKdo=; b=l
	pN3oFiF/5GsdG+56gnjWbrs5re4JJDL7O0+NgLqUg8PU6JzOFO7tHo2pZtvfGXao
	Y6zFog8dhLtVQiHF2wvrtuMTcG/erO7ZoD/EGyifB3fPBzIKyGWR9o7xmwkrXLNI
	7l/q1oB4uUBBsJTXdPZ0gUNHz3GRv5rMt4wW6yj1zABJLZ4AddV3e6HdmlaltYT9
	JDhUlKs9pM7XK68fdxdL7hl9sT4LG0h82tCiEOZODcT8dk099lapeK0fLMIW37JK
	KFDxYVdHWlZ0fYXArrjN+OELxzr46oX2mmHg0fZK7uztaQoL0vGBCWpKCv3YGZbf
	1bh5zKQ9i+MF3NBrXK2Og==
X-ME-Sender: <xms:WghYat-FfCpkMPLbMtXOp4jCdx-Dkv32_I2U9KZZXXmj8lGV0PI5bw>
    <xme:WghYaqqz28ZZ0jBnAKrO_TNSnnkL_-5acYVX6ICqr8-ECMl59i1qIa4lpS97ES32K
    ZHtnkZi-eX4kOeX0-Apxq4Impx6HqoGjGvVdfIPegcBbzFXgA>
X-ME-Received: <xmr:WghYammD53GDocuBWQJUt6l9cSIdhTj6ul8PVYqUSHbMLiX-o0uhiWOocninAzBbSmMgqUH2GMV_iBabWIdzYQwWb-fyEhQ>
X-ME-Proxy-Cause: dmFkZTGiYS1SsfNMwJV3sRzJyE+D7F6Gwwqz4jnYnc+85UiTDOt3qc78UK19r53Zs6BPCD
    X/ixyNC5k6Z3bde1k/0DQUyROBokklCStyfKL48og4Of9qhd7Zig3VWfkKP/ByhZTjAosY
    q8QzRR+jkXWeam8Tda33RtL/buAUv3kMsfjywa0w1Be6zfQf0/Ai0mkA8OpMVqe3zfL/Ys
    VvcgZFUf7hEUTdaqSTO7UhFqPxofCvVO0801zXfksEcDrczEr5PCDSosF5h+N/IxNO8Zz/
    ZWNHfWpv5osW6T1PdSUh7KtoTxPsHnqWNjiYXiGUml/2k+STXVdMHnsAAzuzOIwzEf9bOZ
    Ee6f744HOb0popapv2tR7Aek08p61FX+G/ZjpNKYu9T+VoOOqegKFwbSYJiJRoOPpILYmp
    iFjoGcVn8+slq17ejCXlHBjeZvNI41DjAaAdVG0b67Z6BRTcHF/E3jmkrvJ5Dt4MquiPw6
    K42h/yQNlm4z9lE2MVtAui/4ONsPl4L/h+LknKOC3HUfDvtLVoBQ1HbGekoWsrHW7WtN4m
    pjX7XyzGvv/E4cLeLR6Gbns1M6yiX6NrG8w/Q0cbutZRD3H8pqlIEcaMuYBvD/f3sPgo42
    K2uc18pHQfNHsPns4EK0wNQeZHJ8gVZAGDdULB0GtXN10ByI5gEKSzOBILgA
X-ME-Proxy: <xmx:WghYahiL4Kkf57W2bNo6_Pil07WKy-0JObBP4ZNRXmQs7dK6V13n1A>
    <xmx:WghYaucjdmQOVOtTHpB10cSa2PTMnTTVuzuRc8f-icxvD8Yebwt98g>
    <xmx:WghYahhDcDmJJjX0mH6elsq2BHFRoSonSjPwH9LdOW_3-LaDCKEW6w>
    <xmx:WghYamzwqWEHd3QCSnQV4bhkudUbtaV-MjJtui2up9AboXDyjFTEgA>
    <xmx:WwhYamo6tbP6eapcAltIg20UDtxJemLvPCVDzygYRE5U0xzBjjoypgq3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 18:23:20 -0400 (EDT)
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
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] VFS: add vfs_lookup_open() for nfsd
In-reply-to: <271981356.1167752.1784150466429@kpc.webmail.kpnmail.nl>
References: <20260713060814.2849-1-neilb@ownmail.net>
  <20260713060814.2849-4-neilb@ownmail.net>
  <1899194169.820712.1783939194879@kpc.webmail.kpnmail.nl>
  <178397971669.3371781.14361088370957076736@noble.neil.brown.name>
  <2091253759.1001623.1784032128121@kpc.webmail.kpnmail.nl>
  <178406989145.3371781.14103195631413999969@noble.neil.brown.name>
  <271981356.1167752.1784150466429@kpc.webmail.kpnmail.nl>
Date: Thu, 16 Jul 2026 08:23:16 +1000
Message-id: <178415419692.3371781.17330667014672666678@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > Op 15-07-2026 00:58 CEST schreef NeilBrown <neilb@ownmail.net>:
> >=20
> > >=20
> > > Yes, sounds good. Keep in mind that vfs_open() does not handle truncate=
, it only
> > > happens in do_open() in the open(2) path, so you must handle the actual=
 truncation
> > > back in the nfsd code. You are probably very aware of this, but just in=
 case :)
> >=20
> > O_TRUNC handling is a bit untidy (or convoluted to use your word).  Some
> > atomic_open functions implement it, some deliberately don't.  If
> > atomic_open wasn't used, it happens much later.  Maybe I could try and
> > tidy that up.
> >=20
>=20
> Wait, so for those ->atomic_open() filesystems that do handle truncate, how=
 do
> they deal with this? In do_open() we have
>=20
> 	if (file->f_mode & FMODE_CREATED) {
> 		/* Don't check for write permission, don't truncate */
> 		open_flag &=3D ~O_TRUNC;
> 		acc_mode =3D 0;
> 	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
>                 ...
> 		do_truncate =3D true;
> 	}
>=20
> So on truncate do they just set FMODE_CREATED regardless of whether the fil=
e existed
> before or not? Or does truncate count as create in general?

No, they only set FMODE_CREATED when the file was actually created.
But the setattr call fro do_open() which implements the truncate carries
ATTR_OPEN, and if the filesystem knows that it always handles O_TRUNC on
open, then it can ignore ATTR_SIZE when ATTR_OPEN is set.
I'm not certain that all filesystems do this correctly, but some seem to.

NeilBrown
