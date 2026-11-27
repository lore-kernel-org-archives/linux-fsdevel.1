Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769327;
	b=WKXEpuP14lp294jK/lEbuJrad5TTyraoSwV6DRbK6E0IDkKzXtSOa5Zwz/2c0KlLphEA
	 8py0paNuQFoB5L/SYAEJ0QA/wFnGSLyZhwnEfGWL6jqL4jvESumnibyZvojblEQvFhXFf
	 vHxeI5ZRFEqdW8fezA8nM6Cmw29xVIpGVnUbu1kb9gi7NmTJXmAt8E0foQmtrBrvhEiAK
	 HldnLAqAv+YEchsCcb7sqlnxlCgkbDVNnqlDoK2C3hAIr4W2pzsgIqUSHxzRDaJgNvwND
	 bqqruc5fFpzovx62msw8WTZ8qFvpRRwIHoWpUTNffZeUvtQ2/xBnUm+BDO9fc+tomUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=IDez9NqT7Tj1QDvV6FYEN7zWNFn2T031QM3aseBOhj8=;
	b=J/fjT2uJGelWr3n9yVhdBTzYdIVi70VYxiheXNdLHwAInc2/Wd0BKIC1tanurifaV4gA
	 EMjagTwGcdh15koF83ooChuEJcDCGl2xX36NFtIs49q3dxI6grXYHPRrB5ExiuPle7yg0
	 9HySXHsj44Esr7j4nFVe+ybNUU73/P8ghwt9LLPYOSl3ve3ZX0Q1Nm2lq7k8f2G37/Ikd
	 NHLM27vSwCM1tjCv6WCrmNxHal6w2ceuZXr195doZ9vbPLca+iHU7hyrMowQPP/7iYtjz
	 3Hqm7IQ1QA19Ybevch1FhgcIAoEmsjt3CpGug6NYYS4kZabEp+J19T9LDxFOgXy3t4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dbJOZn5M;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF0606A323
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 08:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DF0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dbJOZn5M
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so63442735e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769324; x=1796374124; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IDez9NqT7Tj1QDvV6FYEN7zWNFn2T031QM3aseBOhj8=;
        b=dbJOZn5M3rCgRLPPOUJ++VnJKMJQm3Ohn3x6VlLjqOyC2bNT9/mOFF1yxLOyrzF1bl
         C+Kj5lfk/G5v+Ibl6kXxQpP75b5N2GOnPrygQfOpb+hL8pJdLWW2ruCSdOPWljpoOom9
         3k2U5q90CgtKcvQNVpmkgFpbHw4JRD8hnkpuKZMsHjBoE3LC1jnUEnzmSEuovDxk9r9t
         Wtqp53MEml1QkDIqwqCWvYw2/rzLoJc4/KbtnJ3GcoNMKSCSq01qjbob847q1eNmgWQu
         Cney17f61yibRSRiKAu1tIAGEODdNaIqbSZsxA3cV2i7XAT3GC/VSTY+hR3Urp47LrxJ
         8cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769324; x=1796374124;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IDez9NqT7Tj1QDvV6FYEN7zWNFn2T031QM3aseBOhj8=;
        b=sgW6uxxy5H1+eJk7rY+Wbj4l4u9hW5pKDm2PIyM7B/EqoJDH9eqV16e9q/dFKjPh3u
         cXsxT7kkmX9uuciOJNSqaIWjzUxwi4uMMfZQV8GMSlLaOZZWVa0rXMgx7kmrbmDG/mdN
         hGN2jC2weOig7MzrMXKmTzS2TEtMm2HZRZZt3Bvm0YdhvouaMxBZumFHdKOqXalEyrCC
         ijLwKa31lTa6Aaf9U89FuJTMt9Qfrry2G7gIHshVKEnzJZJ7ZpBUM4wp9j2JlH9raQLO
         7MDImyP2iLqsJjNR6kMSWBNz5Ekl7FG0jbmhJ7/8qY1wZfDQQ0um06EJAZxG1lCPmoQ+
         oDsw==
X-Forwarded-Encrypted: i=1; AL+hErGua434JZFxDnscWB+KvOT19DQEvQ8ewmvbCj7il67hJcI12GqHtywOtvGUXoKWris3Wq0pNci+E4TZptId@vger.kernel.org
X-Gm-Message-State: APuU4Z+JMf2x0HHD+AD0hvx7HjKBjHdw/meSmuu1YkzU0UNTlKa2fRHV
	kBulMua0NQxGukqlW+Sg6S7Q77fthUJJXXblPO3n8Olx4yA1pe7vqmLv
