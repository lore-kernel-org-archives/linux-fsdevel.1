Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4E4A35
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414005; cv=pass; b=dwepaf8rvxDJz8UNmr8AXbREQZ6oqEsUIFEqJXnphxbQ7FpLuzQTTZlc7G85a1LSqKvVPeDl5msDOQlTLzFmyrPzee1SYsyuav5CD87QuvirEngv2urkegGwB3gE0uQFeokTEg+0PZFQKKBSKKKcxb9yWamqh9AncXQ8kqjdbK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414005; c=relaxed/simple;
	bh=WyP7nPrPtPqtyr6/URCI4Apap9WDHuW+mqDo/IlYt+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+XBDBNv+4PyS3TbFyKy/tLVJqlcH7AnbALQDysKUHFP6bo4g+JyjKCnYYR1bBEqc61roP1bRCo4A++bJM56SzeorO4sCyHajIvisStHdkU2wYQvKxSALQz6aXGK/y9Y3mbcPL2oS4B3ZY2qz3i2+Ps+y3xo2yROULqiwk7G3u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci0JEUoz; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci0JEUoz"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c45281a06so16479690c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 15:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777414003; cv=none;
        d=google.com; s=arc-20240605;
        b=heM6CVa3T5N9SRNLfnFkZKlu9Gy02Nfyr3faSJySBlF9ddxnjmn/EBz+ogLZctd0RH
         W+Iu2SAvqF6oJzaGX5E7REN6m1taiuBbhAKaFW6/m3teTaa3SasDAYg2Dk+SK/FMUcr7
         JRGjupHFHQa9oOFxFg6bX40Q5OSdBQaWUyTdbfW4JrARFU6wEIfeKHw2e+EIqiWexL4W
         zjI0i71a3xCOXgdGb/ekg1DJrRPn9PfnhKJsMRfLg142BtRicRsgtDI66UhntISByOmu
         Ctq4mfh5HuEjaw8Q6JxHS59gV9GzKEv6wvaSByqCV8lLD5AGJp2esSvmlyFYnuLo1Ubm
         G05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EfhhdHruc3Joy400ylQzHb0UM5HE5aa8zxWkMNyiQVw=;
        fh=jZxos5pOSJ67sFGR2MOjpMs08FCkp8tRpWs5bFHZ9X0=;
        b=ixBR3NWZT+HCgaynOgKcKf/yMiAfe5Xa8WuyReSogdVKlnND1tyJzZYyA1dVHxQ4YP
         5dlSixSID4VWFzIujd25/4BtY7JhqEUD7r9i3OmWcx+QIAJ4Q+w23ZssFVk5TE37njmz
         qwTitzcNBORErne0ix8gVspcIaCWWtfICS+B5tSsN6fieN8qlF54ofWTVtNKvtUfgjNM
         DsYwCwUWoHVfmJoYD0vizOFqkgeRfoQ7wKL4ef6843ek2hmBsPT7bGfK2s8X81O1iNIY
         TiK2M5D3mUw8SpnzdkB0dpRShbDho4tb6mRcWfXJw/VmUrKD2cetgHq5x1C1n9pq0e1s
         /wGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777414003; x=1778018803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfhhdHruc3Joy400ylQzHb0UM5HE5aa8zxWkMNyiQVw=;
        b=Ci0JEUozQASDL6GwI2clm8pNcqaYU1vAdizIIYhxga5ziwjlm4xBnZK34T+wuvINCd
         HGatM0rG3cH8ex+OU9KG/KKtB9MW8cgxNqPeTKGgvSkLT6RYBhzcgqfNoCqNkNmycfYv
         ZtvRGY+dOAQG+zj3Y6zmbZepaQNfKenV6ZHkdsXJFI6aN3+rYFQBvSnFo5x8MZB74n4V
         NgaffyTT52zhWh4Zl8shkadcQbR8DJmF7uDK66E8r3BrlVJ6vUWYsD1zm/9a/1kecVm7
         QGMom+zWjVhP0k54jSMB74+T4GHV/yv87AovOSQB+KnKxoKfYE7Hg1pdAskuMvzMOfMD
         c2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777414003; x=1778018803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EfhhdHruc3Joy400ylQzHb0UM5HE5aa8zxWkMNyiQVw=;
        b=sRmyOd89FW0MDyVv506gW9F6PNOcCGaAZH6JNxa6+wMuBAP/3FVriP+/4qwfa65uv9
         kfY11aZ1X5kat1eRTHzPESttZxSmTs45i7bF2xbsvkQ+Jkk+wteBsnnQzolSfXevJ8uW
         FK4y2XTxwFNnMERysHZEqhcd7rX6jz3D1ecSmHIizf+p5QAaUqwLYdQlLHPfxaL2HGfP
         oIn7ST9sWrj5p6P/DP0JI358tVFCjOOYEEWZX6L8g1kwTfYqZ0ucgL/Z7GBe3Ioke4uE
         VcJvmJr+VB29vWJICfp364heIFdwqZiNhk6CHUIfkyW8Hco2ekIqcQvpO96+68MrqdTG
         TL4w==
