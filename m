Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805478;
	b=ei9KDuyl/veQMEGq72D1KRlgjI0iUnQjzvsUYTSWen4l3/zcA9HKMc0mbpr5tbYRYWQ6
	 pIpKyjnnK/+/CCsEZbeP/s6DziCJDTOvmntChOLSfz+FaQFwetRUKqiN8P01auNKMHOOM
	 2UStAmamj0w7d9sr13vRHgVdbVnHJCCWDWJUfA3lXONL0OI3izLcvV9gY9bTon2nzhNQP
	 YzuOJiUyYjeA/VX28gMLugzL9kbVAqmFnKqe9OuNmke87SVxLsvMGbTKBtMRF800b8dbe
	 stoKVxgSb3waEBt8Q34clVWjFSJmcNpfJkXSwqtamRyt2vnOw9VVb6uNQSsUwZuI7Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=JmL8LoMVs76VvbagqtHAZXdxFbOYrgh5zmv9OUe36GM=;
	b=Sf0Nza8amSY/o6TBPxmFR2D8S61yLAy8E6tFP/b+v6x3kdy3NkIJCYsZcsnCJHUTAsg9
	 YvvFOJNhOI71GxMsemRaLo6PgYn6evh2+9/HuzgdfwdlmfJ0HiLECWi93omVWnohBN6vP
	 xerYD7lGTCHyTwiUqset1HL7gA+b0jY4i+2IVGSkKwW5Lg+S95DKHM1iwotSA2v+lN0fA
	 IHeoOeTy64qkupTa50JcayQEAI6I64NRzn4EA5zzpqHrJTtljJ6lWrIjEqHrR48mE9OJc
	 yrJXO89qo3XAJsVInD49AiAkWXefsv2MwVG7Cakp+oTtf7pNyh4VFHRMLq+MX6ljJUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m3pNdptj;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252B606A326
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 18:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E252B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m3pNdptj
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so4995023f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 10:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795805476; x=1796410276; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JmL8LoMVs76VvbagqtHAZXdxFbOYrgh5zmv9OUe36GM=;
        b=m3pNdptjqW81pY9NLNr665+hJMXwfSRIqlg9cV1mmo9g7662QC2nuYP6a74k3dZ3Iv
         zvWxD2plIKeVWrLGkl0fu/pCXc3Vzo5AvT6VFc4h9ivwKjhKyhk7gIjLCx9npZwJUmyQ
         Nk4TvX4IzB2micR2Tn6o+UKGujjmbSTrorSwb1pZ/GkQGqOji8LqBS5bCMicKVrMKepu
         ioYd1kId/PYWHMgCja4C2aGhqgHUyOK5G1CCmNbKgHfRfy+Yjo4yFy+orjpyYzTB+iHt
         M9/R5HRHUsAyOqHMXuprEzV4ETE8D3x09EMM2j33PoYMAXrIBvD7VzX01Z6gcTlyJABk
         Dmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795805476; x=1796410276;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JmL8LoMVs76VvbagqtHAZXdxFbOYrgh5zmv9OUe36GM=;
        b=FOJsAWdFf8aon2B1alw/Pkrs6puuMiB15qY6dhb4PvfRu0SpHV67BZr0Tz/uf8FKqe
         jkP4mdDJuQ+7z8mSQHAxfg/edpKXXcISgRVbZDRSp0HzYJp2NwpO95JTITgKc/mhMDQK
         2m8/n/lG5SR+Jv1/U5Q7443vbfBIVQEnXcv1l2UVo0Lah1IhIsqHiEC6agaDTCyBNEbu
         gZ0ZWD3/IhmOODC/CCK8Gwh5WNnIbYVL7NLCv/cd6eSDsnXAMlAyUXjXGlKPYP/j5HHO
         Vyyirj0NfI+PEmi/NAPRcdzg53P4tMrIXpV0dBkNfyXOX9m0grng5wtatvoCQ9U1JAbx
         MaHQ==
X-Forwarded-Encrypted: i=1; AL+hErE+pP4RLHbSGrJ2xJ9zwoK28yHWa0RvDVKfNkBHINUwhmiHiY8295lauNB6wU5hRSGH0ruRp1YgU9o4QAQO@vger.kernel.org
X-Gm-Message-State: APuU4Z82HstqOx8u1ZF8XaygUQNmhjk3CnYnMPE4YRU8OV40KjUPRWcE
	0WvF3unAuX64IalpKuvKrOXfbKL3S84Z6bqciQUqjgpV0lw60P15ozU7
