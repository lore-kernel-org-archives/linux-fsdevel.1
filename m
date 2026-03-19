Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF097372EF9
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943677; cv=pass; b=dHhrFjgVKf3uGd/tQ+XKoCA7nP3dtHrCfJ08klUlCi5GUSWCmMGgOT4kardWgGKH6Ux2aP9EiqpJLgUjVGgRPbhebQHjPsIYILwLVxgjgFDMQ7xducmXC1zE0n6sIwkLMnZaeFwa7bp760vGHbAYbbXq4nR0qFXjAHn9mg2YeGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943677; c=relaxed/simple;
	bh=qLyBC2v3psQTDHggKp6cAb3+simj2kT/Xqn/adDf4nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbQCix1TK36hYEuA3wXlEtG9udPPijLfJsXdRpn4t4EdVejiPBxLni2EZX1B7d9QyilG81NKgiWTYbXgAJosCcTf+QvqHewWgY+rM/rY5HncBn+Few2Q5DoFkBd3V2/nw+IKHa7NWQiR/JKiIUOJEsbZOA7ZfPJFj+N4yBA5lVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+7dDoex; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+7dDoex"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so6566845e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 11:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773943674; cv=none;
        d=google.com; s=arc-20240605;
        b=SNv+S36UKSoginuRxb4w8ZnsREKv+QyVblV9/nGl47skJaO+EK0bP/bRtp9WFdIgQS
         Iu4NjwEwOIHw9RC9R9RBKAkzxahaKlmEiPN+OKIyHPzN+CMPqX/c+l+ME3E/iWMIVoCx
         gF1NEtl9gOjn2KzbUgNTVUr6gYCa3Zs4r1xaQ/Ebz1Q6HJu2+Wnz97RElyHuwXsOI9Jv
         26sOdB4YdT7NwEIsjAjgX7IoNDc9e+yCF12/F0Bby6oJPj31LUo6EPJDqdN/mmJa467t
         8Hf0BoKWPGj1B1S8GzKcs7EeurDbnjZF0u6+6NhQndyg0RMWg8/+LkqG718SAdXDHGeB
         x/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LPwYDOqDzfGuF9EEcoCkuHGw4QSL61z/ViJbQ5YfE90=;
        fh=JrYNdKIfA+Th3j7F1YrzCa+tY7iTSbeLD9Tup5hnHPA=;
        b=huarXB+7gohm7iHxxvj+7u9/M+2Ixeeu51qvxIDtPNi5saXB4Nfkc2reY6SJZeR3QK
         6epAfA50XhF5tfa04xeX5yiHxViZTp4I/FyevLVyjpqlyBH4YhiULdDaRHWAHFjKUVrD
         t25Nx4ptQFwUmAAZKSiY7fE4btiDKCpIF2Cv+6LuJ1HRIyD5jGl5YZvMUNCgTbDEN4a+
         A08ukwtrc3bvOg3ZEi7A/osR3xRFfzNMq1B3lNRb2plRFJheT5eimN4Zw2HJih+wVUz1
         kYRucoCZ3OgkZgm1nt8ux2oPGjyYYPeFcs0MtHrJqYMBkDWXYns63uNSXZJyH8VeAWWL
         Gmjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943674; x=1774548474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPwYDOqDzfGuF9EEcoCkuHGw4QSL61z/ViJbQ5YfE90=;
        b=g+7dDoexpUo2XZb3gfCtgxL6GYIMbW3NNNU0LNQT+eecn24i0HZpMjD+f4ddNbaxtm
         eXFoxgFBGaYh3Zbfwb/KTIEQLjBxHgbqIgXfxQdQ183zPE9G0Vu6Cxc2mFOa4dYcg5Jl
         sIvbHx0P8K3R0ES7NmwsR7I/KC4msGLZW4A6Vykd3/X7QSQLUC8GqZ7fSKhgGtv62bHc
         OnFpVj6P+PydbBqek+Xw6jfj8DS8rWftuvVYX4w4BhQgvGmEQHa0tMOGa3bb7W3fMjhy
         arWLTvVJrUHqiFVkPDLr/ACX4NG9qHqjqh+mMjOBKSRiB1EGgyu0Qmnf9MJynsV+qsgH
         TQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943674; x=1774548474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPwYDOqDzfGuF9EEcoCkuHGw4QSL61z/ViJbQ5YfE90=;
        b=SrZgElNHwDdMfDorLVNjvPdR5EcN3l+kA7RyEx+Uct2J1jKsnMtZ12rFdHyRnEPVIJ
         cRkr8Ip7RxvfuAz+G8yzHGWQdp4znAzJM20JrDlAJJw7iXzh68mlc9yyaSxIZZCWvR4X
         myEt5ocpFT+TUE5bBsPePh80MQZWZ4+metbFRDn2XBjxmagCLcy3XDserEqMauBSujiK
         LBH9OeNy2ZPJqRj4n4QDB4IxD5tH2vODqz97zCV2enEdkVIWOY8fM5PKEE38p5HwEWai
         UsoSGeX9xtrLxA1alzr4sgIAlysA+/CP4kavBugzittMzVqUdUHOPrPNVAhtuLbfABMm
         F2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOIcLaXGaAUgPGEF8NtNsF0+mlRwvpivGz9bFNIayEoAzb5IBrW5tKABkkp0rx8TLhOgq1kdO0rrgS8+SV@vger.kernel.org
X-Gm-Message-State: AOJu0YwavK7fQkQvmhhzITwzjuQgZhOBErQjTmlsZ8IBz9EbTmb4z7sd
	OXVtgNzTERAqggTsRdMjpKZmYUaX0XhEaLVvV4b0t89CsDS7KRg7F9KFajLZtOJlQnEiRSNOH1o
	cJ7h1r4hKHkaxCzKhn+lfPRJqZ/U/b4U=
