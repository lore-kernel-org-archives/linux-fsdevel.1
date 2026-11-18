Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795024254;
	b=UFQI0f7GqsWoBIwPrmfUwB2p6NjZFeaXYJoJ1UmfEPxyjQIvv5ig9lzakKTkka0un3Yf
	 jKl2170aElDz2PKXMVQu9W2EXgtVY0tjZ7T/n+hM6y6tk6kB94joC2pLvJw3RewppLD6Y
	 Hq8NAOn2osLaAV/WEEMWhBTOcZqjbXmT8LHF6JH5zhfYCAZeBteIVNimfOquusmNDdRec
	 xa8+vOjTyG74cnbVm9AITHvSQAb428uyDwZTgaBHCxtpynQmSLeVwiRXsCfc7Sf2rMaHH
	 7Tq9DVk6a+BsAJ8UCEP2M9aI6FefjZd6F5RCDA3GqsnEDtAv5DklpJnAtkJkioFd/sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BliQBsLi8Tf+bGa80m+pxZeHcLThIeJfSszhbNvQWjc=;
	b=hxEp+iL0ldA/9FkBsp3eUANHq9M3S7lxbLutQholB3oTXNuJpxNCO0Jat4XdSft6BkI6
	 pdcfW+A0KNGxIB6Fvl8zHK1/Jn17jzrKFUdGuDle1nlh7lFS8vFMxhJcljLrWTopSQD9f
	 N2By6q1IJqBQn4lS/R7PrwtM2CjaobItbZAgcmwhbD6RLpzYTkLWmBjXhsrC6lEe6HXgN
	 nJtuL0iMVwTulquiaHx/Sy6OoEeV8TugSy4pBvzsQ3LisH/hilBzxYySc2PdWZvpe0iy3
	 aXFfdj2GYLstPCGkZf21ZzeElYD0muL07Kn0+hKDLK/kcjLtj6PW7QX+Q2nFara15Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0urFzns;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88260A260A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 17:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD88260A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0urFzns
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b8786bb305so1993414a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 09:50:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795024252; cv=none;
        d=google.com; s=arc-20260327;
        b=jJrkwn6GeIvXcW+o9ZWZiSTlpBb6jITB9dFh8v7Hdt+xlohO6p0JydBMI7ys7StK5c
         jQR7lBO9lafXH9oeRP+MeWyOb/kJmn64K9vMZUZVsf7xXpYsoN++fGlLWOO/+QETowpE
         CnvtH1GFCPhIoctt1R42/2I7kqX3sYAOTvdA5VugtnDnY4ysLUe8sB/bglk837rSRnTf
         RSCIR6qQmpo9lQnMoaS0mxTP9zV5Z/5wJclxhsWvg1rLi+cz1C7bXSYnJy8YZTH+sBk8
         Zs/HlC0pUUsdvIlCH6NCe3xbw4r7P+4fH3vHmtGmryZov8mX8eeQuZXG4zGQIF+A8g85
         CEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BliQBsLi8Tf+bGa80m+pxZeHcLThIeJfSszhbNvQWjc=;
        fh=rtWeH5wTrD+yNw1XNdjGus4llV5N87yP6t/z0FPz9/g=;
        b=K1d2McXahIUTtXESBqNhsripHCqvzMYo9ZH4RCJeoJTdq/XG48kkq4KKS7SOrW/3+z
         k/fCZZqultj9ZwZXpI98+1VRhxn5Q5Y58W08ebiQAJV09kHWWFOuy44+v/O8rRdPs03l
         8QTHNIhQA8T8AfoshHndZX56cZFacWK69amYSuXZZXSaNRO535Ja6uNLzfaX2nYEOYY2
         l4eLUt0S0WUIaPih9mSmqRwJxQVoKvK5s4VeA9arUorzh4na3EvK2jFKckiAqpeElasi
         KmZYOY3lQ+TV6SOqxBu6+oLq/xQE7HBHu+p3NznySXgvUwby4BGzWYFlvHGNc3uxEvzk
         mjyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795024252; x=1795629052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BliQBsLi8Tf+bGa80m+pxZeHcLThIeJfSszhbNvQWjc=;
        b=t0urFznsvrKRqixemRUZFc9mgXym3XN1YMBmj0waBLyV3CsdgnHy8xmpMpLBOjvFSO
         4OyVbjrHe3QbmjmaFHziwXJZHZ3OpkdyrRZKOYWCdCJexvqSmUuVu4fnaP7X0VKW/H2Q
         uU2+obaBKEAHGKd8XWt2iDtAO+W46sMhQn7B0F4IN3mylmD+1QrZ9esi0QvoH9kZT9bX
         EBKM7Z1u6o+AxA5zR70zZUIovWhwqLZJa6oEexWqxHL96XtNRn01UmHNOonMpcB3gc6f
         RbyVXVt9WSJBogGVLF5lTsidaWxQ5lTI8ZoKmu6C/MRJ9rExNu7Xb6AIdnGzmI6derxu
         Duww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795024252; x=1795629052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BliQBsLi8Tf+bGa80m+pxZeHcLThIeJfSszhbNvQWjc=;
        b=1u1m5cMg/GjiH0HXE+Y2nvm8mhnXpud8LxxtOy8qefpYnMZbOowLVOF5TUkJHUZc80
         IM5rVMEEXjYucZgRN69+mvA1QyXy/vJ6MW9+2E+P2oZiNkCPg2XMq9eAyi/bIznpxVcb
         gPXjIPywgDJbn5ZdK879wQev2STpP9ir2SJ3sD8fexmrNBSKqNPc+eZb+wagGaG8K0F4
         s5CzNOtqTjAIaoa7mXxmgiouieVaZflJ2hUMG5aGQjTel60bs4nK26i3es1YJmv1g5r/
         0/DZWcg5vAL+OLGPa49lJAY0XIXcSF3iUrSfK+i9X4x3iNhs5QjLQam9nrNm+b9kiWFq
         UUaw==
