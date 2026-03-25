Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8E3D9041
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444307; cv=pass; b=UW+MAUyxpsECXrXsh76Qfhs4nH7jUaNLokvXcWLk/ie3i3hlhjZqhzTBzB4769IQFmT99OIbKLa2mJZ9u8Un/1ecT8/Ja/B57wWMeEAIPE26Qk8LZKdCbvlnlj3TvSVJELD+CxbsFKlV7alGu7fh+eNrtZWLfo/KnFB+ZOyqgCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444307; c=relaxed/simple;
	bh=YxIHujYENEm6EBmD9azc6mtyM7Yqawhb5mVPwFjsj6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGQnZP/havynnPPq3rW9DpfGd9I91A4ZPc91tsrLUUZHQSffHffP/IS+IkkLNCZJmmVsQe/EK79oH+bP5RotbYcjYam80VGKNM+5j/dpsz2M8fri8TkuTu4VUwVNkqVS1Q8QOSEhXZC14yxqUAHsYqmX+4xXbyQqa0Es5YyHObs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq+j9Fm7; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq+j9Fm7"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so4016593a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 06:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774444304; cv=none;
        d=google.com; s=arc-20240605;
        b=YmowOEbsaxOBtVJ+/oMGZ8LEA3ECRFRxLzuZP8SXn+ACEiFGVebKmfW0WISIIoQNkX
         97zdxvje9qYe5hNRHureDSc88T596igZBW1iBo0fhwIAZHRmBLVqYRjN9IlYM5PfHIfU
         kkCOThMofqf71FLVihmqiM3BcW3II1MTeickX+PzU++azgVpNWEOpzzZTcKzflRZjyKr
         LScynY7FGN3UIn7DbsxULVaepiZBduGi8fV5+Pk2lUv0dwB205RQLb4R3xdQXf91/MBR
         sSk5wwx09RcMaq8WHLD+tyjQhBmFK9FZw80MO6f4LYcB9PMOR8rFtH0LGGeFF4hJ42Bn
         r/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YAL3MktHcr/vcvwOIY/V2T5PrQZaA2TbVtTOY5hlRDk=;
        fh=RrV91ArYW65qDj2U3sOe6A6tC3TF5QPGuXYDA7xqInA=;
        b=QJflk2TiJsd9wQq7NVJ98rGLdTlTjsRDU7PeL4mOMZLUP+OkEiCIA1nAsFSNXzV2Oz
         AzdBROMUSG8UV1FAPtqsXokBLNis1mbCZ7eS7VGTo5bzcWzCkCJmBvQvYf4FAaRHw0Vd
         6B+lEvQK2XnWwlCYDi56HdwB43QOekRic+7/V2/uTboUfWw9qsHfjTLPv6bDJFnPpw5a
         RcC5e0CIbkDRuSYZAmMwbEMWNUK0m/f7esv9ScaGWBlWnbE9m/anQ2UPHABrSFpphCy1
         WPHqf3Yf1r1eUbiiPlS65DtNDeruiI7XV18aYfJ1kp7crSh/Am2+uNPZmWkVchp6Nzn3
         gOGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774444304; x=1775049104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAL3MktHcr/vcvwOIY/V2T5PrQZaA2TbVtTOY5hlRDk=;
        b=Nq+j9Fm7dB3NlgPT/j7CFPL6q9kvtl27uyQKqZH3G5XyHTHID0r2CES3SG/6f50T1P
         MQYyIw3FdJQxu+ImrGN8vzXHTx334aTeCr6USnlWtBUGJ1Iu2HSskcDqeQYkZcxLQddG
         yFZ32GMhMGBgKID5XNE0IIK+OcKAWACNIQT6vb0cJBXrRVad8HsOfHYivWw9rDUSeE6G
         JVcHnyOgmJ0Sb/oaGfgR0THeqQGRru7EtJ/vXJnwYXYc0rAsIhCmUwMTmUEKtZGY0O/a
         S0Cfl3r/M+0tVsOHI5fZlzaQPhk2rvtqYQZNDxXbX39pKeOBfOfbjf2nu8A8BFch9ck2
         76QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444304; x=1775049104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YAL3MktHcr/vcvwOIY/V2T5PrQZaA2TbVtTOY5hlRDk=;
        b=HEPRpqTu11YyIb9CFG5QTv1LB6+s3DyQOW1EXc20LgEMCkV+n86GFc/XenknKYJj59
         4Af/MwAqEFs7RDXgNFcxsE2l54PrYCgGzPHb3Y/OrdDrLcuSRH/N/pEC7uPCZkaBjbuh
         U6OLsDezRXq02NIdA7oz0FCkB/XCdmZmlBm1xr2pGVZnBV7Gs8Pp29CY31buqmA5luyj
         /PZghzlENtcaVYinLAF0etyAYCMziW3nqUHtD1D/pKmObdkYq2HDEVjwM25qP4Nao29D
         /oyMQMjA5qgTp7iNnJmtgY8296yDZMEuURVieY5m7Lp/9MQG+TIUyBIiR1fty2LnAvCq
         F/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1M3NbZcRuMESrCTu+FPtVAf4OEmnxbS5UK2ksYvo++8pkWtu//iFZxmTW9Q3eZN1wdgUOvt0VS4eCYVIj@vger.kernel.org
X-Gm-Message-State: AOJu0YzyetQ9bnuevmWp0aXgdKZM3+192GXr5eY2mbJuV37Ql1G2VxM9
	dojlVvODMh7TS5cXTg4VL/Olr2R/4I4RyppYy1++ugS9a5dN2NIvQ+l3I4mrT4s7TLwFcnxBTs1
	OQU1cX8Fr9H9kJ9mlmZbHSLP0OGo123A=
