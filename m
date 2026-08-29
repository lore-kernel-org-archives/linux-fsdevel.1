Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BD346FAE
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788015874; cv=pass; b=HhZ3ye8ASTsch6UuNoG+895LU2a+XZt47Z9+4d6ZT0FF1TofwTtHF0pRjVILK06ZetALvYlGbgkJuwYnFM0ILTblz+Wgsr6Jr0jka6VkCabJByMfbyLeyLDxtpisXBZdCWvMfGMIiHgmcECE3TPrNtu5141iiuTDLZXZUp2VeH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788015874; c=relaxed/simple;
	bh=UWm3xjClObIPYMOSfGgY93JerFiRNkq2N+PP8m2Jo2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRA+SbLIiYJ3+f6qjYYd6ZY7jdB6d1AJvXDwQI7h40nzD8SKDx+QWyDD2kPvh4iXJqQjaNLIRwAPjUamESnsYHa5FXBkRYGaEMeVEL5T2O0by15BKi8Vo1UlBxLY/y/pTpx+r3g+v2ui8G/7VL4zPMtq21IB0D2WvFSirv8JibM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8/3maGJ; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8/3maGJ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso2532006a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 08:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788015871; cv=none;
        d=google.com; s=arc-20260327;
        b=EsHH/g7UWALJXIHyUje8ERl1wBkQXobWdHUu+Rt3pLfaIQmO07gAWxFTRfzf3XGqEW
         3aTAAsb/NzPbq/Fakem5kewrchcMiASJmKrfYB5Cs34hbKO3sbFWSdoxz8cCJ9SLkSKP
         kOEQixGOZ7vTMaXsp2LX0Fh1sNgvNt4TJf4WvuLMNtcU93TBNWe6CvmwOyvOBp9tjFYb
         +l4yaAJmncXxiY84vp036ffRWn7ah15Nwe9GObH4JEYevvEbb5ENwTICwsOaLwL2ORhL
         i80jNYIAv1GhORd/8nyn1WPe+robltkQf0bH43GjgR5anNTXUzLdcUC7Bs+AwyhjmCMC
         AU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I7Zg7yhRSkpOkqt7qHxPhqcB4HapJZSFJdwwt7yRRVE=;
        fh=1RgBchr9ZOZu6jhEN0Ha51bPS0Nwq/TKkbIy0VTsDAE=;
        b=dhvOYG8DYottQYxC8bFjxo0v6qyQAvp01wxpddg5/T/AxLIL9IeUrlmNCYq2ZloOJ/
         GJua2jB+zi3ZxkNBXS4NWQb5nR1RtqD/csQa3/hSbUcUlni0OTJ4KQ5o7BPlxVAY/7D/
         1hr7I0EzaYA2jqJD4T8Qmm1bGcX7twdN2QXWquxTzDAqZ0/BfHVm7fo6mJrdmfIqMO6F
         L+EYLewMbvqg1+pdh4XNSsUrSxpUWZHRaN2dzhg+cuenVhXJ8fi+7pJy1mFxQxyt9tCW
         HjknaIuPjwHDE2k+ZrV9GDuCuiSze6IhPiW2CkweRYOanFPcFSnJu9SsijQeHcYQA2aq
         qR8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788015871; x=1788620671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I7Zg7yhRSkpOkqt7qHxPhqcB4HapJZSFJdwwt7yRRVE=;
        b=d8/3maGJ8iByZ5JbIW/1FKrEsvlyfss3qrM4PGpSI5v/LvIStwW25Dm6EUOofawQwq
         bNDaOUn6K0eaYcsWQ00FxtBoz2zV9jlVNoXjDuho424tzBe8+b1rC1ClaSy0pxVaMsUa
         HQpbpTpDFzupPqATQCcopFrxlodm2Zv74mh4GhXcRHg7nFTKeOMagzmTffIDcqSx8mI5
         MfV27HmwbKH4Twnc7T2+/pvMKKHZisZp80giCKV+jrZ4LY+4yD3ovRBQbfnsqO7X++hn
         glREbL/hZsg0fmogQN+cQrdJgdEvl1EkUeM/hloj+kN7HFcquDFppjV3gG6czctKtgZ4
         E6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788015871; x=1788620671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I7Zg7yhRSkpOkqt7qHxPhqcB4HapJZSFJdwwt7yRRVE=;
        b=lYBC6LIIzNRlEpim68ugSkrr7zmv8PvxUV1rQW1xW92jnqhttx+jZEiqvtqK2VMnh2
         r6+9fadfz3x1kT928sMfgE3e1pE6+FHUv7vGN9llmnHGKExDlQCJYI21/xLZd+30u0yo
         syoSxzQX6iPMGr5jxcRl3G7dFvDyn3B/vnbcFualOSAjSZzqAmOfsNTTl3Zs3mlgyHQu
         8E50BucUQ6naO1XEb7HPJVNb//JWTqachszYLqur7DPLIAkZZ5aXx8zYKRAwQ5DE/E3l
         yYTuM8WDkCmYWrnfA8AURlbgB4z60fsWJSyx2etY7GwDSzumJApQ88ovcSUBL4qH276Q
         JL1w==
