Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794828676;
	b=G40DAdkx3xTkNUfa1A09DOlJ+tjMrp7mCOzOneYDNXgc4AmWLL/nMIrYihQvUj/8FDLe
	 yGuyUYrcaQB6856eNVbd4cqLB+xj0214Dm1O4hexDtV0QxDMTe+TM59jAGBOUV8FuwxNt
	 gfh0hloi4bta6crDyACoLYOPfc+3hVQiI99Q7PB6zfdolKNh6hfkkYrCKUEC1IipO3i9w
	 0vsihGb9toN4Jnsh7ccBI0EkiF9YZo1NejUGC078Lg6qe9AWH7r4CnWvfZhoIP44BD0Vx
	 hbt48EQw8GvIMq1hlEth5eaSBGoIT9Pn4HaaiOBUNA17vrWNjVZEShZRZG8zTEQmpyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wtSeKpS27rBmoNgRnmtk6Fl68DcVUzwroJjv5Gt9KJo=;
	b=KSCNofGOEtCihGFMOxVkVTemUTeIi9PwgYVMru+w0LyxgTGV5oUn9wEdWI1et7UPJUen
	 Sa5JoLw1nGaIcWLTzc712FmfHUoR97d1fnPFEXlztBoUKtIUOAhCBCgxmgHPSbuILThWk
	 E3mfIllBv3Ae9RImhlKbl3vprvgjKLvUggcN7gnKsryGylg7nm0sNtolErPhPurku9YAm
	 RyAtdabglgCXA7ZgXoGjqvNObqPoGsYSr6J9BjYrZJH0K6E2s03ywEixrblzxHI6myLZc
	 tMb7WGAaTCcfptPfrNNM/f1Ns23ns3VglSGZOSdwgAZ11WnWMLsJUw7kwNQePxxu5OQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxWZ3V2d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA8606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 11:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DA8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxWZ3V2d
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3adfc004920so34836161fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 03:31:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794828674; cv=none;
        d=google.com; s=arc-20260327;
        b=hH5PXH+Px4L6dxwUlWwAXn9Tq6ABBYU2Oy9pQ1cnqkYs2/jhMZVS/Ia4T/Xu7ejtLw
         2ipt83Jz9v691fLBFZwvpsvnXn0yWZv30DAJAMJY3taLXEk8msWDZ0CY5RsgNzvclZz4
         0PeQRj06MjDDtGi5WoLQIw5I+xS4y9NY5staiYyRwd1pnjdRxmLRH+RpZKXioli+Ubq5
         3Sf3Xm6cbdkC0gZq8CbKSL/qqJM9bL4JyJX1nq6AEe8qwbEJHjT3OtS6uN1xyy61k8Gr
         BIVxFB3DnsU+V7XpjvL5axOoZysAp5wLkY+2M0E3PHY7RYqJ0DouKoUsnN3+LCGhVyjk
         CIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wtSeKpS27rBmoNgRnmtk6Fl68DcVUzwroJjv5Gt9KJo=;
        fh=WNvT5X8/ogI1+jk8W/+3yJJCM/7Qt9EZ3bacld6WlqQ=;
        b=XO1Mb/lDuvETpVcxtPohEeNYtgLiXOfm7ZmJpvQxU3rqfVr0FHAfLjuziDyT/WJw/O
         Nkp1RjxWklZ+SrHud6ae3OuYS7tmTmJis+P+UiGjd0dOb1vpeAi/TB7zGYCk0YXNiR1/
         lGagjgwZrmLKWxDEI3y7Pwf092FGwzAW0iEtFwwWkyBuPWjT1ZaSbfful0Tq8rNbbsfM
         xaiy1jqNsH7S66urB0lMetODAp+0Wh6JPht0V2P9UPRF00shLlF2T17rydE2spqvgKFg
         94UA0MAaqbodFeqPXV1ZTbkUYohdgiva54wPmyHFVQhaDx9dZEqDbsQM5g3H1Y5s82MJ
         fjOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794828674; x=1795433474; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wtSeKpS27rBmoNgRnmtk6Fl68DcVUzwroJjv5Gt9KJo=;
        b=kxWZ3V2dVLj+c2/8iSKefCrbXhzuXYCgt5E4YLq/IbkWEXpqNbQOR1/wAnWoWUhqXA
         QXEo807K+w4JcmYKtkfJqxmstIa4egAT1Sl4+XhRI1Rbsv3DKmQPvfrB7gbuDfW1uRmH
         n9Luy6QTnwLwntMmFdIBQKVSBC120MN2xvKRYW1Ib/gid02S7pSadDR5mk6mfYZJ1CE5
         qfpaFgr8QW/aEVwn62yYQHLYw5S/Qo6GSb68PdpnJ3gvg8H/wu5CB1dwjGHHMKtcx3Cx
         +PupmxkMqvBMbrWh0X2nETj4/m7GFVhZVT1iy055+ZP6FrtX93azsktz0agKKku4ajOW
         ZxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794828674; x=1795433474;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wtSeKpS27rBmoNgRnmtk6Fl68DcVUzwroJjv5Gt9KJo=;
        b=pT+AK6mPPUlItqlga+6tfQo/bovhbovlwYL9UY5KnTiQXjY/G43hvb8CYHJi5js3cx
         GmdCnJCOdfoRr2b9cWLtcpevYVfFEE7Cnm6CpNQ06k+wZoyNrnF84XMoADeITkjYb/dZ
         PSKHS4bc5Xg4nSXf1jyCOtcG7aEhFKbQU/53nHP2nwFxZTb4DqKFY234mzbuUTinNipO
         zLSeFwtYrv4cP4fWm2vXKmw8XXOq66pFJjpXuz+BHpVE5tf1r6EyLLORZHN2Xs0zjyDb
         Q/CLFkKzro9DKIoUNidkfrjFQDQmRP3N72vD5A0lNL02NSAW5wE84NBV2AtcZG3PN8A7
         GtJw==
