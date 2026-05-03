Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963592641C6
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777812126; cv=none; b=S6qIGSghC6rfPdSgqvZhfnfhp280AG1o4CFHwBhJD70e8yKiOCkftA0C+2Cx+PCIIB1wQ1RauZvoO/4YFzi8QfOSE4Z8wWFdo78iw2jozqMtPn0Jabw3LrcVIqcMaWrIXD8W6mwLpwD+COH1cpy8/tuR5Q6L9b2QeaL2gPH5Wn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777812126; c=relaxed/simple;
	bh=dt0StbWCWLJfXBRUgdFQWHuaugN16EV1camHQn0ZTfM=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=b2Hv5/Y3H1a5Ed0EAmfGmO6qsI0N8VLfUabC5QuoDT6q5daECPbBCeywxw/xVkfIhna6FekQhnAtQaA43qWNdpcR/vvqtGkmQ8dAAjYqSF35YbG0CX71IimDsrKGbim7JS1cUvAyFQfD9CB3vTMgY4arnnbwKSFT6sZ3ruD/OWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b=YfJx4Hf0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20251104.gappssmtp.com header.i=@dilger-ca.20251104.gappssmtp.com header.b="YfJx4Hf0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so355542b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20251104.gappssmtp.com; s=20251104; t=1777812123; x=1778416923; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Eote778LdrknJsapZDxLzaDakks9rKzrSxwhLLyLxo=;
        b=YfJx4Hf0slVay8bUXpjXo/UXODmcn27alraDkYjEZGCVz/kAQBy2oyvkLl6kHjkjnS
         YHb9F5SFIfGrdJIl4KtgClfJGG2JEmZHkwQvlPYcCVHWJhbDgJifoPrGpEqPBniCROmi
         DZCXmF+5ugBHgmuKw81BJsp5NnZd3Taylwdnq2bHFMbpHE6RyZfZSHGycGmcDKwcyna5
         2n8/cz4sKbNfdkaLuUMlPaVTcwFhc4maibFOYL6TzrkCK8AI9VqER2oAoUz7l9mRrjLR
         024VVKlJ7qUstQxKWbLMgm2ueE0AVnQfHclKnOSmkNxGJOR3SrBON6o+iLcdubFR9cL9
         Q2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777812123; x=1778416923;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Eote778LdrknJsapZDxLzaDakks9rKzrSxwhLLyLxo=;
        b=OUcxRpTCjquYTFyIQAvd3pRAr6h/mObvnKPJMl0DkGxdwmuVnK2CWFsBsslPAclk//
         prNaZAmKJYULZVLFklru8da5TnbT/+q1tsvZWuhFiibJ1JvNpUn6o7dgncBh5pNGqj0J
         64xWb6vpuAoHdWrrwtEHKK/nrHtNKdfgD54NzXafuaQ07YQ6q45ukHjmgIlZ7bRgX174
         DeHiZrNfdThHEOnT3r6LXNxb6VVINMYaIf+1WW3F1e0Hp2AY1Ke3gG+CnwQHCN1QkoPt
         JJ8XEXmn93bo69ZAmKvIoy5FJEQfYTPuzh05TkodlIQhHqmkikG/9RVl2w5L0vE5LyiV
         QRiA==
X-Gm-Message-State: AOJu0Ywxn+y1rsYnwpUZToLRkB6a61+UlKueUPC/6oNacAmb5fDCinFs
	HxK/vJxzzgjQWgegW4wQ5oLOBi87WOM8dBNc7/RmDLdYPGyCvi9KRir96X9b2RRYOz0I7dww67W
	/liWJ
X-Gm-Gg: AeBDieueMYPdTIJ+SIG2TwieOILlDX7ah/OuR7IVOdhwAX2ZOnVXHNiibOwifQVWsnm
	N2xTe45N9nK5/MkDetvNo/c6oALB2T37gklQdX4OIs5zKdwod6G9bu84JTwKYS4L/WC1IeRnWuL
	H9D/xNeAWmYaRJSNL0YIxz0jGxZdL5ww2aeP2T4arXrj89RzAvo9RFmnkevAhx1djB3Iwk5AofX
	ZLHGsX4eI+e8kwRSqXRx2R+gxhZgUEh1jXgCUs7SS98ClsfFmGT0tvP6ZqlgOPJKw1+LG3nNYIl
	iGTcg7GuqUsNdIG/C3RxuyftweFuo9jqzyw0TqnnbjV+sFRIbFWX946ldBKu6f4F1X4IZIv7Eza
	09hgdDowAcZINpsxZp2o0Sppv//VjhkJ+kveowWqJLUG1RQLDSGTNx/RMsVwMkk0shqzylWKCJu
	6p+5U8BNJH8rMBCT3Vev9et9JolWUenMMjEGunhBgllaYLJSnXQdxmk6ijsyhodmU=
X-Received: by 2002:a05:6a00:bc8a:b0:82c:249d:d84f with SMTP id d2e1a72fcca58-8352d23cac1mr6248636b3a.37.1777812123077;
        Sun, 03 May 2026 05:42:03 -0700 (PDT)
Received: from smtpclient.apple ([2604:3d09:3a84:1700:4008:5c92:aafa:bb6b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b5b921sm9760937b3a.54.2026.05.03.05.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:42:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andreas Dilger <adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Meaning of struct statx->stx_blksize field
Message-Id: <FAE1F98E-276A-4D61-86D4-47AE39F2E7E8@dilger.ca>
Date: Sun, 3 May 2026 06:41:52 -0600
Cc: linux-fsdevel@vger.kernel.org
To: Zeno Endemann <zeno.endemann@mailbox.org>
X-Mailer: iPhone Mail (23D8133)

=EF=BB=BFOn Apr 27, 2026, at 06:41, Zeno Endemann <zeno.endemann@mailbox.org=
> wrote:
>=20
> Hi,
>=20
> The man page of statx(2) describes the stx_blksize like so:
>=20
> > The "preferred" block size for efficient filesystem I/O.
> > (Writing to a file in smaller chunks may cause an
> > inefficient read-modify-rewrite.)

The statx(2) interface is meant to be able to emulate the stat(2)
interface, where 'stx_blksize' is reporting the same information
as 'st_blksize' exactly as documented (preferred IO size),

> However, from observation it rather looks like that field
> is set to the "block size" (meaning the allocation unit) of
> the file system the given file resides on - at least for
> ext4 and vfat.

IIRC, ext2/ext3/ext4 have always returned the blocksize for stat(2)
st_blksize, so that doesn't prevent the two from being the same.=20

> To my understanding that value is fairly unrelated to a good
> IO transfer size and for the most part not really relevant
> for userspace apps. For avoiding inefficient read-modify
> rewrite the actual relevant thing is writing in multiples of
> the page size (unless the page cache is bypassed, in which
> case I guess stx_dio_offset_align is the value to use).

That is probably more an effect of history rather than anything
related to statx() itself.  ext4 doesn't really have any other
preference on the IO size other than the blocksize.  =20

>=20
> Can someone confirm my interpretation, so the man page can be
> corrected? Or do I misunderstand or overlook something?
>=20
> Thanks,
>=20
> Zeno Endemann


Cheers, Andreas





