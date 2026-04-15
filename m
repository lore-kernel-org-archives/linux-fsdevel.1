Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D42F9998
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776217236; cv=pass; b=Qqh8VviAChpTAyTblFquhyRHofxWIg0g8CT0ftfI7Nhz1G6ykXJIaGIWVoI6UwqRwt1ErJeyy7nseLz7raKgXvBsGxddQrlJsT+sFX7cVHRNRRT1DWilldtylIvhPPn74f4y1nJUowGNMfDRR0Ix+NKplTjf4ENgRoQM1TFq1X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776217236; c=relaxed/simple;
	bh=3Hz9gfF5LejhLhxzApt7VdQmu/8gvCbPs9+G6vnIzoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/oEuebq+UZ7ZFwh+9jH+/hMQlGA1+xHlCScPgXS84Tq/333aNfWOq2yM+rn/EXI4NAeLv6Q2ESfZlTkZnw8eROqr/O9raJUNSVoXR+ZHgAtFnNE0WwlW2XTz7E8U3NMno4ZDpNNw6AnPwCRwMoIZsrc5QwgdBGtilmC9whNu74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=reu3ep46; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reu3ep46"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7b37d84a6b3so28125277b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 18:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776217234; cv=none;
        d=google.com; s=arc-20240605;
        b=N635tgKw23tElwQX/VZKZqVmUVNMNKCExZh1YhN7ZMd5OLYgXHG3imF/7awEQ79Jyo
         vbpT6fZZrN1ULt4/R1gdE1lggH/ZcyStke3pkM0qkzvWDOxJC9IUEzl86nfUH+cnHPr5
         zxr/BHGMlCuwaMVp1hmCI6+4hW97nX99PImvUhtTetS6LTksn6JldeSKsTdU7xhBs+CG
         MH2EdkkR/nx5RywiicF6NA68iAPWKIvUpx7Q/zos/3HiCKM8ghudSPkLH2wNINESiF6w
         pQCyQOTByBR99pAEIvQ1eTfZkP8xTeE+T4kUGWFYN4U/GKnIjftp4BH7RlTg41gzZxA6
         tdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=goTPEgRJW7kjllxvNENoc627OwL7aMfLFKaQL3tBuAE=;
        fh=47JmSDBf32hfI8H4J0oeUeBLVwCQQKM81M/CSTcwTPU=;
        b=XlCt/YLiewoIMGQ3Yan/wYgvgB/D6LoeZwYuumgw5PESTVdpy0iVywY14rKUP0ilEj
         YJZW/Tla5MRPuQwzz5N1/AsJC96h7XZ/lRcupXE0mUNAgOHa+5T7qRlj1sZsPcsU6EWM
         ST+IDKolhRsJh6Kx02uaEF3DUwiWu8hepBc9y7SkecJ++4Bht399btHp/CZhS88yahSn
         DzqPf6mDRQWsVjp0L38BWPkzqYZ5FHJa+t1mYB5pHZqG6V05pEaUoLpvTAXA9vBBaw5B
         KqfTHuEbjUBuOXgyWS0UWBY8UsoM5kURTGS1cF1oCSucyiWrvKTUN2SEndKePq9lvqYl
         uYfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776217234; x=1776822034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goTPEgRJW7kjllxvNENoc627OwL7aMfLFKaQL3tBuAE=;
        b=reu3ep46HgqD/j4noIws6VpWYlVknXa8Q9VyNB0emC4R+024KPsR/eITNJXdXn6qbq
         ZKFDSerT4Y3lFHj7wSIsxYL3UeM8N4eZeKa6yeO1FqtdwXnaj5qBG6h1SsLjFqlcQ4r0
         vpzhl7H4FK0m/4ypcGTKTaMFqkFkyUuFYhLBT+Y8hO16T3bEe0QUKTI9PMsD881Tz9CW
         LZTE2OWPhjPvUiqAMW3eIwl4VhRbKJ2ZwpAD6CyT+cYq+kn2lKg6ymCDxmLfTDHgrdQk
         gILmejFqQjYSj8HSM1YXjb7+1PnYUW+b6ubAPO1Ts0snzy6Ycil8IH39C+1Pnl+xR0No
         jA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776217234; x=1776822034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=goTPEgRJW7kjllxvNENoc627OwL7aMfLFKaQL3tBuAE=;
        b=nuC128my9IhmW8pOa9huVS2NsAeY417i3Ul0CR+aPbTPkHcPYhx/g9qSsw/LxGrs9/
         qHKRetawEks50pYY+G3swHhVqcVXF1KEs63Tbegr1xdByBh7KUFjU0Vu1eH/UQ+ZlZIy
         /8rxJM473LcWJnjwYKnLe7hJrWB+GsL8/FZ6za6H1MPrN0/OzufACW/mh/gSiEX7zv3T
         lw8GjTuQBW7PM1D0Tg5p2Q9iqzWyGDrZ6kaE98Ooa5ha+3dAdj7f6WaKhf8MP/gepPxB
         dDyxPW9ApUm2zAwYlIq5M6vGXKNHOyt+n+ADNRmqLPPu5V7+kkRy/Cl8l1Dm5wrr1cNr
         yBhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9n84+lKzKc2MXzZ/l4/C2SKSuCu+SfjKPPY+UoVDz6LCTWsfHnY2GjwHjXa3eZIRT15O4u3/hKlZ1dcf2h@vger.kernel.org
