Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC63D3314
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962046; cv=pass; b=o2U7UZDU2gVNgVS38nSfH6NBQuq2P+22AALoAMA9BXno38CH+YMhM1oNqxkkTr897WRuolhKmTbHN81vJgKRQ7BevuBvh6aDYdTIUQp8b8gRV6pjPEJzvOPFDjSkOz1tmmw2OheFOOvBsm8JTZo6xwKw7Y7TWH05h5EN7toITqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962046; c=relaxed/simple;
	bh=Tq1GUshZ0URB5eunwgA44UJvtqfscr+nNVhjP+E6wLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7i08MmzkWyCfyDGL8Z0548iI6boodp0XjC2K1ZzT0IypzcVenteeujsm4tcEMupEWDFPLeBHpzWzo3t7fTUzkYmR2Los7ayLW+XCJJ+M1FX8tCq2VBjyT35eqQtXOD+Tfg1SYtyvyCU4e3m4a/SgAVQXNqX7m/cyUPRaENdXlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGqx1WOR; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGqx1WOR"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6acad9fa466so844292eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 13:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785962044; cv=none;
        d=google.com; s=arc-20260327;
        b=M5y9MMpv8eOYvNtXWPHKkz6bU6ZiDCa3r7s9NBW+ki3KzebqKdw9CDtSoakUHaZMCa
         NOEBdBrqWlnV2/lvEUklLr2OQ6F8wn4GKrQRC6c9MehBmMyK/Ivc9OYnstZE00bMMvJA
         odzgMo7+lYO/A/RPguT6A9oG8hVmS4240Az4WT+bBLZGqjRH89BBYPY5LbM8qXPVRcCO
         Pw30WymuuNKZA5mbOZu1V14OTyqgt8DeylLUfqSvPdY5J5lrW7Z/1SUQ4DJMAAVhk30E
         2Qdm8nVNjWs2ECM0ScxJlM2qP4bU3fKqOUsdiXT7rTeSfLC6zu+25gaLmTDwcwnp0Zkt
         Nlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kA/AU2w3280P+roGG7oJQqeX77M5dx6w+CVBmDt93wg=;
        fh=9qNw+aC+tVQoRpZd2AVn586/Gz4JbNV35paXWabypyQ=;
        b=a/OfxNEBc5bzHppcSINwfPTJ6U62FeaBPH8TNXbWSqSO3TViZxRIGWhFXp30+Gjq/C
         22N3ipRZHN0Gi91ekbV0rVaYv2vw2uCrWQq/ODgyEAhHhdos5Yhzpb34rAMSN67t1DY6
         tyvv2/cvciu2OJ3V874uG87wqNyOZYlFxam4Xy2zpYPRZKvNlB07g4B+XMdlQ147zDH9
         8+321FEoi27OuO+fqmBJ77uQaz3tUa0ctjQLMSZ4z54SjhedqlHNZQU3/1tumXUFPjSS
         yRzKGG2LPZWon0Gq+ZvEXqVDKVqIja5YfMdh9kDdilygV0LZtysMReVyvvBN95GG8z88
         yRsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962044; x=1786566844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kA/AU2w3280P+roGG7oJQqeX77M5dx6w+CVBmDt93wg=;
        b=eGqx1WORislurbX4DfT0fo99XWmdIrpBohj6ZAeojvHfp5QRZd2gvxubf/EHMLtse0
         hS1ALU1BJdki5m3A1TFbSIEFdINh89JTr4Co2JnPvx5bFc5G5UYsDd7ZSEmXIzw2H55m
         Qo/A/PgM7bQfiFDglJ4lGdIXKARwN6meNj6aO4aTNWqy0mTltI/5uu9t4JSGJMY+hQ2U
         xoVuCvsbmPcBPlM5ON1hRPThVqr3mFIo9neXGnocKgWzDJTzIwtTHBz0xS9PJOIYWB81
         N2e3Bkhr06salb1wwHg8EvQ1n5E67DnEYmdLyVxqOYRClnxCNJNvzd6UVdayoKKgDVVA
         DUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962044; x=1786566844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kA/AU2w3280P+roGG7oJQqeX77M5dx6w+CVBmDt93wg=;
        b=htco20NFpGpoIgOLq0skku3gQOuNcVEpz6t8XkbY4LIqeDpBvdy1cTSHOtifj00Cvc
         3RA58VlmrvVVMHSiLByHlz6fUmoyeSvSa63upNqock8f2f5+grZT5mb7Ij2N0+QWPk5f
         ie73zW06DyVapdAI6iwVd3DYEoAoqsBcUDPfv26qaHqFXkIqxTWl9Y9qDUeMywK6JOYP
         WvhXwo7h7c6/eWX+KOB8htEOVxX5lTcUTrXKS0Phiv5p575GBd1iAlq/di48M292SZvn
         CPhTWRCIw78Ive+i84PACUNgZimsFjlyOcy+POshXtF6WZm2/C1CEzW0BULE/kEUHCbY
         Lffg==