X-Forwarded-Encrypted: i=1; AKwUvBxAYlJV8Y7wNik6wDcf+x0R5d+YM4vjgNDAv+tqx466Fz6zQMJn3zBTUP4iWkZNF909A+qEI3h80PFYkn23@vger.kernel.org
X-Gm-Message-State: AFuF++l0a2mJ7p5TL6HQmeg48MirmSLvOGAPOd8gaMBt7lgVRV1Vmyux
	/a7Y9ZtAB6IqgHm2IamHX6cwDA9c9H03cW9H5J2DyO0Eo3Rsg9VrKeRoJqeuaGbfieQwDTHocUz
	8GvactixULZnm5ubniNxcjrIEtRhMUm0=
X-Gm-Gg: AYBFou27CFJywLNr2cR1AjZ65vhHHISx86DmuJ3uolVIrW/3ORmTOzXBZkynLxwyfRR
	e45fbAER8tabdACQw26vdwkRpS/8Kde9HpVsw7V4AUga/lCdKJgMZWeafUC1JxBaMH5otXyGlSu
	p2Aha32P0yOu9kVNVvnotS1IVdhVq/8vUhVkyhV7i/8W6oyTs72BujIWg5tHlT2QoRmrLY6wOb+
	kEKqZPmGW1whwM3TfyWf0TmPM11Khl65nfRdaUklh0YlHV0ldinxohBVhLQUWo444bYL/n+Dw9l
	qzjdJdssXKWintS6pa+dB2OAzpHJNbRRSxUFFmhMtXh5jw==
X-Received: by 2002:a05:6402:20d5:20b0:6a6:1bfa:90f5 with SMTP id
 4fb4d7f45d1cf-6a61bfa9284mr4898179a12.4.1788015870965; Sat, 29 Aug 2026
 08:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827045007.3831259-1-4ncienth@gmail.com> <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com> <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
 <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com> <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd>
