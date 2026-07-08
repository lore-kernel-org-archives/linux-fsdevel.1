Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87F38B140
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511228; cv=pass; b=Oa0Ii8hytTJ3mZBhK53D+jvbvmAzOnEUBi1GdOBDpV9V8NiMtNeeKFN6zkBUWitt3oiSCoRl8lC8aMlAF9Qru18jF/mnKdILh/BLnFJzQ+fQJQAVLlVWJKDouMNNIuAnFZrI9cmpIHVS1mubKz+TWzl5332WEke6KBz6Fv9SdfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511228; c=relaxed/simple;
	bh=HZ6XHRVdMid4KiFr1KD5AuiEtrvMy6dttYDhZPcK7m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrgyXGAUBiwD6NcFdQfJhUPIk0Gcv8VVEdjxnV3vkez2yNoLu5KlY0hvuCKOLgpa9/q1T+x6Y3aSJ0yf3SqYsnptlHenNgxZpYJKpawnrRbwxj4yHaG9eiBoXOOlFCyOti7X2Zv6zCXe+bUFavJpZ5zQDrsRGkxKU7JxFIhUIvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=lAwffmsN; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="lAwffmsN"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso318505a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 04:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783511226; cv=none;
        d=google.com; s=arc-20260327;
        b=KZA+sSiyJ9Nhc/L17esJ2DYVTfzHJBeO0JFv2D0BgXDbOhCJ8cHRLLZe6gkl2Zr6cQ
         AZNsEsAWpy8nbdRPS3jwQGG7pjGOaLjQZpbQZSUcLD3duJefzfrk488cTamJRqCFsEc5
         h1mFSDwmPPnLCYZiFt1y3IHnIPcyYJs9l8cVQregaVu066IY4PBNjpCZxlZmflutBSZ1
         mZK89Ayc7pWhUkSLE2VBPJmzVqkHFBNVc4MADPG7etd692wqH4iTlCvFHb2VCVvLqxb+
         arTaTr9NZLGy5DsNjYLTx5Ec5g15bFM7DTNEIfeAmhLUelzfncg1DpOtAKpCY240zpVI
         6G5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e9LcL2EmsnAfaS8zlx+7ddixnoRQmUi/LbnHQfSgG2I=;
        fh=IA61nDI0In2iTD5m2llDXiIcQrc4KY9EIGyzmCh5tRs=;
        b=IrOYE2QUDYcpTMCkykpEsxeUg0wo+WOo+D18jUOunAmtw6Z5rwa1NLExuwbQjR0Rxf
         V+520qM9+J1olPoSOYStmwcS5Rty7YoNcptM0piSO4njjbedi345rPC6ZrET1EcNCgae
         64ZMOzH1qViD/X6Ymee0mP87XKIbp+JJOCnPfdrzwcmFVuYkVndM+Z3fJhI+VsAlTueB
         lMWjr+m10fWKgKXbdyNTwXM1kXyPboduT6pZebpqHYCA8mIvG6iOMZG37PNkb3Q/efqF
         dXAYkON1NHEtgxi+ru1UesqCG0c1VzE4kKul7/t3KG/bPVPaHySAqI98MnXpaNk5B8NS
         UO4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1783511226; x=1784116026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9LcL2EmsnAfaS8zlx+7ddixnoRQmUi/LbnHQfSgG2I=;
        b=lAwffmsN1Uv2VMWHOiYuPRPo/Ut7gDyXRa0qMm6AjkhQejz/75RHistqLk8sh3NQlD
         2+DTLu64g6hVm0tKWqlLmdRHLFVYNwV2xSHN/a7R20hQeLbxxEWcgU8IlFbKJdQzFj3Q
         859A52PkkW4OSdbTz6tEiq5uXv6XIReMFRAUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783511226; x=1784116026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9LcL2EmsnAfaS8zlx+7ddixnoRQmUi/LbnHQfSgG2I=;
        b=GIvR3GugGF4VN4VaGyPOLKQm+Gr7eMx27X/Pjbt+twwllV0tf2fLe6OO1mXdyBoewK
         IiKKrvBq1D57lh5XrE3cEt34GaJdQEMstIB5rV/AwJLAsjo7nfctJ9s9sG4my+jy+1yL
         G9E/7ODNqtS7k9LxTOmfONtU6+hEN4RwIs+KA16dTsc+bAOQofDWOX45TdWhf6n5f6Xn
         rceyR8hHn3Od4OMOF6WdxOgizeVBUIOghvJoxYzuKm/qJk60/9aH3I86xGr3pu0QWCAy
         HJ/sAF4pfYWoyM58HV/iPGCkhDjSPqcsPi5dkuQCdvpKm0jwjxYraJBL7qa5PkwAwPF+
         FWGg==
X-Gm-Message-State: AOJu0YyOxbqdOFypSsRoaEvyBD1DVJAqBLL4lETGmZu0etfxU0c8wsWq
	4YTm4oADmk4KvSBwMDpFg4VxElqhNF6C8wUj1TBjlsEKpI67dTR/kVdxSEMEwk7H8r7KdkNROHR
	1BDYgKQdKsAHuoZ1H4NeQ+LgNb7+u/smkBowm+xYQFQ==
X-Gm-Gg: AfdE7cl6u0rbcv4OWaWJ8Pdl+3N2J0VrnycgqpR7V3EmoVJ0SZqUeOzHmZhCohelArP
	3mHwxF02CsIimxM2Jd7aVApJP8FsBLRppbGxrKSG2YXcdQqSGv7JBAqCkDdZa+8Kl8pSfrrLMmp
	CPDwhN9KQ2nIAaHtSUQxrdPYX8qmuBHelIEhL3PfyRXScV9HhoQwRcisdCfiYGsyhyBeuHNYksD
	Dv4JGUt0TaagdSABcsbQj9znkp4KjJ0WhEdOf2HYUtzdVYSQAjo2mBgyIn7UJU4DQ7q3BCwQTN7
	cX2RNK1ct47RYqdF+SpjBZeluLN09rE=
X-Received: by 2002:a05:6a20:12cf:b0:3b3:fdb0:2288 with SMTP id
 adf61e73a8af0-3c0bc55cd9amr3035041637.0.1783511226436; Wed, 08 Jul 2026
 04:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523130445.1101818-1-daniel@thingy.jp> <20260629205854.0062b1fc9588ba9928bb1707@linux-foundation.org>
In-Reply-To: <20260629205854.0062b1fc9588ba9928bb1707@linux-foundation.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Wed, 8 Jul 2026 20:46:53 +0900
X-Gm-Features: AVVi8CfinkEnutyTpIrgqLtLXGqwtm_mnz0TIuLo6KCJIR5SV-U6B6T7w6u6n30
Message-ID: <CAFr9PX=2sZxr2BaisdnX4nB5zvM7J9zkU6zWihd8mNxOJ=TudQ@mail.gmail.com>
Subject: Re: [PATCH] tmpfs/ramfs: Let memfd_create() work on nommu
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Tue, 30 Jun 2026 at 12:58, Andrew Morton <akpm@linux-foundation.org> wrote:
> Sashiko had no complaints but it seems to have found some unrelated
> bugs:
>
>         https://sashiko.dev/#/patchset/20260523130445.1101818-1-daniel@thingy.jp

I took a look at this, made my own fix, fed it to fable check/clean it
up and it seems to think after its fixes the sashiko reported issues
will be corrected.
I asked fable if it thought there was anything else major in the same
file and there are a few minor things but apparently the bugs sashiko
reported are the major issues.

Once I've tested it a bit more I'll send it.

Thanks,

Daniel
