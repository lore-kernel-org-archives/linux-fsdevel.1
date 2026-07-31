Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A783537E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510763; cv=pass; b=mdSPgP0sVG2y0aOY2btrSgREpgT1IcT03q3hgncVqnG4PUQhumZSQzuVZ5PWDvzPa5KXUsNp41DhTZNOI2/MQbqaH1rUV6Fp9r9TS/41gCqpTH4b7yyeahrSxcR2iCfQTHTYdBmlouxuZA//BV0zHb21oPdXBELAErh+ffz4VMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510763; c=relaxed/simple;
	bh=IdgRWRvcnCirdUh5sQzR67qnIXGYMC7nya6/mcmjJ6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLo23IGGpHTvuLzlKUkkPLvOr0GJQua7KP15exD4Ugc+dAnqMNZtDyoe3vBEmbKVDxmP4Mi5mJbvu0IUq9xh/mVgMTW37hJLRwzUEOdQ9pnf74ksylTFeIb2ItVcPZex1Y8urYnCJfTkv3x1L6jt/bP3G0PMbBZ6aGlu6CZy2vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfGnMGI1; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfGnMGI1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15e03c2763so196046866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 08:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785510760; cv=none;
        d=google.com; s=arc-20260327;
        b=SQjTLIYEST7wXQdc0qRXiYLApL2ohmBsNkCYvlaK6gCrHUudFZOx3dR4IT6cAi1Bj+
         YP8proSLIduIi+sMZkRbWzsiEtUHDKzR1wW0CV+EpOukKqhrdd7YEkgig3Xgfoe4HCom
         HnS9vLbjZ565wscHPnDt4hiGyY0MQZN+FN0eDf/Sxgdi66ESVq/ohrE9VWzp4MXIj9Ju
         /1L9h8hBZP/5YuuMYl+DSCSCn2Bnzac6wVTGkNDvfiOWomQmMVlkS+aFsHSVPI7mWLP8
         J9hlZsIxC4xAZaGreiafoj95pYszLP+zceHQ11+A1FcJYzRiIlYt0WJSD5tNSp++H2+4
         xOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=COI6X7kAr0YuBq/GVy19CEVE+2293eraElc4C5SyyoM=;
        fh=7Vh0mOFzU2E4Zyq7VDdmTwuMRZXoHkaZE8/Hrso1/AA=;
        b=EU2qvnhA9Si1GxILincpApF3pyZUBn0HNm5uPdrippdQGfWtPe+N81Ji8cRkEl7ezg
         Aw/BZ5U67PYrb8K5aN3TUWfrc/I+8ch8qIceHsgAqF/xlj8CyqDhlS8JxjP2++6HUW7A
         KajAixQGs/CAdgEmSAc+uLi8Wj1bNKPEsZIo1bnWsGPy5Ntgry2/C8/EEXrogxmOwF3g
         yP8l4GyXDBhuLAULnxMjdULdz5/Jh+5usTR9FkpSwVO2XHhvbgkN307OC05/FNKGVxO2
         bj8oHXEUfHUkFsn1SrDe7CQRGRPfcFrdYFYMzYLaetvq0Gu8L8gMn2J34oIK2AGZ84xk
         jjhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785510760; x=1786115560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COI6X7kAr0YuBq/GVy19CEVE+2293eraElc4C5SyyoM=;
        b=UfGnMGI1ajycYMdA1TIvJw+Kg1jL55+1iGwLpVHhOEskXqIiSkLkqYz/js6Sk8Z4K1
         LNqTlfHsv+XtQ0uuIq1zN3wNAohwxuG8PmT2giSrazVUvnaYnIl/7CR7RfCZO2cH1iU4
         yyVmjTCt5m5JyZfl8o0aUAhKxd4Zmwnv8AwySWgWG5vf5uF8DkE8Oux2dy09JIZrPwXI
         PD0+Y3DOx2gFLv7zRbkbnNX7ENrF8jVylCUiLEvwjWd1MreseOZF8++fHjZDyB0HvpQs
         xncuMJXSfMFEL4DCAqRKnPHZeXHPvKHJKZJDahXOyCRYC5yvJ3h9p+87JAAIZeQTQcQ/
         55zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510760; x=1786115560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COI6X7kAr0YuBq/GVy19CEVE+2293eraElc4C5SyyoM=;
        b=TdyYhUe/iIAZDo7/UB1jM4QcSxnHIpK+vADCI68lzLzznKukvt/7dR5ewNgBN2ysEx
         D9GH+7HEzcDWastzlqXiq/gL98Jlk0cdoXGiOcE6BnRw0RQSs70c1gGQupIRse+A+86G
         kEzAI5Iv2NMA4sYZLWaTXsRsk8zIiyi4geGrvwk7UgsmZAhwzvpDxuN2JglvByJshZO3
         bMphru8RignPFJMnH5yGScDKvOyGkxAEjGlJgl+B7yqEuZDhSBxIwnm06sSBOihPR6mI
         5YmDejVDRwsP3V26jMS/PKLV9xYscHOU1inL650LdiOYisnMOvsnOCdp8CbiOt639Bmt
         kiwA==
