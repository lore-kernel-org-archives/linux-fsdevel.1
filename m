Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802F356747
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780630511; cv=pass; b=MMpdcvQQqQzajuRmNSnAEzq9s0IMm2QkimFRCL1+gcicOn6i5GV+YOsc4j2r2zTPMthqyxvni6s3DtpBpTzL5ok9eGe6SiGTDIJr+qSrdo9LY8c5wXIKKcvQzM1VjWDFqkosCYolZ8nQKxv3ftY1rWVG1FYTx08PpOeDZ/VSPqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780630511; c=relaxed/simple;
	bh=tBBiDPE3o+AtgfIXatfEfaHMdik1kjDb5UQuzJhBl34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uD/HCXqQ1tAA5vPKY0RNd0q8IEP5f8b30kaH4tOXcVYhoWSud0yNjvO6UWN3PFNj5cem1UTv3RBYkFoXLF6Xw2+/jz2G2sWyIxBXeULr6OEmPt29ncAU23Zw9dIUuPycM1dHdejdzDuhbA7YuDHcHtkfLMDDARr0zmaZaTVJNcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEJPmlBK; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEJPmlBK"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dc93d02916so16033407b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 20:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780630509; cv=none;
        d=google.com; s=arc-20240605;
        b=M17NBQFK0fDoESwyOwisTZu2JJDua2rR6HAAoncHS8+DGSZ8IPBWqBemcNt8JqhVwz
         40B7WbJefHUO9AL9i91TdiBHPVi0LT2J/4UgWbbCTnskY8JTGNFLrbvRPpyYlIJZExb+
         yyxszpUVK1zupwFXmZZEBnV94xx7Sl/9PFTLyCpUgB4lPFRoawibCBymdfRFzvYj56rL
         TL3XRww4qIT0CeWyg5/geC7ab6TpWx6TuzeGulWzo2HA9a7FbjR7bGkN8GEXmYW3sJTV
         EdEwpSvraC6l47tVX5Y09l6s2p2AMmeO2pKtFHN4kmKfmm2pYijS+1eHLnK0i0gPPHv/
         o8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I4pv2DoPNZm3NLeMz+TWILlwNOvFZU+0lzt1tgydzHI=;
        fh=RxEmNr4/HxCeD+iCP5s7kAn/+XANQjFhzw9aWYMzNSU=;
        b=X4kEWx/kn7L8dBVc2MoLgeXsT+csuLUloo2C0o9waoeIADuxTBcrBtegKYZZF/a5p6
         Vxu0Z8iV4is/770kQ1K/D1anbRXXeI3dKQlhYwx/Y7W2MoCTSrq/zI7pFsmjRwOsLlPW
         NvazOL8x9/OUl8RJxAKP1BKUynzXqfAoXjVoN+5EGygAt2jSRDgL+fgG61su6uWL43or
         UBaoVotnBRM+Zo2RczEj9OkcfGKbaDK38kxja35pKV8K+9vLlxVgZ/EoVj8xer6PgPUT
         M+4T/+EhAoh9ZeluEm/qJt3geYK8JLPe33HiLZ1UKmW9tzuDol6vfVHwYx1KQGlyT4uT
         pmJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780630509; x=1781235309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4pv2DoPNZm3NLeMz+TWILlwNOvFZU+0lzt1tgydzHI=;
        b=DEJPmlBKF666ysYzoNKUPXiz8UljrpGUB6bRBKOA7Xued30e7PbB2G9y0eL1ok+QY+
         nSFKWcyhkdS9N8UoTutAvJjh975rgoNNrGjglTKEzlFZEMiO08Oq+DLyDchtaAtmwgnB
         /vSnRfJzqk82uhvvE0vbB7YgZe/tDgepJH1f+5VmlR8ld6CiVOotQLn4gPPhjsC94ZOK
         mPa6IA9vO2tfTzBpI5lUNOXGeaxqVsi8ZHBLChucgkfWyNaH3Vh1PZlAmjBAjn5kbq4d
         SlZi1Q6MXC1htNNZpDTVQjNDk+u8PeZ5WDE5vE5qrw8FXCnT8dmrDfoV5XP3QoMVAsMR
         q5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630509; x=1781235309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I4pv2DoPNZm3NLeMz+TWILlwNOvFZU+0lzt1tgydzHI=;
        b=WvfuWhWqDEO6Yg9NbObsDSNB/5o9FLk5n5BD43QdgU/ShJJQS8+psF61PtOAKx77PY
         iDyy49xiwr0vGXoa5g4ZeNY5Th+p87KQE/Cbyj1PRuZscBevnHQ6uQcj21pTooYcRT73
         3EpEE6a36arIWe7+spj3Q/clHqUKv+tuoFDjAAdwstrQmXkQmkY19grDTXgsgN13P5O8
         noSjtkAr9EfFpcmHtndTUM/ClUeL9Vgwd6e2rpkEyPKq1OIkvq/s75b1IruiJiU+RW9e
         +5xclFTWAUm4nzzoCCImldxPGUueyzi0o9SAOS0K+FDwZT5gEtPNLbNcmR6kIk1kzr1E
         KD/w==