X-Gm-Message-State: AOJu0YzlIjS3lEyQOIJrcBhm5+ou7wBw9AXIMM9r7MnJ2hUF6tudeDgI
	9rJ2HjpkkyFGkjxbUI0pVqnpDYrqpbPKjCHMpBvzZISpCc2iauhIwEbNhFpnSTriQl2yBXTZOxO
	beORUZGGtjzAttpx7VrU6rmE/mpJbBlI=
X-Gm-Gg: AeBDietI455mYUYNESKHRdGe2sZASavinI+8rXvbtc/1/qSWvM/vCvkmI+/uiUvqeGU
	HrCeUoEWwNOM1d/aU3bAinfULpMMoWnh17o5PUczDw1llYVgMrKzjT1yE/sM6GHZDO/eMkUe19T
	+PaYHKlKqr8au6A9CFhdNhohb2Izv+yMzlRHMDBBmLPb9dxzjz23aDClhc0nB2nT3vUW9H7zNvh
	QhfWjQPnntKuEkcP7Cmtq2ino7v9oiJc4+HQziTCX5j/GvMpkis1YZkYpJuVdYDDotGVGzng+uj
	JNVBNAyTdt6GB3jY1qLIXgSsS4/29LCTxRMo8VdkAvFZk547cZ8+zWJr2XIaxA9NiMaDeX9sNPf
	NmPxv9g==
X-Received: by 2002:a05:690c:c14d:b0:7b4:f43f:1a34 with SMTP id
 00721157ae682-7b4f43f1cd0mr52160117b3.36.1776217234212; Tue, 14 Apr 2026
 18:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414015630.65081-1-kartikey406@gmail.com> <f2707a743d06df045daa314bcd1564257b4f83a5.camel@redhat.com>
In-Reply-To: <f2707a743d06df045daa314bcd1564257b4f83a5.camel@redhat.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 15 Apr 2026 07:10:21 +0530
X-Gm-Features: AQROBzAUDlMZCd3MTpQBrfvXM7IfD723UBC9eBtExnNAjinV0MJ3eoj2tDM5wGk
Message-ID: <CADhLXY5WHSrh=6ifSYE3xWJ7PcvVFyLL4HC=QB_AoMo5zqY65g@mail.gmail.com>
Subject: Re: [PATCH v2] hfsplus: fix ignored error return in hfsplus_delete_cat
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 12:59=E2=80=AFAM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
>
> Frankly speaking, I don't quite follow how your fix relates to the initia=
l
> problem?
>
> vfs_unlink+0x272/0x6d0 fs/namei.c:5476
>
> error =3D dir->i_op->unlink(dir, dentry);
>
> hfsplus_unlink+0x57a/0x930 fs/hfsplus/dir.c:435
>
> res =3D hfsplus_cat_write_inode(sbi->hidden_dir);
>
> RIP: 0010:hfsplus_cat_write_inode+0xbe/0x8f0 fs/hfsplus/inode.c:637
>
> struct hfs_btree *tree =3D HFSPLUS_SB(inode->i_sb)->cat_tree;
>
> It looks like that sbi->hidden_dir is NULL and this is why crash here.
>
> But how have it happened at first place?
>

Hi Vyacheslav,

Thank you for the review and for pushing back on the commit message.

Let me explain my initial approach. When I saw "hfsplus: xattr search
failed" in the crash log, I traced it to hfsplus_delete_all_attrs()
in hfsplus_delete_cat(). I noticed the return value was completely
ignored and thought that was the root cause =E2=80=94 that the ignored erro=
r
was allowing execution to continue into hfsplus_cat_write_inode()
with the filesystem in a bad state.

However after your feedback I looked more carefully at the actual
crash site:

    hfsplus_unlink+0x57a/0x930 fs/hfsplus/dir.c:435
    res =3D hfsplus_cat_write_inode(sbi->hidden_dir);

You are right =E2=80=94 sbi->hidden_dir is NULL here. When a corrupt image
is mounted where the hidden directory is absent.

hfsplus_link() and hfsplus_unlink() then call
hfsplus_cat_write_inode(sbi->hidden_dir) unconditionally without
checking for NULL. Other call sites in dir.c already guard against
this; these two were simply missed.

I will send v3 with the correct fix in dir.c.

I also want to be transparent =E2=80=94 I used Claude AI as a learning tool
while working through this bug, and used it to help generate the
commit message. I should have verified the root cause more carefully
before sending. I apologize for the noise.

Regards,
Deeanshu Kartikey
