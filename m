Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB363E123F
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912348; cv=pass; b=kncg8g7ixangphQu3i8ZHcBcPir97sfRUcgYfDfZ1SBhMYUhSiHRA5uVEpxUP3hqRFX2Iz89cy8wDTI6H+1EUJeW9gRoL7V8v7eGmgJBp3SloJqeTRMvWcXIInIxEBiOHujgsWU6xo1MYrkGVsDxeDCuqQQnxBk2Y5ccKt/BLhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912348; c=relaxed/simple;
	bh=xPSovF27zR1ygx9YQZCEuX/Hht8b3O0ju3f9ZTUK1G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=istk5cF+artIDlS7UhtTO+mtXcrOhbo0CzQ9o69W5t9MpoBoR2S2lANZad8w8kdA/oodnapXNtFdel7aGx3RywOmmbC4sYIT5wpGh6+5VaIUvR/xQBJaB6B54MtFm350+QN3yIQPSevp/gadohYLGkrxE5Q78z9e5UnzhIwPkYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pppTIpyL; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pppTIpyL"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a61910369bso173702a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 03:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787912345; cv=none;
        d=google.com; s=arc-20260327;
        b=fzsqPCQB7Xc3pVEqorzcULAnHBrFBrNZVZrXlMtyVdcNzjBeqxgEkP4w5Jn9kZZB56
         qEcZ4jhn7p5QCS5m4kteIzDj9NByWIx4RNyLXLE8ixuEPrDsBY+TrGG12lyZyvOCRZI5
         0HBq8wihuwEWhZ/w7HaHg3wRPLj/x1sjx9mzuzPiQrmWg45+XXN3hX6x4sSghnXP69Vs
         LOnAj1bNdnqAn9XKGXph859rq4Yp2etF/LSLea79lIjYyvamYMtSYr3sk5158Y/Tmtme
         DCqj250lsWtlrQOA8MBDxiQhiOHdDVWi+Qb0RUIas566dfknLqiuey5YWPU9jZ0b3le3
         gqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G94/g0rpxrLTiPX43qTFT7KbB2uJFdvGtG9HayUlus0=;
        fh=z4lT8J+vWio1wGmjD+py3YiICF4lzweD09E+PByry8c=;
        b=GKnYZ8Yh+UFXkt92kGw8k4WUoSbo/lf8RlyvUNswH9rKwfrBo7F8Dd+HTrGomvYsHD
         XWJ/4jz9iyjKCgXL5bHbFtiTlWa/vdPGuASwMgyZbf56EjoNCpodc8t/pkLAhVTTzzHK
         M5O0x4T2zzhMcPSiyaIowwDdXVEHw5yb7SLty08VXyxxgsyCwgxLvLkoV7D4YArRn79M
         KKvkOq6f0SVZ/0xKG/Z67qvs3yd8SyV4b2NveTZYscs/2UqnFUsRSNxBeiF+TJAE18cl
         nlWIcgnIQTBhs10iT5r7zRKDSNVLFY1kPXqBdQdCSaSYOP8VHZPFKTCRPdJ1QgWMASax
         susg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787912345; x=1788517145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G94/g0rpxrLTiPX43qTFT7KbB2uJFdvGtG9HayUlus0=;
        b=pppTIpyL19ki0ekal1ycwimN1FzZpAFQgD/wPg6MjPrvKOLrYUqRlDH1zSk14oA6Vt
         +kxBMmRUNCnuyIH1HVLtxl+UJpEu5pm+RNRceC8++SLhvzKl0L6ccq4Z4lvMv5JbwPBV
         66eblMAjpEMMSOv2BWz7ZzYyDiajSS6puXLbnwH1oe2cC+GjVcIm5arFg8YjJJf8kCkD
         fZkkK4vtk3psmVpXgCmM9DWXw6EE31Dz+jxNaQru1BsTs/0k3GywfspMGMBR9OxBK8ee
         Oc2TuMUNrSFGluU6o2dzaMhtrgLj1wkX/WYNsTcX6RB2qmSavCJOdU8CubPxNtFd877b
         ijnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787912345; x=1788517145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G94/g0rpxrLTiPX43qTFT7KbB2uJFdvGtG9HayUlus0=;
        b=f3Pl40PfJjYSTR56F4qxpXLrEZNj4/sNX8bnsLNP875ILddEIt73cVDO7ImehnyFnp
         41RyMCiN3Ii64UeKNipp4kd955GC7OB7KLxZyvJP3nzusYW9pfCnNZp93pDCcxg44X8U
         UAVIowxRjVRNqu6NdG4SE4o6TIBxIgiDaPzqGLjPhQYib5560V20rjUBpH56VXHdy87n
         UsVONkVfCkj55TfZ4A6DMxyJ5LiSbNp0Dft3S5wIOX+SBSP5P0fr+yfn21tBdaxDZFnS
         OCiUB6fnfkax/WUd/SytCXzkSn1H+pqMdTfHgEShpXK7CZdeTM31oTf8mGSNHjGKz3LJ
         FStw==
X-Forwarded-Encrypted: i=1; AHgh+RpOxb/5MTZo6z2TWC3fJL77Sy/yqs2R7uEGEaF/O24fMc7vjX/q+bbv5GkE4zyEYQoOFKzBu+lL55ANzSSZ@vger.kernel.org
X-Gm-Message-State: AFuF++kZb+4XvbTk6d9JEFNOhdXSMm0Zs1CKCZtQlBvbRaIS1XxYIzr6
	JaByuGmzZ187DF+R1cNrbQfyLX/vAbzteg8+OWbFFaLZ7c2IfVz9ZlzfsX3fVKDBNlSRV2z2Nmf
	Vl3msx328Ion6iTkmyePikBJxYUwsDld7YAK4GmA=
