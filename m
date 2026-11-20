Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204637;
	b=kfl48bUP15yWJWNzE+oW1uDeFcWTMlYT/PTdZQaAu/OiWiEroSzHjfaqhZcUL4Xa9AcH
	 vtRtYowLTcqBw9JPcX+3IAmpA478Pqp/OrOz6Q7pb7mKp10PRNMJHIafaTWsT1QpA8x4D
	 JNd6eikOhO4TpptUrdeFmA5z77FGlwZdchHvnRnfTsRjNmKIlRFmf8ROIf0aSfm8zWz/P
	 TpO3vRLY4+kzWl1yI7FLKwN2Ds2N527IH77IecMfGeuGXvf1j4W11IR8so7ESd8EOyDN2
	 bsUw0/+8iKk/9cvw3svE9vNUGtlXBaxZ1Fr6OsQ9SvCJF8Kgob4pTV9ku+9a3V5T6BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=bepP2SIrLZrZLh3YoUhcI7r4qP8FXfE4vnBTwIQ4Skc=;
	b=KJD06XUtx0myrgoPoR1kMc2oamugnZ1glVv02llIv0euAqF7Kz0/GHp2DbEN4uVQL0DF
	 YShFOuoWVVyYuyyQ2AmQkD/LYqn8rszoBCU1bwrevYVGnUJJTrXyyh8LcGIO0bkUHyy9o
	 gBidXcet5Tj0LlJejfZcaBOVUQtCvo69VZnsJR9i6Egji3DgHxQk10mUsyqnB1yCAsazA
	 6fEwb8yqZEtU52DI48X7Up3P0/XsR0kJRPWR+CXlPwN7Qhk/HxREuvDmLee3YDVNfmsX3
	 oS1h3cz5Yr2AM5MCLn2479l/OW/47JRr4d0Nx+xUYNyeyQCs6I4C/9qB/PFyE98bzww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AyTB9L41;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08C606A6F4
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 19:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F08C606A6F4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AyTB9L41
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so13705785e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 11:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795204632; x=1795809432; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bepP2SIrLZrZLh3YoUhcI7r4qP8FXfE4vnBTwIQ4Skc=;
        b=AyTB9L411sWeTLrB7sHYPusz60A/1/Nv/TJkQTNNIeffYmh5yaV9kxmJlFcKpU5ORq
         rEcgDnLB0ZviSU3SHZQDeZx4auT1Tbi2Bx6Hvn4840ApcbI0hJQbC4obcQdmLQDZ94s9
         sF850yLI25iBMPAfhk1lw6XgZG1G0JRQpdJO+Qh5O+DZbsKYCRx8VmR2BjML2uYw7RjI
         Ss/ozztQvFAL44SPp/zOhqrZMlvYwp3/C02wmdtBcneEI9GClXWjC0Wfz/UDJLLRi2uW
         /LfLhc6X5fTJFRgIBDtEGVYEQbRINXzgzQ+S7eQafxUJW8Urdx8bLpc+0oHF3lur40xH
         KVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204632; x=1795809432;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bepP2SIrLZrZLh3YoUhcI7r4qP8FXfE4vnBTwIQ4Skc=;
        b=23c4cOx3HxZmC67rfDObadxWpB9BQckJT+TP5YvvpUgT+7iVNxAJg/as4qqm2E4OMP
         l2bHnA9ujg8Sxwp896pc0tSqAUcJ93/CLTdJRjcvb+R049HWIRUD+UkelveKfwrkgGoN
         ay/v7lCizb6Y8nK7lDO0/gaNzdyf3YcmLuX2elFKdvaYeeFj5HSYZwomdHhrVfaAyMNf
         /S6obQa9W1SBz+fFyLL4a1rMsiXtUCJpkaXkFqF/CJjby+IEwkXsqY52CvjLPKkm4WCH
         HISkw1sRwggYhw4Gfa4MpybPUhlZ0FBz+DoccxCj9ZVFNOcjFBbPBICch0peEveHvc9Y
         ZEkQ==
X-Forwarded-Encrypted: i=1; AL+hErFVnweXl/rcIoDHAh/IBblHzaLg2sOcyhTxi/8Yyr/2NkwRQphHlW7+/XOLaz3P0EX21kqKz4/O8W5tzqdo@vger.kernel.org
X-Gm-Message-State: APuU4Z9DUsqQXGLjEN//LhcqGx2Vs7PKgH1FT7+71OYjfdTNxhujD0g1
	kwX69J46UBFQkBH7tLUc3exU7QJOoJ76CWb/kGkic/zBAwsF1sk1ud71
X-Gm-Gg: AYBFou00s9gwmPbmuzATi/ZcKPwv/SRLzcB6SLJPo42D3z7CVdh9lHf36PVss1kUzsI
	oh5tZ8Rfbnmc7JtcUhKk/ji1XEHBtIpg5vc2ebwkJSOAL2isJuQ0mRU2E2MtZ+A+CSk+8uwG0Mq
	E9bsDdJ/6pnrnRcNScSFzOn1DPvUj81Ve+RWoz0r9A49K3LHDI5O+uBckE+ziRy+WXmZWxxhds+
	5kA0quSk6996usiT7prTQTz6n2QMKUmYmIOfcFkOvXMazA3UU5LhCkDwOSQGBP0c5VCZSY6kW5v
	/g3AlLe0nbuLyn6MbV0b+NvbNNJmPMhDGcc7bRDIPTPTkyIkQi2fTb/0emCaRQeWkHBP3c23Zo/
	HdKq7ahgDXdt4BldAl+0PZGVlmy4lBxqlDPLyU3FeSdbKKv98UMHJ08dS0rvclfzZxCsUeUMepH
	vphdls4M+ij46uDp57xj52qVBGiJUz/tqFioVKTmYzkfjuIZUMSRemq2jRyCLTnE5NeKQXcHzwV
	g0KzKMBVAQ6jx6WlJSsaNnAQbghHnQH6QmJjrznlz+d0fo4TX8hUK4DaVt49YDtrJQsgtvVEK3h
	aOtXhXVtGsKa6sz+X0yWwMwkfA==
