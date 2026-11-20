Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795186533;
	b=npxexuVXL3xYxQBwVUqm0HSTlaNCI0iEOOAchmR1iUl5gIKwtSg9Ev6ajiM6DUHU/YDI
	 saJz8ImNmqDf36vKoysZjnFRDvPKu/jpFBN+cLV8E0IIW+G7ysHY6WT1vBp2NcYXmoCwM
	 Hm/2B6DYjeFDWAhXgTaNyEvXuAilfLTqDOxvjQEwlx6Rh1BBzdOCL8IkqoksAuCT/l9P3
	 UKj6hvzMZEHXCPR2LlmqL1Jp5pSoQ9biFUoTOg6q7HX07n+wsK75D3M0BXp6CGIsDlEeY
	 +Ns+oqDZrdugnTYDk+S9EOSussy0N4fmAEWT9SklNKq+EG/qKnkO8UnMcZHyg9N6L5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zpoWzG1+g8sYeNmdw7RPLfc/0HSn9Ajkmbs7oAG/5Qs=;
	b=m3E3fwf+ZqsTK7e/dUYoXqmowUnYLEJ2IaOxwQ+YOxVN0eDWGdyFAmFVe/z/yPkd0R2x
	 JQbFaqpp+j9VyFRQuPYwUH0XUJbR0wwbHbikEfokhnTAtAT+KohO/cfXExax3DJWri3rE
	 fZGRMyz085W9SdEJys2JElBVTezHUwMRNc8f0DaoA2l+SZretaPimrARZoCaeQ8pPJi+x
	 3UQ4PEIzRE9TTJRvmNDvjjGwt6oR8dVpqDtGUwZKp5fNq67lEoFw5E+9z9ql7JBT+9AOO
	 p1x0DT3531SdxtzpG8HdBd0ZyNbRqJpzHEEtIscPBkcxwHYsAwmXLwYyAu+Slj358Tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XT71/E4r";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78B606A336
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D78B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XT71/E4r
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b88bc47e23so1231317a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:55:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795186532; cv=none;
        d=google.com; s=arc-20260327;
        b=VbaNhQtfqlqrwcvqbsx0XfOkEtinDDDXHh4GmOzryUzlwShRJbt1OGkxlJxVUgdunY
         83y4F3wPhbmO9zeRgsfr/ol/Crhou/CyzUATs2MSlMFk7UCDjNNSlaOGKh4h+s1/PZp0
         dn7g/OLC8jho4zdHrkTc1hno0M2YdP+sR4LJKHnyGoHst92VVui34/PeMP7jNQ23OyYf
         9cz3cDNGSPXqmLl+yeAdax0XIpKWcpOq+5zhEfcX8RQlqery6Uuze8KPIekI4kV/HdTf
         38T0Wx0pQrlnAxuoZZUpTCJPK4wod82al7LX6JyeScDYhMOtdLI+bol33LyPimoXE0vu
         HX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zpoWzG1+g8sYeNmdw7RPLfc/0HSn9Ajkmbs7oAG/5Qs=;
        fh=39J4a72t7IrDu5THo2prWhZWZLKEcju1H8/Kizsuv0I=;
        b=DKhjCy+hrI67SFtclJ0djk56zmqTxjrbN7V/B+XsWX9kA9gakaWbNP/wMomtPE9G5k
         f+lsCBlUm4Nc3kVAlSy/xdBplIyDP785qHcUw3+kbZmU6X8WWZLINoDqSF4vhEcLM+hy
         NCidemYZ7XRWN63eNGbibGYfvGsQz5AQ7KXdrG0ToCNwsgN+sYvv5tn1PxPgW+UzBaGS
         0XFO2FvhqcU3GzSohY2h2vwEu75Y0/mYYe3pIrfqTD/OXG2x5/gj2IqRib5UuKRo561i
         pAd4cPFsHYhD9WLYcpas8ro+nnomltJqWwmv6/y+T3SbEu5MkG4DX6xxZjy/dMDfLPYn
         fQaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795186532; x=1795791332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zpoWzG1+g8sYeNmdw7RPLfc/0HSn9Ajkmbs7oAG/5Qs=;
        b=XT71/E4radr+V0uXgPEtpy0gTEoHCeyDzLAY8K94G59n90O+uv++nCc8LBTX/toK/0
         oCtVL35qsDqsHFCvztHPd6HhjbqSJ8Vwc8ZJfStI7YYUhYzRNmLNpBIQMkc69ILk7c36
         ZDgsLeuC7kJXyHt7GV7DGWfHYIq4655Im+cirBeI+iUHoUj7bKjfKZyUnrONaVl4D44J
         ww0U5x8tM0ESZ2EwqzQw4R3/0gUwPfGJym0p5b3otFIF//GO/UwhtCfcmLJW/40OkP+W
         CdiJIaGOl4B0ABFgWYbTFah8knh1vRGWghRZ7vMT9mim8VxC0/RTV9tBJ5cW6vANuiQ4
         lwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186532; x=1795791332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zpoWzG1+g8sYeNmdw7RPLfc/0HSn9Ajkmbs7oAG/5Qs=;
        b=zngBzBeVpSrEL+8Z9UMXPpDmKnL9m4PVrTWQ83wRDltcMghBvn6rkn3o53JUPQtEwQ
         DtR1Zpa/0L51HJk1cgWW9p15JPOHQlCBuNLqhj5YYXZC+Xg76EY5AXoXrrdblCk5UChR
         cdLuHRogQwK/UIHB7fSAprZn78qKXXrz2TMquPJYexNh7R8mz1wyz+vFD2kslVnHOgus
         XdPeNXVUGZ26ayh6QPXjE6UPV/JxX5q1RHuWb4kdujOoypReIsCr8BFNpVebtnvZhr6d
         timvbG7N9viEwnLATGqUvU1EiNr6RueeYHfwh/serJJQuYuqaXjFa3vruEvasArULJ/B
         HGYQ==
