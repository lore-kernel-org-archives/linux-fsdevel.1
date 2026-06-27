Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3F815B998
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jun 2026 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521553; cv=pass; b=lwkWTkKSfrM8wq5qvZTGkjdH2kOdwojhMVJ6X0lwsU4lWrpGUr55Cjo9TtAfYOUhSPHPfzZaJQy7P7Fx2adfepqxjUxOQ1h9UblVm8vd5o1XOkCIbXDSh8TdiqEukiyVbS+WBdfBqywAOIdvM6uBrTrXeQIHBNT4IlnqmHfBArQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521553; c=relaxed/simple;
	bh=brO8EdFdNeP9Vb8g7/GotId7wEaoEi/JoUZfCX+YxuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3o132L7dEFf3igXnH41MQRjiykC+3iLlp143QN6CzodWANFpUt2KYo5BXynzAtdNHLxtRv82sn4Hx7snLP7ew/ou9BXFF8yr2Joqenla+HeKwn9fMlezdSvugSpOFdmxULDa0HwBX2YrjTJI5ShsjCTTjxXPHEqDeOaBhLC0zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=KmVwxmvL; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="KmVwxmvL"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a1133217easo667668eaf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 17:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782521551; cv=none;
        d=google.com; s=arc-20260327;
        b=aCgoleD+OBpSDBqnXPa3fC7sV3NEDYaBvlcZSlpUupc7S9GN/3wjC+l/cQRzqLmFxO
         4eHXaHnJHKsNo4ayXMXDq7QaCACse2JNmAQrYHeBeFywM76AoiFLcjMSPlseY/Amml5i
         dYfiztR1YDC6Z6sDRCChmRmjxuUPLZ4dqsZ1PrqFd/XHkqqehXjTEZBQ+imHYG4n3zMG
         USkBLWbdBXbeUZkicC2RygXF4I7vdsw3P9pIbK5oz+2ChBXQJOmSSerzToY+ixBkC/WV
         gDo/OMImfhkYFzojLxLTvFI+17oagHa0Fpxmz2/3aebZ9W3pNf3qpVJZ10wdk+LMUOg+
         /peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZHCESSRd1P0dw/R78GsTFnwS7wbrkg4aLEU3H1At6P4=;
        fh=sF8SN7CNJYgg9Xv9JpjQo+MiCuXP2zUVmKS53vjVIXc=;
        b=kTnwIAwtDkCS7/7DykXo3U1ctocPI0U/fbE5BUDXdJ+TVVd6XwOuth7ElLCCdGcqKs
         Zfc4n6fGPO2wXPpwVz3nVkk2jOMcbt5Ye6XnSwVi2EgGcLP8gkExWY3RITbM7EsimzEt
         VWahqSirYO9Ghtq54oLvsJzt26l644YihaZ+Q1lUYDuW5K2D2jNtKRTs/jqUHaa3nfz+
         5Fi70r/kcJj+pB9cmGYbnsMjIaHpDukjt4+QV+hVqZFGSNF7OEGVf9CtS0O8y0PLizHb
         pG9/1UU52e7xw7rlpQ4ov5GpUBE7zTFHYbLjambQMdqrRSFv06ZNbU2QSGLk4d/RxVzN
         jF5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1782521551; x=1783126351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHCESSRd1P0dw/R78GsTFnwS7wbrkg4aLEU3H1At6P4=;
        b=KmVwxmvL7fD4fWl52WaPISoL8VZF+KMdD6KcrGIIvC4Tcf4+m9RoJzYShAw19JlkSW
         aOUewA1YBgtTUiGhdYqtXXjFcQIi+TUGVS4NaoO4olqaTmvHK2m90lR2zP4pAWny1yA3
         3+WG/V10bF1YVIIsMZv2xd2xhQP2kldqS8hvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782521551; x=1783126351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHCESSRd1P0dw/R78GsTFnwS7wbrkg4aLEU3H1At6P4=;
        b=MnyZ9iIh0Uq1R1ErScU+rQmUWb3dTt89WKUDqjvhUw/jNyyv/bXYQGGpYpEoOwJPbR
         KzZl+UM9erxYhgUdYcmkd+X9GPDMuSaKYOtuULmQeQ6IVzC6rmOp40OqyvWvFodwB8pa
         FdYzdiI45FSTQnh3RqLiVjwOevNRrJer1Ah/G9yOV7M6FLVaMY2loS0OfAM0njIasqPL
         MoURzqrjeEVdnG1eFX80gjD63Or6op3uoY+1o+6/T1qgXrig4PAWUEhgwE9JhyzxFQDh
         vLW0LwXXtOmQ0Hh7TcPyUTkNauen9xDGj63StXv+kfiePPo1vpYaVCjYP0VjgP+t/BUs
         T9Iw==