X-Forwarded-Encrypted: i=1; AFNElJ95MLggXwPIqFUIsPppQ3lfZDKUfX4csZ83xi5jvEiSYF7D2W51KiNsPWENO0s3Yi4pi/oxwhFev7i/DIYe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34opNQbeSH4FO2DtVIwpWM2cEU8LlMzHiyVCZuME9HIv8ht6C
	twKv5jhWryC9bVCWKyUG0Enva7KECija9mhoNcziL7tkUVMrMMRKoHPGqbj7yQDyE+xeJEf6KCp
	yfcTIQTMIVpzX74Raxr7GiBfwk+tdZn4=
X-Gm-Gg: AeBDievnRs4YNgl0HiswdgElNHUEknQJnq8Q1rk5gBGIyRoEnnKpLMRho/4WDYn6TPV
	EcocTy6JLNMJ56WgjQFI1tYsSBR+kNMvpthIfhFA4stSeJbdCUOg5diA3/vJPEqHwA9Qqg03lyy
	9FWu543AKKyezqU3d3Mzja01LxqjlGkK0/xsS3QhhJFsukMH2rWKxVYQrd64YpCitAwGNUVF2ox
	VuBRRpiLmxTn5VQMVNOFQMCgFlA38a2ik8yYO/hZFdezERWOtfQNwYyLGVedSmhMrde6m0mCoT1
	pTNnd7AnoSo+Kf+Bew==
X-Received: by 2002:a05:7022:4583:b0:12a:8ea4:252 with SMTP id
 a92af1059eb24-12ddd93f1f1mr1904671c88.4.1777414003188; Tue, 28 Apr 2026
 15:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206202757.1535351-2-slava@dubeyko.com> <CAO8a2SgqvbP-WJAMnKLn=pKmDfjdaq1f86-1MFoqeo-4iehBOg@mail.gmail.com>