X-Gm-Gg: AZFdTZdHB3dXth7PlPXvpMWVv0NZ8hcW+ol8UF5U3CIFZC2Rw8Sl+MvxYn36m02OVt2
	kOUqPmyMbjEkysFriPddWHNa3H2a1B2LOQ/F992zoS0jz1vH1ywnsq/2wxx0R3pi4a3qIHbG1kY
	JwlsMX6Myv2sqEngZ3mWBSzCYMH+k+Yiok2I03/H2t9rdEw/CVuPy9+IUS1eeIFM/IQtjj1TUuy
	UsUPPmqpd7bFCfg70bJSQTKJqZc8Ucfi+BSA+WMZO/V/ovjzC0DBkLePWbYn7swegSeq2XsJ1Ve
	PaInqCSBOXhZE9gEeNSJlqa7GHq/fkWfAsBj+kT75zq9bG6Ip5bXbV/n14ntd77SKg3zo1HjYrI
	L59BLGABu1WvWZG12ufA3Chyp/iryZra2LwiT/GFqy2OJJTYegIS8g5k22djVOj+SMbjtUJ3amP
	tc5vVvNPEL3ilh/RFxx2uLSf77a8EAgXj3d2HIEVhpQNfo3RX72WMeTrX0ri87oJs1RChzuGnuX
	EIkbMeWLzIfyLoskcyQuoRYGaVS5iDFu2O2tFKJ/yJ4IK9oZ37e1TjbRvPysyRorWh1LThKrq8g
	s/TEaUoUXlMGrxXzpPUhEhF7j0fjqGC1t8Ju2FDFCK3emWL64x1k/mVvT5Z6X+gbBAxIwA==
X-Received: by 2002:a05:600c:4f81:b0:4bb:5e8c:13bc with SMTP id 5b1f17b1804b1-4bb88805902mr454676765e9.7.1795769323802;
        Fri, 27 Nov 2026 00:48:43 -0800 (PST)
Received: from localhost ([130.192.98.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906635c7sm426511305e9.2.2026.11.27.00.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 00:48:43 -0800 (PST)
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
 boundary=c6f8ca06bd0087fb130def184d18448cb7c766d554c063c5f32d1cf88680;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 27 Nov 2026 09:48:36 +0100
Message-Id: <DN5V3F9BWZNC.ZIJY7Q6XMDOM@gmail.com>
Cc: "Namjae Jeon" <linkinjeon@kernel.org>, "Hyunchul Lee"
 <hyc.lee@gmail.com>, "Eric Biggers" <ebiggers@kernel.org>, "Theodore Y .
 Ts'o" <tytso@mit.edu>, "Jaegeuk Kim" <jaegeuk@kernel.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Jan Kara"
 <jack@suse.cz>, "Alexander Aring" <alex.aring@gmail.com>, "Darrick J .
 Wong" <djwong@kernel.org>, "Andrey Albershteyn" <aalbersh@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, =?utf-8?q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, "Lauri Gates" <lauri.gates@gmail.com>, "Christoph
 Hellwig" <hch@infradead.org>, "Dave Chinner" <dgc@kernel.org>,
 <linux-btrfs@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <ntfs@lists.linux.dev>, <linux-nfs@vger.kernel.org>,
 <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] vfs: use goto out on error in vfs_fileattr_set()
From: "koraynilay" <koray.fra@gmail.com>
To: "Greg KH" <gregkh@linuxfoundation.org>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261126163114.403846-1-koray.fra@gmail.com>
 <20261126163114.403846-2-koray.fra@gmail.com>
 <2026112647-earful-frosted-6ef3@gregkh>
In-Reply-To: <2026112647-earful-frosted-6ef3@gregkh>

--c6f8ca06bd0087fb130def184d18448cb7c766d554c063c5f32d1cf88680
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Nov 26, 2026 at 8:05 PM CET, Greg KH wrote:
> On Thu, Nov 26, 2026 at 05:31:11PM +0100, koraynilay wrote:
>> Switch from using if (!err) { ... } to the cleaner if (err) goto out;
>> in the main body of vfs_fileattr_set().
>>=20
>> Signed-off-by: koraynilay <koray.fra@gmail.com>
>
> Real name please.

Hello, this is the handle I use for everything online, thus my "known
identity", and even Linus himself in Commit d4563201f33a
("Documentation: simplify and clarify DCO contribution example
language") said
> And despite the language, we've always accepted nicknames and
> that language was never meant to be any kind of exclusionary wording.

Also, I already have a few accepted commits (here[1] and elsewhere[2])
with this DCO, so it shuold stay like this.

Thanks,
koraynilay

[1]: https://lore.kernel.org/linux-cifs/?q=3Dkoraynilay+%22Applied+it%22+f%=
3Ajeon
[2]: https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D29803ed3ce

--c6f8ca06bd0087fb130def184d18448cb7c766d554c063c5f32d1cf88680
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCawlD5AAKCRA0bnTtJTDo
OA8rAQDeEx1D2WxXRvyGunXEuOW+Cj+dElpy7MJchlEm/WMNBwD+JvucXkEupO3z
6yiHSY99QVuCP3aqlN/orccezZlLGQ4=
=mM8H
-----END PGP SIGNATURE-----

--c6f8ca06bd0087fb130def184d18448cb7c766d554c063c5f32d1cf88680--
