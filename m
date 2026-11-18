Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795019816;
	b=UDAjyqDRaw0VEwvDyVC47McCkGXiBF5avq2xhLVFwA2qgITgkynem+JEkGQgED041Rk1
	 tXxHvGntgphxFIheC6mYtzZo3tnjWyfeQVqGA6mHsQPQB1l5vEBwJd9BSKEnFnkbchhzj
	 1zWpzhzHvmg9aT+mlWx4C7aXLgG89vTvOTaqhG5B89JpsluyDj8qmmIroZAGJDvCrXGYP
	 sI16EEb3F7LO2IVYuA13zSTAhzkPBUf59mybBixOqk4OR9860eMwh3IMq8n6zabQMSU+J
	 PiwUzNzEHlpoL3rxlylf7cdEWiX90l1LAzs2CAjYlYuAXWOjuVocOaoI2+mu36iDX5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ThJWWn15R7JIY3hayjLwOhu3LzqQd50Rds3OyAm+UpI=;
	b=JC7/cieQIUkG35uTg5mDHTbWH1mlpgUiqmuu5YmQe4SUN71TtuR91mP7V8KPhryhUCDq
	 9oNYJTW6qwp+N7Lmk0KbVsnC5gUfja9C+jS8E3xLOoXDaRAsgtobqr+E7GeByvzbTSalp
	 zKQVwpewI/Y1Dt1ZYhD/MS7laaXHVC5FdDtksLYu8jejoKpIk1LKHa3ZLlS549bVZcx/t
	 OSMmJ9cjo8vRn3zWqy8OcUG56KAOxS6yuE3pbe4hnVbdn+sSDrBZnbrf+HY+BmAnQANP9
	 ME86guFNwkmNwrj/9qr+hKIvLxnIlr9s/SoKCX0qO5N5h6nM0R32G7GHUvHUiWlu6sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q928FUfp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EBE606A32F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35EBE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q928FUfp
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so2097455a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 08:36:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795019814; cv=none;
        d=google.com; s=arc-20260327;
        b=OknnDO0Ed7ccil8F8R5ZLkHF16OUa/rdoKYegr2bDDznUOFg8rRaZiSliAON1+lmeb
         5/1cIUQw07mz+Go4CQynrBvVD/uFsUTyy2iSjdPm2ft59/lJUmgky2pk34ad9DzYh4mf
         NEP+eLwZVXb1/EwnEfMtSVXj4nRQ9rUWhJs3QuQwgp+fXMLYQMKjiG7/QsbcKlm1GdN5
         4Y02CJw70eGpsGxUsGUoLT1BYgXz7P/+Drte++S4UzA+0EINw+jDkHeItZV+s1NkgmjH
         iiFq211Qnm3/LIMoYKE0ygbS8YXos/wVQ0M0s0PGJppZlVYKHV2kk00GEgKRPsPlFD3f
         0HtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ThJWWn15R7JIY3hayjLwOhu3LzqQd50Rds3OyAm+UpI=;
        fh=2drCHBhFQ+N3YJwrPkXeauW47sIPunS6e7ZIG5kJH18=;
        b=BsoOdeOOLe1jQ2H27zV4vTPNkVNm1/up2ZzrgaTDww4gDfDilK8zJoBAOjE8W2UE7P
         /LXSgK0zU3KgyZvAYCaMe7XnRgxTGc7mBi64KqUkdtkOFPheYo4sTN/kPUvM0trESdlo
         Or8cbKZO831jM7rLoR6Xyk+Len+h2cqPKud7mNtLDGZMUH7fPtS7/XHgjky3hgD4U+PL
         /m+yasPyNqkCneB3RZCy0vlAlOvZv6cS+KaNYaEZsl8/pK4dVjoEphcg/MWz0XD57a7t
         dyqdtS3sGUCa7X6F+MDzJG1Muod98gXPrcC38OwQboepsdRyHRLsknrQ44HH60sjm2ca
         +LIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795019814; x=1795624614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThJWWn15R7JIY3hayjLwOhu3LzqQd50Rds3OyAm+UpI=;
        b=Q928FUfp2LnQkjGEnKMIMu+nIXWPV8Mw0HjVjFDQa7MZUVLuYPLFwnsc7iiHqC360u
         Kp8IRabh9aATlCbBIrXYC8LB4ujsA2WowQnPl0onFZOSJ5rVYhQ50HD2q0pTUJXyKimM
         OUL77cTMfVDMrYjz/NQW0TKyEQpYRFMt7Ju+HVxVGfRQjrSAY87Mpzq+C/2x9bC6NTow
         OtYFWyMzdvLEcoERGP5aXpJZMZOJljjkWPd07rML7zS6cDn/RnBxJCXaYM/7fpaXHvui
         3d3div9gMzI9ed77/rJrBt7B9+fw7rgFDQ4NESvylFpmE6QFtWC5GnB6Lj4Ro4sGb6Nt
         AJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019814; x=1795624614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThJWWn15R7JIY3hayjLwOhu3LzqQd50Rds3OyAm+UpI=;
        b=wuzK/fyMZRgVNqOUja1b0JTakLR2SQTL0FDOdDU4+WHY75ilUI03HRPLegS2GPf/uK
         XAcRm9HBahLW1NQpBR5/+7SmCldzj0t7OzzRmtmEARKQLvZor/8H+kPf5/dvRnqSLIyY
         7dAuG1qRqjv47JS/QJJqbO6ERt8dCMOgEcBrHQb1E2vjEDuCrffDgx+I2bf5lB7OHQjl
         13eb6OErAkvYHZ7Vudbr8+VRtG7j25Y4ysu+H0KIsIWWKEtfJJzfQQ5Yha2lJwycI1rS
         z9TdsTs80dETq64JoOkxD9BZKe27pcZuE0+QGy9qBFxy15SxkjbSPddFmlRjTtgJOvRC
         qeeg==
