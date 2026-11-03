Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705108;
	b=k++8UCGtohIHQ2EvrNUNFT5Iat/tCOBNCpYkQ0C087OLL6qhT54u+xQ+zStNuhaLh0tC
	 tfqBf7FUsKvuYLoL2Euqc2JgaFVCuLWX4eKXuatraV9BMfDaO7PQYfY0k/kjnc/SXOEtC
	 BsWaEVNAgAal64lzOIdsCIusroCEaz7C4avxrBqy+mERK414f8J+XkrVzEM8/uc7sb95z
	 +S76HMcSYTlJIEiHYTf/V5+wJCw1oxr2wWPKHigYl8MaPI0y+l9B6kvEDNgSZEJ9RNK0r
	 tZoEKPyhTw702RnJUGxbrKUxn7nOYyu7qErhMFxnvp+gQ4DTraAQpdEq/mOqapq+6Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=8bSO1iAMGBoupdoV8PvbgD0X+fmxLosH8U23GEaK4zU=;
	b=jQn0YTOsho90h6+pw4ZwcZI188DF/T64C0+XVwPurYaG3ZqnfQ+kQP6xxnlNkhCDUybh
	 rWXBp6WZsmehwWcXQShlGCb9TtL+eNceFKxV1B6wIAs1tBHkmCZDG1lNIAezC1dp7YDX7
	 IFY880hfPn+ZEqV4z+saG9FMpaXP5kAS1jgkks70/fYhXzFfHVKvM6AC3B3L99GiGXE5v
	 qID0PyVXIbwdLX0xiQyKkaHROcK9hdILvWxNgW77p/iZHumEHimVOQxeiH1ITeJuPymEW
	 JiP63FNWZalX/+/j1+iMVrit585Dnj68hQ1IrbLZFN1+13hnkNaPLT7b7S6uyLjqAmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R8q97n1k;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2D9606A818
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 11:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C2D9606A818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R8q97n1k
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so34115135e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 03:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793705107; x=1794309907; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8bSO1iAMGBoupdoV8PvbgD0X+fmxLosH8U23GEaK4zU=;
        b=R8q97n1kh1aV4PKBIUuf1oPYOGuko+1kq7bhp8ZO63wFwGah4y4zR9W1eUkNKRcwX7
         2+gCOi3WE5qhZf/WgPYD/UA7TSuhCKOJzGlb9wmJ3eUPjARIrirex3++nr90++4tcn1u
         7b3E4H/hQU5WQDi95tBd+ySV03TRsQJ3NFjbjTyaQNMaU212ghJTOnQyCgLOZJ0dblqa
         4uMcK1pTGUxwf4od+bmoKXjzkvL1cKYZSlpGCRkovdi1bsK4VL2oB0LvNYSryDraDEYB
         jKDiCEJTFKwsoMJLPi150yIktWuoe0jLClfAFmEbzvXY/BsT66K6ATrLheptA/1Uupd8
         J2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705107; x=1794309907;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8bSO1iAMGBoupdoV8PvbgD0X+fmxLosH8U23GEaK4zU=;
        b=WZ0nxRJDX/fB8cMjc3LYA+A91jEJfw/baBL5GEN7CdDmbTGbkekTmkxaE/wrVDHYCG
         3ZdJL6LBUA6yv0PBvKllgnAp+KZ0BH1YXYW2pJSvZnbpDtCaVRCINs0OepFjYp2SmDuD
         Ipw1EdQksp0QBOFfkoHuyPMCDXMk3EvHaJNOsdMq9NAblWyggt5cI4gEDnzeuoVGUa9Q
         gcT+fLtQVSHSg8PLEV3Hjvwsc6dIWevcA2Tvy4uTH0JZZP6bPmwjld2/KHimqT+ZKf2k
         sSTf2wjwrLx9WOuHOcRDqE2MbtxwDly2MzdU9Bmaxl3lcfz6KMklas6hVifI+pxrHQko
         45Lw==
X-Forwarded-Encrypted: i=1; AKwUvBwq+5immYful/PiVoN0DPuDEgDoq7V6CPnRYdSumCjTIYjXAvJdgbQgZFFVf3lzWNdj35IuzT3xGReye7pJ@vger.kernel.org
X-Gm-Message-State: APuU4Z8GBiizR+TRcaXZzAn8g4badbqEQrc8RZGcChk5+HlMMYtDDKH5
	cPQ6KRo7dekgZZzTrTHtTr19QCjKYdZu6nymZmMxrQ6av924/DbmaLUi
