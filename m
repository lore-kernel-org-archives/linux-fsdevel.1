Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443330;
	b=yEzuDtPRfVunAeGSUdKvp4fK3MvOX+0iyH/2GxvleZB5L3mL060505tvRLOlXjl9DXVt
	 5Wh0oi6M+o4baun+fxK6KnHWHXJCH4B8NY0Gp7BrCeY9ZCtnCBsz/g9X757/XCyVSjsE0
	 w+663i0NgztARH/vx0RRQZtppPUF/bb2T+bSphNnMQPFj8D2G91OY8XLbw37S3QTt5TvK
	 /bLtvenx4pZUehDiU3JzxnZrkaCsyPPBJInNxjytRc5eTqoIdits1IFraWBRgDfDRDv4+
	 498M58FmshhbLC7KOfLJRKLsdCPRCcOzmU0EBLIlsXpdFT+Aicz7nd9HqtZIMBKuPVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=SVkCiAZ9hVspPzZuKZbqXCYeKQk4BcDbwlCFk9p1ut0=;
	b=0D+pog7xwvMk78ewjSXuLfWsKoUWpB+YnTKfde8jNeJmDgQRdRXUQkaS7fIe+5M1G/lz
	 Vlj3tNB0ol8V2XeCj/wg/VBf5fTLOwiY66iJ1aN+78hE6RDOf12v+Bu/Rvey1020DMZk6
	 aRFR8CH8s8oZdeOepczP5AzI/5gOtlMySpsQ/+AmHjRfKWOg2d0HrQHdRJ0UL7OoETxhG
	 sU3gWhTnMnNKIaE2uUyxGmtYRNZtQmgBbOGsVR/goAZK+6OcrMXa/wZJ7Knjz1pN0X0IU
	 mt6MZ1l6BxEawkCf5+4h5mpF416XrRFD+oExBWjFGK/w2Ypah8SdAsdMfz+WgDZ/MHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LhurUaLd;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A2606A33F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B6A2606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LhurUaLd
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso2208208f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443328; x=1796048128; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SVkCiAZ9hVspPzZuKZbqXCYeKQk4BcDbwlCFk9p1ut0=;
        b=LhurUaLdrrD6el1BtOOCJ70R+8KqK05u0u89mfuXWG8+J9Bw3rVb386658OMP5zMq0
         decyq5yItprIln2niTvSLmNubbRMdoF++9VmjkmrA05HZdXvZxDurdMDYBuXSM2/ru83
         DL0zGzc4TqwjCvYZ5gt34/pSFJf4/mCtDoKXgpXPt+Sv7g1Y86AFw3XQ6uM+o5M48dZA
         fsqr7/KfuhPw2PRwDKKUwpkICKW7wj5qvnFdYfxcb8shaROlLIM069A9F1sNO6bSCk2N
         auXzk8QjTdj3SnDJjqubihTVZqQWZzgbhHEkWSyJVafh+Xk4iboolLWwWkG1XoRweIGi
         qdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443328; x=1796048128;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SVkCiAZ9hVspPzZuKZbqXCYeKQk4BcDbwlCFk9p1ut0=;
        b=JQ9FqrrN78KwGAUhxAmj5FUe8tvFA0/5eop+pK8gW7nixNc1AO0N2m/8HainbsHxSX
         bqb/TATZNo+nu5q4R1CViyThegefd9/9+THaJ9gy6JS5mp0lEyRoB4bTQqqxoDyx0OkF
         Y5mpi7pmO4P/unW1V94IlCxCC9HfFrjJ1RwYhhC+bBR5cWrRP6KHgf1uxhUve0RlBBIc
         R0GFPX953+SGgQH5ZjeaMakg9SPxLo0NYvugzin4nwlaX3PWxe80o2Fk8wBzX/1ltUJP
         X+Lx2BNvD768eXta1nGArI6ycjHhdM6IhYxUi5vJYiFYoS5gSAKSq4k6U3gNDC47/PIq
         WDIw==
X-Forwarded-Encrypted: i=1; AL+hErFwmPksmUw9jENNfDKgV6Y1JJ7hArnT0eByitEwByXqDmlGXqoFPq3OgENAQvn8Db+I8Xho1/NMf9D0w7F2@vger.kernel.org
X-Gm-Message-State: APuU4Z9iK0xzQNLDPiAPlw6Oi6+OAfCKcaLU96YEw+Ej1DW55QBeYHdF
	ZWi3VwENYQiurVhQB/nr9mRcJCJjA+hYTHbbu85YohxSBh98LFujfHJo
