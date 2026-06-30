Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B3407CF0
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816979; cv=pass; b=PlXgX7skuveMS6Gktzmdoh9vcAlNiSCpoCAyv7Sgxxy2UoBlg2FJWOwqWLwfwL3B2W0B52+ymSUAmdhZ7+qt3TNsuQHGXao4Ki46ihZifpyGSjzEiSnbHwj/wsRFkVzrZuSo508WRdxU6oVcBEWg5gPsl20EKrBSXRHz0YurFW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816979; c=relaxed/simple;
	bh=Orc7+0NqtvmGA5vexJkJx3paGEv0TuaCQx2/aawkYMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O46sHCw5CmejoJrAyDrEEI73IZAN6wokojpMn/6JEF0zI80d5A9lIzQMIbCqrH0rnk9bI0bQeLDZEoFOTJdf3U1UPipAa2N9x541jgh/45K2ZyjwpuWyQn/8xd5tOs37RLi7rd2Xiipi4AWL1CrAi/ZVilHoq1rd9YBNf+HlcMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSJQnwGS; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSJQnwGS"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so7467504a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 03:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782816973; cv=none;
        d=google.com; s=arc-20260327;
        b=jkS1/M1YLdYln35l3KCkLUn5iAYjreWtKWXeOt8ToPxBRsdiUdFdcdifa0VVXY3oug
         eFQUGXfvwfn9LJe7T07z7hBnRcw/qmZKmmuuoCJ0Sd5+iO5YhnalTyrXls0S4j37frfj
         7Qp9aSVFBi3kAJWi260MZv62gaOG63nKgYbWz587Ce0devxkNhJx3FuwN/+Gsz5zzh0A
         MBFqMaggnEAivwEVDjah6BKEXMPeC0eb08O6B5iUSkdf2r/5ziCzy1tdjFWRrxPK8cn7
         +FKDNOSpGMHf3pIW9KfAyQxb6AkJ6nLK32F2eB79W0D3nMqKos96mZtpYDUfAEVJyBLv
         SgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p0A4syWLh4jWZqK6Nlb5P1GnOuC5t+TuDmqTBq/uuSo=;
        fh=G79Bvxl2/DA6PeN7G1iXDlcMOTlZqV7MaC4zMlUSMRY=;
        b=SPk+3NCFZqaa01o6Bnfn6jMLJ29g9igrlXjK2eKzVP6DVL0MGrNXciiTsZtn8lsY5/
         FOlPV83vuyECHLUmCJw2d0Yf+wd8DZIXO2am6tvQzP+uq8G8BIOcEZGjCP2342JEayoB
         FVBoX1PyVqCU16z4MDqAD/E7bN54MzEdeqfdlg4Xzx977tJeX0U+0wuCgcgCN961aKYA
         lr1OAHXeNnN9KSJBwMfVMfMra4z0WAe8ul+hkmTQR4ymZQ0WJw4Ok7LTRhIpEcWai4yU
         WFJbspjH5KMJDF+Vi6a1zjdPRnnlIuxSi1vHhpO4CzJD2YCy7yYoYdklYoMfzNOjybER
         f//Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782816973; x=1783421773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0A4syWLh4jWZqK6Nlb5P1GnOuC5t+TuDmqTBq/uuSo=;
        b=DSJQnwGS0ZuZWFsBUSJ55ryVDr7IBWBum0gRHOr3dr+efvMYrKz/ZyM3P9onhRZKua
         6nC3VH6UFjVCitUlXogqVEKbnr+C50LNbGvSyh3cyXMdh5qcAyx7s1v/JY4L5SqZj9D6
         4sWuYSCXnmq3ngFrnPiG0W1psqR44azq1fBIh/4Vir/X3xXlwuIvBCu51B5j59thHJbG
         9c4IcOk8PO+qGHzBhqMjVg0yvoDnvp4rJDRkWb7/EFjr43CZBHU6z41j1vz/oj8d8cGn
         iisZuPMyV+CeF1VcTywbt48Hym7ibK4Po9LwkaLgR+qiCHeB2FCSVzCFYmG9niYOYbrR
         uYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782816973; x=1783421773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p0A4syWLh4jWZqK6Nlb5P1GnOuC5t+TuDmqTBq/uuSo=;
        b=CGUj9pgcH+EWdxqnJOwlqANL5BwwdYsuvG5fO1wl8rKKrYNJ2EA6es5QWm5S4tVVkN
         dM2j0m5dkmlXWiQgxzvwYenoMnBOHUu0aMqpfHUoi5pIfQtZuXIzEV9F6Tm/9cp891fs
         Agg8oetLke7naHUKCE5mcobuS0UCeUb80fDL6/ekO/TgPrVbZRfcwZBzocg7FvEv46w2
         6646ms+3yaw6GmYquB7pEg19MdeA0RpJTnfxdBPxiFT2A9j6noQr+eFxEf6uNRUqK+nV
         cz5C1TUFfH9+dhXbMopn7+wlyO0qCmmMkCyt/XxVoyi0xNNrYh9R948SYYWslyBcX/za
         HEmA==
