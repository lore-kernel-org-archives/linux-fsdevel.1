Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220838C41A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780968; cv=pass; b=gMxkmlWgeI4xwhPwlwRBvlzM9N/CmlUZGkPLw0DnJ1Q3aN0VsIKnasrPioUqIbAgw+dFUrsaYAk3o83Zk5dTqJav8N/t8HrdPTnJevSu6Zo+hbry2CZv7JgGblvJ13EAEfKtq6fRXecRm86neue3E8sOzQoq1zVaMSO5zuzhywM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780968; c=relaxed/simple;
	bh=30L/GqxGwE4ij2te62giWC36PYHpNRvdg86xgyioZ2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhizSnY5o46lngG9uE1/yLFaip3jQzgapSmVPG/pzMW1PLXchXdAJ03KkQYByqlYCpBkc4q3K8j7KGYfkDp4frKukUZ6PlxEK4LHBAut4GUBn4FFujxUe6ag4UG5iW1ANv56PaQrdGARbnO1y56gmhhs33Es/cQ2CNHLuwHOIWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPGf1l5B; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPGf1l5B"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48532925a4bso33047925e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 13:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773780966; cv=none;
        d=google.com; s=arc-20240605;
        b=Jh05ycsskzKZPD4yUIDekQR9PNdmSNjh8G2v1+gECiKp/9jw4y5m81OV+HVxnAePFC
         7nDE4oAnrPwIsQZw2LCFIppYI4V5ZL9sWju9FAadvuMqY95yyBPw+bABETSTRuusi87D
         ErvuqCzP2rbAx9i5PQxjONGIeJuTt3lHTI51TNJBZPXE6gvcJpHL5rG6zkwY+nhZtjfg
         3pw5pJW6i1YeA6KK7EY8VIopWeg2RLcdLIHjYGIJDTPV+UCGWw+ImV1PPYbsUkqWButB
         Uxv0XgTzfx/whZSINSOkpY9Wqfg+nmaK8MxN1CxTose8QJhFRdvpz3al1X+aw64CXYws
         Nfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGcAEBR21UBhl/W8wjEjj1w1vEEv5juI/qX/znq8GGk=;
        fh=ObdL1IjTm6huzhgnk0hycLBZR/1lsmsTgtQSGZGkqgk=;
        b=V9wwwDFrXj+R1G8gIZv8yJKRImF7533ybRE65qv+ed7rN6zC2JPiIicChkOXLsQwne
         MCGvJWQftypIz8xP/9zRDWSds0Gg80Pcf6dbGi6tIB7oD0IJstesk88ZNoV6hYz62mEb
         hYKcU1y9bdkR+GX7R2XisxbZubJ4sU7GtwdzV/oOFd3Ci4R1BoOUJ2sy4Ye7D46gVihG
         2xSkqKuN/xjPlBjst0EAhIkpxeM71PGo2e+8aVoVv+87fzYhqgeSaipfGw0hbW6+0ayw
         ExNtadSoap+r+s3BgVPEuP0XaOiDfZizhnzykEzvFi7jUtmh0bogx26CTnSJzQRJky6F
         nwTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773780966; x=1774385766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGcAEBR21UBhl/W8wjEjj1w1vEEv5juI/qX/znq8GGk=;
        b=mPGf1l5BbKVePuSU7ZV7Z4BsbjEa1tsNgZOJgmenpIIuwLMrq7xLu6lfR3D4TQrsTw
         duJClHuFjDenoUKj4x/0jsyLYe63f8pIlUrEaObfO6PBTJ5jTF6GZStNLtpgSVHlT1KO
         wFflu7i1OvYannsi/rceSNpcHX6K12Ms5CKRSV1GTsgR9Q8acd6VPPzC4eG3W9WV9y6X
         oyJIhhmF/JhtaZQVx1Apa+rPEMEDi2b2gZu7KV5Ptbr5Ti15HIHGjZWGGit3HOTxXdRL
         FZiMYA781eIRU58ip0rxue5nm7vhOWN9WVchhUIEShnVBBas9uyEd2iMReWSoKls6ghI
         mEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773780966; x=1774385766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGcAEBR21UBhl/W8wjEjj1w1vEEv5juI/qX/znq8GGk=;
        b=PqWV9DqkHGxqiERI5FGRnRgWeKCzF8Nnxwgq0U9ZRF1HdPL7RZTWp6RJQhNUTO5oBr
         OaiawWXIU+y1sQnD5O25aIWAeXqXOceSs35r1k96ErXhEXexMQcPmi3RkYBOrcwjVZYf
         PRYVnZUowYsgH0XSB01+CthFtpiKYq0tUNZpc7QaEHmeC0kIN8+lP4c0qKAc4yIPr44a
         KBlahopfvxVUpa6bYjjB1rbKV3oAikrl7LEH3fs7McP4Fbqmba9MncspVyk0AWh1xfti
         cBODR/dBKFUY3EbOOYB0RX9kf986pya9u3fwG0DJdvHDN9nG5wBjRyXZKxUr5ITxe8tw
         KoPg==