X-Forwarded-Encrypted: i=1; AHgh+Rq15aU7XjoaaV+/UKpUaiPAXzQjCNVrnxGLdY+2MyYr/4vJYifUutRT6G2KQxhdMekazlHJi2xrLCc9kvqy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5VYiWYF2tV3oaMgBKc7yRBmEJJNxH9fMW8wX2QNXiP3sp+hj
	n9A+YjyKcfotwQka89lzgCxERAzwn2G32dCdfqDEh+h1ivlqOt6VneYTqIWO/nCvNAXNKtXvM04
	nDppm/X5DZhCJwl3VqYuZq1mJDPz9StU=
X-Gm-Gg: AR+sD13l27C4vm+IoSvajpFr6r1G2d1ejN9ugHMFbtbNnhyb2jqqGZuQ4bX2tNdtSl6
	u8ps2HI+m7PfN9G1RimonKrD33wWAjzWSkolmHVWtUQnfSYNMnRktBtlRKh88YIySLLIz1x3YJs
	Og3+B4FC+6hAylWxvlEBfb5lLkKKM0arO77lNTB6oy8ELTX7+qgEa2eXnLchaxuE48U7CRsMNxs
	fRvgpeZTCm5EsGTNE+ETMoibhD9lQU4yrI590ugg2nSsB5drT9evkP/sYTCJ9kIMi34dHywSCRy
	nCJ+dvlpujb4IKJF/2BPd5a9LiWbBrQjZgRnxTFfgDJG
X-Received: by 2002:a05:6820:208c:b0:6ac:a539:bc41 with SMTP id
 006d021491bc7-6ae96c8ef34mr4814921eaf.12.1785962043824; Wed, 05 Aug 2026
 13:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785621505.git.coshi036@gmail.com> <8aa2ee674d147d3630f73f7b53fef7781f2aeccc.1785621505.git.coshi036@gmail.com>
 <3dqz5hq2phvgugscfk56q2h6ukf2fc3xfgjhoat222sonbhnr3@62pmosi6frzu>
In-Reply-To: <3dqz5hq2phvgugscfk56q2h6ukf2fc3xfgjhoat222sonbhnr3@62pmosi6frzu>
From: Chris S <coshi036@gmail.com>
Date: Wed, 5 Aug 2026 16:33:51 -0400
X-Gm-Features: AUfX_myim6QhFCyzhdj6B0pWIapAMcNebREVxjcQh-jpAusyaGfXWmZ1mZSgYNA
Message-ID: <CACd_6n2WkaxmmKMi7WidJKLJF7sUGfXzXkeQp4pW1W-tjTn4OA@mail.gmail.com>
Subject: Re: [PATCH 17/19] jbd2: assert on a failed write, not on a buffer
 that is not up to date
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Taken - v2 keeps the assertion on buffer_uptodate() and only changes the
message to "Buffer not uptodate!\n".

You are right that a write error is fine here.  I had converted it on the
grounds that BH_Uptodate stops meaning "the last write worked", but that wa=
s
answering the wrong question: what this assert is guarding is that there is
valid data to copy at all, which is still exactly what BH_Uptodate says.

Best,
Chao

On Tue, Aug 4, 2026 at 5:05=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 01-08-26 18:01:01, Chao Shi wrote:
> > jbd2_freeze_jh_data() asserts that the buffer it is about to copy out i=
s up
> > to date.  Once this series stops clearing BH_Uptodate on write error, t=
hat
> > assertion stops firing for the case it was written for, because a buffe=
r
> > whose write failed stays up to date - which is the point: the in-memory
> > copy being frozen is still the data the filesystem wants written.
> >
> > Assert on the condition that still means something went wrong.  The mes=
sage
> > loses its "Possible", because BH_Write_EIO is not a guess.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Chao Shi <coshi036@gmail.com>
> ...
> > diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> > index 5cc7d097b2ac..fdabe34a7e22 100644
> > --- a/fs/jbd2/transaction.c
> > +++ b/fs/jbd2/transaction.c
> > @@ -920,7 +920,7 @@ static void jbd2_freeze_jh_data(struct journal_head=
 *jh)
> >       char *source;
> >       struct buffer_head *bh =3D jh2bh(jh);
> >
> > -     J_EXPECT_JH(jh, buffer_uptodate(bh), "Possible IO failure.\n");
> > +     J_EXPECT_JH(jh, !buffer_write_io_error(bh), "IO failure.\n");
>
> After some more thought I think getting here a buffer_write_io_error()
> buffer is actually OK and we'll rewrite it. Instead this assert should ju=
st
> have a different message:
>
>         J_EXPECT_JH(jh, buffer_uptodate(bh), "Buffer not uptodate!\n");
>
> to verify the buffer has valid data.
>
>                                                                 Honza
>
>
> >       source =3D kmap_local_folio(bh->b_folio, bh_offset(bh));
> >       /* Fire data frozen trigger just before we copy the data */
> >       jbd2_buffer_frozen_trigger(jh, source, jh->b_triggers);
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
