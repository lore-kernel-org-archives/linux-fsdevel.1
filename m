Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A61221F26
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074863; cv=none; b=lYXm2TrN7TkvyrPoSXpJfIaYvEF/4wSg+/SWTf/JMzj7tGSSDK8VmuX6DOVCk+dgz8Ke9U1SRqA/7IwT+zUGaR+6lszCMqYB8xNRDTCcCIysbCqAJVkS/n6ZzQd7/ohaiChdNGKfVCzpgTliFLKzlYNNkppx769QzVn9iGuNGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074863; c=relaxed/simple;
	bh=5oE2uZvsUyaYXny0+JJJPSa84KiRPnythZashd3Qn4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AEgsUMrLm9MSzg9QPrs+xVkG0TksxLf9MVJIaDVFI75SigaLLTv2v7wxBH1BFndCHKm8fmuxbtk1JvqLHuWNU/qzYF6vAPD+6aivGkaziWHGxynx85atZGkFsXS8EZx0yCjGb3Ky3xitGb+Qsy2SpAwbKyqSu1X9NdJbs3uzu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=0gkTl/OJ; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="0gkTl/OJ"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6711693e489so269732d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789074851; x=1789679651; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5oE2uZvsUyaYXny0+JJJPSa84KiRPnythZashd3Qn4s=;
        b=0gkTl/OJmBjWfwJAbU4LrFEwm9ZOE8sbJErQ5DuRCrXF+JVUSKvesLUAehm+xHXX8j
         emNADLursV5iwQlJ6QLQ1J+8jAe9iTuNezhpZD0bekGb4xRIAziTjpUJQ+cH7wspZqlA
         4FLZEWiD0GMDYnM67EqdsoT2a8cWsrZBJ3hh/njJ2tdvx0CSiieIKPEsePQAQ1CMTm8r
         kfLTQu/2LqzOnYca35ZYV96frEeTaC+wspg/dI9IkANwwXIqPeMEDbjdlAEccscgJdxe
         Au0wbt5bSfm43T27bip4JxAJzxVasT70RV8Ra24TM2O2krt/UyvAElyziQinRN0DE8g7
         05yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074851; x=1789679651;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5oE2uZvsUyaYXny0+JJJPSa84KiRPnythZashd3Qn4s=;
        b=Bqysk9HQXNAy5yjeF7zTnQFijkpoYMk9IuEbkzp45t8HyhX8u2FlP0VN3HebfhJict
         1cZP9T10IPqIciEshsBx/bQqXt5Src5egzgrzkQgo/ERnwm8/vuFlHTiyFv0Vih6/gNY
         PWnmF3L7uaZTXE4nxkRKWYWuMmIE8uukpUH7RXY1HnN5RgUVrsIm1XWW5ph4mmup+6pT
         4Y0udeL6A178FR1gPpf2tzEgw/HUHMM8v77fnO+zPKjQ+I1q3/H9Tr3iFXGoebwb2OYX
         GFiPZl/11decc0Uwgbm2ijldMIHq+FQjhm6zrfAY6HTUPtHLSUT+wiOW2qysNOuePCQ4
         YW0w==
X-Forwarded-Encrypted: i=1; AKwUvBy/jaoXTnqQfNgkHG5NhZ0uN1SYb1d+obPTyUtCUefFQl+8O/Fdfe1O9nbutdZXCO7JUiTaxFGpRE/5VrBc@vger.kernel.org
X-Gm-Message-State: AFuF++n1ceSzTIWo6zy5sZaP9PoqtAXZRDT6ZlBZubVagPRAI1jIYRtS
	Pi3VOzA3NsHFiWmTFD7BKMcMuxyTJf1Nk2RZ0yZj+yhNc5ux0/7EiOHdWVffWCI02YY=