X-Forwarded-Encrypted: i=1; AJvYcCWlFfvCUko8wYUYqkiAcktLpTD90sub2v6Gw0Eq4ppXK2Y3fa7bwjleBJAwgajN34tMLHwTVqsR5JYqcXXn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+Mb7Kr4gfUG22LmbnD6VGQM20IGphFEolOpBtsfxn+BR5MS1
	h6uuAoNStcmEfXeYEwaEgKy7h0tgOWRa4/yaOsCHYWAActpELazhWKU7JXA23Bqws99FlrFqEsw
	wT4QWBYciPgJVIX2Ih70ZPkZirGM6dgY=
X-Gm-Gg: ATEYQzy3AP3I167mNEScpMXNXOmLYm6Gp+7NDf6kqR7vH9/Z8yOcmksaxMQYt7jLYMk
	9trn4ugyi5XZ9ggehb2RmNrpHiHEE7V2bboHZAozcY2DstUahGTL3x90CSDJqOoXXzESMZNtMNH
	0eW383Qk+3AMmaeKtnKJaojwf4aTyo56NnzZwXPIuni/3WNQ8W4c6pgFLLU9NQ9tKwgf6Rbc55D
	5RLkatalvSoGYTXHA8wpPZvGjad0nDnYfGjmzW2PaZSYIfxQcCEWtHB/eGB0opvdt0L9mx0HiQW
	wlRqgA==
X-Received: by 2002:a05:600c:a08b:b0:485:39d1:b500 with SMTP id
 5b1f17b1804b1-486f445315dmr16500215e9.16.1773780965545; Tue, 17 Mar 2026
 13:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317203935.830549-1-joannelkoong@gmail.com>
In-Reply-To: <20260317203935.830549-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Mar 2026 13:55:54 -0700
X-Gm-Features: AaiRm53wUE27CrAaPdpinpr9TjQa0y7_Qnc3aVfdqtm8WwV7AAtfKLnauwMTyo4
Message-ID: <CAJnrk1Y_LmQ0kZrKSGTWTXa-fQy550mwULqzUhSZWB8d9qqvUA@mail.gmail.com>
Subject: Re: [PATCH v1] iomap: fix invalid folio access when i_blkbits differs
 from I/O granularity
To: brauner@kernel.org
Cc: djwong@kernel.org, hch@infradead.org, willy@infradead.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, stable@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 1:47=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Commit aa35dd5cbc06 ("iomap: fix invalid folio access after
> folio_end_read()") partially addressed invalid folio access for folios
> without an ifs attached, but it did not handle the case where
> 1 << inode->i_blkbits matches the folio size but is different from the
> granularity used for the IO, which means IO can be submitted for less
> than the full folio for the !ifs case.
>
> In this case, the condition:
>
>   if (*bytes_submitted =3D=3D folio_len)
>     ctx->cur_folio =3D NULL;
>
> in iomap_read_folio_iter() will not invalidate ctx->cur_folio, and
> iomap_read_end() will still be called on the folio even though the IO
> helper owns it and will finish the read on it.
>
> Fix this by unconditionally invalidating ctx->cur_folio for the !ifs
> case.
>
> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Link: https://lore.kernel.org/linux-fsdevel/b3dfe271-4e3d-4922-b618-e7373=
1242bca@wdc.com/
> Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and r=
eadahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3cf93ab2e38a..e4b6886e5c3c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -514,6 +514,7 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
>         loff_t length =3D iomap_length(iter);
>         struct folio *folio =3D ctx->cur_folio;
>         size_t folio_len =3D folio_size(folio);
> +       struct iomap_folio_state *ifs;
>         size_t poff, plen;
>         loff_t pos_diff;
>         int ret;
> @@ -525,7 +526,7 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
>                 return iomap_iter_advance(iter, length);
>         }
>
> -       ifs_alloc(iter->inode, folio, iter->flags);
> +       ifs =3D ifs_alloc(iter->inode, folio, iter->flags);
>
>         length =3D min_t(loff_t, length, folio_len - offset_in_folio(foli=
o, pos));
>         while (length) {
> @@ -560,11 +561,15 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
>
>                         *bytes_submitted +=3D plen;
>                         /*
> -                        * If the entire folio has been read in by the IO
> -                        * helper, then the helper owns the folio and wil=
l end
> -                        * the read on it.
> +                        * Hand off folio ownership to the IO helper when=
:
> +                        * 1) The entire folio has been submitted for IO,=
 or
> +                        * 2) There is no ifs attached to the folio
> +                        *
> +                        * Case (2) occurs when 1 << i_blkbits matches th=
e folio
> +                        * size but the underlying filesystem or block de=
vice
> +                        * uses a smaller granularity for IO.
>                          */
> -                       if (*bytes_submitted =3D=3D folio_len)
> +                       if (*bytes_submitted =3D=3D folio_len || !ifs)
>                                 ctx->cur_folio =3D NULL;
>                 }
>
> --
> 2.52.0
>

Forgot to add 'linux-fsdevel@vger.kernel.org' to the cc list, adding that n=
ow
