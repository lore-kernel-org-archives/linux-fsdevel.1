Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B73ACA60
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292417; cv=pass; b=Vbi88BPhkD0oWLdDYETScyNAFUz98RgGMvQ9RboVUz1lPkiWL3R7g9x/XGKVilQeyeUaW21eZSXQqTdpHU8Vi7GxACuTaxT5ka/pTQXXTsh5n9ffXl1znjH8eMVPS74xUUbSnxignOUcjjdkdtYicwYeCcXH7mzLfSUvHep8jac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292417; c=relaxed/simple;
	bh=7ND6Qeugqma/lV+rmaSyCzo7YD1hP0YqUQcNKsMAkek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/ekcvlhfiKgm1WPVqjqYANAljrRX2GWJjiXEs5TA+ALyVVyp7HXiggP4ZcNLMppcmUf5Faj0XWJQG4YBzuslVftbH2i9I6/u04M0Fjgrlso87pzxLWgVc7m+VrWC8cs8T3eJJ0NnDmMhqtWofmBpQcst/xDoRZMXGOeGSJ+E8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJe18EXo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DeJMFTY+; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJe18EXo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeJMFTY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777292415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdxEESAqEllYThJFICWo/rzdAfjGyEOlpjHW+bvhUuc=;
	b=gJe18EXoWjCfVovybSjKHOCzlao8c7oeerUrQyV3Ii7TT4EpoCgCE5nPvCp70AdQQhg01I
	kGOMf48qvpVGU3B1OC6jHw1Q/WVkLOR+GGNqdP+dW4nuGOrq3qfrNHtFKVhu1AwuyY19JD
	nUC/dcIPutItyvCyzTC20rQ/2uak2RM=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-zXapzMGXOPm78hzw9eq_XQ-1; Mon, 27 Apr 2026 08:20:13 -0400
