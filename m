Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726518;
	b=GlhhnRunCHUqJmEuwtdxpJ0IUbQ77Vam6UCzIeuJYOzeGJ2AIjOs7JcE6muXa/z1GA1g
	 eoRlZriFs0WwoRe1sR3VszjX9NZGFIOJhJtGunWdxJphBUKcSLfA8KfrozWIuSsISMZdD
	 qw1lncAtJ2nMkqsp2MN8ZEePqd0OA8FTJiWWJPKwiREdNhLI9oAOMGlDnhScqfw96etH6
	 oy043GOeicJszh8QgmYGpyBNgvCqNG8TLkIz2qQZd4CM+Dlsv+g1nw3+k0YvWqvVmfiA1
	 D0jwv2Q2/0G9S+lIaDepBdjYb5hoYrj9VY60R75J5wb1dVqQAWF9FgelvgJxpm5v0Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=AD4L42H0HNVoYlglqMFr39a2BJYBFr7pQM1pceNP/MA=;
	b=Uxtjb0Js/yZ7XDPrAHX+ZkU3oGO2EncZ73bWKPOMbvxz0i3xylEec1vH2j+1kDI41Qts
	 rbcZs/1yNHnpcI7BNO9Ze6NeNK5LtMaNjhPzo2L3fzNWgkLgICValtQuWXNQEBkhxa0cD
	 ON3VEZhB8fbjBylgDBMjwhpfVq+taf0D1i+qK3zseQb2ZBXSpUIV7o2WCffcmvU9j1uid
	 sArFfuwejqBWirTr0c2jKVQ4/sm5NlY4GUnNJykS+AY+RCyPGfJT16Z0XRX55Aa+88Wlv
	 9tK+vwJZ7uU1uTEhW9hzT9fRPWhptrmUhUNhfuyisSR2COhqO9QjL226qKacigoBvwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PPSaT/cx";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE9D606A329
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 17:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE9D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PPSaT/cx
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a208d93758so47292565e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 09:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793726516; x=1794331316; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AD4L42H0HNVoYlglqMFr39a2BJYBFr7pQM1pceNP/MA=;
        b=PPSaT/cxmZ6hURUQKCutb+9MNl3fhi5qn8d5wFV015ZFNP0p7wP/UMc9QWwSCjKlPZ
         zL/DD7gvjUVS1WwDG0vy7qUtdL4e9ZBG8lQnrDRgkfIUIZlbzvv/trLSefcWiQBKSr6u
         RWiOf73SY7QM6RfyYuZu6k4tR5WiWRRKh/RIeV0cY5iHRsNLK+hTXF4APDRoBkCtO0ct
         XYVAwfYwEMmz7BR45aY/9jxlYMj2cVxDIW7S6WMomC8Q4pSudP/vALucJz1DmpNouKJK
         rA6xG/hBuUMhhOF7kKRJNPw+Wh4MOGJIc9m2NaRK8UCv+/ZvMWsAaIltcn9U+q8NCPVX
         b5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793726516; x=1794331316;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AD4L42H0HNVoYlglqMFr39a2BJYBFr7pQM1pceNP/MA=;
        b=nxEFhlUlO8sf8Kwnykwl9pBpw9+G2JJkLHFDfMphn8IUgVF2bHt6ZZDu8pOGnw7V/h
         Aqh01iDSpzVSlfxmEJimUlnc0giMtNHXXRFlOASl8MxS+F7pUNSp5eFd/2c/gtnMlliw
         tBhepB50bFpYP8hkxfj13wUJSH9d7P6aRyPjJLbnTF0hFJdJ5aKHwh9Y1eXIwDK/Pzfp
         OyZSFUUHhNlRaj/utjE8h37b7TwsR2+wr1EAwLT6XbD3pdeM1Gj+VAKO+t1sgkuxX62y
         H04zGWhKmK2Hl1iTuwNCOL901/amTMshN1UpVdNoevJJluro2yoKc6tmPdTZ45teoz9G
         wnlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAd6wvSlx+fFEF2ZtpeAL01l5Edz94BLl+oKQSkkD2mR/0teTFH4weUeNExIMUW8wQSGkDCRq4uBAcR1hm@vger.kernel.org
