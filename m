Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785380;
	b=N4tv1cvZ3mdv2pgU+ge/qMcdPXSccoLP3lhewwOSgXFCg8lhkwk5Py9x3ejUZGAETpiw
	 IxGPKaiJHq4jmqIAXySBW41P+lc1F7PiHXZuORFWYTIyC5041s8u3ak9jm2xo9ASaShzg
	 hs6SmgNmNbRw1cxreJaRircLhlOPYdKSZu8F34+yM38x+7SfEWUv2ZcItfcOXIhdTblDR
	 wF0Es1uSW2D16AlkGToYhPE36NVLHS3qtGhFGXdrGTv3nIqylfHPvx5xSIyGRCIAcQUYC
	 ksy6m2QQGFafnHHR85wkMDbCwB2VLDA8AARRs++M1Cdiag9rGCrLMnxDc9WzEQYg8XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:X-Mailer:
	 References:In-Reply-To;
	bh=KP1KQQ5zc6J2penQP9T7HSMskKwpsejXhyxZijwDgBw=;
	b=3VIeck60nvaekK0R1KAv0DDLHboZ1ITVr4QqAhJNYcNztxD2Fg1UxDmsO9CaVQxJp7cr
	 nGDpaX04lJa0y6NbTAv90leeTPLFh6aJYU928OidGihZ+OcHTmcRJ0tKUDDH/e47kOqcK
	 UtT/7EMW7JpPdaxbNCbWGmQsfSCVlLD0qsNkJDtc2FIno25In3K7dPpuAvTaMCDuEZqNb
	 qFzC3mTgBS6ScsYNrQp5LOmoRIkmKw2Iz3qVvEeGFRPg51wK3ECs4vnlrAarROZMMJ3nt
	 prr+CiRpB4uXj21+r6Bp9P+82puwqj6djdKMdQzSRshWiuqmL4v2SgKWJPP6B0lbZUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jDNYoHai;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C67606A323
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 13:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28C67606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jDNYoHai
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso77096775e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 05:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795785378; x=1796390178; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KP1KQQ5zc6J2penQP9T7HSMskKwpsejXhyxZijwDgBw=;
        b=jDNYoHaiPCM26YLr1LFLyg6vcqQ3lRu+qOryzuAYi+xEuAHmc0UqBdZ4poBpehE/5s
         7PiUWUCK2wkW2dteZs/thupIvuqyOU4W3Pq5sVdCMf0lb1Kxo4J28XQbhfyF7mT2cs7q
         3uFW87E7O1hT4++crNJt3NAX0SUI6+EOb5aReqGo7+i54H0+ooS6ly1ZFIV5I74tqsqS
         IKB4ZHTTJl+Khf2B08Stb1mg1Yplxkn/8s7Lx6Cqfze+pKKEyi0RsBeOj+BbhwP9gSIJ
         mP2LhvB4dpZzb760HoemttcxB1nTp4qjR8BwnjtOJyYwn3j7VDur80K0A/7El8aVvwX8
         YkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795785378; x=1796390178;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KP1KQQ5zc6J2penQP9T7HSMskKwpsejXhyxZijwDgBw=;
        b=AAtSEaqkUMmCKc0XOl8chZcbXYJXE/tJKXcDrST5qI5aoEWgUFvqpHtQq/5fGNZWEc
         NCSvkkUGbsmiI3svv+P9o2nTER2iQfFppEfzth3hULSan07kmTjCvSFMQTPpsXHD1Ony
         YlEebbWwTVdo3Ekr/Jha3Fkx2FMVBpC+YG+Oqys+rfYs0zC1J9cT877JSrGwnn4kg3sF
         a2NsB3mIwBkQGC5ANkx8Or6FXDz/mSUp4FXISYxekJy0hBSp9ArWVwu4mR3870t7W9Ej
         VISQZbq9aqDyYLy1DVKZTHP3X2PfZHDrCOOc/mE9VLMT6JcE6kC4EmoqUCGw8YkKxPq8
         H0iA==