X-Forwarded-Encrypted: i=1; AL+hErEg6YB8BR+rkcy4pjZBrxuAjAqz5+PVxBOJ3LemcIZOh1PcvdeUswZh5Mn+sSlcQ8ppfQNGeRmjOoiafmPr@vger.kernel.org
X-Gm-Message-State: APuU4Z9a9IWkiGtvV+wZE8kSAN1JOWR3WdQiiE4b8ZiRzbs6CjDXUA04
	y+m99FH02uYS7qpQOSdCvTtmx4ofDG8hbLRD9ZFoJ56cxDaVM6FBMI16bwBO3Z5SySfuvXVpZ51
	cwHJOGqOlUX+NABNcVe/gKA3jbP17EUg=
X-Gm-Gg: AYBFou1IFbPoQrbUY7E/dpCsqNwjwTF4Y9xzJauBQt1c81QbHrTxyo1pkrrbY4Ih+MI
	cWTiXwWDyb7ONqodSELTqm7M6dizdTO9m7NKNij4s9gpOSzrn3vBTdC09jI+qRGnt5TU9Wba2WP
	BcGjVemCkJMOgD1RswsZyRmuP+Jgt5hlZ4xn+iRRT0lnobuhcC9gQdkR7BSRz4Tc1AvvV/S2L8W
	rSpy+rwaeizfsDWbR2n1dd7QiLAPUhXXZiHb0VNDhvOPdQjvqh0gEyN+SOmdTzkAvtQK5AJ65Np
	3acRCURQWoNkJTUY5HSMky0hXq6GHCYW47AKvK4RyuHPwyiapSKkcfZcp+O7hcenclXg1DxYddJ
	IDS96n58Yb0oSD5rIAVRFcKPx+5iXNaYtMrHYNK6GVsvDATysvtVQbUPf4sIrFLbf+AbdeQ==
X-Received: by 2002:a05:6402:c711:20b0:6b7:b12e:1638 with SMTP id
 4fb4d7f45d1cf-6b887effc26mr1999145a12.37.1795019814317; Wed, 18 Nov 2026
 08:36:54 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115180343.576773-1-koray.fra@gmail.com> <20261115180343.576773-8-koray.fra@gmail.com>
 <f297d9ea-ebd7-47f4-ab7b-de5c45980000@app.fastmail.com> <CAOQ4uxhpMARO_ZMJDeoa044BwufLVnS0o4Fv0abBF=tjaZmtWQ@mail.gmail.com>
 <cd49ce48-58d7-4341-b4fc-34e63daf3c52@app.fastmail.com>