X-Gm-Message-State: AOJu0Yy8ue8DeQfevU9/6O+GeSBOo89viMt/MLjLUR//6RZhotQVM/9K
	2cvCvDxC6LeTupnktiCQJVI7ILydbqdufNjIEK6dPMoSlDn5TXkbPIsxmrs7U90I9yefUC85fvC
	iQcV5abOho3QYpFYKEBYmAqLDtQHeqS9r+y9+5ZH8upxIfFsXgvP5iRcQKA==
X-Gm-Gg: AfdE7ckp3mrstl1u0IwbQG5DUEDF6wptluRsVT4ebcRST2uZoYFVTw3QhJGrKwRNOAx
	rcmGHe2AMe7w8ksc2jXYspOnpTFbG6LyQfZ5Ke8eZB4b8UuI3EABluxKamru27o6uMQ8hIQ3/W2
	KD2UHq1ErsIaEaasn/i9Bzg21FuiK90oXO+R8WB2Hk6kKg0eKddFrgQuMTUhz0YffRrYstl2v8d
	odjbZH5M+RtKSHKj65UtTG+kU4D17RGe4rScaFQOJ/lmI26mwo3vgKghLPnQI93o826eFyGfkkW
	YCAtBy6ZR6v1fyJpHpF30iPt70lagdnI/FWFacqqZu8=
X-Received: by 2002:a05:6820:c0d2:10b0:6a1:3e91:dcaa with SMTP id
 006d021491bc7-6a13e91dd34mr3251589eaf.22.1782521551412; Fri, 26 Jun 2026
 17:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611212633.5058-1-kylebot@openai.com> <04c1bff937f903a43820ae4c916b6ea919944869.camel@dubeyko.com>
 <CAC7i46-j-5QgBcv2Bm64NUz+T5nkTBhiRmh=a7i0_hd2x099Tg@mail.gmail.com> <a6220ce5bf7f546c77123934974a0f94f19a6711.camel@dubeyko.com>
In-Reply-To: <a6220ce5bf7f546c77123934974a0f94f19a6711.camel@dubeyko.com>
From: Kyle Zeng <kylebot@openai.com>
Date: Fri, 26 Jun 2026 17:52:20 -0700
X-Gm-Features: AVVi8CdB0ZYf0zX8JWkLTIpzZh_HzYiGLF74z95XaaMxAxtPjn9Jk0P6oGN3Mbw
Message-ID: <CAC7i468bgEXQTdj_xheFeGiJ+T+3c+OX55HWgpct4pvpwuSWgw@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: validate thread record before delete key rebuild
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, outbounddisclosures@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viacheslav,

I hope you had a great trip.
It was difficult for us to test the patches without knowing the exact
number of xfstests failures. So I wonder whether you could help test
the two HFS patches we shared previously.

Thanks,
Kyle

