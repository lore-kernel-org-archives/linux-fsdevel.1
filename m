Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F076D279DCA
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176923; cv=pass; b=uJ+ckbyLxotnXQDm0FQk66n4RaYnJbCxOiPnaOo4lmrXSiq1ac8T+itjUga9NUv3GrCQNRHA3PLyERyzS/RVfzzsmw5ueDv9Q0FxTedzNfz5IEqUviewZJy5QjIDZvzcLgdolwdPeiG557AdhlMizsYQbLib5bDxaPJbgnNbO5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176923; c=relaxed/simple;
	bh=SERM1KIbVz+crSEjnqVaFo9yCCkiphW5Gf1Z2ZnRitM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nh/SDDdwrNGhjFxwUsf/cO34uKbXV+a+qot3Z+ufERKE8ZB9u2Af2ys7PEoDLdiQy32zgE5ymoPzEzmo/2q2IA1LJlMU+/tCSGOhKldqGpnEcneJ6C6KxTFb35QD2xsxiIMAFFtXd4pg4V79gFpwkxEsKIYFXTkNeVj7BskPY+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpVWJqUY; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpVWJqUY"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso6606161f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 14:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773176920; cv=none;
        d=google.com; s=arc-20240605;
        b=V3GbVmodk4pfwrqICpHbgNGFS0iBAqBNM+a8s/dUDDMWT4UTbldMQWaDQDgQ70GYkJ
         xRzJCO3GWSmwpY5yFwQmrcO8Fdp6bRUa6D8RNC7bxM/HFo+BVPixZoYC0hiyB4dgOZje
         Wo3b9QX/QTxpDpp3Fx8e/kJjUhwExnj/DAd3NOb5x/emPTz3z1PqxgzUP3cPwwikxI0x
         heXjNYhKUGontVT7Vo/cr84XjdpGLxfQ85koXoKthTaIubNXmZ4aA0TZX6EvV1a+wQIo
         KOVR1bGQZWLiUvMq6eXZictB816vJxRp3dmWwrjA+65sjnt7gZ0+dMLUG0LJLAS/Wey7
         CUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bm3E+N8oekJhnwTHafDthtPb0dhZaLByvpqtWh3IaZ4=;
        fh=h/dfvY/M0fgQSU5sjMaOGS/FGT8IM9WVJs5hcX5Rb08=;
        b=KPIpG9mTbRnSnoL7S+4YBfKkBEB7wgB7LD/7d91TgMMIzUQt/EW3DYqekFpd442DyG
         u/F19Uox40reIyozF1kPREiAN7GAj/ltTroSI818EbBnEWCUuxdSFGfFfleBNcRZixxI
         pV/v/pjZvvYXRosETeC31jtNOTWC2beayI+Yqsc6ln+2W2VQBwd8KNN7Lg2BxF8SoL24
         iZw9wQWxnpbFkS26LrOeQV6gTQyEixPd+6RRiE5CamMkQgyhRxt/t5dpGYxEbhJyPrAA
         bQwRswkcXdOOFY+fP8+COP2pLU+TCohkRFdvOiisixK09/pYs2tmHvtIrDTNvS9FgRXy
         tqaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773176920; x=1773781720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm3E+N8oekJhnwTHafDthtPb0dhZaLByvpqtWh3IaZ4=;
        b=gpVWJqUYyo2P38liMXo3144VIFzMGgCOGPaJHNot2lIJ+iE4kEnWJ3f5WG2PYMfivH
         MEgghOQ2RMuSIMK7MU7PVKNxXknPK5dzxwol5dAHuNg2mz8WylS8lmgNWfdPQcu0RxCS
         2Qy8s0GqXEBHA6DR1SmL+1E7phsJXbNhORfrU8BJc8hws3fyrNfn3P/C6CROKIAtW9UY
         AaE1AAK3geIDxgnZR3+diqkWm0+ug/21TCp2OYZAMdpBIBQ++yDcBxfqE+tAyUGdq9mI
         Oa4RkwwPhkxdNQSiOSd721bkY2SfoxSdfFD5BQ7gf9WWwS4iJItExm0aabeaiSaBm6gi
         8DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773176920; x=1773781720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bm3E+N8oekJhnwTHafDthtPb0dhZaLByvpqtWh3IaZ4=;
        b=pGdCtKM4gxDTbiqbOtJ/64B/1tkc216GKiF2u4gVtDrTeL3DDNPmF82g4ecj3PPG8N
         96XLiV6QJeQtOUkKCHQw1j+neZIeLcAv94ZjNqVAjKqRtgWefJBJT38GxaOdK4ldnx8Y
         AjF8N1l/p1cbnaCZztjaURp4AovQ+TxFeLoTgyLeHkKQH0w10A4wfJzgD0CH72dn4gt3
         qfXGgEjiNy2qXDgSEnWRN+IsIeAAlzIySLTm44Ykqi9PO1xE+2gs5bDYA2G4ABSjqbMX
         NQbDOZa5uu1ap4d8NUuVo3NpzcgWAcaAdItyvCUp0MK7SUC7SOP4zJV54keCzyaAO8lz
         sCZg==
