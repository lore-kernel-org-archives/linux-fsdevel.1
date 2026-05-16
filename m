Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11512D21B
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778925642; cv=pass; b=P2xX1RlmuzBwEabg8PY6bwVVpO6S1Ts1J3Mg23Jlzo9aC5W+hpEePNFFsANvWPIW+iuv4jfsbU9w+LVDILVaXi5cz9lT28oJxCcGXMgn0ok6IT8NZuEFSrB2BLz+k3yv9OzAypJ3TK/FeNmhjy+nCM8/HkNfiau16TgCNUgxkOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778925642; c=relaxed/simple;
	bh=ozFabX2+wpA1waNxoOg9swif06Ui7c36yrFFuSF2xp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ck0QuPjhkE3zDKuZV7y46Nv/m/XCM/R2eQeMPMPx43ENdC1etVTJy/Caqfk471aqiAbXRat66gIWxd9UeauCaMyBGz1GwW00X9s74fnx5hCCKwjJ2EFVrTFOLW53+ti2yDJMHjyOMcUxNhWDpFRxIFFcMMrLGUtnUJ8vHuMduKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvqBcgnM; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvqBcgnM"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bd5e373d07so2552527b3.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 03:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778925641; cv=none;
        d=google.com; s=arc-20240605;
        b=THejsdOKw2RuK8lGFbdPlz+ywM4CRMUZ2hkwaTa1ptehAP8bm85b9kDadF4PmOhELX
         g1L+WQm6Xn4Pt0uU2kruNO7bt+W2XsbEbcCtJwTEehNzQ31LDriStqIdpNAe9gxp3KgW
         i22IvBzpsJUkstc/qfSlCY0fWXG0f59FBRRiJZJmEgjilIQe1pNO0/rlSEDpatzzbCZ/
         3GefxdrPq+AXUHzg/rU5sDyv6CZi0y49m1uzZevb+j/6+AXHcNWvW+B8gxyXFcEF6Ic8
         XTH/NzIyr409DDPmrEStEgPgkOstniN6aPQWk3c+jh+qhvww/OxT0tY9z4oSBcrsLUmZ
         14Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KfbpVW27G4iXABfVGKQoBu/iXDGvwHpAsamzbVWbpv8=;
        fh=S85luFW4oKzSTn8kWZ4FgrhCRWWvYVTBMJb3tctTpik=;
        b=btZuYuXUjrQqDIuX4xdDdWjC7kkK6/5QkZLFQ5Ry5+R20zom3jdOAzr8pFn1CYmcKn
         z1t9+LsJAHuCr90bft25CNCvDGUnUEFxhnHYVGMbFh1/38rl2gTGkmXzbXQynAH6pfdV
         SUf15qxtms/kXF2o87RE6fHg4doORVJecFWgOTAvWIY3ZH+q2V0R5/+qTvv1N1MJpIeS
         XNQ0zz13TloG8sAY8oiVKKm0w6pd65Nb4NfmNEgvcv8KkdhpuWWtcvUxdOXOcjnREM7D
         jzCaJg209WD3C+zTE8NlggnGlmTL02sV705am20xMYG1Pd4ay2+pke7PFLaHYCG8NTZH
         XtOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778925641; x=1779530441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfbpVW27G4iXABfVGKQoBu/iXDGvwHpAsamzbVWbpv8=;
        b=DvqBcgnMmB+VexQf48jIeAYuFEsocYqnzjU13Po++XkkfhqCPNl1v3nrgMROjF8W3B
         juvmAIDJdi8Ft3a0AVTCyJ1LURoYiliVTv88gEXZEgQOORmthpdKQeLLEx2wESl9J8O0
         5kumISzYVaTNXOwZixgrDtTNTA5f5llBsZxUVm7ymo1B5JRhELndWiUYI5r4WYriOTJK
         BXlUzi9J+GHAkhyVATqTTT3uEa0l1YB4UTWRRLS5T0U1CwFWnVHEOwhlk8dKqVQrd9mR
         fM/HcZd1ite/e4fV1VZzVefiJuvGctuZft6d0k0j0srQwhUoCo/EMsRrbGORXIoYyRxT
         QD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778925641; x=1779530441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KfbpVW27G4iXABfVGKQoBu/iXDGvwHpAsamzbVWbpv8=;
        b=p1uAlYIiCU13tS313RvqEGiNjiVqP04qeyYHe7szk9JLuoskdDRGub/t+ExhboL9qU
         Jo1grahkM2u0R4ZkTbQ0mcQxFXbcc9WL7ZC8L5CYM6FlYulQ3Frx+zex7fSYmJTleBH7
         GBAuY4fOVQXhyXerS+YjeFdtZbyBWjCLeqPZKKiahk2UK3f3r5Z2uXYOWKODJNoNpUXk
         UqSykl4XaLfkE1YvcIRqO63pvzg1xOEig+dEOgPgX+w6OH3am3kNx4PxxKOUBHFDlYv4
         FMQfDukArGCCKJlRD9VvpUuH7FZbzXtBp0vc5AZO6SOj0clV4xb17Uz+Z0LSDs36Zqzb
         K3mg==