X-Forwarded-Encrypted: i=1; AL+hErHR3tdvz9MLcyYnleOf4KKjE+2jICf3I1SZuYGNzV/M5EJOHGJY7sRn6PhG8OEv7ogaAUXAZMqULV7tnJAC@vger.kernel.org
X-Gm-Message-State: APuU4Z+Md8/yuCIus3OyArOQJ3TApoaQXt8BpkZ+rV31zk/vRf2M+iQA
	SBIOsgBEz/H4XD8YvaL7VxqeAo7kZZJ2I0zT1hjRoCibB01iiJPJrLmZ
X-Gm-Gg: AZFdTZdYFvSa3UhoQaiIm76rVMXqo+1Hs3O0B01LOo04htcjWcUt/pyyrk7bmiAfoSb
	EWQQKaI/EV6x+cGl1Io4Rg3V2CGZPH51HHXoWzS0+XuUJKGIigwEiaywcefnXm1erg0CIMDqxCu
	lHY5RfIccBBgOlE5Rd3fCWzuhW2VM01Cyq63n+NftUUgtWufuXzTEWP9Yll+go3JGnmj/TKV2i0
	aq0SQUPXgFUUNHHXVMs7Wobq6wFbi3TN08evs37lWz8NWLDjLsHOxMvinCd8fbM3yhxxLKEFUz2
	lWjH8GfQ7whP28Ws+RfLUgvY7DZTe0YbOMEMWIh7nyvV5Hw9ujwovAPhgU6H/sL0JO/jAGEOjd4
	ThjirvadalgunTPpT0G5Wei+mthDQ+FqHkMbp675zjo70BZsdVt3XFFKdCQe21Y0KX3mlU2eNWE
	CQOiw4ra2CXmcvfMeY5KjpuW3Q5b1yBui0tTPLpu2AzMCqSeLzDNyuab8cCYRPzLjMRUuBQOvdH
	AxyPZE/CWClRVcZ2xyVqe/hOTpgJN0Ox0+NPGmXQI2P8uMaz08vcN2nQ3sGi7/TDZqHz/tqOU6v
	kQzQxwBwmj6itLEiri9MPMYJ+RuUVxzHTqQSTVQfqOXtvPf77VMGu6qamfyG
X-Received: by 2002:a05:600c:6219:b0:4bb:a5f1:fc5f with SMTP id 5b1f17b1804b1-4bba60168f3mr171039875e9.26.1795785378311;
        Fri, 27 Nov 2026 05:16:18 -0800 (PST)