X-Gm-Gg: ATEYQzxj4rba+pOQoUP7VZQL2sqhsrjR5tmufShpELTtuOUCRpt0AEo+BnAafa04p8s
	NW/rbg8FWBPo41P3okJ9YW1nrliLU2N/Ja4Fk7t/Sck4ToFJP5xlqyybKwuKghcRPabnDai4rZ5
	fwQWmP4v9NM2BpKaKgftJitL62G1I6bFDTdZL3XqVIPm17VSh7i1PuPm86x33OYBakIWuC+whoY
	LWdIkRMEmSIDmV2MAKkqLAz/vCLWx9SzXeaBoOgacraxPbBw8Y+bR0m8FjzkNu3X+k9dUSsHTgA
	58rFew==
X-Received: by 2002:a05:600c:4e8e:b0:485:3fd1:992c with SMTP id
 5b1f17b1804b1-486fedaafc2mr1248265e9.1.1773943674033; Thu, 19 Mar 2026
 11:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318225604.71545-1-joannelkoong@gmail.com> <k7ln2mcmll3t4zic3smao6hvvxprmpsax45fh6mwn4en6f6m42@sdpuqd2pqiwy>
In-Reply-To: <k7ln2mcmll3t4zic3smao6hvvxprmpsax45fh6mwn4en6f6m42@sdpuqd2pqiwy>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Mar 2026 11:07:42 -0700
X-Gm-Features: AaiRm51PiGs5infWIQSFJuqnAy1FZOdjdr7orrxLP3LNZfiW4rd16rvmfCo8zAw
Message-ID: <CAJnrk1Z7OTah=zam8_4LWx8Kc0B6omrVbiiDRNHm34yAKNEBEA@mail.gmail.com>
Subject: Re: [PATCH v1] writeback: skip sync(2) inode writeback for
 filesystems with no data integrity guarantees
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	david@kernel.org, therealgraysky@proton.me, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 5:42=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 18-03-26 15:56:04, Joanne Koong wrote:
> > Add SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
> > guarantee data persistence on sync (eg fuse) and skip sync(2) inode
> > writeback for superblocks with this flag set.
> >
> > There was a recent report [1] for a suspend-to-RAM hang on fuse-overlay=
fs with
> > firefox + youtube in wb_wait_for_completion() from the pm_fs_sync_work_=
fn()
> > path:
> >
> > Workqueue: pm_fs_sync pm_fs_sync_work_fn
> > Call Trace:
> >  <TASK>
> >  __schedule+0x457/0x1720
> >  schedule+0x27/0xd0
> >  wb_wait_for_completion+0x97/0xe0
> >  sync_inodes_sb+0xf8/0x2e0
> >  __iterate_supers+0xdc/0x160
> >  ksys_sync+0x43/0xb0
> >  pm_fs_sync_work_fn+0x17/0xa0
> >  process_one_work+0x193/0x350
> >  worker_thread+0x1a1/0x310
> >  kthread+0xfc/0x240
> >  ret_from_fork+0x243/0x280
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> >
> > This can happen in two ways:
> > a) systemd freezes the user session cgroups first (which freezes the fu=
se daemon)
> > before invoking the kernel suspend. The suspend triggers the wb_workfn(=
) ->
> > write_inode() path, where fuse issues a synchronous setattr request to =
the
> > frozen daemon, which cannot process the request
> > b) if a dirty folio is already under writeback and needs to have writeb=
ack
> > issued again, in writeback_get_folio() -> folio_prepare_writeback(), we
> > unconditionally wait on writeback to finish, but for buggy/faulty fuse
> > servers, the request may never be processed
> >
> > The correct fix is for sync(2) to skip the sync_inodes_sb() path entire=
ly for
> > any filesystems that do not have data integrity guarantees.
> >
> > A prior commit (commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INT=
EGRITY
> > mappings in wait_sb_inodes()")) added the AS_NO_DATA_INTEGRITY mapping =
flag to
> > skip sync(2) waits for mappings without data integrity semantics, but i=
t still
> > allowed wb_workfn() worker threads to be kicked off for the writeback.
> >
> > This patch improves upon that by replacing the per-inode AS_NO_DATA_INT=
EGRITY
> > mapping flag with a flag at the superblock level, and using that superb=
lock
> > flag to skip the sync_inodes_sb() path entirely if there are no data in=
tegrity
> > guarantees. The flag belongs at the superblock level because data integ=
rity is
> > a filesystem-wide property, not a per-inode one. Having the flag at the
> > superblock level allows sync_inodes_one_sb() to skip the entire filesys=
tem
> > efficiently, rather than iterating every dirty inode only to skip each =
one
> > individually.
> >
> > This patch restores fuse to its prior behavior before tmp folios were r=
emoved,
> > where sync was essentially a no-op.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a-asuvfrbKXbEwwDSctvem=
F+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com/T/#m632c4648e9cafc4239299887109ebd880=
ac6c5c1
> >
> > Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and interna=
l rb tree")
> > Reported-by: John <therealgraysky@proton.me>
> > Tested-by: John <therealgraysky@proton.me>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> I'd note that previously, if the FUSE server was not broken, although
> sync(2) would not provide any data integrity guarantee, it would still
> flush the data so practically, there would be no user observable differen=
ce
> unless you really did powerfail testing. So some users might be
> unpleasantly surprised by sync(2) suddently not doing anything on FUSE
> filesystems. Maybe for SB_I_NO_DATA_INTEGRITY filesystems we should at
> least kick flush worker to do writeback in the background?
>
>                                                                 Honza
>

That's a great point. I'll make this change for v2.

Thanks,
Joanne