X-Gm-Message-State: AOJu0Yzwmkye6wdlAh3sklfOZ/PVOK/QGDBcyGCl46WNm6NytwPAEnbn
	xcGkn0dKRV9bfdg0dLIoTFn1qUp2L75fNZa5QZuVeUgGU1Z6Rv/DQxPSnM91SDgOGpsb/BIQ3e8
	TIuuz7asP6H1y+c+8PNQpK1WXJ6YK9EF5KTjeds4=
X-Gm-Gg: ATEYQzxxitvPnV7soyq/u+hFqVHp0nXso1qvmmG7QQL4YkzhsNM/RACLkOKtUCFxFJR
	bTP4HyDLHIc/zRIW4QDfYBuPrd4QpAkNHJSTTUh2YjuGQWGdSDsIJ0PdlraeFJ65UTaP70xhlzr
	yosvvjGlsdrCpBHh4nFDOflTby1rAtF5xthsUKLEqTMMv/SGzgsCxxwXUsMjg/lkkgjcI1h5sER
	uVrYPDOjkyHwt7oladsZRw7HHHejS/HniGH+n+zVtj4VWhJGSBwMuf862reMmWi+xScJjcjH+UV
	5TeOzw==
X-Received: by 2002:a05:6000:2485:b0:439:c1ca:82be with SMTP id
 ffacd0b85a97d-439f821b679mr632084f8f.28.1773176920172; Tue, 10 Mar 2026
 14:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com> <CAJnrk1a0BLS1+1uf8BqKCZ6+vXdxDHkp3WtjGgz8A4e=sx9C0g@mail.gmail.com>
 <35327273-23ae-4fc7-93b9-03bd4abf631a@wdc.com>
In-Reply-To: <35327273-23ae-4fc7-93b9-03bd4abf631a@wdc.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Mar 2026 14:08:28 -0700
X-Gm-Features: AaiRm50WJqxCv_v01ZAKzrmIFBGJwjCtbRIzf-ky4shoSOJeDmdmRSMif2IOcy4
Message-ID: <CAJnrk1YSW5m6mHuFX6cMxZHBt2qdc8aEx9B623WGoTyL1cjjBg@mail.gmail.com>
Subject: Re: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 4:44=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
>
> >
> > 3. If you're able to repro this consistently, would you be able to add
> > these lines right above the WARN_ON on line 487 and sharing what it
> > prints out?
> >
> > +++ b/fs/iomap/buffered-io.c
> > @@ -484,6 +484,17 @@ static void iomap_read_end(struct folio *folio,
> > size_t bytes_submitted)
> >                   * to the IO helper, in which case we are responsible =
for
> >                   * unlocking the folio here.
> >                   */
> > +               if (bytes_submitted) {
> > +                       struct inode *inode =3D folio->mapping->host;
> > +                       struct block_device *bdev =3D inode->i_sb->s_bd=
ev;
> > +
> > +                       pr_warn("bytes_submitted=3D%zu folio_size=3D%zu
> > blkbits=3D%u isize=3D%lld "
> > +                               "logical_bs=3D%u physical_bs=3D%u\n",
> > +                               bytes_submitted, folio_size(folio),
> > inode->i_blkbits,
> > +                               i_size_read(inode),
> > +                               bdev ? bdev_logical_block_size(bdev) : =
0,
> > +                               bdev ? bdev_physical_block_size(bdev) :=
 0);
> > +               }
> >                  WARN_ON_ONCE(bytes_submitted);
> >                  folio_unlock(folio);
> >          }
>
> Here we go:
>
> [   17.872952] bytes_submitted=3D1024 folio_size=3D4096 blkbits=3D12
> isize=3D5278880768 logical_bs=3D0 physical_bs=3D0

Thank you, this is very helpful.

Is it correct that the block device's inode->i_blkbits doesn't reflect
its actual logical block size (512) or is that itself a bug somewhere
in the block layer? On the iomap side, it uses inode->i_blkbits to
determine whether or not an ifs should be attached and what logic to
correspondingly call. For this case, shouldn't the inode's i_blkbits
be 9 since "isize=3D 5278880768" indicates it's 512-byte aligned, not
4096-byte aligned? I'm not familiar with the block layer, so your
thoughts on this would be appreciated.

If it is fine for the block device's inode->i_blkbits to be a
different value from the logical block size, then I think the iomap
side needs this fix:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 867e8ac761c8..03a97361570f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -543,7 +543,7 @@ static int iomap_read_folio_iter(struct iomap_iter *ite=
r,
                         * helper, then the helper owns the folio and will =
end
                         * the read on it.
                         */
-                       if (*bytes_submitted =3D=3D folio_len)
+                       if (*bytes_submitted =3D=3D folio_len || !ifs)
                                ctx->cur_folio =3D NULL;
                }

Could you verify that this fixes the hang?

Thanks,
Joanne
>
