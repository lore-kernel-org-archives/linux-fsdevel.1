Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10306446855
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515866; cv=pass; b=H9CuGCr4cKo7d5Gj4jI4V67ONaJV7jFlxG54IbcEYkSuS2Jt/SlNh7vqh+ypM49gGr08FiNr6KkrT+CFFzV2rt5IzdGg3N692gfmFYkD2DzKokHX6xDPdOb5fcgINTP1OSuCfh+Q/s6inA5mm0HWyfo1O6tVmNGgvpV+5pM+hRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515866; c=relaxed/simple;
	bh=6WmWFr9BY8WHDH5HOaS9iTFTd4EmRtRdp6fMjyF+1mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awuEF1HdZW+FvtKZFl4HplC7ug6LTHvxHn5uyFHR43YYN0N0DYADGlXTEpE0XRrOGGjc536XW9PA1Hhot/TI3ZXLRAtEnSbpiWSK6hHdSo/HPYBawmrQzZts0utw6FPsda//27J6Yh9aNPDsanKHpYoGDqDsnAMQwRGbQ2/clhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p34yhGnZ; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p34yhGnZ"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f48c750afcso724409a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 02:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788515863; cv=none;
        d=google.com; s=arc-20260327;
        b=DJkgYx9bDvYtSSKN49fwkn0DfMg+IOJHA0a+YuP7ResUrFE7YgHla8JDSinaizAGAp
         2fCRaVKGQH2+AD1FcvD5vcpT+pJy34RFGibbCAUl9wQ7Y/qKbfuKxuTPajda7+QikAj6
         x7r3z6TXzrEwEN124hIsNnPqKzERWmF7AzkqMYMt0bMnCxKJiFZdnGzIIP5Y0B4ZGdNO
         9muhpIIXkvozLWHKfWjbPZ+rY3g0QC0cOKTLRxAQnYackt8FRpmH+m8UHetYOxZHLIAu
         h1O+Uz7bkqi4R94/i+Zx2unjcEvzza9ilgjKLrOfj59Mr8IT7WR58N5GbDnImUm9ws5Q
         kjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3pmQAxfFHxZRfYhLuLaVrq3tjXnncmJuNgkRzDwbSwk=;
        fh=g6RrWsm70O4lzHdi61dV1gQn/JroY3Rq5RtJFKsDQYA=;
        b=ByvXWYf5akwZ3axzETetNc3BCG1hxuuYt8NC6QZDjgwnau9mPdl8/sbtwzWbflCSEy
         H5TNQx+iSqqI3NfYaWmJtDxcAJKNlvbJuTitNBUpYIEnJMNVOcmBCWCFYTE1K+qVdI85
         CuAYM4weG8lC78XXuFjpk6dHOSXxgJnuouiAyE3MQJIqP05HDmZKyA8lvjeNNDYIfE1n
         Esr1k00h5L2o4PhSUposzFRRERtX6Co6vp3ndAACeA0H0te27NmktRxZH7rabxDFW9ya
         fpNIIucc9x+V2s+sOUMeZ4zAxdpynm9h/wJdJag7ivD1onD1AVbX7qAyIi5rycUqA93R
         AaLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788515863; x=1789120663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3pmQAxfFHxZRfYhLuLaVrq3tjXnncmJuNgkRzDwbSwk=;
        b=p34yhGnZVz8zMYlY8wulQUE91x2tam8kGrjhqaIwbqLp6Z/RuyPDqnER0vqTTmlYVq
         3BvTZX3KBOJLJAX+8EGkrBhgtRoDPO23k65T+0fBX4vI207R12ZHwdNIkC4vB9iZVzn4
         bI3nZF0hA+OFaNULTutflrZ1uOjJkXIiMHbPDWj+Hwg8UKtsdCqUkJoa9+/08m7C0e/y
         qOaNDmgxASD2bQVX7TMvV5L464sncRHDZU1R3WlgkFo7czqNoHoJXew0DNfXMMvhLtV6
         aIuhMJGf+85TkA6ByjGdLzwwrLcT1mXrxEciHf3N98eKNvWV94eksVFqFirnZ1Uv9jWB
         kbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515863; x=1789120663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pmQAxfFHxZRfYhLuLaVrq3tjXnncmJuNgkRzDwbSwk=;
        b=oJ3VxqWGNq+T01IN93dZBetNzN4hohEs1ElfLn2jNK3mUFvWrnDLnllP3g03JYZQlj
         IOb1KuseJggBPJ/1H0NDUjlVXhI1fpC4RRe4DZK7EfWxPfqtAfJPtCluPYnHTB6cKDHl
         StPokUsuMB1KKu5omuRDUtmF+vfq2ODZ7V+5Sh1XcwaIzzLeQI98f6Ekg/h0EVGUUb5b
         10u870aBakNmQqSWuWzu2lR8EVxIINiHZRHH8sv9CiSKpdjTO51Sat7vkxHCU1zbNiyT
         Q1MbPs5toagOX0ab+uU7b6Yvp3Bit9nJVKrhmkx5rCE6cWtWvb/RoVvJSc049Gmdt1En
         IYkg==