Received: from localhost (mob-176-246-245-5.net.vodafone.it. [176.246.245.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm947107665e9.13.2026.11.27.05.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 05:16:17 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=d266ab6a5424ddaad121a0a52eacc7f99696bf23ca7b0dd531f4216c8dd3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 27 Nov 2026 14:16:09 +0100
Message-Id: <DN60SA2AMQI2.3C10NXIO3L211@gmail.com>
Subject: Re: [PATCH v2 2/4] fscrypt: update fscrypt_prepare_setflags() to
 use xflags
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
Cc: "Namjae Jeon" <linkinjeon@kernel.org>, "Hyunchul Lee"
 <hyc.lee@gmail.com>, "Eric Biggers" <ebiggers@kernel.org>, "Theodore Y .
 Ts'o" <tytso@mit.edu>, "Jaegeuk Kim" <jaegeuk@kernel.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Jan Kara"
 <jack@suse.cz>, "Alexander Aring" <alex.aring@gmail.com>, "Darrick J .
 Wong" <djwong@kernel.org>, "Andrey Albershteyn" <aalbersh@kernel.org>,
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Lauri Gates"
 <lauri.gates@gmail.com>, "Christoph Hellwig" <hch@infradead.org>, "Dave
 Chinner" <dgc@kernel.org>, <linux-btrfs@vger.kernel.org>,
 <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <ntfs@lists.linux.dev>,
 <linux-nfs@vger.kernel.org>, <linux-api@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261126163114.403846-1-koray.fra@gmail.com>
 <20261126163114.403846-3-koray.fra@gmail.com>
 <CAOQ4uxjGLfuZMFABCwMvdXwnU+P24G_aTJLudWbjeSmWwyDF6Q@mail.gmail.com>
 <DN5YPR39J7QI.1S1LCFLNUCZNL@gmail.com>
 <CAOQ4uxgzmB0dEpQCVGKOc8reJ6OFV=BxDMgRW81aKiCMwDSn_Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgzmB0dEpQCVGKOc8reJ6OFV=BxDMgRW81aKiCMwDSn_Q@mail.gmail.com>

--d266ab6a5424ddaad121a0a52eacc7f99696bf23ca7b0dd531f4216c8dd3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Nov 27, 2026 at 1:02 PM CET, Amir Goldstein wrote:
> On Fri, Nov 27, 2026 at 12:38=E2=80=AFPM koraynilay <koray.fra@gmail.com>=
 wrote:
>>
>> On Fri Nov 27, 2026 at 12:35 PM CET, Amir Goldstein wrote:
>> > On Thu, Nov 26, 2026 at 5:31=E2=80=AFPM koraynilay <koray.fra@gmail.co=
m> wrote:
>> >>
>> >> Update fscrypt_prepare_setflags() to use FS_XFLAG_* xflags instead of
>> >> legacy FS_*_FL flags.
>> >>
>> >> Signed-off-by: koraynilay <koray.fra@gmail.com>
>> >> ---
>> >>  fs/crypto/hooks.c       | 10 +++++-----
>> >>  fs/file_attr.c          |  2 +-
>> >>  include/linux/fscrypt.h |  6 +++---
>> >>  3 files changed, 9 insertions(+), 9 deletions(-)
>> >>
>> >> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
>> >> index 149498bdab94..52d6a33fc9e9 100644
>> >> --- a/fs/crypto/hooks.c
>> >> +++ b/fs/crypto/hooks.c
>> >> @@ -182,10 +182,10 @@ int __fscrypt_prepare_setattr(struct dentry *de=
ntry, struct iattr *attr)
>> >>  EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
>> >>
>> >>  /**
>> >> - * fscrypt_prepare_setflags() - prepare to change flags with FS_IOC_=
SETFLAGS
>> >> + * fscrypt_prepare_setflags() - prepare to change xflags
>> >
>> > prepare to change the file attributes with file_setattr() or one of
>> > the legacy ioctls
>>
>> Ah yes.
>>
>> >>   * @inode: the inode on which flags are being changed
>> >> - * @oldflags: the old flags
>> >> - * @flags: the new flags
>> >> + * @oldxflags: the old xflags
>> >> + * @xflags: the new xflags
>> >>   *
>> >>   * The caller should be holding i_rwsem for write.
>> >>   *
>> >> @@ -193,7 +193,7 @@ EXPORT_SYMBOL_GPL(__fscrypt_prepare_setattr);
>> >>   *        another error occurs.
>> >>   */
>> >>  int fscrypt_prepare_setflags(struct inode *inode,
>> >> -                            unsigned int oldflags, unsigned int flag=
s)
>> >> +                            unsigned int oldxflags, unsigned int xfl=
ags)
>> >
>> > This here is a backporting landmine -
>> >
>> > Changing the semantics drastically without changing the helper name
>> > or signature.
>> >
>> > Please rename the helper something like fscrypt_prepare_fileattr_set()
>> > so that backporting mistakes will be caught at build time.
>>
>> Yes, though, would it maybe be better to just use xflags_to_flags() in
>> the vfs patch instead of changing the fscrypt function at all?
>
> Yes, much better. I agree.

Ok, will do in v3.

> Now looking at the /* initialize missing bits from old_ma */
> hunk my reaction is to look away its huge and it should be
> using helpers probably called from within fileattr_set_prepare()
> itself - because if this is de-facto preparing for a set.

(I'll reply to this in the vfs patch thread, so it's easier for me to
find it again)

Thanks,
koraynilay

> Thanks,
> Amir.



--d266ab6a5424ddaad121a0a52eacc7f99696bf23ca7b0dd531f4216c8dd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCawmCmgAKCRA0bnTtJTDo
OM+8AQC9tcOsGFPF287JKL4pLZnhvZs7off4ihtuxm56vgpT2AEArgij7OQEsKKN
AWm00Ai0JaPzKxHQtiid5dTOQhG5TAY=
=uJ63
-----END PGP SIGNATURE-----

--d266ab6a5424ddaad121a0a52eacc7f99696bf23ca7b0dd531f4216c8dd3--