X-Gm-Gg: ATEYQzwx8BZNQj5Ngk2Rril1onboeubJt0aSqEleGi/LfDdKizwsFP5nJGL604iCWZj
	uOYPrhBny1tgqOE2D/sI6JkKMiYsjdUr7Gx2nhn0JkfzkbdkmyTETG0cytQmgXGRxBFtYc+YB4I
	8REjFyBuavcvodRUZQSMLoeguGIAJKzBMpndH71JFCRTKOhdoXELNTOnMWiddDh9oaoNbTLQ09V
	yZTm3AkuQrRjeslaJur3dN+spQTSMt670zA/TZH7p0rHwlTNo/kExB3g0moroVa5UMVDer8Q+Lf
	t/ysfo2PBEXJRwwv6z+WLcXlqZBK38IelWMZ2E5rwg==
X-Received: by 2002:a05:6402:4557:b0:665:57e8:66f1 with SMTP id
 4fb4d7f45d1cf-66a8267303fmr1719430a12.21.1774444303803; Wed, 25 Mar 2026
 06:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324145750.90719-1-amir73il@gmail.com> <acN457svKhT5TcKI@infradead.org>
 <CAOQ4uxh5NFvXGop6ne-zfRbH5p6BPT2kCt7dUkP__-TtpeJjJQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh5NFvXGop6ne-zfRbH5p6BPT2kCt7dUkP__-TtpeJjJQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Mar 2026 14:11:31 +0100
X-Gm-Features: AQROBzDVeGqnKO3akasKMPWkhznjGnqFPgh3LUU0b-Y45Yn6DEKMp5I8lCECmUA
Message-ID: <CAOQ4uxge9QDMwnLr1+W0xF2GocnFWVrbhRdriaf5Qe+4KkrG4Q@mail.gmail.com>
Subject: Re: [PATCH] ovl: make fsync after metadata copy-up opt-in mount option
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Fei Lv <feilv@asrmicro.com>, 
	Chenglong Tang <chenglongtang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 1:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Mar 25, 2026 at 6:55=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Tue, Mar 24, 2026 at 03:57:50PM +0100, Amir Goldstein wrote:
> > > From: Fei Lv <feilv@asrmicro.com>
> > >
> > > Commit 7d6899fb69d25 ("ovl: fsync after metadata copy-up") was done t=
o
> > > fix durability of overlayfs copy up on an upper filesystem which does
> > > not enforce ordering on storing of metadata changes (e.g. ubifs).
> >
> > I'm trying to understand this previous commit more than this one,
> > but what 'enforce ordering on storing of metadata changes' does
> > overlayfs encode right now?
>
> On copy up or a directory:
> 1. create a directory in tmpdir
> 2. copy attributes and xattr from lower directory to this staged
> directory copy up
> 3. move it into place in overlayfs upperdir
>
> Until commit 7d6899fb69d25, there was no fsync before step 2 to 3.
> Only when copying a regular file there was fsync after data copy up.
>
> This of course provides no guarantee over the state of the copied up dir
> after crash, whether the directory is observed in upperdir with or withou=
t
> the attributes, but in reality this is how it is since 2014 and for many =
local
> filesystems (e.g. xfs), there is little risk in this practice.
>
> It should be noted that overlayfs is quite picky about which filesystems
> are allowed as upper filesystems and specifically network filesystems
> are not allowed.
>
> > There is no real ordering requirements
> > anywhere in the Linux file system API, so it does sounds like ovl
> > is making some assumptions by default?
>
> Correct. I would say "making assumptions" I would just say that
> overlayfs has never taken this aspect into account.
>
> > Are those documented somewhere?
>
> I guess not, but now that this commit introduces, fsync=3Dordered,strict
> and a documentation section about them, it is a good opportunity
> to expand on this point. I will add that.
>

See modified documentation below:

Thanks,
Amir.

Durability and copy up
----------------------

The fsync(2) system call ensures that the data and metadata of a file
are safely written to the backing storage, which is expected to
guarantee the existence of the information post system crash.

Without an fsync(2) call, there is no guarantee that the observed
data after a system crash will be either the old or the new data, but
in practice, the observed data after crash is often the old or new data
or a mix of both.

When an overlayfs file is modified for the first time, copy up will
create a copy of the lower file and its parent directories in the upper
layer.  Since the Linux filesystem API does not enforce any particular
ordering on storing changes without explicit fsync(2) calls, in case
of a system crash, the upper file could end up with no data at all
(i.e. zeros), which would be an unusual outcome.  To avoid this
experience, overlayfs calls fsync(2) on the upper file before completing
data copy up with rename(2) to make the copy up "atomic".

By default, overlayfs does not call fsync(2) on copied up directories,
so after a crash, a copied up directory could be observed in the upper
layer without some of its attributes.  This has been the overlayfs
behavior since its introduction and it poses little risk in practice
for common local filesystems (e.g. ext4, xfs).  This risk is further
mitigated by overlayfs restricting the upper layer to local filesystems
only (i.e. network filesystems are not allowed).

Overlayfs can be tuned to prefer performance or durability when storing
to the underlying upper layer.  This is controlled by the "fsync" mount
option, which supports these values:

- "ordered": (default)
    Call fsync(2) on upper file before completion of data copy up.
    No fsync(2) is called on directory or metadata-only copy up.
- "strict":
    Call fsync(2) on upper file and directories before completion of any
    copy up.
- "volatile": [*]
    Prefer performance over durability (see `Volatile mount`_)

[*] The mount option "volatile" is an alias to "fsync=3Dvolatile".