X-Forwarded-Encrypted: i=1; AKwUvBxkEUaoe450fEErLBSyh3keMvnQoyUvLujKNsf2IU2wMuJlZRX07/Mtt/D+19sI8zL2VgRvcTobGZtiHqCw@vger.kernel.org
X-Gm-Message-State: AFuF++nRxsXmYCMtA+I/PGMdjDjFu8eSc1GcRITSm5S1KHxH/lx7yXl7
	1XXe+HJsjpQyEi8SYnsNotyIpUGicPAlv+Cj9qa+ya3lqx1GCEAtL/6vZxxRYbE13JeG/GsT/Fh
	xAmGDQHq+XMz9g8hGTjIy14cIuJuDOhPIkb5c0FN7
X-Gm-Gg: AYBFou2iENdxKNtSeFMJAbCSLzRD/yHtLg3AW5z2ZFwoYLU0D070GdV2yE3ReNRIE2L
	pAalnpq4/F2gKNGRW1yfIxSQQ7/W6uIiUBpUVitGgZWlYxjCyP9rJLw9KCelck6NehuGox4891G
	IFzZ3+KHvK9OjZCPSXQe34M0L3PWqPSoBp8NtvE+wjPzpJXvmNB5MuTcfzrfIr2qJXC/+bQBm03
	FFtb9gXwDOMQhN0YGOP0Zdt3hfk8niKKYrEwoKAHi+eUGVJ6rjU6etuaD/2V+TyZ0lXtGtYmGMi
	eH3YeCZcX0/YW3+IkbLwWW9gcgsx03Oj7jqdR+hJkW9AlLrTRJfTr7+TWZHHhCiEnR5W06n0DAT
	eLPfUFU2Zo+hCtyzsyB2Y9Shb/gg6nBJsTHD3EB6iWokWG1cbxCShxwcpMl/cUWhErPAlLFd1yO
	oXI8oUgFfBdjvqHoDw6iiizDCf
X-Received: by 2002:a05:6820:6ac3:b0:6b0:4170:59ad with SMTP id
 006d021491bc7-6b6fc7d1f64mr3797277eaf.24.1788515862149; Fri, 04 Sep 2026
 02:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-clown-zersplittern-sequenz-987f972a607b@brauner> <6a9a8cd1.a011d2ce.399d32.0000.GAE@google.com>