X-Gm-Gg: AYBFou3YnZAzgx7xL8NGdPRkjbpvbTSkj33gLtN/ZRbvK9Z2mn5t19wdNVNKor624gX
	1qxfO29NBmB6zsJuXJvAcahI5NqM+psXV85AXZqhFNIR36NhzeYquY7fUNub/QkLANWPHovMM6u
	82FwlN6W+0qRqEbfgR+YrlcYclaxr+E5ETWJvL11J/+m/KOdj3jkE+2dIfQO7ydsDhXO5mXMLSs
	f/pkml7P3RgjEI3qxeREs0EcL0zgBxMxr5TYe8zKw3pLXQ6kc/ejJN6IqtsjTRvit80M/QZC0b7
	c6Hr0nvxFnWKJ5A1SRVkiCvtYeY8++Ftea5o+Hq8w+Djp5s0zWFyGxe8yEC38KUMPXO0BZarfqF
	Dx8AEfErDbY/2bjCGJVB/vou4+OBoxUrZtWwRmEL8wMeQCzTeCohPlWym67stsXXOOIsoYSlBY6
	aMPK3SeZksaNMErHxYs8q+bVcNiDFtgqGmotyMOQP8UMmgrZXOiVPVqU5nacu7RrKDm62N/XhIt
	66z/6huS7ldJ+PX324fabqLJukfEghduHKLOtRBI9puNL0CmJY0hyz24ZxsZiISDP5pEs1xU174
	67QQ4f4WbLWWsbhnxKDjT7Cu3xBbvVBjrp2a+aO1FN10HaBaiHw40KO+m3VmdYL6KzrPOA==
X-Received: by 2002:a05:600c:871a:b0:4a7:d9b1:b684 with SMTP id 5b1f17b1804b1-4ac14ec7947mr295648015e9.2.1793705106618;
        Tue, 03 Nov 2026 03:25:06 -0800 (PST)
Received: from localhost ([130.192.98.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a96fc87fsm47137555e9.12.2026.11.03.03.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:25:05 -0800 (PST)
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
 boundary=39af0fb162530eef4d1786772010c721ce09e1ab8025fd2ff3bbc4e23655;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 03 Nov 2026 12:24:59 +0100
Message-Id: <DMLJE2Z57AD9.1W22LSE7V9HH2@gmail.com>
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
In-Reply-To: <CAOQ4uxjkG=1j1z==Mv4wzkF042rXstodokKnBfMFBf2e-Eztmw@mail.gmail.com>

--39af0fb162530eef4d1786772010c721ce09e1ab8025fd2ff3bbc4e23655
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Nov 2, 2026 at 3:54 PM CET, Amir Goldstein wrote:
> On Sun, Nov 1, 2026 at 2:57=E2=80=AFAM koraynilay <koray.fra@gmail.com> w=
rote:
>>
>> This is an initial implementation of a new timestamp to indicate the
>> time when a file/directory was initially created.
>>
>> This patch series takes inspiration from the one by Sean Smith
>> <defendthedisabled@gmail.com> [1], but using
>> file_setattr()/file_getattr() as suggested by Darrick J. Wong
>> <djwong@kernel.org> in [2].
>>
>> The semantics of this new timestamp should be at least these:
>> - it should be the same as btime on a newly created file
>> - it's user-settable, so it can be preserved for backups, filesystem
>>   conversions, archives and any similar operation
>> - it should be preserved every time mtime gets preserved
>>
>> and the correspondence with the other timestamps is as follows:
>>
>> ctime <-> btime
>> mtime <-> ptime
>>
>> Examples:
>> 1) a .zsh_history file created in 2019, then after a few years the user
>>    decides to switch to another filesystem, copying the .zsh_history to
>>    the new home, in that case btime would have the timestamp of the copy
>>    and ptime would have the 2019 timestamp (just like mtime would have
>>    been preserved)
>> 2) a symlink created in 2020 from the home directory to a /path going
>>    through the same process as the .zsh_history, in this case it would
>>    also make sense to sync the ptime to the 2020 timestamp instead of
>>    keeping only the btime (so the inode creation time).
>>
>> The proof-of-concept code (for testing) for stat(1) and cp(1) is
>> available at https://github.com/koraynilay/coreutils (master branch)
>> (Note: these coreutils code changes are a prototype and won't be
>> submitted upstream as-is, but they work as expected in simple stat and
>> cp -a/--preserve=3Dptime tests)
>>
>> Lastly, the name "provenance" and "ptime" are not final, I personally
>> don't have a strong opinion on any name, but while testing with stat(1)
>> I noticed that "Provenance" is definitely too long for the normal
>> output, so another option which would fit well is "Origin time",
>> abbreviated as "ntime" (OrigiN time) and not as "otime", as that would
>> conflict with btrfs' internal naming and create confusion.
>
> FWIW, I agree that given the existing uses of btime and crtime in the
> kernel and various XXXprogs, using 'ptime' for kernel code is probably
> the lesser evil.