X-Forwarded-Encrypted: i=1; AHgh+RooRrOdHuNQj6mMqkpBv7xLEtkYWD28P/cL8xNA7e6p1N/h4mzBTYLG0iHDSdPJ17REOYwyw2PodLZf2tFx@vger.kernel.org
X-Gm-Message-State: AOJu0YyKZ+ZZ7MmJeuW4VAMDtCGiftzXQsAobbpiwYI83vHfDjyDJJYz
	t32IumkdJy2aC8Nontt49O/RZB+O2Gv/zCtBgJSD8ACirVmFqiWsRnVyVg9PouhLTxSVjAE/QJ3
	Az5ghAsK4sgU6jGL/CGU+ANailkU9r70=
X-Gm-Gg: AfdE7cnHMN1EduqW53GcSrCEwFfHbCvE/gvwfszo+iymvGdzX3nb8ppK9t9CSNkrmMZ
	qONCVBW40OS6wyAQ8Mib9GUGY8pQh4tXyehZLcbG97KIcXQ/YrVHOdLvkX4wt+5FZHEihss1yp2
	1yqD9lPaQDk7+g/5fbDeYTDfXPCeBltLKrQk/t0yZ7Q9o89y0HjK4dqCpDtxCewbBn/Z/qpNBXX
	Xmf4Iab8X9t5h1YHqNaSujdAdbwAh6sWVpSPMaS06Y94dHPXq7u4n9PxNt6Pp6+ojIhpRh/wdf0
	ygjws/1NjVvxhUkdcvNpDRIUdP/fyfA=
X-Received: by 2002:a05:6402:5487:b0:698:bbe:9c8 with SMTP id
 4fb4d7f45d1cf-69879de69bamr1227728a12.15.1782816972468; Tue, 30 Jun 2026
 03:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623111533.2285005-1-ptikhomirov@virtuozzo.com>
 <20260623111533.2285005-2-ptikhomirov@virtuozzo.com> <ajqOyIA8tPQsxfz6@cmpxchg.org>
 <3f6392aa-c1f6-4263-8892-978dacbbd8ca@virtuozzo.com> <CAOQ4uxhras5YAr8_HBpuHSDwvfiEF8vAr0NDB0R_PXtGDhnqjQ@mail.gmail.com>
 <20260625-lehrbuch-gehalt-wichen-1b2f3533efbe@brauner> <CAOQ4uxiNrEZ8rsRc11mdjkMWe3dfThE0DJ2vXuO0yiNemnpR6A@mail.gmail.com>
 <20260630-tierisch-ehrbaren-errichten-bed402a0a26c@brauner>
In-Reply-To: <20260630-tierisch-ehrbaren-errichten-bed402a0a26c@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Jun 2026 12:56:00 +0200
X-Gm-Features: AVVi8Cce_xT1IqdadZbbNXWS9V0ahfJfi6147JUNn_XGlol1jGtfRLAq44glwps
Message-ID: <CAOQ4uxhN_K23C359OLpF9mTe8-90qBvKS+dTwf5+WVvxr-0Jsw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs, mm: add ->cachestat() file operation
To: Christian Brauner <brauner@kernel.org>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Shuah Khan <shuah@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 9:55=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On 2026-06-26 17:18 +0200, Amir Goldstein wrote:
> > On Thu, Jun 25, 2026 at 12:36=E2=80=AFPM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > On 2026-06-23 17:34:47+02:00, Amir Goldstein wrote:
> > > > On Tue, Jun 23, 2026 at 4:55=E2=80=AFPM Pavel Tikhomirov
> > > > <ptikhomirov@virtuozzo.com> wrote:
> > > >
> > > > > On 6/23/26 15:48, Johannes Weiner wrote:
> > > > >
> > > > > Yes, AFAIU in overlay when we use realfile we should always use i=
t
> > > > > with_ovl_creds(), even though I don't think there is anything cre=
d related
> > > > > in filemap_cachestat(), I still think we should follow the common=
 pattern