X-Forwarded-Encrypted: i=1; AFNElJ80KWUG8LTCrB0Fuz0cTdCFOMm3m1J2Wdkobk4wwgDQFEIT2bfCZQJislTNiT67RCdLdG9kGr5R7gGqXSSW@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZ+mOez/L28A3vTs4Ln/d/GJL/GK33O1DmYpnTRZNG4IPBgMa
	YyB6MNQWv8U66UXeN6YY01znNJtHzl3NIc88Hwfs4isCTZfVeiaZTj0XRvUeKXpPVs66TkuCTr0
	EeQTT5ubJ6CR4MXiIr9nAWJx79rOP3EE=
X-Gm-Gg: Acq92OEbv84bfrbkcJv22ICiU79XFHchsOyjIJOY8XSjYxqjVLl9ds7QvZxOfzzMmt0
	aO3M9HWzOXBcdTK9MLuv7lGkYQCWgXcw4GpZ6uvddIxNl/ERPtkVUawk5Aelu449DViNxzBZGw7
	rpObi9E8to2n/TEYUIYxFHMY+Ofor8w6GLR00cvH1N8S+nAf5K0Pe6B1yrvRjX4398v3QuSFXe/
	c0R54HTqIj04fD8ueh5Ohttd4LZyKHuamzNaYimMH+D2VZt+2mCjJRxqpNT8uxUa3FJ0lNvSslR
	2D1SzRBRAFKFsfwb33MPa+AWr97TfJjD6SMZ
X-Received: by 2002:a05:690c:c18f:b0:7b6:f4f:f05e with SMTP id
 00721157ae682-7c95bd18f6fmr76712107b3.40.1778925640723; Sat, 16 May 2026
 03:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515163424.1575298-1-michael.bommarito@gmail.com> <CALFbBicg4oz-MoQue-_MCYaROeWJMkDUySaMP1_Te9z5wP_1Jg@mail.gmail.com>
In-Reply-To: <CALFbBicg4oz-MoQue-_MCYaROeWJMkDUySaMP1_Te9z5wP_1Jg@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 16 May 2026 06:00:25 -0400
X-Gm-Features: AVHnY4IDawty-OaDG5f4M0NQEvxBkxuxcJ9qQTQ8GWtF7Xvy8dJzFgQgpGGEjBk
Message-ID: <CAJJ9bXwZcAzfm+U8Wm11FRGSjNVro-VoAxghFCp=fJLQmnhN0w@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs3: bound NTFS_DE view.data_off in UpdateRecordData{Root,Allocation}
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 12:44=E2=80=AFAM Pavitra Jha <jhapavitra98@gmail.co=
m> wrote:
>
> Thanks for fixing this. Since you cited my original report as the
> basis, would you mind adding:
>
> Reported-by: Pavitra Jha <jhapavitra98@gmail.com>
>
> to the patch tags?

Yes, very sorry about that!  I switched from a 4/4 patch set to
separate patches and missed your attribution.  I'll let Konstantin and
others weigh in on the patch before sending v2, but definitely agree
with you that you should be tagged here.

Thanks,
Mike