X-Gm-Message-State: APuU4Z/ycqd9zWpPjJev3QEeXCAusOqNTcqa9Za+oYD441SoYvDilakz
	rz6NBDBxPSNBhVIXEBzrwgEO3aLwUC0Y1enczhGkZF32AAwW5iKRxf4h
X-Gm-Gg: AYBFou1S8ADOflF/hIoVpQkIhgn16vGoR65YlJZ9ae4EHfnGg+0jQyLFg/3A7ifmw5A
	PNygoFqtScbbLorIPKZobhggOuIZj2e3TKRZ6yem0XMDGtb/vPkC3qqSS2h5QHnWQHMzJtHkCnt
	GKF43VNLK3M8KfUhSWBW8e7eVbBcOYcDehggE9k6FJHLW0XeWVz5pFCS1oGi5Wfflx167mkX3MW
	wPXmSHicEi8ibMft4jvd9ghN77By/93wj13L0bANfVIgJl/p6vPMhzyRmV+tf+R+81QmXfJj8WK
	E5+iGSipbXk/5z8O9rtX9KFa8TmZc7j29PXo7lwHYolqYJE959fkXXgtArjuJ0nfGsKbYEpMq5U
	m1YSS9JasymJ6sI2oRuvPu/8+To6elCMW8j9U7ODqoQ/0CYQjz7GZAo9WogQGm9L1eceMHG1fDv
	7tW9eOgvracvrF00jx71vQ6qUg67DBisBGa9j5yk56etUzR1QVJjBURDJtTMBLcx2sW9B7IpO1M
	PTY+D+QON6T9l2jTtYpoFaBFaRO1bn4ytLW9IO5hKyvLVLP09NTwx8mEKAIFqnpwv0H53z69NYD
	5nrseih+u0/oJBSC8/24bzVs
X-Received: by 2002:a05:600c:3b0e:b0:4a7:7d22:c50c with SMTP id 5b1f17b1804b1-4ac150b2243mr345177055e9.2.1793726515970;
        Tue, 03 Nov 2026 09:21:55 -0800 (PST)
