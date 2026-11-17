Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.231.203
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794943778;
	b=0/2Cd0gsL3x6aJx8k8tOTwTQ4PzeSG6J+IblatslWNTbdihSNsb6gIERes59f64fWa78
	 1NkrJABytdVPxCjuLo/TmV1pM724Fm8l3v+oYRbdPNoCmessenguF6oYzA4nVHbRSjt/Z
	 /ySnY93n4LyiVQHmZLXNAEYHvY0oz885Hgte/w0yM5Ke44pN6kiXkwxvXxckorZgluEdC
	 Q1EjdELpZzqO4KjWbELJ67r7R+Eev8Le0RhxT+3EvBLMvZjjeeCMKVlkoXkVezyq7nLRq
	 sPHRJt0mVQx1H0yLSAWlTPd2hzHKJojF08f+MdRYb9eay3pQVoDocxhRN0ywX7cYfAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PGjBYsfF8c+MCFmt2RtqM8D82MXv6pCt/UIwi1wWB78=;
	b=46a2Pk2h0M2eSiXOAQVIrmZCVzVaO43ANTlXsNmi+0apmCa5+jwWpSfmBhPhh3y9ePZX
	 pIZs9P4Kds6KsIyWZzyI7Yeb0yuOJJhVEmtRv40MvAcwl3dA1I7+/SUVYoJy3JSaek6xh
	 W6h2Sljev5d6e/RMa5Tw0UNCKuDBJPKBY+rxKETH/nsOL2iSWK4bBVUb0uMKCAkmqqOPU
	 nF5Rhg8LnIDZid8lFmZKFISbBGIEziy2Ph+wyTKvKDCby5Ham1FdxdxGnxL5xeymnZb2B
	 /YAP7kug81PNH7NetlDzqIYqRJWKHOlMN0bOaXl67fjg0ZIxN4/ruvR/bJzG27bnoyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J9UrYEXx;
	arc=fail smtp.remote-ip=74.125.231.203
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA5606A32C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 19:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ECA5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J9UrYEXx
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-56d3169ad31so4615b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 11:29:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794943777; cv=none;
        d=google.com; s=arc-20260327;
        b=lgfQFtCkHEIj3Oa3+bksmC0eC+p9W7w3dBT7ZLPNs0F4UKJzuO0dR568Hc2B4fv6Kk
         FpmPufnemVPghsHvSUtZG2T66KsbYSOnrLkQYk8XkM3otwQvSOJoYz/id9kHRC29RStV
         mWqP3TddNSp5hp0xqlfX7ujR8IR7yVThteyGIG8PSTMSY5A/FrMc7kpbHiqXEMPpPv41
         SmXfHqr3I7PqgHWoGmLrQ4szPG1KE/9eqAFaWFhCuISW6yOkOaXQPy0vxydcv7zL/8DR
         wnxjyzJCpduIotTMNDiYZWVy9N0c1g+q6NjNABglGrhKQItK0HCMKLvTw7g2nNDY8M1x
         kWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PGjBYsfF8c+MCFmt2RtqM8D82MXv6pCt/UIwi1wWB78=;
        fh=0IixZoppqvXgyOhYmESADBd+Dj5RInMEdvDV1u7zDnQ=;
        b=SWWKw0i3b+/M0I4mMakEkxjxwx0j0zBj5h8HAg4xzq86SoYQoVddw7SAZa+p8GXOS3
         Z2KbMgwfzNYqYp3GMqXsuZtMxrKekhs0ULQ7YwxBFjipN4GL9evMYG1I5oDu23KEu8z3
         nkKCFk8eRjXp5HtjVRvB49/itrSA79arfI8lDo8b6dpQJGxaG28aIYqUgEZYHd3ocv58
         Qp9nkjX6DqvfK3YNUiEANM06OU3SZmSp+Xp7f7N7m+N350gjdjkKuai+95SSPsMS/iL1
         WiyMZERlkpm3JUb1PjTmUmeoRFu2vvX7f/QCQiO/Xj1+8tBMil7wo6n/L2E7cZAYbF0B
         HZgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794943777; x=1795548577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PGjBYsfF8c+MCFmt2RtqM8D82MXv6pCt/UIwi1wWB78=;
        b=J9UrYEXxFInTGXGxlAMUyzzW3JA4/NndbMPgVU8XEM/hPPaZ79SYjeBdxVnRKYpwgI
         PpPmtP7P4G2Vufq4mTh9OmOEMshV2ygyKC6o7GFt3AVazvUkyEl4BKjrgfR6Q6R5oRu0
         vv8ooxp06WmF5OO5x4alju7OwYJjG/bIeuQAtgbUsd3Mh50VtWjpzbX+pooVhdWrVmY9
         jDggGPFyTIy17xI4m0YXO+AaRPjf2J8XPNEpjsgnw3tFmswdcZu5aHBLtydsMz0gwx7s
         MrjX10vB4bjX4m16M3/S3rFf91KljWLV/XQ3EMVYFQsUQTX6DUz/+XHea74ZpM7M4z4h
         Hkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943777; x=1795548577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGjBYsfF8c+MCFmt2RtqM8D82MXv6pCt/UIwi1wWB78=;
        b=ebTftTLrWAypKrRt/F3gaxFJMf1WoPel8A5sXzBZXuKzrCk9J3H5cQdBPlDFWhE632
         kKOH+CIbfi7ew6BHM4tYDLTiQ5qLssVDItGmAYgbVXEoekB0wUP7McEaN0S03t7ONAIA
         iPS9YEW84fNsncy8OBKDGS0oYJSQSDT7dHehzn2X+f01W0IxB7eb9MFw499I/lvVJBip
         wTRIj8cLaagB2nIK/6s1G89qdMT1kJFAfrASNYrLYZnVqpg8RqqdJJP8I1f1m9+gb4TU
         ttEHwu89MME3bMVuw4oPC/rciUBVJNZcFeLEGvfUmgSzb5dy+ygQvq1ft9qa+39UyNa3
         gUfA==