> > > > > other overlay helpers use (similar to ovl_fadvise() and ovl_flush=
()).
> > > > >
> > > > > note: Actually some places get ovl_real_file() and use it without
> > > > > with_ovl_creds(), e.g.: ovl_read_iter, ovl_write_iter, ovl_splice=
_read,
> > > > > ovl_splice_write. But those look more of an exception than the ge=
neral
> > > > > rule. All other instances use with_ovl_creds().
> > > >
> > > > Use with_ovl_creds() is a good practice to keep the mental security=
 model,
> > > > but it is useless if the security check (can_do_cachestat) is not i=
n the
> > > > vfs helper (vfs_cachestat), so please move it there.
> > > >
> > > > Also it kind of makes more sense to check (flags !=3D 0) in sys_cac=
hestats
> > > > before checking permissions.
> > > >
> > > > > Also there are simingly no other file_operations which return "re=
alfile"
> > > > > for further processing, mostly the operation from fsops simply re=
places
> > > > > general operation with its own logic completely.
> > > > >
> > > > > Thanks for your review!
> > > > >
> > > > > ps: Hope overlay maintainers will correctly if I'm getting this w=
rong.
> > > >
> > > > I don't think this is wrong per-se, except for can_do_cachestat().
> > > >
> > > > Just be aware that the real file could change from one cachestat
> > > > call to the next (i.e. due to copy up).
> > >
> > > I'm really grump about adding a new file operation just for a
> > > special-sauce system call which is under a CONFIG_* option even. We'r=
e
> > > not going to set the precedent of piling on custom file operations fo=
r a
> > > single filesystem everytime someone adds a new system call unless
> > > absolutely necessary.
> >
> > I had a similar reaction.
> >
> > > This looks like it could just use a new helper in
> > > fs/backing_file.c that the cachestat thing can call to use the correc=
t
> > > file.
> > >
> >
> > I was considering suggesting this as well.
> > Having f_real_file() complement
> >
> > but technically, can_do_cachestat() should be checked against
> > the overlayfs file/inode AND also against the real file/inode with
> > ovl_creds.
> >
> > I'd love to be able to provide a backing_file "template" for
> > operations, but I don't have a good idea how to do that.
> > Do you?
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index c68b8c0a4097..d93059d53e88 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -57,6 +57,8 @@ struct backing_file {
>  #ifdef CONFIG_SECURITY
>         void *security;
>  #endif
> +       unsigned int flags;
> +       struct cred *backing_cred;
>  };
>
>  diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 27cc07738f33..64e07ebc43b0 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -50,6 +50,12 @@ static struct file *ovl_open_realfile(const struct fil=
e *file,
>
>                         realfile =3D backing_file_open(file,
>                                                      flags, realpath, cur=
rent_cred());
> +
> +                       // Raises ->flags |=3D BACKING_FILE_CREDS and set=
s ->creds to ->backing_cred.
> +                       backing_file_set_creds(file, ovl_creds(file_inode=
(file)->i_sb));
> +                       // Now add a helper that performs permission chec=
ks on
> +                       // both creds for that cachestat() thing and retu=
rns
> +                       // the actual file to operate on.
>                 }
>         }
>
> something like that?
>

Confused.
It seems strange to have backing_cred in this scope.
I would expect having user_cred same as user_path.
backing_file gets you from the real file to properties of the "user"
facing file.

The cachestat() syscall has a reference to the user facing file not to
the real file.
The helper would need something like f_real_file() to get to real file
from user facing file.

Anyway I am not seeing the big picture clearly how this could turn to
be nice code.
Maybe lack of imagination on my part.

Thanks,
Amir.