In-Reply-To: <cd49ce48-58d7-4341-b4fc-34e63daf3c52@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Nov 2026 17:36:41 +0100
X-Gm-Features: AclHuK_Wot5qcfi8_9CAebWCtd31KyKZ5gW_T2w6JAANm_7TsCfaaSyfxQBsTLM
Message-ID: <CAOQ4uxjme9sJ5LGNDnP6rEKZLTJzX_ZdcMohgu2iLULK96GPOA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 07/10] nfsd: add provenance time (ptime) via FATTR4_TIME_CREATE
To: Chuck Lever <cel@kernel.org>
Cc: koraynilay <koray.fra@gmail.com>, David Sterba <dsterba@suse.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Paulo Alcantara <pc@manguebit.org>, Chris Mason <mason@kernel.org>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Sean Smith <defendthedisabled@gmail.com>, Andrey Albershteyn <aalbersh@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 5:09=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Wed, Nov 18, 2026, at 2:44 AM, Amir Goldstein wrote:
> > On Tue, Nov 17, 2026 at 11:02=E2=80=AFPM Chuck Lever <cel@kernel.org> w=
rote:
> >>
> >>
> >>
> >> On Sun, Nov 15, 2026, at 1:03 PM, koraynilay wrote:
> >> > Implement provenance time (ptime) in NFSD, as introduced in a
> >> > previous commit ("vfs: add provenance time (ptime)").
> >> >
> >> > Map ptime to FATTR4_TIME_CREATE, allowing clients to set it across
> >> > CREATE, OPEN and SETATTR compounds.
> >> >
> >> > If the underlying filesystem supports it, use __vfs_fileattr_set_loc=
ked()
> >> > to set it, returning -EOPNOTSUPP in case it's not supported (i.e. wh=
en
> >> > __vfs_fileattr_set_locked() returns -ENOIOCTLCMD).
> >> >
> >> > When querying FATTR4_TIME_CREATE, request both STATX_PTIME and
> >> > STATX_BTIME, preferring ptime over btime if available, and advertise
> >> > FATTR4_TIME_CREATE support if either ptime or btime is available.
> >> >
> >> > Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.7
> >> > Signed-off-by: koraynilay <koray.fra@gmail.com>
> >>
> >> > @@ -3646,7 +3649,14 @@ static __be32
> >> > nfsd4_encode_fattr4_time_access(struct xdr_stream *xdr,
> >> >  static __be32 nfsd4_encode_fattr4_time_create(struct xdr_stream *xd=
r,
> >> >                                             const struct nfsd4_fattr=
_args *args)
> >> >  {
> >> > -     return nfsd4_encode_nfstime4(xdr, &args->stat.btime);
> >> > +     const struct timespec64 *ts;
> >> > +
> >> > +     if (args->stat.result_mask & STATX_PTIME)
> >> > +             ts =3D &args->stat.ptime;
> >> > +     else
> >> > +             ts =3D &args->stat.btime;
> >> > +
> >> > +     return nfsd4_encode_nfstime4(xdr, ts);
> >> >  }
> >>
> >> I have trouble with this approach.
> >>
> >> We've already established that, for the Linux in-kernel NFS server
> >> implementation, FATTR4_TIME_CREATE reports a file's birth time and
> >> does not permit NFS clients to modify that.
> >>
> >> After this patch is applied, the server reports the ptime instead
> >> of the btime on some filesystems but not others.
> >
> > In other words, for some server filesystems FATTR4_TIME_CREATE is
> > settable and for others it is not.
> >
> > Isn't the NFSv4 protocol equipt to deal with this complexity?
>
> Not a question of whether NFSv4 _can_ do it. It's whether it _should_
> and whether opaquely choosing a settable vs. an immutable timestamp
> on the server is the right design.
>
>
> >> Essentially this changes the semantics of existing files that have
> >> a btime set -- technically that's a regression.
> >
> > I fail to see in what situation this is a regression. Please explain.
>
> Any consumer that depends on btime being read-only is now screwed.
>

Who is the consumer in this context?
An NFS client?

Can't an NFS client be connected to another NFS server
implementation which does allow this?

I can't wrap my head around the problem.

Thanks,
Amir.