X-Forwarded-Encrypted: i=1; AFNElJ+LcIuK8JEGX0i7mt/V5vJkSv0YXMRS+nJ8nDKWHOS9Cw7YmYWfx+Bo+avq1/t2eJVEIyrn8V7MVENnvuSR@vger.kernel.org
X-Gm-Message-State: AOJu0YyMb5tNb1QM3/z923az8Y4c7j6Dp9Vt4CtIToreBTx3K0gU3V2/
	1RxN2RR9fr976B6lu8OLjuoOttYmtxWcFT99jrNnYeU/WD+fQuSI0vARlw4qR1newSROmw6Dq5d
	0gfJAGJFPo3loO7w1Z9mt1QPLUX17/MrokDkB3Us=
X-Gm-Gg: Acq92OE79SlOiPMkuu8BfA/vO5J7BDJfr+v6z7nC87wcaXymIpqjemH4Zsk7A6ppJqx
	x6YN7ruJO02REHBhcw6H5G5rczjx2Tr6fIBm7l8W4hBT7JA5dEgW2L7HU8uIuStYVT00F4DO54H
	jnnLkYny4ugrwHULfS60iSV8WHu9P6wRXSACms8jp3Hyb+YGCpm9WimUyEIWfI7EBp6TlyW/r+y
	Ymac9MYDloim86sA2dvZnDYQDDhudLH06lJ1ciJZ6Jty5y185u8eRkBQEetEFrml+gf2fl0wbP8
	e00SzHUi+4aKUpezp/Y48oGM9lgB
X-Received: by 2002:a05:690c:3801:b0:7db:b027:614a with SMTP id
 00721157ae682-7ed0cee89c4mr17944427b3.36.1780630508920; Thu, 04 Jun 2026
 20:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604202441.65226-1-m32285159@gmail.com> <20260604143040.61f70396c568b7433110fb3d@linux-foundation.org>
 <CAKqfh0Eu=sp3rfAGzhTPcx1Vw5p=sjxTigAWhkzskYrAWB9iWQ@mail.gmail.com>
 <20260604195355.c2446336f3f8cdefabadc697@linux-foundation.org>
 <CAKqfh0GR1EbuxTcuTnUUS34QLiinkD7TPCCEqpd-8oS3S824ow@mail.gmail.com> <aiJCJNgm6pYKgqbn@casper.infradead.org>
In-Reply-To: <aiJCJNgm6pYKgqbn@casper.infradead.org>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 4 Jun 2026 22:33:10 -0500
X-Gm-Features: AVVi8CdqETQu8RFKnjwAIPMM8VDdm74nLUC9JuM2HEL8Kl1Jtwv8Um3k78lFw5g
Message-ID: <CAKqfh0FFB0EkTAh-+6uK0aNqWVZhdwMpP5-Nnz4GEoWYXQM3Dw@mail.gmail.com>
Subject: Re: [PATCH] fs: efs: Fix compilation bug and use pr_debug()
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Fabian Frederick <fabf@skynet.be>, 
	open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:27=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jun 04, 2026 at 10:16:44PM -0500, Maxwell Doose wrote:
> > ps: I noticed this was listed as an orphan in MAINTAINERS. I'd be
> > happy to step up and maintain this, I've got a bit of experience
> > maintaining stuff in iio. Hopefully this isn't too far-fetched!
>
> I'd be just as happy to see it deleted.  efs was succeeded by XFS in
> the mid-90s.  The last efs filesystem I personally saw was in 1999 (an
> SGI Freeware CD).  If there's any filesystem crying out to be converted
> to FUSE and removed from the kernel, this is it.

I guess that is a fair point. But given the fact that we quite
literally just found a compile-time bug I think there may be further
underlying issues that need to be resolved before conversion to FUSE
:/