X-MC-Unique: zXapzMGXOPm78hzw9eq_XQ-1
X-Mimecast-MFC-AGG-ID: zXapzMGXOPm78hzw9eq_XQ_1777292413
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56f71e90581so8122087e0c.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 05:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777292413; cv=none;
        d=google.com; s=arc-20240605;
        b=aYrZiS9+A/z8P+2HfXjp/I/4xTJBGvOmuTylCI9SgvYP0EMZng8c488TG1KpZusAsB
         EBabqty2zdzg9NWVqpxEGZptySDVfPQTWzO/ehlu3Hf4oc2bRNgaDyTxd3bov7xRoGH2
         hzho6XtLGkzJf+SXovO+Z0Zwm9RDf6VCwgB+XlSb9hYmJjkWSRi9CYlcQhHKnCMWJCv6
         Kb7ayljZVd62zedEYNqPPNMoJqLVtZGlkRYizpLEJci0PVW4ewswoOa4ks5DFinTgnok
         YHIJQa1LRJtSYJAKLFPM/jJpDsBOWWC4aFAtC9qx7xuYXh+LEcfmaiN5V9p/qqHzA2Ow
         S8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pdxEESAqEllYThJFICWo/rzdAfjGyEOlpjHW+bvhUuc=;
        fh=SCexI+WTIDPWHaTpT/x4Ar+h4bJsJyp1u3tpNOElHnw=;
        b=NGP8zXpx4bKzcTVUtQPsIl8qJJ3cis19euX1KLTQvJdOknqY7pQhbssG3x3Y3zOhzw
         PpyFZwrsiD2R0S4q5zYdjxMdaetdx6HvSU/YJA8ZjC7RTxCEbkfWthoD/0udaRw1e7iK
         ZmRGmB2az2W8wxLqVZBuYI7hQh6stql3Z2jNsQy+1ekC9CXBqiEYAdzxVs9TpEb6ABdj
         Z+w/NLTvzBkLq9YEi+CnG4Jd1ANi5AXZR/SOFhrjEDnhxoZZpVN5OKFEw2BOJV92GTCr
         bl9R5dcAC7nVJkvjPmlxrDockEgYznzL5U8zsUnJzmU9uZBb2jBATm8bQCgan8lXxC68
         B6IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777292413; x=1777897213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdxEESAqEllYThJFICWo/rzdAfjGyEOlpjHW+bvhUuc=;
        b=DeJMFTY+Ln5d22IDbnR74B1NyFIeIK72ax6uJs99bstW+hoebwKQg05H0SQFZWnuz1
         ZkVfBngM7f93fYVVAtihhMMy1ZKMBBrNnn/SgfzF8ddxDa4pe5+YLKvAa3h6hG909P39
         VkROeT206k3znx205hp1LCLzpJfuytSm4miH9NnzDKgs9eKs5lqhY8nCxNHF0F0sdvdD
         LJCBpzYNwMc64+VAcRG9Xuz6gtY9GG3cc9tWOq9eTo0j+jVzhYamcQRQCcW/ZJTFlWhF
         HGUri4zfS7ymBoNbqpDDKE2sVkRZJfVnr7GT7i4sMkHq3hTUR3XWcWVcK6i6xrA4DNwf
         am4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292413; x=1777897213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pdxEESAqEllYThJFICWo/rzdAfjGyEOlpjHW+bvhUuc=;
        b=GsMzqc3QwfhHfso9Fq4e4zfBLe1Jln7h6gv/BujhalUbMdKkKkHdkETS+mjrVZUn/g
         /NWYjbRPcb00aV3u1ieABkl4ZE2xDQonTco10iMk3eXIzCArcyWC2EiRvP7Cfbrg4t7U
         QZzUCPnSPAKfAcvqeMZQgI4C15NQ1VCe76iu2k8hIQZpYPUS8BazW/BKCF47BatY6QZ1
         gSUoO2GAd7Yds/hWFCfjtlyqMAzZpdCihowNgTExa1Nk3vZmqpYUluDL/2HiWJxR99ac
         8IHU9KQhFAoWhA72egRR9YAhfToYx0pojwxvhDYLpQgPfZtnh9xfRVoweC99CmOzFRuc
         rtrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bPji7mbTmExbsQ2B2az5hLPxbNOI7cO/0YZxno+WD8VMaGBelk3KCNG+rSOFb2eMQ3aqCCNEpmnA4fnkL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3y3+EsHfIJyQBNOtSxk4EUzs4S8Z4aV2cwkNcSAvvQ0o8OzUj
	xAv0QNSdugX/qq9Qz2sAnmldKECZT3VKFn0wJ6RrP5GWusQ17v9AnzjOh4xGUzjROiSVXGCLgNT
	1mThdAn+nuebUSCh7cm4mU/47CtHLwK9KUD8I7w/YTfvr/un9qyptwAeTy2OzL4LUg7CGUxN9QR
	D3gHijNQsGOZ+KSI4HlTYI4uhhZmmb5RayFtKo6EP9FA==
X-Gm-Gg: AeBDietTjwnZk4KYVVqdbfhXr+7FoeMlUqoN7N+9GuOfRyIJtwG7A2nWV269hLjMzI4
	4xqUx3Zl9V2i9kogde0lMiCr9ZgD65PtzCYFjHgfSHDvPakOoSO0UyLWc5Q6fc22/ECkMeP907t
	R8b0yTjXQC2Ag/6jRq7psV772aYyTHUW2U0gvs2ZuwTiq/LaAX3mW6gBL6OUXBCxbKaG713lW4D
	5Ain5H/w92kVuY=
X-Received: by 2002:a05:6122:3110:b0:56d:9e98:4676 with SMTP id 71dfb90a1353d-56fa5a50ef8mr21563615e0c.13.1777292412973;
        Mon, 27 Apr 2026 05:20:12 -0700 (PDT)
X-Received: by 2002:a05:6122:3110:b0:56d:9e98:4676 with SMTP id
 71dfb90a1353d-56fa5a50ef8mr21563593e0c.13.1777292412536; Mon, 27 Apr 2026
 05:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206202757.1535351-2-slava@dubeyko.com>
