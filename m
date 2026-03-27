Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7E3E714A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609790; cv=pass; b=jW4p7mHvRf3cAK2x2VmN0ywSW/U+Hgj006oroou+VtiDaf/FFQssHwk6TCSFI1OHO0Mn9HuTQ4nF9dpwQVNa85wJ14X0lbExxki8ZFGiPW9MIWCgTrmPgf9CqZZIMkp3yDu4Zu5Sbsg7bbvEVR9RdbQ82BiB8O+pm4rRmPqZ8tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609790; c=relaxed/simple;
	bh=ZVUSVN22rirdB2W+suD1qjIDwFy/2R7FDSsezZv8VSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7EdEHCd0QaJdd5UWp86LJ5pAV8OTgLRQ7P+8NmMw5aevnl8xTZcRN9XSB0itJ0B2dq/8lX9RcelrF7RH+ndDzuWOSCxRXE803RYCXyKpdicxxk85ACga/N+mnkWtm50RUonwtASEXCE6X2nPb262FZlSwAt/01HxDpSxRH94n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJTa2gs1; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJTa2gs1"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b980b35534eso463904066b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 04:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774609779; cv=none;
        d=google.com; s=arc-20240605;
        b=PFbz41U7QJnVTmH2z6hheA0/PyR7yY08Mdq55+KZEovzLcg8Hj7nGYYcH+9za1Z7JT
         L21ToGFCDcUUHoDRXa2BRFrNGDkLHsXjpDf2f4VulvAljTdvMW9Q/DbpzKZ4TUr8VdtH
         R4gMr0ljBFylllsH2V8JsEgHnC540G9OkV2aD8yooAtgOLsG4fNUTBR19SeUc6VB+CKv
         C3anu88ILoz+9AA9m1M18hejjsajS1W5Gye4IPAOz3x8dMUHbUH44WG9dMYZ1OELb71C
         84vOeJMI0VLj2eVGgJkESrvfpy3NG8yJLAEn5WY/gIxOl2cNjZ/JOJkicu2dzB6rmBfb
         kLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qByozSkeAIvuXKwVx4Y1ULXB+DloAKTWtZ7pVWLDr2A=;
        fh=lcq743zH9dF+ka/oaI9fHDVPY3eZO4m5TZlfGfQ8G8c=;
        b=itxxzPUg96pPvkBqt2NKSThnAH5rrCkrK+2AgIkUMK4SxHJ6UzmtU7XpvJcl5IR55X
         aMAB39QUgNBc/JLeXFUOj4eHAYTBojwyNV68LOU4NbGv4hzUcDSrRn6hbLAV6F7PEO8D
         W2/expKfpH0vHPum3qOW+3jr5kv0peW9zdPUQMjehe8mP3Iz7j1jm1boMk9iiAXBliez
         ND75ALzTFVCw3XgnCJUWHkAu7QTRvymyabjC0fV237olXQhUE2PfAD3tsGkrFU5eoXQL
         UIELrKRCAdazLaQVIulm4Sa5SOZseGfQY1Zj+PP3NwGuS9/Jp08l79HMnb+Rvp+UYUG0
         NPqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774609779; x=1775214579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qByozSkeAIvuXKwVx4Y1ULXB+DloAKTWtZ7pVWLDr2A=;
        b=oJTa2gs1N55wIpENqrRMTHB8A7/O6skSt1ymi7jTOAUyPSutz67dcIcceYSbKaMfDV
         o+d/gxuJ7aWksPMw7iRLwjwjIWBK/eSTDqandNFVpyDWNxlgYBTtd2cE89IIlad+tqWB
         35YzmFIUWhPkBG2PFi9jcEP3aOhovYvHvYhAl2YQClbggCdX8BaCZnDtbm004bgruPHk
         E0Ib0Qf4Nb4jx6NX9qDBuEcns5fAWN8xrNNp1LsaIJg4c3zChMEMpq1sQIeGmXw0B5am
         M5Lpx9apWme9gt6u5qG1tsXPeKdo4nN2aNFs9wgnPi5LFJL+bGrW8fkp2JBHGJEvCgEO
         yK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774609779; x=1775214579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qByozSkeAIvuXKwVx4Y1ULXB+DloAKTWtZ7pVWLDr2A=;
        b=ai3ig0YFpcx08cBiWNIIKuwreWL4NT3Zp9+VKhwCVnYHUSbpL/Uh/zN9CRW3QF8Crs
         7tGCELaJfKvwtlwUbxgb4KP4CCcON+advhcr3wXlaS1vv9uDYMEMacEvhVdIsTERXjr9
         /ChJMvMgFaGwb5aNK0MUBUHnNac7PhCzM0ToVm+MRiuZTTlTAg1yAvQ+PSU9OQs3yOrZ
         3jT3gAe3698UsM/8SHl6x/HfqpjwBUfv8TctavhP4aeEoI063mS35vvat4pV1cnKo2Kj
         S8LheNMxxfZSQvb6GdrQwkyePYclXG/NWQsOKoMDNe/IuXTp22ZiJ9dLtcgJ62cfkyM0
         OwSg==