X-Received: by 2002:a05:600c:638e:b0:4bb:6c5e:b006 with SMTP id 5b1f17b1804b1-4bb887e265fmr93789305e9.3.1795204631450;
        Fri, 20 Nov 2026 11:57:11 -0800 (PST)
Received: from localhost ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm177401215e9.0.2026.11.20.11.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:57:10 -0800 (PST)
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
 boundary=0ce1f2737ac23ac54221dfe9ad89c8615ea720b53f7a9f6f6b271bd43f0e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 20 Nov 2026 20:57:05 +0100
Message-Id: <DN0AXFYCMGXO.1O5VDUA6GJCT4@gmail.com>
Cc: "David Sterba" <dsterba@suse.com>, "Namjae Jeon"
 <linkinjeon@kernel.org>, "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>, "Jeff Layton"
 <jlayton@kernel.org>, "Konstantin Komarov"
 <almaz.alexandrovich@paragon-software.com>, "Paulo Alcantara"
 <pc@manguebit.org>, "Chris Mason" <mason@kernel.org>, "Yuezhang Mo"
 <yuezhang.mo@sony.com>, "Jan Kara" <jack@suse.cz>, "NeilBrown"
 <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo"
 <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>, "Ronnie Sahlberg"
 <ronniesahlberg@gmail.com>, "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>, "Sergey Senozhatsky"
 <senozhatsky@chromium.org>, "ChenXiaoSong" <chenxiaosong@chenxiaosong.com>,
 "Darrick J . Wong" <djwong@kernel.org>, "Sean Smith"
 <defendthedisabled@gmail.com>, "Andrey Albershteyn" <aalbersh@kernel.org>,
 "Pedro Falcato" <pfalcato@suse.de>, =?utf-8?q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, <linux-btrfs@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <exfat@lists.linux.dev>, <ntfs3@lists.linux.dev>,
 <linux-cifs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
 <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v4 03/10] ntfs3: make crtime user-settable using
 ptime
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261115180343.576773-1-koray.fra@gmail.com>
 <20261115180343.576773-4-koray.fra@gmail.com>
 <CAOQ4uxjdEiuJMQxtSL8XrPYHSamtfMh+BM8kS1wj_PVME4JynQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjdEiuJMQxtSL8XrPYHSamtfMh+BM8kS1wj_PVME4JynQ@mail.gmail.com>

--0ce1f2737ac23ac54221dfe9ad89c8615ea720b53f7a9f6f6b271bd43f0e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Nov 20, 2026 at 4:58 PM CET, Amir Goldstein wrote:
> On Sun, Nov 15, 2026 at 7:04=E2=80=AFPM koraynilay <koray.fra@gmail.com> =
wrote:
>>
>> Since NTFS supports user-settable file creation timestamps, map
>> provenance time (ptime) to NTFS file creation time (crtime) by using the
>> newly introduced ptime API (in commit "vfs: add provenance time
>> (ptime)").
>>
>> To do this, update ntfs_fileattr_[gs]et(), ntfs_getattr() and make it
>> persist to disk in ni_write_inode().
>>
>> The timestamp is now retrievable by using file_getattr() or statx(), and
>> is settable by using file_setattr() with the FS_XFLAG_PTIME flag.
>>
>> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
>> Signed-off-by: koraynilay <koray.fra@gmail.com>
>> ---
>>  fs/ntfs3/file.c    | 20 ++++++++++++++++++--
>>  fs/ntfs3/frecord.c |  8 +++++++-
>>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> Please don't change the unmaintained ntfs3 driver.
>
> If you want to include an ntfs patch work on the new fs/ntfs driver.

Huh, I thought ntfs3 was the modern and latest one by Paragon.
But apparently I missed some news[1][2] lol.
I'll use fs/ntfs for the mutable btime patch then.

Thanks,
koraynilay

[1]: https://www.phoronix.com/news/New-NTFS-Driver-Submitted-Linux
[2]: commit 1e9ea7e04472d4e5e12e58c881eaacfb3e49b669

> Thanks,
> Amir.



--0ce1f2737ac23ac54221dfe9ad89c8615ea720b53f7a9f6f6b271bd43f0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSgVimKafU5DQMcjcDmj22qf5IGXAUCawCmEQAKCRDmj22qf5IG
XMFuAP4jbqqWLf0rzRDeTfZI93Ntri5exvb2a4tXBADewtwEHQD+MLXXfUDqNxpu
FJSnl3dfZi2d0aWeniR+psgoM+VAKw0=
=6Hcz
-----END PGP SIGNATURE-----

--0ce1f2737ac23ac54221dfe9ad89c8615ea720b53f7a9f6f6b271bd43f0e--