X-Gm-Gg: AZFdTZdYPqMTkZgyS3yMiJF86qqo2cmzov/ToZEK7K/ZAnMZXyZtaZsq81iwYR9rtpT
	fbjrcqS1o6bRrFxZV4Aw20DNqdFS6NCj85rqHj7uVqZzf4cZugz5UdHt+GoH9GiJM5Wl8xBCGXn
	6YDJ1J/Id+gHlsKFflRspn53+Gl6caIjFe09fQ+486spAcseDuDMmBkC/ivmXQWtgbMxSE/Tgdi
	njZUNfqKtv1j09zisGqp9nSqeN74syteG8FWznRn/9qnfHFnQzJMQ/xVPMEjU7GWf6F43ez54rx
	FXtwRqhlh6GgGAB/r8bEFlK1ISoL95LI9R96q207hUY8FNCHSZk9xKsohNn8hTCjPimqJd5VYl2
	I1FI4u3ZXXxY4d5EP0GzruiwNPTt7EdEz0jYkHo9Qq4jxSA7JYZxasO4VemBpK8Tk7qtdGl6ZX7
	5dhDN9upgEyswSI4F2QqpTdp+pmgPS1NvN6kjnd78JB8pe376pz+glVThRFViIFIMSeg6p/Nkfc
	59enfNA54pjRll0YBrr1ZQe9TSxyt9TR624GFAuaA0ZoQEg7M3BNwmoNUvnnnrmGPMHbA1tpwuC
	Wpzi+pkFl0tYqYoYWg8jcKWYA1E=
X-Received: by 2002:a05:6000:4b0f:b0:48e:d7c:4bc8 with SMTP id ffacd0b85a97d-4abad6a1782mr21438558f8f.7.1795443327853;
        Mon, 23 Nov 2026 06:15:27 -0800 (PST)
Received: from localhost ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad6403fdbbsm15815535f8f.15.2026.11.23.06.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 06:15:27 -0800 (PST)
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
 boundary=d4d0d8ea600ad9a6a0e804d6ccca97eae7564ecdc87e5749b6027a98fdf4;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 23 Nov 2026 15:15:25 +0100
Message-Id: <DN2NJH234CC4.2LSWRSOO4TX5I@gmail.com>
Cc: "Namjae Jeon" <linkinjeon@kernel.org>, "Hyunchul Lee"
 <hyc.lee@gmail.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, "Chuck Lever" <cel@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>, "Darrick J . Wong"
 <djwong@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>,
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Lauri Gates"
 <lauri.gates@gmail.com>, "Christoph Hellwig" <hch@infradead.org>, "Dave
 Chinner" <dgc@kernel.org>, <linux-btrfs@vger.kernel.org>,
 <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <ntfs@lists.linux.dev>,
 <linux-nfs@vger.kernel.org>, <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] vfs: use goto out on error in vfs_fileattr_set()
From: "koraynilay" <koray.fra@gmail.com>
To: "Andrey Albershteyn" <aalbersh@kernel.org>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261122000856.536902-1-koray.fra@gmail.com>
 <20261122000856.536902-2-koray.fra@gmail.com>
 <awP8S5KF9v-nqWVY@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
In-Reply-To: <awP8S5KF9v-nqWVY@aalbersh-thinkpadx1carbongen13.rmtcz.csb>

--d4d0d8ea600ad9a6a0e804d6ccca97eae7564ecdc87e5749b6027a98fdf4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 23, 2026 at 9:42 AM CET, Andrey Albershteyn wrote:
> On 2026-11-22 01:08:54, koraynilay wrote:
>> Switch from using if (!err) { ... } to the cleaner if (err) goto out;
>> in the main body of vfs_fileattr_set().
>>=20
>> Signed-off-by: koraynilay <koray.fra@gmail.com>
>
> Looks good to me
> Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>

Thank you, can I add this tag to the v2 version of this patch (since it
won't be changed, and link to this thread in the comment section of the
patch)?

Thanks,
koraynilay

--d4d0d8ea600ad9a6a0e804d6ccca97eae7564ecdc87e5749b6027a98fdf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSgVimKafU5DQMcjcDmj22qf5IGXAUCawRKfQAKCRDmj22qf5IG
XGk/AP9j2YLEmAts6UKmrX6qw0EDoHRjv0eLrfHDRJfhkjSDdQEAixfLgqqT3tMt
wDbEqGGddyloPl2sCvNgcE83htldvgM=
=8yb/
-----END PGP SIGNATURE-----

--d4d0d8ea600ad9a6a0e804d6ccca97eae7564ecdc87e5749b6027a98fdf4--