X-Forwarded-Encrypted: i=1; AJvYcCUnfy71Zz6EOOz8aMRjBpB1djl9PI3CkWMniBLUe5n0L1QxNHHtdS++BoA3WK9gkrFkE3qaPJS1soPMVEq0@vger.kernel.org
X-Gm-Message-State: AOJu0YzlETLTfChRp8Ids7K65+dvePPJVnPGpSyCZWR843momoFuNCTm
	tjBTFoqad5Od8CgegLFdcJDahSdOKVOAl8qUSoDa7OaDfE5d+32wAv0YBG02dcGBItH2kRop5Lv
	SFPQ/UiQlBHDYzC0MqgoDMQ4VQkqwCSo=
X-Gm-Gg: ATEYQzzUpOKnyBI5zKmWdNnidklxl/8kAYVmBQQIkgV2hm3TiAikg+PE/yefQzp704I
	wDn7O21+vIFt4uLXgx6G9LoIKREPB1vwO84oXqgw6aOY8gQW/R9U1ba7tfPuhZngCPoKEv3lVo/
	vAt9OnQZLHRRg06luENCCeD0dxuYfd+1cwTq2WdXOpO/qwZmP9N4EpqXTbfGzOUOktnahiy0ssr
	rU8oO7F0EsxayJ9I5SGGu0rI51LI4JazP6VacMix4SnZcujGWRXJ3Ux66jDQZOM6nZXYLJ7XoEj
	bXddN1DJBTw7muInRtTO1+LACJuE3EdAvVMwxNF8IA==
X-Received: by 2002:a17:907:3f8d:b0:b97:b88c:386b with SMTP id
 a640c23a62f3a-b9b2eb9bd1bmr316439866b.29.1774609778731; Fri, 27 Mar 2026
 04:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324145750.90719-1-amir73il@gmail.com> <acN457svKhT5TcKI@infradead.org>
 <CAOQ4uxh5NFvXGop6ne-zfRbH5p6BPT2kCt7dUkP__-TtpeJjJQ@mail.gmail.com>
 <CAOQ4uxge9QDMwnLr1+W0xF2GocnFWVrbhRdriaf5Qe+4KkrG4Q@mail.gmail.com> <acYZglh4iyauvDZj@infradead.org>
In-Reply-To: <acYZglh4iyauvDZj@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Mar 2026 12:09:27 +0100
X-Gm-Features: AQROBzC2dL79PdiPpxlUD5MQNlb4iqMJeIMOPJZddoCKl1fQWRstl-FZvT8sICw
Message-ID: <CAOQ4uxgw55ibvCx2ihXZ_oEfRQsbBacaoRi4onUWu_XDp9w1nQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: make fsync after metadata copy-up opt-in mount option
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Fei Lv <feilv@asrmicro.com>, 
	Chenglong Tang <chenglongtang@google.com>, stable@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[CC ext4]

On Fri, Mar 27, 2026 at 6:45=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Mar 25, 2026 at 02:11:31PM +0100, Amir Goldstein wrote:
> > When an overlayfs file is modified for the first time, copy up will
> > create a copy of the lower file and its parent directories in the upper
> > layer.  Since the Linux filesystem API does not enforce any particular
> > ordering on storing changes without explicit fsync(2) calls, in case
> > of a system crash, the upper file could end up with no data at all
> > (i.e. zeros), which would be an unusual outcome.  To avoid this
> > experience, overlayfs calls fsync(2) on the upper file before completin=
g
> > data copy up with rename(2) to make the copy up "atomic".
>
> Sounds good so far.
>
> > By default, overlayfs does not call fsync(2) on copied up directories,
> > so after a crash, a copied up directory could be observed in the upper
> > layer without some of its attributes.
>
> This does sound a bit scary.  How does a directory copy up work?
> mkdir + adding the copies up entries, probably with some chmod or
> chown thrown in?
>