X-Forwarded-Encrypted: i=1; AL+hErH3C2eSkxkrIeWb2tdtAokGXhlBWP8J2Z2gyuGgEd/e5EA01rFLYaeoWlEpN7xnJdaMykMAdCCIpgFVxF80@vger.kernel.org
X-Gm-Message-State: APuU4Z8tkrlGXqmBg1L3QjlQilwEHZTF4TLuMsTBfSjWqqRW9W9kT3QR
	e68HAaTmOYuuls9DUtD9fsEgyuL9spAfIpQ3qpiIczR4Bi8DDUT+eY8k4PEAKeZhg9jQMsQpdjB
	GwEInAbqyKlxZkyLWr9hwIuZitxxCyFY=
X-Gm-Gg: AZFdTZfTqnqh54cTWp2nDAEmJanseUjya25Mi8hwP9vrnbpv9BlVjFsUFwXAT2bBwZo
	CXoshgK9YNKTha8FIx/HFg/VATfL1CHO9YBZkK0g/iDMZTUiT7d+NjT8UimoNubLURb0fsweGc3
	kdYCrfYg20M12NSfo0kAfpBGG2/cns4Uux/AUGTF8XcRb7Bhq9WEzjC8vIuHH2MmEsgKtgrrdeY
	b1wBTz7EBXiBST2FwAyv6ExvjNsn+PjkLSdvBgTt1HdBEkypX7nsSRICDOCo0lvxdddpVMFa5Se
	9dta8DdUPnkfXclRVMKQWIj9wZTckzc3DAY0+UUT7M7aEkUrolm8Sp8zWWrUlTzNGPUj7IYH12I
	2p1/uB1fHFpvgqBUUDG2teZSUlvSI6KopYZllU+6U2UCG8bzxnRMEPntX53M+JGTnhPve1w==
X-Received: by 2002:a05:6402:3223:b0:6b8:5f08:931b with SMTP id
 4fb4d7f45d1cf-6ba37ea44b2mr2503989a12.26.1795186531571; Fri, 20 Nov 2026
 06:55:31 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115180343.576773-1-koray.fra@gmail.com> <20261115180343.576773-9-koray.fra@gmail.com>
 <CAOQ4uxgoNsOH82FyrCxc+qSoid_CFmbmpL0qgWFw-e8E689fFA@mail.gmail.com>
 <DMZJ4PL1JVA4.2YEB7EPYJR5Q7@gmail.com> <CAOQ4uxi6h9BBP7pf4sR+gc2+4XtkEgbxXZha45iZzdB_wGFVgQ@mail.gmail.com>
 <DN02S2XNGRZD.1KNOZJ0GGDJNG@gmail.com>
In-Reply-To: <DN02S2XNGRZD.1KNOZJ0GGDJNG@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Nov 2026 15:55:19 +0100
X-Gm-Features: Aa3M54om4CtJTUNd2Te8u7pI-ZPclkwXdtuzgdSJLpiBpdV9ZiFnAJvfZll4Px8
Message-ID: <CAOQ4uxh+d-wNC0aWLEexPFz7zj=TZjLyu61kaEmwBx9_hKn2gg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 08/10] nfs: add provenance time (ptime) via FATTR4_TIME_CREATE
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Paulo Alcantara <pc@manguebit.org>, Chris Mason <mason@kernel.org>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Sean Smith <defendthedisabled@gmail.com>, Andrey Albershteyn <aalbersh@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:34=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> On Fri Nov 20, 2026 at 7:45 AM CET, Amir Goldstein wrote:
> > On Thu, Nov 19, 2026 at 11:10=E2=80=AFPM koraynilay <koray.fra@gmail.co=
m> wrote:

> >> >                    fa->fsx_xflags |=3D FS_XFLAG_CASENONPRESERVING;
> >> > +                 fa->fsx_xflags_mask |=3D FS_XFLAG_CASENONPRESERVIN=
G;
> >> > +                 fa->fsx_xflags_ro_mask |=3D FS_XFLAG_CASENONPRESER=
VING;
> >> Uhm, why both in _mask and _ro_mask? If it's a RDONLY flag shouldn't
> >> it *only* be in _ro_mask? (same for CASEFOLD)
> >>
> >
> > Good question. Maybe
> > I guess if you want to follow some percent
> > FS_FL_USER_MODIFIABLE is a subset of FS_FL_USER_VISIBLE
> > but I think that exporting ro_mask and _mask is going to be easier and
> > cleaner than rw_mask but not sure.
>
> Hmm I asked that also because you said in the xfs shared extent thread:
>
> > The advantage being that it makes the interface symmetric.
> > User can alway setattr() with the buffer they got from getattr()
> > and instead of randomly ignoring flags in set, the fsx_ro_mask
> > along with fsx_mask defines the behavior exactly.
>
> But by putting the ro flags in _mask too, a user would have to clean
> them out or vfs will reject the call with -EINVAL/something else, since
> in that case the vfs would see the user say "I want to change this [ro]
> flag".
>

That's just a matter of interpretation.

You could say that if flag FS_XFLAG_CASENONPRESERVING
is in ro_mask then its value may not be modified and fs needs to
fail the set if the user given value is not a match to the current
kernel's value.

Could be used for an "atomic flag set" operation, but I think
this is taking this too far.

I am fine with xflags_ro_mask and xflags_rw_mask I guess this
is the less ambiguous option.

Thanks,
Amir.