X-Forwarded-Encrypted: i=1; AHgh+RqsjFN9aIZs94p5WNhW3QPePlJAhp82vdSOvr+N4sTJCBCRpd5IJ94DPxfqRRAJzoZZ/bl0n+3eCOabWwYI@vger.kernel.org
X-Gm-Message-State: AOJu0YwRvJ8OHYnP1gkR7+PA+EzC2bzcL+pp/XTFmd87Vm6kuClibQVS
	+jio6/IgY9VeftiQyvUOBnULeFgkcI56IY9kLWC0TzKeGEFjlHWiDUU+OumXNjjlQsrGyj16vW3
	EFGGRhKxLGO7sLf2FbUcIVdLs0zwfSaw=
X-Gm-Gg: AR+sD13eXWV3OXhmYUhM50Z2x7QqzGptpydMsxaQOCemOMavJzpJfQefAZAgeOmsHqh
	/n30xl12vQQUkIgzHk1NqaFwRQNfOI8f6VAOOOiz0IBKz20apT2V7dGzTyG3HttmnDAvWUlu0Lh
	Lm7i5u6/9wlTYrT0JVrT2PgUf0d15VSFmq7VxPd5rf7heiuFkIKpiFuBCsHsxpl/sTAfZ/Ff5LM
	WBacd0F6/JWxhclwsDJtWbS8h40n8i09MFzevM39K7e6XlXz+SSe6uCS8EwWY1K6rfn7m8MIKUr
	bS6fxbsOxVvS2m8JWjYNAM5NKtxkhQfJCNw+W5pQaLYdQRYgUuCA2z4J
X-Received: by 2002:a17:907:960c:b0:c1c:4c72:e6df with SMTP id
 a640c23a62f3a-c1fd2b43f5bmr179379066b.0.1785510759885; Fri, 31 Jul 2026
 08:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430053645.1466196-1-coshi036@gmail.com> <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
 <CACd_6n17-pJuNoCLsstP7goocedrr5F8T8BwTjRUNx8frKEPgA@mail.gmail.com>
 <bnchcfog427eo3bxt5h6qautlq7sb2o4ww7cjgad73biycdn5f@np7qkbyqizup>
 <CACd_6n1Sht4xs6P_GT0-+wj1uu9Ww_4X=TysQRvq6ZSFJ71CBQ@mail.gmail.com>
 <amuyCIg0Y1YRiFT7@casper.infradead.org> <CACd_6n3C1btK38SdwiG_RPdxxCQ2qUtp4o-aODhhRzH3LNn+yA@mail.gmail.com>
 <amvwL-diBsUo2ouS@casper.infradead.org>
