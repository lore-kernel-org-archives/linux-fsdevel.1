Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F53B27E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253448; cv=none; b=ue8uifGGWSsHfFf0fjCBk2sNyZTYX63Ic3hOi2NFIFakBYVnqTve+hvvxYFH7kafTFwGu8bK9opnzdcr+xBjDOHEVDmfRlZvhLtcEwVk8on8110JS8qm0kfswbcjAC5HWy6gxsRP+sBHUxbA05t0l/DAMXjGZ87OFsjMU3Sg3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253448; c=relaxed/simple;
	bh=BGhneuItUz7KOzuK/epKfC9DwI9TTG3U2/mjyrDhuFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5IdKhyNtHJA7ipZSColv8tqkJZhhTCKQFNuku/Y6ovsqMC8Eu2+LhvUjcI8S+l52kp1X8fZaM9tK1LYpKazos6jKH+fO9zX7UiZHFqA3IHaB8rMbMp/Ci4ymFtzf/c45a00GaegMmByehrT/mZxeRHeTqeIjfXQnD4V9IUexx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=UqN3+Cw8; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="UqN3+Cw8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BGhneuItUz7KOzuK/epKfC9DwI9TTG3U2/mjyrDhuFU=; b=UqN3+Cw8lnLkXQku8/2OqCKTwi
	htxm8ZztcdBM3HX7YGIOz9jjw/iuaOVE6gzUvnN5ByKL3jFwsjJnxalCnLfGAJgVMm8piWV+X4ytU
	9UIsoz8V/P1DPoWzO7SNh4HbWBSY720M05icATzMfZ3MYTodXeC2kGmTO8sbmRQfWIujBYGKDj5dC
	vun45bcMbQMBFzRkYM6rK39mBsbzxuHvpdedI1jzh+NDdnH15nv9GkmdGu1RTZRBPkf/yXXH1w7kM
	9XrUcS7eznhh3hPFjyvzAUul/pXqdZzmu/76RchhAs/R+WSlkht06MVwckfmarIHs2V7bXpG+hWWp
	If/mmZyQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wc9Wl-000000007sj-0IMB;
	Tue, 23 Jun 2026 18:23:31 -0400
Message-ID: <82a3c10f5a59bc6961b5faf2fbed5727c1c8ea84.camel@surriel.com>
Subject: Re: [PATCH] fs: Free any excess xarray nodes in clear_inode()
From: Rik van Riel <riel@surriel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Zi Yan
 <ziy@nvidia.com>,  Jinjiang Tu <tujinjiang@huawei.com>, Dave Jones
 <davej@codemonkey.org.uk>
Date: Tue, 23 Jun 2026 18:23:30 -0400
In-Reply-To: <20260623192850.1595958-1-willy@infradead.org>
References: <20260623192850.1595958-1-willy@infradead.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-23 at 20:28 +0100, Matthew Wilcox (Oracle) wrote:
> For many years we've had a hard to hit leak of xarray nodes.=C2=A0 Hugh
> documented it well in commit 786b31121a2c.=C2=A0 Recently people and
> syzbot have found ways to force it to happen with madvise.=C2=A0 Rather
> than fix the leaks where they happen, just call xa_destroy() which
> has the side-effect of cycling the i_pages lock.
>=20
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Jinjiang Tu <tujinjiang@huawei.com>
> Cc: Dave Jones <davej@codemonkey.org.uk>
> Link:
> https://lore.kernel.org/all/20260121062243.1893129-1-tujinjiang@huawei.co=
m/
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>=20
Reviewed-by: Rik van Riel <riel@surriel.com>


--=20
All Rights Reversed.