On Mon, Jun 15, 2026 at 11:24=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
>
> On Fri, 2026-06-12 at 16:08 -0700, Kyle Zeng wrote:
> > Hi Viacheslav,
> >
> > I prepared a xfstests environment and tried to test the patches.
> > But unfortunately, due to my lab environment constraints, I could not
> > fully finish the tests: some tests errored out even without the
> > patches due to environment constraints.
> > I think you will still be the best person to perform the test. I'll
> > ping you around end of June.
> >
>
> Currently, HFS+ has around 15 - 17 xfstests failures. If you can see
> around the same number of issues without your patches, then you are
> good if your patches will not increase the number of failed xfestests.
> Anyway, I'll be back in two weeks and I will be able to test your
> patches in more reliable environment. Sorry, I have pretty no time and
> capabilities to run xfstests during my trip. And not very much time for
> the review too. :)
>
> Thanks,
> Slava.
>
> >
> > On Thu, Jun 11, 2026 at 9:11=E2=80=AFPM Viacheslav Dubeyko
> > <slava@dubeyko.com> wrote:
> > >
> > > On Thu, 2026-06-11 at 14:26 -0700, Kyle Zeng wrote:
> > > > hfsplus_delete_cat() is called with str =3D=3D NULL when the last
> > > > open
> > > > reference to an unlinked HFS+ hardlink backing inode is closed.
> > > > In
> > > > that
> > > > case, the function finds the catalog thread by CNID and rebuilds
> > > > the
> > > > catalog key from thread.nodeName.
> > > >
> > > > That reconstruction path reads thread.nodeName.length directly
> > > > from
> > > > the
> > > > catalog B-tree into fd.search_key and then copies length * 2
> > > > bytes
> > > > into
> > > > fd.search_key->cat.name.unicode. It does not first check that the
> > > > found
> > > > record is a thread record, that the record size matches the
> > > > thread
> > > > name
> > > > length, or that the name length fits in the fixed HFS+ catalog
> > > > key
> > > > buffer.
> > > >
> > > > A corrupted image can therefore provide an oversized thread name
> > > > length
> > > > and make hfs_bnode_read() write past the catalog search-key
> > > > allocation.
> > > >
> > > > Read the CNID record through hfsplus_brec_read_cat(), reject non-
> > > > thread
> > > > records, and explicitly bound nodeName.length before building the
> > > > delete
> > > > key from the validated thread name.
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Assisted-by: Codex:gpt-5.5
> > > > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > > > ---
> > > >  fs/hfsplus/catalog.c | 32 ++++++++++++++++++++------------
> > > >  1 file changed, 20 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> > > > index 3f0cc1b1bb58..000000000000 100644
> > > > --- a/fs/hfsplus/catalog.c
> > > > +++ b/fs/hfsplus/catalog.c
> > > > @@ -351,23 +351,31 @@ int hfsplus_delete_cat(u32 cnid, struct
> > > > inode
> > > > *dir, const struct qstr *str)
> > > >               goto out;
> > > >
> > > >       if (!str) {
> > > > -             int len;
> > > > +             hfsplus_cat_entry entry =3D {0};
> > > > +             u16 thread_type;
> > > >
> > > >               hfsplus_cat_build_key_with_cnid(sb, fd.search_key,
> > > > cnid);
> > > > -             err =3D hfs_brec_find(&fd, hfs_find_rec_by_key);
> > > > +             err =3D hfsplus_brec_read_cat(&fd, &entry);
> > > >               if (err)
> > > >                       goto out;
> > > >
> > > > -             off =3D fd.entryoffset +
> > > > -                     offsetof(struct hfsplus_cat_thread,
> > > > nodeName);
> > > > -             fd.search_key->cat.parent =3D cpu_to_be32(dir-
> > > > >i_ino);
> > > > -             hfs_bnode_read(fd.bnode,
> > > > -                     &fd.search_key->cat.name.length, off, 2);
> > > > -             len =3D be16_to_cpu(fd.search_key->cat.name.length) *
> > > > 2;
> > > > -             hfs_bnode_read(fd.bnode,
> > > > -                     &fd.search_key->cat.name.unicode,
> > > > -                     off + 2, len);
> > > > -             fd.search_key->key_len =3D cpu_to_be16(6 + len);
> > > > +             thread_type =3D be16_to_cpu(entry.type);
> > > > +             if (thread_type !=3D HFSPLUS_FOLDER_THREAD &&
> > > > +                 thread_type !=3D HFSPLUS_FILE_THREAD) {
> > > > +                     pr_err("found bad thread record in
> > > > catalog\n");
> > > > +                     err =3D -EIO;
> > > > +                     goto out;
> > > > +             }
> > > > +
> > > > +             if (be16_to_cpu(entry.thread.nodeName.length) >
> > > > +                 HFSPLUS_MAX_STRLEN) {
> > > > +                     pr_err("catalog name length corrupted\n");
> > > > +                     err =3D -EIO;
> > > > +                     goto out;
> > > > +             }
> > > > +
> > > > +             hfsplus_cat_build_key_uni(fd.search_key, dir-
> > > > >i_ino,
> > > > +                                       &entry.thread.nodeName);
> > > >       } else {
> > > >               err =3D hfsplus_cat_build_key(sb, fd.search_key, dir-
> > > > > i_ino, str);
> > > >               if (unlikely(err))
> > >
> > > Have you run xfstests for this patch? Sorry, I am in personal trip
> > > right now and I cannot test your patch until the end of June.
> > > Please,
> > > ping me around that time.
> > >
> > > Thanks,
> > > Slava.