X-Forwarded-Encrypted: i=1; AL+hErFW6x6JsgQUE0wEqoFzlQuCL0yMXEUb9Mljqo23ywOYsHLmq3pWSoMzZpvViXvvyXRZAmfWIcEY1rBfnAeE@vger.kernel.org
X-Gm-Message-State: APuU4Z81MeR6oe3cmxWPZpGPrRIOdpd4qjFsAwrPkXtJ/1DfT4HkdURF
	96FUSaqo3yGhGbTRvyGZSvRq/MBKSNpfYBFZ1h4nlREwu3XuzqUvsQBGQLu+7at4TDSdNSvyF5C
	BCx/rN/AKOK3Awi1Dc/sah28p9EkdyuA=
X-Gm-Gg: AYBFou19P6MXrPcrVmNJbavBaKKaKcQtyI1fnGPMIdbCzKFr0h8WiMbbTqNZGFVQzHp
	LjUx0fPsjCFL0xyUH8XZQ5LSmRAmg8IxmFOEs8GRL2IaBY4M6/tN9piNNN4qJyRaSNvE9Ia8MXm
	iIMKEY1ld97wVd5JnyynwduqOuaG62mq1J4/BopW0qDcCyGMXA+dvUBMIdOGLPRlM7+N5G2FPSy
	NduXNmF4lgLYN4uPYUPt8EoXhYlc9uq93eI4qoezjydPohDTqJR6llzWho2qMCoxiriYTHm8l3+
	a2N3SayRHBM/q8G0K3tRwPfsEBLrnKgAdywCdnyooNksmzTy+DwnxGjNBojT7p3yjskg/qQFDNq
	3nhPgsDmfBnaJcEAzy7w8dY+X4dIoPwuLtPORbvg4V+3svCjFBahDV/25MnvnPiDFUpwKogW2Wv
	ofeB7tmmehYr0+WBQ=
X-Received: by 2002:a05:6402:5411:b0:6b7:df0c:18d0 with SMTP id
 4fb4d7f45d1cf-6b8a2e6d881mr1966295a12.11.1795024252167; Wed, 18 Nov 2026
 09:50:52 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115180343.576773-1-koray.fra@gmail.com> <20261118142613.be3r3s6kobkkxnz4@pali>
 <DMYFBDIV4Y08.35ZKR5G86U1H7@gmail.com> <20261118151605.lqtn5fz423kuswk5@pali>
 <DMYHPLWKPSH3.MUM1IIZZIWNR@gmail.com> <CAOQ4uxiwpdC-fKkqS5kiZ515q9MenC0jX4USV1idN7h2njx45Q@mail.gmail.com>
 <7126bdd0ff59e9ea9bc58702af2ecb38096330e8.camel@kernel.org>