In-Reply-To: <CAO8a2SgqvbP-WJAMnKLn=pKmDfjdaq1f86-1MFoqeo-4iehBOg@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 29 Apr 2026 00:06:31 +0200
X-Gm-Features: AVHnY4IxnYgvLO6gv2dhy5InpC4XEPsYzK5WDUnuYnkaCnYxSPnbnQvlqg7_4VY
Message-ID: <CAOi1vP8tGqgYTmcUVHBGziCcr9njJaEvdxxEkmAv8mUVK9C_yg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix generic/639 xfstests failure
To: Alex Markuze <amarkuze@redhat.com>, Xiubo Li <xiubli@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 2:20=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Reviewed-by: Alex Markuze <amarkuze@redhat.com>`
>
>
> On Fri, Feb 6, 2026 at 10:28=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> > The generic/639 xfstest fails for Ceph msgr2 protocol:

Hi Slava, Alex,

This can't be specific to msgr2 protocol, so I wouldn't emphasize it.

> >
> > Ubuntu 22.04.5 LTS (GNU/Linux 6.17.0-rc7+ x86_64)
> >
> > sudo mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=
=3Dsecure
> >
> > sudo ./check generic/639
> > FSTYP -- ceph
> > PLATFORM -- Linux/x86_64 ceph-0005 6.17.0-rc7+ #16 SMP PREEMPT_DYNAMIC =
Wed Nov 12 11:01:48 PST 2025
> > MKFS_OPTIONS -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch /mnt/cephfs/scratch
> >
> > generic/639 - output mismatch (see /home/slavad/XFSTESTS-2/xfstests-dev=
/results//generic/639.out.bad)
> >
> > The simple way to reproduce the issue simply running these steps:
> >
> > mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3Dsec=
ure
> > xfs_io -f -c "pwrite -q 0 32" ./testfile251125-0004
> > umount /mnt/cephfs/
> > mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3Dsec=
ure
> > xfs_io -c "pwrite -q 32 32" ./testfile251125-0004
> >
> > Finally, we have the unexpected content of the file:
> >
> > hexdump ./testfile251125-0004
> > 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 0000020 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> > *
> > 0000040
> >
> > Initial analysis has shown that if we try to write out of
> > end of file, then ceph_write_begin() is responsible for
> > the issue because it calls netfs_write_begin() and we have
> > such logic:
> >
> > int netfs_write_begin(struct netfs_inode *ctx,
> >               struct file *file, struct address_space *mapping,
> >               loff_t pos, unsigned int len, struct folio **_folio,
> >               void **_fsdata)
> > {
> > <skipped>
> >
> >     folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> >                     mapping_gfp_mask(mapping));
> >
> > <skipped>
> >
> >     if (folio_test_uptodate(folio))
> >         goto have_folio;
> >
> > <skipped>
> > }
> >
> > The reason of the issue that somehow we have folio in uptodate
> > state and netfs_write_begin() simply skips the logic of
> > reading existing file's content.
> >
> > Futher analysis revealed that we call ceph_fill_inode() and
> > ceph_fill_inline_data() before ceph_write_begin().

With my limited understanding of the inline data feature and its
history (it was deprecated years ago but is still in "will likely be
removed altogether in a future release" state?), it doesn't make sense
that ceph_fill_inline_data() gets called on a file that is created by
the kernel client.  The kernel client doesn't write inline data -- it
only supports reading it (after it's written by the userspace client)
and potentially uninlining it.

> >
> > void ceph_fill_inline_data(struct inode *inode, struct page *locked_pag=
e,
> >                char    *data, size_t len)
> > {
> > <skipped>
> >
> >     if (page !=3D locked_page) {
> >         if (len < PAGE_SIZE)
> >             zero_user_segment(page, len, PAGE_SIZE);
> >         else
> >             flush_dcache_page(page);
> >
> >         SetPageUptodate(page); <--- We set page uptodate if len =3D=3D =
0!!!!

How does a small file that has a non-zero size but no data (e.g.
"truncate -s 32 testfile") is supposed to look when the inline data
feature is enabled?

I'm asking because I'm not sure I see anything wrong with this call
given the surrounding code.  In case of len =3D=3D 0 zero_user_segment() is
called to zero out the entire page.  This call to SetPageUptodate()
follows that and seems to be on point: if the page isn't going to be
marked uptodate, the whole sequence of looking up, locking, zeroing and
unlocking it is pointless.

IMO the actual root cause of the issue here is ceph_fill_inline_data()
getting called in the first place.  ci->i_inline_version for the file
in question should be 1 and according to commit 4849077604f0 ("ceph:
don't get the inline data for new creating files") that is equivalent
to "no inline data".  That commit changed how fill_inline is assigned
in ceph_fill_inode() but not in handle_cap_grant() -- I think that was
an unintended omission and adding Xiubo to confirm.

If handle_cap_grant() gets changed to use ceph_has_inline_data()
instead of checking for CEPH_INLINE_NONE directly, the issue should
go away.

Thanks,

                Ilya

> >         unlock_page(page);
> >         put_page(page);
> >     }
> > }
> >
> > This patch fixes the issue by checking the len argument and
> > setting memory page uptodate only if len > 0.
> >
> > sudo ./check generic/639
> > FSTYP         -- ceph
> > PLATFORM      -- Linux/x86_64 ceph-0005 6.19.0-rc5+ #2 SMP PREEMPT_DYNA=
MIC Thu Feb  5 15:43:51 PST 2026
> > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch /mnt/cephfs/scratch
> >
> > generic/639 6s ...  6s
> > Ran: generic/639
> > Passed all 1 tests
> >
> > [1] https://tracker.ceph.com/issues/73829
> >
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Patrick Donnelly <pdonnell@redhat.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/addr.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 63b75d214210..436a287fd311 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -2184,7 +2184,9 @@ void ceph_fill_inline_data(struct inode *inode, s=
truct page *locked_page,
> >                 else
> >                         flush_dcache_page(page);
> >
> > -               SetPageUptodate(page);
> > +               if (len > 0)
> > +                       SetPageUptodate(page);
> > +
> >                 unlock_page(page);
> >                 put_page(page);
> >         }
> > --
> > 2.53.0
> >
>