In-Reply-To: <20260206202757.1535351-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 27 Apr 2026 15:20:01 +0300
X-Gm-Features: AVHnY4KsrXF6FbtCKnOVPXrHM0XTTMBPPxUwKeAJV4Lnc1M8s-oXgLyQqPAN6RY
Message-ID: <CAO8a2SgqvbP-WJAMnKLn=pKmDfjdaq1f86-1MFoqeo-4iehBOg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix generic/639 xfstests failure
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>`


On Fri, Feb 6, 2026 at 10:28=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The generic/639 xfstest fails for Ceph msgr2 protocol:
>
> Ubuntu 22.04.5 LTS (GNU/Linux 6.17.0-rc7+ x86_64)
>
> sudo mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3D=
secure
>
> sudo ./check generic/639
> FSTYP -- ceph
> PLATFORM -- Linux/x86_64 ceph-0005 6.17.0-rc7+ #16 SMP PREEMPT_DYNAMIC We=
d Nov 12 11:01:48 PST 2025
> MKFS_OPTIONS -- 192.168.1.213:3300:/scratch
> MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/scr=
atch /mnt/cephfs/scratch
>
> generic/639 - output mismatch (see /home/slavad/XFSTESTS-2/xfstests-dev/r=
esults//generic/639.out.bad)
>
> The simple way to reproduce the issue simply running these steps:
>
> mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3Dsecur=
e
> xfs_io -f -c "pwrite -q 0 32" ./testfile251125-0004
> umount /mnt/cephfs/
> mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3Dsecur=
e
> xfs_io -c "pwrite -q 32 32" ./testfile251125-0004
>
> Finally, we have the unexpected content of the file:
>
> hexdump ./testfile251125-0004
> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0000020 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> *
> 0000040
>
> Initial analysis has shown that if we try to write out of
> end of file, then ceph_write_begin() is responsible for
> the issue because it calls netfs_write_begin() and we have
> such logic:
>
> int netfs_write_begin(struct netfs_inode *ctx,
>               struct file *file, struct address_space *mapping,
>               loff_t pos, unsigned int len, struct folio **_folio,
>               void **_fsdata)
> {
> <skipped>
>
>     folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
>                     mapping_gfp_mask(mapping));
>
> <skipped>
>
>     if (folio_test_uptodate(folio))
>         goto have_folio;
>
> <skipped>
> }
>
> The reason of the issue that somehow we have folio in uptodate
> state and netfs_write_begin() simply skips the logic of
> reading existing file's content.
>
> Futher analysis revealed that we call ceph_fill_inode() and
> ceph_fill_inline_data() before ceph_write_begin().
>
> void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
>                char    *data, size_t len)
> {
> <skipped>
>
>     if (page !=3D locked_page) {
>         if (len < PAGE_SIZE)
>             zero_user_segment(page, len, PAGE_SIZE);
>         else
>             flush_dcache_page(page);
>
>         SetPageUptodate(page); <--- We set page uptodate if len =3D=3D 0!=
!!!
>         unlock_page(page);
>         put_page(page);
>     }
> }
>
> This patch fixes the issue by checking the len argument and
> setting memory page uptodate only if len > 0.
>
> sudo ./check generic/639
> FSTYP         -- ceph
> PLATFORM      -- Linux/x86_64 ceph-0005 6.19.0-rc5+ #2 SMP PREEMPT_DYNAMI=
C Thu Feb  5 15:43:51 PST 2026
> MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/scr=
atch /mnt/cephfs/scratch
>
> generic/639 6s ...  6s
> Ran: generic/639
> Passed all 1 tests
>
> [1] https://tracker.ceph.com/issues/73829
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/addr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 63b75d214210..436a287fd311 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -2184,7 +2184,9 @@ void ceph_fill_inline_data(struct inode *inode, str=
uct page *locked_page,
>                 else
>                         flush_dcache_page(page);
>
> -               SetPageUptodate(page);
> +               if (len > 0)
> +                       SetPageUptodate(page);
> +
>                 unlock_page(page);
>                 put_page(page);
>         }
> --
> 2.53.0
>