X-Gm-Gg: AYBFou3rsDE9MaY8MeT2JFmQPqmbTGkjAnIKhlkeXuClwd+qKA2WSPTUJ4THGgC3VXZ
	flWkxoa7rXbU84DxinX9jOpJeT3lrGabvQSdF7Xt2MFQCbcof0bG+0/yQUYjSpSz0lOgyWmfv2j
	4PfhYCsL4/N5qm5+rmtlvUwkOMaFOwTKABxivQO+FsYLxj+9OONQGIx6HfEwA14KP3bC0njTmxp
	nXt6RpEqFfw3t5FiHdjOGjQ/Dt63rb7gzmu3T766TqEwRZqjn6QmEZ9HYUqCsjFTDU6p35/7Way
	p2kFxWrcMhtrcikiuxPr42AQ7jzqOhnMavBooaOf5pbakYSPiLFvZkGcHtetn8z5DVksXM/te0X
	eghgHckBFb5KrLwjRKbv3d+86atJYOO2MD8ZeZAq6LjHE0BWdw/Rsqq6593sy3+eMrY+c7IhpPp
	eiEypAu/9PM01rF7W1LHMD4NPsmzErjealIkZYBjAxoZcu/s3EEhdSejo7wBOP9GW0lI0ZO4j+8
	YkxeBjL6sIKvEihfkJjWp+rwsd61CiJjLyfAA1lorjfIlC58rKAaGhyyygsiJbN28rQ9M1TRCXZ
	gutzSCzQDK/4HoOUNOI7FrTbsoqMA5P+caIOIWfGrS/4eAocRZ9ifDHpVq0lXTSP
X-Received: by 2002:a05:690e:12c2:b0:66f:c1bc:4095 with SMTP id 956f58d0204a3-6712472b6cbmr664487d50.88.1789074850705;
        Thu, 10 Sep 2026 14:14:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:2670:dacd:b84e:82bb? ([2600:1700:6476:1430:2670:dacd:b84e:82bb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125df80e6sm155378d50.10.2026.09.10.14.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:10 -0700 (PDT)
Message-ID: <f156a3665404751b29fd21d9ee136f2d66d5fe87.camel@dubeyko.com>
Subject: Re: [PATCH] xfstests: exclude hfs/hfsplus from generic/339 run
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, glaubitz@physik.fu-berlin.de,
 	vdubeyko@coreweave.com, linux-fsdevel@vger.kernel.org, frank.li@vivo.com
Date: Thu, 10 Sep 2026 14:14:08 -0700
In-Reply-To: <aqKzDpccJgkmzC5E@mit.edu>
References: <20260910000449.747189-2-slava@dubeyko.com>
	 <aqJ--AqubS-CWiV-@infradead.org> <aqKzDpccJgkmzC5E@mit.edu>
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

On Thu, 2026-09-10 at 09:49 -0400, Theodore Tso wrote:
> On Thu, Sep 10, 2026 at 02:57:12AM -0500, Christoph Hellwig wrote:
> > On Wed, Sep 09, 2026 at 05:04:50PM -0700, Viacheslav Dubeyko wrote:
> > > The dirhash_collide generates filenames from arbitrary random
> > > bytes (only '.' and '/' are filtered out), which are not valid
> > > UTF-8 in general. Catalog names on both classic HFS and HFS+ are
> > > Unicode. Feeding random bytes causes fsck to report "Illegal
> > > name"
> > > or catalog corruption that has nothing to do with directory
> > > hash-collision handling, which is what this test is actually
> > > meant
> > > to exercise.
>=20
> I'm curious --- does HFS/HFS+ reject unofficial Unicode characters
> such as those used by Klingon?=C2=A0 (Klingon is an invented/artificial
> language, so it's considered out of scope by Unicode; so Star Trek
> enthusiasts are camping on an unofficial block of the Unicode code
> set.)

I need to double check which particular Unicode characters fsck.hfsplus
treats as invalid one.

>=20
> Invalid Unicode characters could also happen because newer versions
> of Unicode have added new emoji's, which might be added as support in
> the mobile handset userspace, but since we aren't regularly updating
> the Unicode tables, they might still be considered invalid if you
> enable strict mode in ext4/f2fs.
>=20
> > If user file name creation manage to trigger fsck complaints, you
> > need
> > to righten the input checks in the file systems first to fix this.
> >=20
> > We can then find a programmatic way to deal with these rejects in
> > xfstests, as ext4/f2fs in case insensiive mode probably have the
> > same
> > issue.
>=20
> Well, strict mode isn't enabled by default, since users might want to
> use Klingon or emoji's with a skin color that matches their own.=C2=A0 An=
d
> no one has been invested enough to continuously update our Unicode
> tables, and add support in the userspace tooling for upgrading the
> Unicode version in the file system superblock (which would then break
> compatibility with older kernels --- for example, if they downgrade
> to
> an older version of Android, etc.)
>=20
> Isn't Unicode **fun**?=C2=A0 :-)

Could we have any generic way to detect that file system could not
support some Unicode characters?

Thanks,
Slava.

