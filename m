Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C538371076
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411530; cv=none; b=gH4o9hAGSAvR09Sf98+YVKSzSpXRCKagAJCysS2DgEAMmO9bvBxutImvliKoBG09E+Nmf6oYi+H+IRVG2BiAlkP0H3SD4yOfRYQzlCM0c5v1rHX7T5LxQ6DbwVVx5nZqjOpcLByeKBghbKicmoxuI5zpQdbvUI4lIjTPteIAHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411530; c=relaxed/simple;
	bh=PSTLDA5BHqtvmwoYu6NWI6X7ONa5mXD1T2lvby3YmXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XqJ/ttap5khbx1Kx0a3m5KiuwQ81jETBzHdeKHG6aZnbqUVgLwRdpP5KXqfzCBckpiGtmLT/KNjlpTLXCkb5MM3A97NS53W0gFT3ezgtE1iByzCWQY7oElg2i+0YsFznXVgycTTr2GW0yZjLzP4Hp2CTh+8+hJ+vXsP4N0Bbj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=lFDA23OS; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="lFDA23OS"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d4ddd179eso19395137b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789411526; x=1790016326; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=99ti4HqO2yqDTib0U20tCsH8joNtnCFUu7flAkJsqBw=;
        b=lFDA23OSia8vxP0ZPKnQ7NHXNuTjsH8tpT8U9sggPAcSz45k0VBvwWlLRARZi5+Vn2
         tMI5s1f3OWb90UWVsB5vlxrfWFJm785al6fCzcivtZBU63x6ZxsTyxzm0GjCf1WBXekv
         ixM++2FIoD5kVJvJH5A7MQkv1GyqXrBcCMH7lCxB2mnOBe55JinFZO3sj/jGk65A4biL
         KiqBmcKbn4rY2VdY/7LWhQJNUg4B77JQwSvX3oKzqO7vupHF7WHBUOMwxD6RyqG/D4Zh
         +UYGLBaPRc6miL7waDbQXJE4ZgPJNYbqwChPgz+kkWYz4n6FwiZg+bgNJdMZqzXBZG6s
         4Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789411526; x=1790016326;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=99ti4HqO2yqDTib0U20tCsH8joNtnCFUu7flAkJsqBw=;
        b=CyWbcfwmpIdGBSLW+jqj3CX5gfUEZmsSMIXMnIn64+CV146te/g7eZkAam5bbNdTiq
         HxoeleULZ/Y/m02AoyzNP7lb9XWziurfEM9hzYkhRQiDmPv3WT4cYxWut6NkAv3nlpEU
         EBG9PwXWw+OoAv88mlpnGLUk8CjXz0Q4q8rwHfKVEXTRZjYyBrw4PU2vwh8kt/zi7WGs
         ShcTrYXbotXe2SLkn+xhcHH+J/l6teHdT3E7MATYYnXbJ+6qTE/uq/Gdoztxj/tbVlDd
         gXDCFjo5NdKacww7mBkIS2wgHvk0mK0nAvxlS9W8z65cELUX144HXUyNQERbCav/JyD2
         Lbug==
X-Forwarded-Encrypted: i=1; AKwUvBwQlLwstelmECjwmi/LpHVChlm68mph3R9Kp4e4Rb0fYTgx3qUKOZuZWT4lggR0Nryx4xg8nEmQMhi5fDom@vger.kernel.org
X-Gm-Message-State: AFuF++kW5E9/TU48ZQEE4fOfn/3tbtcwzCmSGWkfBa9lrj3rTLg47bhW
	UlAHOLxC6bLVOC3R9dQbECXWCxQiSKIo+DaufKqCnJ1txCNIeTD7/FFDxRQJSjq4+TI=
X-Gm-Gg: AYBFou0J6jqE8EnnfKHhz+CllJST/6uULdbb9Vce6dl3xJASeoBpLM8ysvcY2zJCcnx
	AT6nl1fD37ACDeskcK7rb8EWpmyHDwgw3WhvDb6eVyOMGP2unmSitR6Fs0wHrdXRVABxkCt+xDe
	LN8bkInVQThM/I3PC4/Lrd4ZYDv/rKniQWNDW8xvp2F1K/+xKNGYNFOsW2a6TSGr5/5gFNf0CV3
	Wq5hXNzViVR0o/y2U8auL8JSULekJQTzyePKdlc/1TGWYquwLnpHBeJRiD018vDKfES4+el6hRn
	cunaOf6Z2QDUwDQhDritPAHjM5/9UOsWDKy2aWICEJGri0Gr93ffGBkYnaE7ipD0cS9GBsHNQgR
	7FJJpQ4nngpJ40H1u2a5CC8P7nN/3t9cvDK8mCt6JQEVk+xMOoiL7vOMgl+J6IGv7ub7uBeJ6wI
	sF545Zh+w3cE8Bz2xQ37quZ89KQZPDJWnM9df1Hmme3gqJDiXddNMLn1ud7Wnr8LRk5zbqlizIQ
	fUTYrjudSzcgwsuudLi032woZk6Ffq0stEkrLf2nYxo/mVgjVbJPA4l65f5kZ9umkhJCqJkXb/e
	gtcfeRn1penN7USDaLkmMxF2sOPe+5ZmVH9I0O9RV1sqFEQfXS2LvM1T2d4qOD4k
