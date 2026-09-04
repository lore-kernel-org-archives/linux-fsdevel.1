Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212C438488
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513491; cv=none; b=Y7K3/oezbY4gtKae6NaqoT7/f2Ycl81ok+nTDeiW88VPM5qoItsjQgQfnU5A8R6+ErmEov2jExmHAhkft/VSDycKhxIxRQ0tSFffm57yVVsM76kIKhE4LQIt+6azRma7P41PVXkohh5wgMu5AmArX2vKAdew/n0n0rPNMyikPBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513491; c=relaxed/simple;
	bh=OR2W4C5RJeu31LTWR0IuWWn8GbjlLAisu1bzfRpRmto=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GdFCiOpaLDODkE71ML8zuyJ4AsF9YNO2UNfGl7m5V8/4Xuikm7iT+IZnzlyTYyiBpwufeK6S5YH3XnDFPd9OKlTGDZohSSdiMV/wdfIpf7myZkV9LHZr/+ov/0QqoPIAiDMEg0u2bPskMSGVopGlpauGyhpFqt0WZD9lDx2CkXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-4489b7aa0e7so141988fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 02:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513489; x=1789118289;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:in-reply-to:date:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lWA7gjj4ueJ+MIU8cYLOnoqtXa/lQkjXbHrHZ6qQ27s=;
        b=Dw0P65NCnDj2hpq32D+dotkjy1XzOgdOe9jI6dQHkPqd682na7KFPIyCNsP10g1fl3
         eRvcG/2sNAGRKA1GVMGjrFxiUmb8kDT7RZbXIAOvBBePBROBBlBzNMc4SnXg3oGmU2BG
         4AeTi3VwbYcW6Tkj3TP/gHStgyUkr4uX6BAgCiPOq05o4bx73U6H7qjeA2YjPFeaw3uz
         sNEuQtR/jKSkPN4/siJIDgj2PCwjDum7y3njoSJqFj+2OaGhehYPMR3nE7QHJ7BIkQjp
         i4C8uBBKukm0y42OAKezwMKbWiGQJAv2B5DfrBiYXH59Nk+zIWcaeqgI09pdHMvGUmQS
         +dfw==
X-Forwarded-Encrypted: i=1; AKwUvByKksGp7X1B52aYFmE7ry3oB83y2XD563jjNwYQPRbouaEIY/2d0WXiZhNXwkWFFIpgt8PavJh1PE/lcaef@vger.kernel.org
X-Gm-Message-State: AFuF++lyTbGViBAHx+kXGFlQPQFLvbcJLQkqKR/umhwNxsC8qV1MSB05
	Ej2I+PnGox59sf2NEWM9HtWyHUgK29eTuggNmSQKQ/QVxk2rffS0Ptl+2H9SKDTwwwzXiKImMP1
	/XLdQBejOlz2dhnVn2x+IrKJ94IRuiagpmDmeXu/WbKPaYyueASUrNhNEZrw=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2912:b0:6b7:46e9:9702 with SMTP id
 006d021491bc7-6b746e9a327mr1580777eaf.50.1788513489314; Fri, 04 Sep 2026
 02:18:09 -0700 (PDT)
Date: Fri, 04 Sep 2026 02:18:09 -0700
In-Reply-To: <20260904-clown-zersplittern-sequenz-987f972a607b@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9a8cd1.a011d2ce.399d32.0000.GAE@google.com>
Subject: Re: [syzbot] [fs?] memory leak in path_openat (4)
From: syzbot <syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com>
To: brauner@kernel.org
Cc: brauner@kernel.org, iommu@lists.linux.dev, jack@suse.cz, jgg@nvidia.com, 
	kevin.tian@intel.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Wed, Aug 26, 2026 at 07:54:38AM -0700, syzbot wrote:
>> Hello,
>>=20
>> syzbot found the following issue on:
>>=20
>> HEAD commit:    26260251022f Merge tag 'livepatching-for-7.3' of git://g=
it..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1196a1795800=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6c1b5958b2d1=
207f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7666ed2c3d4219=
6bf7e3
>> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for =
Debian) 2.44
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D139f717958=
0000
>>=20
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/0f75e7622b1f/di=
sk-26260251.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/2bbff9fd7b60/vmlin=
ux-26260251.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/95d733004907/=
bzImage-26260251.xz
>>=20
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
>> Reported-by: syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
>
> #syz set subsystems: iommufd

The specified label value is incorrect.
"iommufd" is not among the allowed values.
Please use one of the supported label values.

The following labels are suported:
actionable, missing-backport, no-reminders, prio: {low, normal, high}, subs=
ystems: {..
see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?a=
ll=3Dtrue

>
> This seems to be a reference cycle in iommufd. path_openat() and
> alloc_empty_file() is just the place where the file is allocated.
>
> The reproducer does:
>
>   r0 =3D openat$iommufd(AT_FDCWD, "/dev/iommu", 0, 0)      /* =E2=86=92 f=
d 4 */
>   ioctl$IOMMU_IOAS_ALLOC(r0, 0x3b81, {size=3D0xc})         /* =E2=86=92 i=
oas_id 1 */
>   ioctl(r0, 0x3b8f, "2800...0400000000...0010")          /* IOMMU_IOAS_MA=
P_FILE */
>
> So that last payload can be decoded as:
>
>   iommu_ioas_map_file: size=3D40, flags=3DR|W, ioas_id=3D1, fd=3D4, start=
=3D0, length=3D0x1000
>
> So fd is r0 itself which is the iommufd fd which is handed back to IOMMU_=
IOAS_MAP_FILE.
>
> That causes a cycle:
>
> iopt_map_file_pages() does fget(fd) without worrying what it calls it
> on. So that does iopt_alloc_file_pages() which takes a long-term referenc=
e in pages->file =3D get_file(file)
>
> The reference is dropped in iopt_release_pages() in fput(pages->file)
> from the IOAS teardown. That in turn runs from iommufd_fops_release().
>
> TL;DR:
>
>   struct file(/dev/iommu)->private_data-> ictx->objects->ioas->iopt->area=
->iopt_pages
>           ^                                                              =
      ^
>           |____________________________ get_file() ______________________=
______|
>
> Closing the fd does nothing. The hex dump shows the same pattern btw:
>
>   - obj1 struct file @ ffff88812811f9c0, obj2 its LSM blob
>   - obj3 iommufd_ctx @ ffff88811161cd80, first word =3D ffff88812811f9c0 =
=E2=86=92 ictx->file is obj1
>   - obj5 xa_node, its ->array =3D ffff88811161cd88 =3D &ictx->objects
>   - obj4 iommufd_object: shortterm_users=3D1, users=3D1, type=3D4, id=3D1=
 =E2=86=92 the IOAS with ioas_id =3D=3D 1 from the repro
>   - obj6 iopt_pages, kref =3D=3D 1
>
> Likely caused by f4986a72d6e4 ("iommufd: Add IOMMU_IOAS_MAP_FILE")
>
> Afaic,t, this should either reject based on file->f_op =3D=3D &iommufd_fo=
ps.
> But iiuc there's other cycles that can be formed.
> For example, via a vfio device fd that's bound to the iommufd. It holds a=
n iommufd_ctx reference via iommufd_ctx_from_fd().
> So mapping a bound but unattached vfio fd builds the same cycle.
>
> So probably this should do validation what type of file can actually be
> used like shmem and hugepage file.