X-Gm-Gg: AZFdTZdNZvB6Uy7JNJFsQcra0D/GY9ReGMFEjXjiapUr7ROyH2p0ICemapVQ7Wiu4ZZ
	hH2u/ZzMK2iuDGBTIId5lM4BrWZhfcCttwFEpsNbmp3heiQVOV9sf5waGwxJ3zMArJR/babigIu
	vab5tOOa11ZMpAP5+0+3fAbsJaWqy94hR2aFq2+VIdg3NZx736gBGaFe3pgHNLTd2Af8AoWuCB1
	x517mWZ0kRuPshB2z1K2w7+QySaRpTZkTlvTr6Y1qkAFA/xMYDeSKq4A11MbjDJfk8jRXMB9xK0
	A7YtNNnnI4Wu9yMyPglewsmfzIly/nwrmzH87gmdafUG/WtD4IIUSYE6SU83pTW3ujw94JIeM/W
	pOihuJaSSWkBR63h2dzIB3/DLNzDBh582HCTwpB/KxTCmW64rT0xLcV7I389lUIAct3HAntnVxb
	rcmxpBpfYpWk03b7RAkY9tcST90OQcAPHoPrZzAUmOCQ7NWtLDc0a0Q1Lto6Y1hyI5YvTlpD2pa
	nhmcgDSqAX07/PnI6cbsVsHUjwH/NP/9Jf1cBlsjl+O01F7hULpMW90B6rzBr6N4xMeWGI+dl5o
	sQVQZTrOJgVBUCd2ZBwH/EzTLA==
X-Received: by 2002:a05:6000:4812:b0:48d:b650:69aa with SMTP id ffacd0b85a97d-4abb55185e4mr49465105f8f.50.1795805475952;
        Fri, 27 Nov 2026 10:51:15 -0800 (PST)
Received: from localhost ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4bef07f9e0dsm4921752f8f.53.2026.11.27.10.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 10:51:15 -0800 (PST)
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
 boundary=3d0117b6230d8b8a6a185cfbfe10dda73718c7f46272653fffdbe69dff91;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 27 Nov 2026 19:51:13 +0100
Message-Id: <DN67WTNVL19F.1D5GOBP57BP1L@gmail.com>
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
Subject: Re: [PATCH v2 3/4] vfs: add xflags mask to fileattr API
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261126163114.403846-1-koray.fra@gmail.com>
 <20261126163114.403846-4-koray.fra@gmail.com>
 <CAOQ4uxhA+93bo5WseLxe7cAvJHJ8eQodoQHLwh=iToyEVkeXEA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhA+93bo5WseLxe7cAvJHJ8eQodoQHLwh=iToyEVkeXEA@mail.gmail.com>

--3d0117b6230d8b8a6a185cfbfe10dda73718c7f46272653fffdbe69dff91
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Nov 27, 2026 at 6:48 PM CET, Amir Goldstein wrote:
> On Thu, Nov 26, 2026 at 5:31=E2=80=AFPM koraynilay <koray.fra@gmail.com> =
wrote:
>>
>> Add fa_xflags_rw_mask and fa_xflags_ro_mask to struct file_attr, both
>> __u64 to match fa_xflags' size, and bump FILE_ATTR_SIZE_LATEST to
>> FILE_ATTR_SIZE_VER1, which is now 40 bytes.
>>
...
>
>>  #endif /* _UAPI_LINUX_FCNTL_H */
>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>> index a13c7b32a1bd..63d88ebe3420 100644
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -238,10 +238,13 @@ struct file_attr {
>>         __u32 fa_nextents;      /* nextents field value (get)   */
>>         __u32 fa_projid;        /* project identifier (get/set) */
>>         __u32 fa_cowextsize;    /* CoW extsize field value (get/set) */
>> +       __u64 fa_xflags_rw_mask;/* supported writeable xflags (get) / fl=
ags to set (set) */
>> +       __u64 fa_xflags_ro_mask;/* supported read-only xflags (get) */
>>  };
>>
>>  #define FILE_ATTR_SIZE_VER0 24
>> -#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
>> +#define FILE_ATTR_SIZE_VER1 40
>> +#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER1
>>
>
> Man... we really need a bot to review all UAPI changes
> Please someone tell the bot to check
> NO LATEST/LAST/ALL constants in UAPI headers!!!

Forgot to add: maybe Sashiko can do it if asked nicely :D

> Your patch does not introduce this constant in UAPI but if we change
> it we risk spreading different versions in installed headers.
>
> Honestly I see no reason for FILE_ATTR_SIZE_VER* to be in UAPI
> either. For other UAPIs those constants are not in the UAPI header:
>
> ~/src/linux$ git grep SIZE_LATEST include/linux/
> include/linux/fcntl.h:#define OPEN_HOW_SIZE_LATEST      OPEN_HOW_SIZE_VER=
0
> include/linux/seccomp.h:#define SECCOMP_NOTIFY_ADDFD_SIZE_LATEST
> SECCOMP_NOTIFY_ADDFD_SIZE_VER0
> include/linux/xattr.h:#define XATTR_ARGS_SIZE_LATEST    XATTR_ARGS_SIZE_V=
ER0
>
> So please move those contacts before adding/changing them
> (can be in the same patch IMO).
>
> This is a high level review.
> I did not look at the details of the conversions and validations
> Will do that for v3.
>
> Thanks,
> Amir.



--3d0117b6230d8b8a6a185cfbfe10dda73718c7f46272653fffdbe69dff91
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSgVimKafU5DQMcjcDmj22qf5IGXAUCawnRIQAKCRDmj22qf5IG
XJUmAP9OYQdkwBS0FIjyqP9a3I8gdrfFrp/bZms8ThGuY3SovAEA9zGXlhLiGxhC
iuYnX95tMjFyQ2w7/Y0yIwxjSTRZ7gg=
=DR0g
-----END PGP SIGNATURE-----

--3d0117b6230d8b8a6a185cfbfe10dda73718c7f46272653fffdbe69dff91--