What do you think about the origiN time (ntime) (Origin: in stat)?
It would also coincidentally be alphabetically (ntime <-> mtime, n -> m)
the same as btime <-> ctime (b -> c) ahah.

> The question of how to display this in stat and tool is a different quest=
ion
> that can be left to the userspace developers.
>
> The UAPI headers uses Birth time language and stat displays:
>
> Access: 2026-11-02 15:22:27.067329367 +0100
> Modify: 2026-11-02 15:22:27.067329367 +0100
> Change: 2026-11-02 15:22:27.067329367 +0100
>  Birth: 2026-11-02 15:22:27.067329367 +0100
>
> If the UAPI headers will use consistent language:
>
> +       /* provenance (settable creation) time */
>
> +       __s64 fa_ptime_sec;     /* provenance (settable creation) time
> (seconds) */
>
> I  think that the man pages could be unambiguous:
>
> stat(1)
>        %w     time of file birth (immutable), human-readable; - if unknow=
n
>        %W    time of file birth (immutable), seconds since Epoch; 0 if un=
known
>        %p     time of file creation (mutable), human-readable; - if unkno=
wn
>        %P     time of file creation (mutable), seconds since Epoch; 0 if =
unknown
>
> statx(2)
>        stx_btime
>               The file's (immutable) creation timestamp.
>        stx_ptime
>               The file's (mutable) creation timestamp.
>
> And userspace tools could be displaying ptime as:
>
> Access: 2026-11-02 15:22:27.067329367 +0100
> Modify: 2026-11-02 15:22:27.067329367 +0100
> Change: 2026-11-02 15:22:27.067329367 +0100
> Create: 2026-11-02 15:22:27.067329367 +0100
>  Birth: 2026-11-02 15:22:27.067329367 +0100
>
> If they want to, without that being more confusing than Provenance.

That's fair, I don't like too much the fact that this would have a
different name vs the variable name (as all other timestamps do), but it
would be fine IMO.

>>
>> v2 changes:
>> - fix permission bypass leading to ptime update on immutable and
>>   append-only files (found by sashiko[3])
>> - normalize ptime timestamp as done in fs/attr.c:notify_change() (found
>>   by sashiko[3])
>> - fix wording in vfs patch to be like the cover-letter
>>
>> v3 changes:
>> - vfs: reject setting ptime with -EOPNOTSUPP on filesystems that do not
>>   support it instead of silently ignoring it (found by sashiko[4])
>
> Please see my review on patch 1/5 on exporting the supported mask
> to userspace.
>
>> - vfs: fix not being able to clear immutable and append-only on files
>>   with ptime, and allow updating immutable/append-only atomically along
>>   with ptime (found by sashiko[4])
>> - btrfs: validate on-disk ptime nanoseconds and reset to otime if
>>   invalid (found by sashiko[4])
>> - btrfs: avoid re-assigning ptime on unrelated chattr calls (found by
>>   sashiko[4])
>> - add ntfs3 and exfat support as suggested by Amir Goldstein[5], but no
>>   vfat, smb, or nfs4 yet as they are a bit more complex
>
> Please explain what makes them more complex.
> My concern is that I would like to see that the proposed API fits the exi=
sting
> fs and we won't need to change the API again later to support them.

By "more complex" I mean just that when grepping the code I noticed ntfs
and exfat were very straightforward to implement, while vfat had the
msdos/non-msdos handling and smb had a completely different structure,
so I thought it would be fine to have ntfs/exfat as proof-of-concepts at
first.

For v4 I can check and see how easy/difficult to implement ptime in smb
and nfs (and vfat) is if you prefer, or keep that for v5 and v4 for the
mask change.

Thanks,
koraynilay

> Thanks,
> Amir.

--39af0fb162530eef4d1786772010c721ce09e1ab8025fd2ff3bbc4e23655
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCaunEiwAKCRA0bnTtJTDo
OA2+AP9tE+FSr3eeWAWRuBVnKIDJtzRzw2cV9tUkiSUVhqG0LgD/U+rTyz1e7vUB
noQFwO6TgTl23M9IOu9TvoLKXA8jug0=
=e8Hn
-----END PGP SIGNATURE-----

--39af0fb162530eef4d1786772010c721ce09e1ab8025fd2ff3bbc4e23655--