In-Reply-To: <7126bdd0ff59e9ea9bc58702af2ecb38096330e8.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Nov 2026 18:50:40 +0100
X-Gm-Features: AclHuK8-cETfcc5mQcfuFgReFzNL3uUqtJJFv8XHOum7KdV27M9jJ90gtN64MvU
Message-ID: <CAOQ4uxidYWNVmoPgxKrxesXTxpMB-JqUZx9p6xXZWD5m+hJ+JA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/10] add provenance time (ptime)
To: Jeff Layton <jlayton@kernel.org>
Cc: koraynilay <koray.fra@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	David Sterba <dsterba@suse.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Paulo Alcantara <pc@manguebit.org>, Chris Mason <mason@kernel.org>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Sean Smith <defendthedisabled@gmail.com>, Andrey Albershteyn <aalbersh@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	exfat@lists.linux.dev, ntfs3@lists.linux.dev, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 6:36=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2026-11-18 at 18:28 +0100, Amir Goldstein wrote:
...
> > Guys,
> >
> > Let's take a step back.
> >
> > If this discussion is proving anything is that the btime/ptime
> > duality is a big headache and it's going to be a source of confusion to=
 users
> > even if we come up with some smart pants consistent semantics.
> >
> > As Jeff writes, I think we should consider making btime mutable
> > be a per-fs choice and not an API limitation.
> >
> > A filesystem can even decide to store both the forensics btime
> > alongside the user settable crtime.
> >
> > There are some precedents in xfs with settable UUID which is
> > a different field then the origin UUID from mkfs.
> >
> > Fs that have immutable btime have a few choices:
> > 1. Keep it immutable
> > 2. Start making it muttbale (like the Win fs)
> > 3. Start making the user visible btime (STATX_BTIME) mutable
> >     but keep the forensics btime on-disk for, well, forensics
> >
> > If btime becomes settable via options 2 or 3, this could require
> > admin opt-in (e.g. tune2fs -O crtime).
> >
> > With option 3 the crtime feature would be ROCOMPAT
> > With option 2, it could probably be COMPAT. Maybe.
> >
> > If we accept this story and the major fs maintainers are
> > in agreement with this plan, then I think the missing piece
> > is making the "settable mask" visible to users via the new API.
> >
> > IOW, we need to somehow export FS_XFLAG_RDONLY_MASK
> > to userspace instead of only exporting the supported mask.
> > And then with the addition of xflags_mask, we could also
> > -EINVAL on users trying to set readonly flags/values.
> >
> > Perhaps a single xflags_settable_mask is enough.
> >
> > For file_setattr(), xflags_mask is anyway a set-those mask.
> > For file_getattr(), does it matter if we get an answer
> > Filesystem does not support casefold on this file
> > OR
> > Filesystem does not have casefold on this file and
> > you cannot set casefold on this file
> >
> > It's kind of the same, isn't it?
> >
> > What do you say?
> >
> > Shall we drop PTIME in favor of "is BTIME settable?" API?
> > Leaving STATX_BTIME exactly as is.
> >
> >
>
> +1
>
> I think this is the better approach.
>
> Looking over some of the earlier discussions around this since 2010
> (!?!): I think some of the XFS devs objected to making it settable for
> forensic reasons. So, on XFS you might need to rev the on-disk format
> if you want to do it there to preserve the "historical" btime, and
> maybe some xfs userland work to make it accessible for forensics.

XFS_IOC_FSBULKSTAT will likely continue to publish the original bs_btime.
if a mutable field is added it could be published as bs_crtime.

For forensics this should be enough.

>
> For the record, the statx manpage documents the btime field very
> sparsely:
>
>        stx_btime
>               The file's creation timestamp.
>
> There is no documented guarantee that this will be immutable, AFAICT.

Yes, and it really isn't immutable for cifs already.
It's just that we don't have a standard API to change it.

Thanks,
Amir.