In-Reply-To: <6a9a8cd1.a011d2ce.399d32.0000.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 4 Sep 2026 11:57:30 +0200
X-Gm-Features: AcwNN1U7j0-le73bygNJxDaUo8VXPRh4lkxTXAwyp7z5061WENtccz_ye1P0Dso
Message-ID: <CANp29Y4e=0yahrA4K8xKO186JiruTorRaq7u+Y=Q4Mo-3SReCQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] memory leak in path_openat (4)
To: syzbot <syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, iommu@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 11:18=E2=80=AFAM syzbot
<syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com> wrote:
>
> > On Wed, Aug 26, 2026 at 07:54:38AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    26260251022f Merge tag 'livepatching-for-7.3' of git:/=
/git..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1196a17958=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6c1b5958b2=
d1207f
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7666ed2c3d42=
196bf7e3
> >> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils fo=
r Debian) 2.44
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D139f7179=
580000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/0f75e7622b1f/=
disk-26260251.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/2bbff9fd7b60/vml=
inux-26260251.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/95d73300490=
7/bzImage-26260251.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
> >
> > #syz set subsystems: iommufd
>

#syz set subsystems: iommu

> The specified label value is incorrect.
> "iommufd" is not among the allowed values.
> Please use one of the supported label values.
>
> The following labels are suported:
> actionable, missing-backport, no-reminders, prio: {low, normal, high}, su=
bsystems: {..
> see below ..}
> The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems=
?all=3Dtrue
>
> >
> > This seems to be a reference cycle in iommufd. path_openat() and
> > alloc_empty_file() is just the place where the file is allocated.
> >
> > The reproducer does:
> >
> >   r0 =3D openat$iommufd(AT_FDCWD, "/dev/iommu", 0, 0)      /* =E2=86=92=
 fd 4 */
> >   ioctl$IOMMU_IOAS_ALLOC(r0, 0x3b81, {size=3D0xc})         /* =E2=86=92=
 ioas_id 1 */
> >   ioctl(r0, 0x3b8f, "2800...0400000000...0010")          /* IOMMU_IOAS_=
MAP_FILE */
> >
> > So that last payload can be decoded as:
> >
> >   iommu_ioas_map_file: size=3D40, flags=3DR|W, ioas_id=3D1, fd=3D4, sta=
rt=3D0, length=3D0x1000
> >
> > So fd is r0 itself which is the iommufd fd which is handed back to IOMM=
U_IOAS_MAP_FILE.
> >
> > That causes a cycle:
> >
> > iopt_map_file_pages() does fget(fd) without worrying what it calls it
> > on. So that does iopt_alloc_file_pages() which takes a long-term refere=
nce in pages->file =3D get_file(file)
> >
> > The reference is dropped in iopt_release_pages() in fput(pages->file)
> > from the IOAS teardown. That in turn runs from iommufd_fops_release().
> >
> > TL;DR:
> >
> >   struct file(/dev/iommu)->private_data-> ictx->objects->ioas->iopt->ar=
ea->iopt_pages
> >           ^                                                            =
        ^
> >           |____________________________ get_file() ____________________=
________|
> >
> > Closing the fd does nothing. The hex dump shows the same pattern btw:
> >
> >   - obj1 struct file @ ffff88812811f9c0, obj2 its LSM blob
> >   - obj3 iommufd_ctx @ ffff88811161cd80, first word =3D ffff88812811f9c=
0 =E2=86=92 ictx->file is obj1
> >   - obj5 xa_node, its ->array =3D ffff88811161cd88 =3D &ictx->objects
> >   - obj4 iommufd_object: shortterm_users=3D1, users=3D1, type=3D4, id=
=3D1 =E2=86=92 the IOAS with ioas_id =3D=3D 1 from the repro
> >   - obj6 iopt_pages, kref =3D=3D 1
> >
> > Likely caused by f4986a72d6e4 ("iommufd: Add IOMMU_IOAS_MAP_FILE")
> >
> > Afaic,t, this should either reject based on file->f_op =3D=3D &iommufd_=
fops.
> > But iiuc there's other cycles that can be formed.
> > For example, via a vfio device fd that's bound to the iommufd. It holds=
 an iommufd_ctx reference via iommufd_ctx_from_fd().
> > So mapping a bound but unattached vfio fd builds the same cycle.
> >
> > So probably this should do validation what type of file can actually be
> > used like shmem and hugepage file.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/6a9a8cd1.a011d2ce.399d32.0000.GAE%40google.com.