X-Forwarded-Encrypted: i=1; AL+hErFlI1BgjAHpt26W04AhrHENmSi3VsfSOcZuC6urNKGdhqbd+9ZJwcsk3V6g340RBx5GEFIhzz6BGz12dE6p@vger.kernel.org
X-Gm-Message-State: APuU4Z/kQ2QrN7a2fA5yItEn7niahUWgAfWudjFUQl072oambIbIxY3n
	dFEwPDACSvmjmS5Z+7wUmn1CJ6p5vh5gTAza6z5g/DHK98c9XnOYNjl5pqnSvanSiiJyujfpd6v
	uNNdqYjWmmsMjuP6xuj1w3JMNZcPEe98=
X-Gm-Gg: AYBFou3BrvEHz0e8npOE1Bc48buXQxvXVezF1dkd6hKcePBhQ7vQMOEcFjvEUlyr9LS
	ElADCVFxOEr50y0v5Zz3DcxjNi7wtqDc+yzCpZ8j77SzL0unrQynCND6TjPbiubM8P5BEZ83ZAx
	RksZPDUTI3zAd8qUKBvrGz/HFjNs2OT7Fk+hclV/9j5vyktV7h3Ef1RdH3MDmQwfCp2armPT1NG
	AHdRAu04zFRul5NIYjrbwjoMAU/1U2wrpDqgqLjK/R97XA7LICV/M894p/7HVQhi9DeIJ36o8QQ
	FKiSb92BgiJLq9SpKJ3fHxlJV7bI2gqjfP9FZedl/PF2c/Hlzx7hANyIsel3k4YXlbxpMTu6xxO
	rchsAfGBMleM0sS3UwXQTL/aEHZrH6UEOL0pzlw==
X-Received: by 2002:a05:651c:a344:b0:3ac:ff0a:9d86 with SMTP id
 38308e7fff4ca-3ae2b4bad81mr32453821fa.15.1794828674271; Mon, 16 Nov 2026
 03:31:14 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
 <20261115210952.2140036-2-graypanda.inzag@gmail.com> <CAOQ4uxhZS1w24GXWphu-PNPbGxVJUDwOfqHdRZcb05+_HVv=aA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhZS1w24GXWphu-PNPbGxVJUDwOfqHdRZcb05+_HVv=aA@mail.gmail.com>
From: Junyoung Jang <graypanda.inzag@gmail.com>
Date: Mon, 16 Nov 2026 20:31:00 +0900
X-Gm-Features: Aa3M54qrozvfFSvQ0gfAb_mSn86pOQYMr6gnIKh6TI_Xntwk7Flfv7qM72l-pE8
Message-ID: <CAO7ntTRdY+5G1wiETFu0SVa3vFX+0RyMO6R5XpoosF0zhuoQYw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: reject embedded NULs in readdir entry names
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 16, 2026 at 7:25 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Nov 15, 2026 at 10:10 PM Junyoung Jang
> <graypanda.inzag@gmail.com> wrote:
> >
> > parse_dirfile() and parse_dirplusfile() reject '/' in dirent->name, but
> > do not check for embedded NUL bytes.
> >
> > Unlike plain getdents() buffers covered by verify_dirent_name() in
> > fs/readdir.c, FUSE READDIRPLUS passes dirent->namelen directly to
> > QSTR_INIT() in fuse_direntplus_link() and instantiates or aliases live
> > dentries via d_splice_alias(). A dirent name containing an embedded NUL
> > produces a dentry whose d_name.len extends past the NUL terminator,
> > which allows callers such as inotify to copy uninitialized kernel slab
> > memory past the NUL byte to userspace.
> >
> > Reject dirent names containing NUL alongside '/' in the FUSE readdir
> > parsers.
>
> My concern is that there are innocent buggy servers that pass NUL
> maybe even because of length including the terminating NUL.
>
> It would be more considerate to make this check in fuse_direntplus_link()
> rather than to fail the readdir.
>
> See precedent in:
> 78d04af4995a1 NFS: nfs_prime_dcache must validate the filename
>
> Also, verify_dirent_name() never checks for embedded NUL, so all the
> other filesystems can get away with this without failing readdir.
>
> Thanks,
> Amir.

Hi Amir,

That makes sense, breaking getdents() for FUSE servers that include a
trailing NUL in namelen is definitely a real risk.

In v2, I will drop the parser checks and instead have
fuse_direntplus_link() return 0 early when memchr(name.name, '\0',
name.len) is non-NULL, skipping dcache instantiation without failing
readdir (matching the nfs_prime_dcache() precedent).

Thanks,
Junyoung