X-Gm-Gg: AR+sD1053YnOWhMXkec03jjhqGQP7UbyFn1F32AT9yxEQV5m6aSzKJa5c9KjV5CEzs7
	ACqto/1A+CPJdECWlWyUQfDkfdUAI6C/RfrdVizNOgXQvTwzYyVcvb/lvjmr8S+b/tXTx2Yrw0O
	6Vaw1cyy1moIr0M62z+P/Jf7RZWNV0ZSohJK0hwa+pVTjWDZm3EkE2Ao4tYu7FIeUg5YFxhuCdl
	mFMEGEVdIqQ+hA+P3RPN9IvNoFh3f06YPZtXpN27hfEvIaM9P3uto8wGolDlC/j8vdqlRjLClD7
	ITf0f2CrAoViKKGwgeiHbM3CY2OMN7El3+dXf8ovsLG0cA==
X-Received: by 2002:a05:6402:a214:20b0:6a6:1c0b:72cd with SMTP id
 4fb4d7f45d1cf-6a61c0b73b1mr124271a12.13.1787912345042; Fri, 28 Aug 2026
 03:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827045007.3831259-1-4ncienth@gmail.com> <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com> <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
In-Reply-To: <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 28 Aug 2026 12:18:52 +0200
X-Gm-Features: AcwNN1Wswmvr4jf3jw-aoY5R0HAHlqDLIpRVY4i-uiy8R8EZM3DFgLb4bzUry_k
Message-ID: <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
To: Jan Kara <jack@suse.cz>
Cc: Daehyeon Ko <4ncienth@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 11:05=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> On Fri 28-08-26 13:24:19, Daehyeon Ko wrote:
> > You are right that an fd-held dentry cannot satisfy the count =3D=3D 1 =
check. I
> > was imprecise in the report: the fd and the final unlink refer to two
> > different hard-link dentries for the same inode.
> >
> > The setup is:
> >
> >   1. create A/x and link it as B/y;
> >   2. open B/y, add the old-group inode mark through that fd, then unlin=
k
> >      B/y, leaving i_nlink =3D=3D 1 while the fd retains the B/y dentry;
> >   3. race these two calls:
> >
> >        unlink("A/x")
> >
> >        fanotify_mark(racer_group, FAN_MARK_ADD, FAN_MODIFY,
> >                      victim_fd, NULL)
> >
> >      where victim_fd still refers to the already unlinked B/y dentry.
> >
> > So the A/x dentry checked by d_delete() is not held by the fd and can h=
ave
> > d_lockref.count =3D=3D 1. Its unlink drops the inode's last link and re=
aches
> > dentry_unlink_inode() -> fsnotify_inoderemove(). At the same time,
> > fanotify_find_path() gets the same inode through the fd-held B/y dentry=
 and
> > adds the racer mark.
>
> Thanks for explanation of the reproducer. Now it makes sense. The
> conclusion from this is that fsnotify_inoderemove() can indeed be called
> for still fully alive open inodes which should be (think of permission /
> pre-content events) still generating events. That could be actually
> breaking some assumptions of userspace although I don't think it's a
> serious issue in practice because users of permission / pre-content watch=
es
> tend to use filesystem / mount watches.
>
> Also I think we could generate FS_DELETE_SELF twice for the inode - once =
it
> will we generated as a result of d_delete("A/x"), and finish_dput() ->
> dentry_kill() -> dentry_unlink_inode() will generate it for the second ti=
me
> on the last close of the open through "B/y". That should be mostly harmle=
ss
> but still it's an oddity to keep in mind and preferably avoid if we can.
>

I don't know. This sounds like a fundamental behavior change.
In current upstream FAN_DELETE_SELF is a dying breath of an
inode and no more events on this inode are expected IIUC.

Applications could be relying on this.
In fact I have an application that almost relies on this, but IIRC
it does one last open_by_handle_at() to make sure before calling
the inode dead. Other applications could be less strict.

Changing behavior so events could happen after FAN_DELETE_SELF
sounds risky.

> Now there's the question about the best fix for the problem. I've realize=
d
> we cannot just remove the call to fsnotify_inode_delete() from the place
> where fsnotify_inoderemove() is called (and rely on the call from
> __destroy_inode()) because the connector holds inode reference and so
> __destroy_inode() would never get called. Hrm, this is a hairy issue and =
so
> far I don't see a good place to reliably trigger detaching of connector
> from the inode. One reliable place would be iput() but that's really ugly
> and would slow down every iput() user. The cleanest solution I can
> currently see is to stop holding inode reference from a connector as I've
> proposed in the past. Then we can reliably perform the cleanup in
> __destroy_inode(). But that will be a rather non-trivial undertaking. Ami=
r,
> do you see some other option?
>

What about the option I proposed to live with the orphan marks
Is it so bad? I mean it's confusing and removing the assertion could
hide real bugs/races, but maybe it's worth not complicating the code
until we move forward to re-attachable marks.

One way to think about it is that if we do the re-attachable marks,
we would need to store ino/st_dev and maybe fid in the mark and
then show_fdinfo wont need to get the inode reference at all.

So in a way, allowing an orphan mark on the connector is a step in
the direction of allowing re-attachable marks on the connector.

Maybe...

Thanks,
Amir.