Don't worry, there is no attempt to implement "directory content copy up"

There is only "directory inode copy up"
or in a more generic description there is:
1. "inode metadata copy up" - attributes, xattr and some fileattr
2. "inode data copy up"

Copy up of directory a is:
mkdir workdir/tmpdir
set attrs on workdir/tmpdir
fsync workdir/tmpdir (fsync =3D=3D strict)
mv workdir/tmpdir upperdir/a

Copy up of a/b/c/file is
copy up a (if needed)
copy up a/b (if needed)
copy up a/b/c (if needed)
open O_TMPFILE
write data to tmpfile
fsync tmpfile (fsync !=3D volatile)
set attr on tmpfile
fsync tmpfile (fsync =3D=3D strict)
link tmpfile to upperdir/a/b/c/file

But note that the trigger to copy up is file data or metadata modification.
Overlayfs provides no guarantee to persist the modification unless
user does fsync themselves.

Overlayfs only provides the guarantee that if the copy up is observed,
the observed data is not zeros because data is synced before the link(2).

> > - "ordered": (default)
> >     Call fsync(2) on upper file before completion of data copy up.
> >     No fsync(2) is called on directory or metadata-only copy up.
>
> "ordered" sounds like an odd name here.  It's more like lazy or

The inspiration is the journal=3Dorderded mode which provides
similar guarantee to ext4 (after the delalloc mitigation) -
no zeros observed after write+rename even without  explicit fsync.

> "nodirfsync".  And it might help to explain what this implies, which
> is that the fsync on the files in the directory also sync the
> directories out, because they are usually modified in the same
> transaction, and a traditional simple log model implies that.  That
> traditional single log model also implies that you get the metadata
> file fsync for free in that case.  I.e. if you did:

I wish to avoid a naming discussion, so this is going to be fsync=3Dauto
and documentation will elaborate on what it does.
See rephrased doc below.

>
>         for each file:
>                 sync_file_range(file, .., SYNC_FILE_RANGE_WRITE |
>                                     SYNC_FILE_RANGE_WAIT_AFTER);
>
>         fsync(dir)
>         for each file:
>                 fsync(file)

This doesn't happen but I get what you mean.

>
> at least for xfs (and probably the others) you should get the
> performance of your ordered mode with the durability guarantees
> of the strict version.
>

Honestly, we did not think that adding fsync on the parent dirs
would impact performance so much, that is why we did not
do this opt-in to begin with.

My guess is that ext4 fell from a fast commit workload to
non-fast commit workload due to this change.

If ext4 developers want to investigate, then may do so with the fsync=3Dstr=
ict
mount option. The regression report is from Google COS so...

I just want to make this ovl behavior change opt-in because I do not
want any more surprises from any other upper fs.

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
data copy up with rename(2) or link(2) to make the copy up "atomic".

By default, overlayfs does not explicitly call fsync(2) on copied up
directories or on metadata-only copy up, so it provides no guarantee to
persist the user's modification unless the user calls fsync(2).
The fsync during copy up only guarantees that if a copy up is observed
after a crash, the observed data is not zeroes or intermediate values
from the copy up staging area.

On traditional local filesystems with a single journal (e.g. ext4, xfs),
fsync on a file also persists the parent directory changes, because they
are usually modified in the same transaction, so metadata durability during
data copy up effectively comes for free.  Overlayfs further limits risk by
disallowing network filesystems as upper layer.

Overlayfs can be tuned to prefer performance or durability when storing
to the underlying upper layer.  This is controlled by the "fsync" mount
option, which supports these values:

- "auto": (default)
    Call fsync(2) on upper file before completion of data copy up.
    No explicit fsync(2) on directory or metadata-only copy up.
- "strict":
    Call fsync(2) on upper file and directories before completion of any
    copy up.
- "volatile": [*]
    Prefer performance over durability (see `Volatile mount`_)

[*] The mount option "volatile" is an alias to "fsync=3Dvolatile".
