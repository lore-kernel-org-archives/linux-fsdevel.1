Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A691F91D6;
	Sat,  7 Feb 2026 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770454513; cv=none; b=NuBA2iRU8MlXjHglurV7a4nkBhRPD13mk02qxDEQR5mL348kUoHKW8ZPKRtJLTg/XIwRcFtc5ueKctYOBpcfv34SksDsKcH1W5GNRNKypQNiw856zDUJ4/3C/sv/W6EkSD053GT4xLWA7xpX8UaK+MpER2BF4G0IPtaNxNuPXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770454513; c=relaxed/simple;
	bh=dvmih6ChEVAcWU28VaRDYdyj69IwLQ+7ZXx3IcRfwAo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7/n69m+lTt9TDv9Uu8MbaexV6e/vBpPYHJwAUG4lSc5nT8JI3icnBq2p00h8tpjH7V2XdfwUFmnNCNBJfiUXErUaEhNeUSQm6B8X+sjQanSowQEhajRrmC/cI/MPZVTa5WRKWrQK4pqxoDIZFlVZ3ejxAUfAg38f4QhZQIF/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=HuO+d5QH; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="HuO+d5QH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=giJoQY1uzrKBzj2DrMVLoYoh3mvGvFB6DdoGbYS9Iac=; t=1770454512;
	x=1771059312; b=HuO+d5QHIj6HI3iqn0WL3VO+hfjoX10QGBhUAVNoRXd2FfHc3zwvZrwsdIfXI
	fAt4MvWsVLX7iJXhHnFob/EybqpGglX6VdDLKmvl9biZqnKOyRSkJdEX4g3YYiVlLF43WUtRvn6oA
	ea70ENzY8kfhFhj9WYiRbsFVkcupOnAtOehCLeSSQgrSZaXHj4/ZmVYXv5QwTinCClA8wIFKRPko5
	HxOYOE9lIp6lNlnoOUy0IsXVZJzWQIvlyu82GCHt1rd5otOfaygtSwZWDSQH2nPJU2O/aC2lYUkKE
	MwIHCwLvy3r9uYhOi14jIToFCKl+A9fhFH5VJirOrKYGnf4ktQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1voe5m-00000000zKW-2e9N; Sat, 07 Feb 2026 09:55:02 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1voe5m-00000003027-1fjh; Sat, 07 Feb 2026 09:55:02 +0100
Message-ID: <66af2e9a17dab9f1ef79ad5812ec91aa9c0be005.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] hfs/hfsplus changes for 7.0-rc1
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Viacheslav Dubeyko
	 <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	frank.li@vivo.com, jkoolstra@xs4all.nl, mehdi.benhadjkhelifa@gmail.com, 
	shardul.b@mpiricsoftware.com, torvalds@linux-foundation.org
Date: Sat, 07 Feb 2026 09:55:01 +0100
In-Reply-To: <a1602ccf-73ce-46a3-b2f9-76cc7d2401e3@I-love.SAKURA.ne.jp>
References: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
	 <a1602ccf-73ce-46a3-b2f9-76cc7d2401e3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Tetsuo,

On Sat, 2026-02-07 at 10:18 +0900, Tetsuo Handa wrote:
> On 2026/02/07 9:26, Viacheslav Dubeyko wrote:
> > Hello Linus,
> >=20
> > This pull request contains several fixes of syzbot reported
> > issues and HFS+ fixes of xfstests failures.
>=20
> Where is the flow for testing these patches in linux-next tree?
> Are HFS/HFS+ patches directly going to linux tree without testing
> in linux-next tree?

The HFS/HFS+ tree should be part of linux-next which is why it's got
a branch named like this [1].

Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git/log/=
?h=3Dfor-next

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