In-Reply-To: <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 29 Aug 2026 17:04:19 +0200
X-Gm-Features: AcwNN1URiFh1xX88KrhxjDd0GnRbkhAoFiuICMBldX0tePYCcvFHRr6K3D5713Y
Message-ID: <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
To: Jan Kara <jack@suse.cz>
Cc: Daehyeon Ko <4ncienth@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 7:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 28-08-26 12:18:52, Amir Goldstein wrote:
> > On Fri, Aug 28, 2026 at 11:05=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > On Fri 28-08-26 13:24:19, Daehyeon Ko wrote:
> > > > You are right that an fd-held dentry cannot satisfy the count =3D=
=3D 1 check. I
> > > > was imprecise in the report: the fd and the final unlink refer to t=
wo
> > > > different hard-link dentries for the same inode.
> > > >
> > > > The setup is:
> > > >
> > > >   1. create A/x and link it as B/y;
> > > >   2. open B/y, add the old-group inode mark through that fd, then u=
nlink
> > > >      B/y, leaving i_nlink =3D=3D 1 while the fd retains the B/y den=
try;
> > > >   3. race these two calls:
> > > >
> > > >        unlink("A/x")
> > > >
> > > >        fanotify_mark(racer_group, FAN_MARK_ADD, FAN_MODIFY,
> > > >                      victim_fd, NULL)
> > > >
> > > >      where victim_fd still refers to the already unlinked B/y dentr=
y.
> > > >
> > > > So the A/x dentry checked by d_delete() is not held by the fd and c=
an have
> > > > d_lockref.count =3D=3D 1. Its unlink drops the inode's last link an=
d reaches
> > > > dentry_unlink_inode() -> fsnotify_inoderemove(). At the same time,
> > > > fanotify_find_path() gets the same inode through the fd-held B/y de=
ntry and
> > > > adds the racer mark.
> > >
> > > Thanks for explanation of the reproducer. Now it makes sense. The
> > > conclusion from this is that fsnotify_inoderemove() can indeed be cal=
led
> > > for still fully alive open inodes which should be (think of permissio=
n /
> > > pre-content events) still generating events. That could be actually
> > > breaking some assumptions of userspace although I don't think it's a
> > > serious issue in practice because users of permission / pre-content w=
atches
> > > tend to use filesystem / mount watches.
> > >
> > > Also I think we could generate FS_DELETE_SELF twice for the inode - o=
nce it
> > > will we generated as a result of d_delete("A/x"), and finish_dput() -=
>
> > > dentry_kill() -> dentry_unlink_inode() will generate it for the secon=
d time
> > > on the last close of the open through "B/y". That should be mostly ha=
rmless
> > > but still it's an oddity to keep in mind and preferably avoid if we c=
an.
> >
> > I don't know. This sounds like a fundamental behavior change.
> > In current upstream FAN_DELETE_SELF is a dying breath of an
> > inode and no more events on this inode are expected IIUC.
> >
> > Applications could be relying on this.
> > In fact I have an application that almost relies on this, but IIRC
> > it does one last open_by_handle_at() to make sure before calling
> > the inode dead. Other applications could be less strict.
> >
> > Changing behavior so events could happen after FAN_DELETE_SELF
> > sounds risky.
>
> I was probably imprecise with my wording. What I meant is that *currently=
*
> when you have a hardlinked inode, you open and unlink through B/y and the=
n
> the unlink though A/x races with close of the B/y file, then you could ge=
t
> two FAN_DELETE_SELF events if the race works out right. The only change o=
f
> behavior I was planning was avoiding this race if possible :).
>

Sorry I misread.

> > > Now there's the question about the best fix for the problem. I've rea=
lized
> > > we cannot just remove the call to fsnotify_inode_delete() from the pl=
ace
> > > where fsnotify_inoderemove() is called (and rely on the call from
> > > __destroy_inode()) because the connector holds inode reference and so
> > > __destroy_inode() would never get called. Hrm, this is a hairy issue =
and so
> > > far I don't see a good place to reliably trigger detaching of connect=
or
> > > from the inode. One reliable place would be iput() but that's really =
ugly
> > > and would slow down every iput() user. The cleanest solution I can
> > > currently see is to stop holding inode reference from a connector as =
I've
> > > proposed in the past. Then we can reliably perform the cleanup in
> > > __destroy_inode(). But that will be a rather non-trivial undertaking.=
 Amir,
> > > do you see some other option?
> >
> > What about the option I proposed to live with the orphan marks
> > Is it so bad? I mean it's confusing and removing the assertion could
> > hide real bugs/races, but maybe it's worth not complicating the code
> > until we move forward to re-attachable marks.
>
> I'm not so much worried about the case when placing of the mark races wit=
h
> unlink. There I agree we can somehow paper over the problem for now. What
> I'm more worried about is the case where someone places a precontent /
> permission mark on the inode and a malicious user does hardlink + open +
> unlink trick and after unlinking the original link to the inode, he has a=
n
> open fd to the inode stripped of any notification marks which I'd say
> violates the promise of precontent / permission marks.

I see. so we need a point where there are no more hardlinks and no more
dentry aliases to the inode.

How about we check for this condition?

Am I missing something?

Thanks,
Amir.

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -471,7 +471,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
        raw_write_seqcount_end(&dentry->d_seq);
        spin_unlock(&dentry->d_lock);
        spin_unlock(&inode->i_lock);
-       if (!inode->i_nlink)
+       if (!inode->i_nlink && hlist_empty(&inode->i_dentry))
                fsnotify_inoderemove(inode);
        if (dentry->d_op && dentry->d_op->d_iput)
                dentry->d_op->d_iput(dentry, inode);