In-Reply-To: <amvwL-diBsUo2ouS@casper.infradead.org>
From: Chris S <coshi036@gmail.com>
Date: Fri, 31 Jul 2026 11:12:27 -0400
X-Gm-Features: AUfX_mwphgqJ2lEKI31O2yyr-NVayXI84n6sow3gKp-QJwQDl-y4pYUTfY9lYsw
Message-ID: <CACd_6n0FW=9H9iesZ3p3+=6yXnvvH5Wz3svS1kpa2qiPuKZKvw@mail.gmail.com>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My pleasure. I did a small check.  bh_offset() is indeed the only
b_page user left, and
it applies as-is: my patch guards the four callers that can see a
folio-less bh (__bh_submit(), buffer_set_crypto_ctx(), and the two jbd2
checksum helpers), so bh_offset() itself never sees one and stays the
one-liner you made it.

Built and ran the replay test with both applied - ext4 data=3Djournal,
blocks starting with the JBD2 magic to force copy-out, sysrq-b without
unmounting, then mount to replay.  Recovery completed, md5sums matched,
e2fsck clean, and an instrumented build confirmed the b_folio =3D=3D NULL p=
ath
was taken.

Series head:

  1  buffer_head: Remove b_page                           (yours)
  2  jbd2: point the temp bh at the frozen data directly  (b_folio =3D NULL=
)
  3  ... the buffer_write_io_error() conversion Jan asked for

I'll note in 2's changelog that a folio-less bh must not be passed to
bh_offset(), so the constraint is written down rather than implied.

Chao

On Thu, Jul 30, 2026 at 8:45=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jul 30, 2026 at 06:09:24PM -0400, Chris S wrote:
> > Yes, that works. And appreciate your reply.
> >   I prototyped it, and it survives a journal replay.
> >
> > Six sites, with bio_add_virt_nofail() covering the submit side:
> >
> >   bh_offset()                     b_page may be NULL
> >   buffer_set_crypto_ctx()         NULL guard
> >   __bh_submit()                   bio_add_virt_nofail() when !b_folio, =
and
> >                                   skip wbc_account_cgroup_owner()
> >   jbd2_journal_write_metadata_buffer()
> >                                   b_folio =3D NULL, b_data =3D
> >                                   jh->b_frozen_data, not folio_set_bh()
> >   jbd2_checksum_data(), jbd2_block_tag_csum_set()   both kmap the temp =
bh
> >                                   (fs/jbd2/commit.c:705 and :745)
> >
> > 4 files, +38/-12.  I'll send it as the first patch of the series.
>
> Fantastic.  Would you care to also include this patch as part of your
> series?
>
> From f7cd3419ce0518ba429ac854282888833bf60147 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Thu, 30 Jul 2026 20:43:22 -0400
> Subject: [PATCH] buffer_head: Remove b_page
>
> All users except bh_offset() have been converted to use b_folio instead.
> Convert bh_offset() and remove b_page.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/buffer_head.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 8b23bc9a244c..3881141a3ff1 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -59,10 +59,7 @@ struct address_space;
>  struct buffer_head {
>         unsigned long b_state;          /* buffer state bitmap (see above=
) */
>         struct buffer_head *b_this_page;/* circular list of page's buffer=
s */
> -       union {
> -               struct page *b_page;    /* the page this bh is mapped to =
*/
> -               struct folio *b_folio;  /* the folio this bh is mapped to=
 */
> -       };
> +       struct folio *b_folio;          /* the folio this bh is mapped to=
 */
>
>         sector_t b_blocknr;             /* start block number */
>         size_t b_size;                  /* size of mapping */
> @@ -172,7 +169,7 @@ static __always_inline int buffer_uptodate(const stru=
ct buffer_head *bh)
>
>  static inline unsigned long bh_offset(const struct buffer_head *bh)
>  {
> -       return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
> +       return (unsigned long)(bh)->b_data & (folio_size(bh->b_folio) - 1=
);
>  }
>
>  /* If we *know* page->private refers to buffer_heads */
> --
> 2.47.3
>