X-Forwarded-Encrypted: i=1; AL+hErGpG1KXslO0dNr1U9qsaIMbnenlfXRQSWkvWktirogo7c7Tab4my45ZQqglWHifrgcWkZ98mz5y6ErGeEkF@vger.kernel.org
X-Gm-Message-State: APuU4Z+TSXLvK0HkrD9up3n+my2kjs7QGONZBXKIg4Zly31SviZRysso
	QMrn9gABNbD76lnfUx/fFKTmbyyMa/oFLqKMAunLOjyXuNgrMY5k/YULXrVhET29YpkJ0HMtI/F
	qhbSIPLoOjToVAsFfJddHrTaw00d01AA=
X-Gm-Gg: AYBFou1gMflFKRcfJ/3+dbdSw8EqSkhT0DXtRMpXOPfvlybQYPc8qGCB6a6aZyWpfHl
	rl6vIsryMyNXeKN3sP2xDssQ3ZZjKuVS+9cW3nzBdA0XYpKl70EXYgYpi9C/LrXG77w1YefXSwN
	es3yniKmUeaISNPwhTut8jFVA8OTLdrjvhr5XANSSJgzHTm2vu9eTgA5uSitLo31vvUAR3cH1a/
	gqZXN3K8FooqU3z65mhd2a25Mu2nqZvosgKUPDr7TKVIlIqclPOiLGyQXFoWsIJwz2MCFMHkWbB
	cUYKtYF3NvYoAnZTeIAH1pCysmwoeRtyxYLJQ627jL3Dff3OGO1E2zTStU2kEY2z4o7HcrXRYFO
	zlQq+iq6vW/sdgqR9a2xsI7TS+H65/7o1cQQV54NakBVw9AUl2J2QKIFqjKyF1h6PhX85BdkRdn
	oH5ZCjrK1Ue3dQKTPlgs7TMIMSJPmACw9RQZchaIbvfl+7uNwdjUVJ
X-Received: by 2002:a05:6808:30a9:b0:53a:e153:e8e7 with SMTP id
 5614622812f47-57741d17630mr920531b6e.44.1794943777052; Tue, 17 Nov 2026
 11:29:37 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJ6F8CFSfgdZqaKMndGZtbaww32Xr_KVL3gA_2Jemgv9i9vskg@mail.gmail.com>
 <CAJ6F8CFgkgksyk6YM3NdMkQNhSFWV4depC4c-mHvpDHpnjhM-Q@mail.gmail.com>
 <6ab4a114-57b2-40c7-99d4-55a4ac4c9a9c@leemhuis.info> <CAJ6F8CHzm4=ryY+j3ao6doR=-67Lq=3-w-kbhk1wdvtYDhyNeA@mail.gmail.com>
In-Reply-To: <CAJ6F8CHzm4=ryY+j3ao6doR=-67Lq=3-w-kbhk1wdvtYDhyNeA@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 17 Nov 2026 11:29:25 -0800
X-Gm-Features: AclHuK-EvuFT3sTbDUuzVCeVohToLo20JL-jPaY9zCV6KfEdKeWy3NzN4uK5qVs
Message-ID: <CAGEkeHdxaC2BBg5wWOCL0pj0r4Ks6mD_a3KpE7h+en9Aupb4zA@mail.gmail.com>
Subject: Re: [REGRESSION] ntfs3: existing files/dirs with ':' in their name
 became inaccessible in 7.3 (ads on by default)
To: =?UTF-8?Q?Cl=C3=A9ment_Smagghe?= <cle.smagghe@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, almaz.alexandrovich@paragon-software.com, 
	ntfs3@lists.linux.dev, regressions@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 7:43 AM Cl=C3=A9ment Smagghe <cle.smagghe@gmail.com=
> wrote:
>
> I'm happy to test patches.

Hi Cl=C3=A9ment,

I sent a fix that makes 'ads' opt-in again:
https://lore.kernel.org/all/20261115103845.56074-1-dennylin0707@gmail.com/

Could you reply with your Tested-by if it works for you?

Thanks,
Hungyu