X-Received: by 2002:a05:690c:e1d3:20b0:859:9c98:b8b4 with SMTP id 00721157ae682-88d2436e836mr13399897b3.31.1789411526083;
        Mon, 14 Sep 2026 11:45:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:df87:8743:655b:3824? ([2600:1700:6476:1430:df87:8743:655b:3824])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8848711b85esm39733337b3.24.2026.09.14.11.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:45:25 -0700 (PDT)
Message-ID: <6a7b33d28aad91599495082a00c8f869e0afa5da.camel@dubeyko.com>
Subject: Re: [PATCH] xfstests: exclude hfs/hfsplus from generic/339 run
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Theodore Tso <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>, zlang@redhat.com, 
	fstests@vger.kernel.org, glaubitz@physik.fu-berlin.de,
 vdubeyko@coreweave.com, 	linux-fsdevel@vger.kernel.org, frank.li@vivo.com
Date: Mon, 14 Sep 2026 11:45:24 -0700
In-Reply-To: <aqQR6cujdVg5qCFp@mit.edu>
References: <20260910000449.747189-2-slava@dubeyko.com>
	 <aqJ--AqubS-CWiV-@infradead.org> <aqKzDpccJgkmzC5E@mit.edu>
	 <f156a3665404751b29fd21d9ee136f2d66d5fe87.camel@dubeyko.com>
	 <aqQR6cujdVg5qCFp@mit.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-11 at 10:48 -0400, Theodore Tso wrote:
> On Thu, Sep 10, 2026 at 02:14:08PM -0500, Viacheslav Dubeyko wrote:
> >=20
> > Could we have any generic way to detect that file system could not
> > support some Unicode characters?
>=20
> We do have unicode tables which are optionally compiled in if the
> file
> system requires it.=C2=A0 But those tables are from Unicode 12.1, and the
> latest version of Unicode is 17.0.=C2=A0 Most of the new characters added
> between Unicode 12.1 and Unicode 17.0 are for dead languages that
> archeologists and academics care about, and new Emoji's.=C2=A0 So functio=
n
> will let you know if a Unicode character was considered valid as of
> 2019.

Only God knows which language will be dead next. :)

>=20
> You're asking a different question, though which is for hfs/hfsplus,
> what character are deemed valid by fsck.hfs, right?=C2=A0 And as far as I
> know, there is no way to answer that question in the hfs kernel code.
> What you could do is to try creating a filename containing a
> particular character, and see if the kernel rejects it.=C2=A0 Ext4 and
> f2fs
> will reject such characters if and only if Unicode strict mode is
> enbled.=C2=A0 But that's not going to help for hfs unless you add that
> support into the kernel....

Yeah, sounds like pretty complicated way. Likely, probably, HFS+ code
is missing some piece of Unicode functionality. So, I am checking this
right now.=20

>=20
> 					- Ted
>=20
> P.S.=C2=A0 A problem which we haven't really solved is how to add support
> for multiple Unicode versions at the same time.=C2=A0 So if someone
> imported Unicode 17.0 into the kernel, ext4 and f2fs really require
> Unicode 12.1.=C2=A0 Short of supporting both Unicode tables in the
> sources,
> someone would probably have to figure some mechanism (perhaps using
> Agentic Engineering) to collapse the two Unicode tables into one, so
> you can answer the question, is a particular Unicode valid in 12.1 vs
> 17.0, and handling the Unicode canonicalization rules for Unicode
> 12.1
> and 17.0 based on some API.=C2=A0 This is the other reason why no one has
> bothered updating Unicode, since it would be tricky.
>=20
> P.P.S.=C2=A0 There is reason why, over a decade ago, when I was talking t=
o
> an internationalization expert at an Internet Engineering Task Force,
> late at night, at a bar, the expert said jokingly (and when said
> expert was very well lubricated), after reviewing all of the
> engineering challeges of getting I18N correct, "It would be easier to
> teach them all English."=C2=A0 :-)

Yes, it sounds like much easier way. :) Maybe, I have a professional
deformation but I cannot imagine other than English for programming
languages. Even that I needed to learn my first programming language as
a subset of BASIC programming language with commands abbreviated from
Russian words. :) This is one of the example of dead language (I mean
BASIC not Russian). :)

Thanks,
Slava.=20

>=20
> Mercifully, we only need to solve a very tiny subset of the I18N
> problem in the kernel.=C2=A0 :-)=C2=A0=C2=A0 :-)=C2=A0=C2=A0 :-)