Received: from localhost ([151.60.201.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0a66caefsm287061365e9.5.2026.11.03.09.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:21:55 -0800 (PST)
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
 boundary=1ae0fec9eeabe43856471b243f1ece3413edf7686407593b3575066613d8;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 03 Nov 2026 18:21:53 +0100
Message-Id: <DMLQZCDREHI8.1PLK04U05AP4S@gmail.com>
Cc: "David Sterba" <dsterba@suse.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Sungjong Seo"
 <sj1557.seo@samsung.com>, "Konstantin Komarov"
 <almaz.alexandrovich@paragon-software.com>, "Chris Mason"
 <mason@kernel.org>, "Jan Kara" <jack@suse.cz>, "Yuezhang Mo"
 <yuezhang.mo@sony.com>, "Chuck Lever" <cel@kernel.org>, "Darrick J . Wong"
 <djwong@kernel.org>, "Sean Smith" <defendthedisabled@gmail.com>, "Andrey
 Albershteyn" <aalbersh@kernel.org>, "Pedro Falcato" <pfalcato@suse.de>,
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 <linux-btrfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <exfat@lists.linux.dev>,
 <ntfs3@lists.linux.dev>, <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v3 0/5] add provenance time (ptime)
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261101015551.786044-1-koray.fra@gmail.com>
 <CAOQ4uxjkG=1j1z==Mv4wzkF042rXstodokKnBfMFBf2e-Eztmw@mail.gmail.com>
 <DMLJE2Z57AD9.1W22LSE7V9HH2@gmail.com>
 <CAOQ4uxiMLDgMXuij99-43UfCqfZN2a=CTet560o_RzU2m_Y4SA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiMLDgMXuij99-43UfCqfZN2a=CTet560o_RzU2m_Y4SA@mail.gmail.com>

--1ae0fec9eeabe43856471b243f1ece3413edf7686407593b3575066613d8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Nov 3, 2026 at 4:12 PM CET, Amir Goldstein wrote:
> On Tue, Nov 3, 2026 at 12:25=E2=80=AFPM koraynilay <koray.fra@gmail.com> =
wrote:
>>
>> On Mon Nov 2, 2026 at 3:54 PM CET, Amir Goldstein wrote:
>> > On Sun, Nov 1, 2026 at 2:57=E2=80=AFAM koraynilay <koray.fra@gmail.com=
> wrote:
>> >>
>> >> This is an initial implementation of a new timestamp to indicate the
>> >> time when a file/directory was initially created.
>> >>
>> >> This patch series takes inspiration from the one by Sean Smith
>> >> <defendthedisabled@gmail.com> [1], but using
>> >> file_setattr()/file_getattr() as suggested by Darrick J. Wong
>> >> <djwong@kernel.org> in [2].
>> >>
>> >> The semantics of this new timestamp should be at least these:
>> >> - it should be the same as btime on a newly created file
>> >> - it's user-settable, so it can be preserved for backups, filesystem
>> >>   conversions, archives and any similar operation
>> >> - it should be preserved every time mtime gets preserved
>> >>
>> >> and the correspondence with the other timestamps is as follows:
>> >>
>> >> ctime <-> btime
>> >> mtime <-> ptime
>> >>
>> >> Examples:
>> >> 1) a .zsh_history file created in 2019, then after a few years the us=
er
>> >>    decides to switch to another filesystem, copying the .zsh_history =
to
>> >>    the new home, in that case btime would have the timestamp of the c=
opy
>> >>    and ptime would have the 2019 timestamp (just like mtime would hav=
e
>> >>    been preserved)
>> >> 2) a symlink created in 2020 from the home directory to a /path going
>> >>    through the same process as the .zsh_history, in this case it woul=
d
>> >>    also make sense to sync the ptime to the 2020 timestamp instead of
>> >>    keeping only the btime (so the inode creation time).
>> >>
>> >> The proof-of-concept code (for testing) for stat(1) and cp(1) is
>> >> available at https://github.com/koraynilay/coreutils (master branch)
>> >> (Note: these coreutils code changes are a prototype and won't be
>> >> submitted upstream as-is, but they work as expected in simple stat an=
d
>> >> cp -a/--preserve=3Dptime tests)
>> >>
>> >> Lastly, the name "provenance" and "ptime" are not final, I personally
>> >> don't have a strong opinion on any name, but while testing with stat(=
1)
>> >> I noticed that "Provenance" is definitely too long for the normal
>> >> output, so another option which would fit well is "Origin time",
>> >> abbreviated as "ntime" (OrigiN time) and not as "otime", as that woul=
d
>> >> conflict with btrfs' internal naming and create confusion.
>> >
>> > FWIW, I agree that given the existing uses of btime and crtime in the
>> > kernel and various XXXprogs, using 'ptime' for kernel code is probably
>> > the lesser evil.
>>
>> What do you think about the origiN time (ntime) (Origin: in stat)?
>> It would also coincidentally be alphabetically (ntime <-> mtime, n -> m)
>> the same as btime <-> ctime (b -> c) ahah.
>>
>
> Honestly I don't know.
> My new idea is don't publish it in statx() at all.

Well I was more talking about the actual variable names in all patches
ahah.

Thanks,
koraynilay

> Thanks,
> Amir.



--1ae0fec9eeabe43856471b243f1ece3413edf7686407593b3575066613d8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCauoYMQAKCRA0bnTtJTDo
OI2UAQDfLMxbWJxZCtj5g/a2TQHWFv3yLHmv7IEjclN8pYY5IgD/VFtdYZ3g+FW5
oxEEhXF7xBfTTV5O+6Ag8QIL/lM51wc=
=XiPH
-----END PGP SIGNATURE-----

--1ae0fec9eeabe43856471b243f1ece3413edf7686407593b3575066613d8--
