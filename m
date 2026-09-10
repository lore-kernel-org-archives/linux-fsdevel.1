Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF4496D4D
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071201; cv=none; b=c/Tn0MopkC4KMeLS4+87CTelbwpyhY4ZCme/gh+3nOmzudyIHVgyvcF3vr3QXxsv0XLvgMJC1k+WAPCCenpbZspY9u2tYUfuSetNuNt/1R9hDtmMPn5csdq3Sr0snM6Epj2s+FKeFfFVVvvMwC6HtXHjFvQfCKx5FSK7k7kV114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071201; c=relaxed/simple;
	bh=Hx7GILGkHVxQZsZ4Pp5OLN+Ni+x/TR2uCF0JuD+o6Ks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pwI5fd3Ca9VBDfiBIMElpB5Jcuxnc05Uh0ncyaPAkPsGIG+skQMQ9qMCBeytPFQEobYdY5ruf18s1YO9sITj53M3NqKrGXy2QiCN/SkARBA1oA6RJlSSkj+HDQ4dWwfWLn4bk3hTEBa7WD/oOltvF57Mlasfx9hSnJ6byHvEANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=vk7prv2x; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="vk7prv2x"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-87ab6e5f91eso1394577b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789071197; x=1789675997; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hx7GILGkHVxQZsZ4Pp5OLN+Ni+x/TR2uCF0JuD+o6Ks=;
        b=vk7prv2xrdDGzyGRbV6CcDLk6EKwueTFC625l3stOzpsnmTgA8DAq1VYlRkTY3DiDk
         bq/6l6iacSaVaiSCoTzJtvchLZ0KyBsalXBHBu+UMg0rG5qa78k7IWPQr5PkDqdSHnoz
         Bx03L/8dcyFGuE/1TlAd9qHu5TWpGLLxj5WdkVz62vMI80y5ykDz69gLnMxcSCTMZFFc
         0k54gN+lA8KxuEnEU3G0kHczcDFmhevlLIVrFV9yk/8NhdZZSZONE8UJre5zRoAvGniW
         LkpUINqIFLjjesvtRKFAbf5lN+yEni4wkVdNiaIn+1Qelw44kGpfSwnp+T/9jTFz3sGz
         LSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071197; x=1789675997;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hx7GILGkHVxQZsZ4Pp5OLN+Ni+x/TR2uCF0JuD+o6Ks=;
        b=W/fIWRu0xD64ybSOGigasdD1oyYfDSCTJncYfY/uXdMOJCEx/sBho5YNjpVtCLAhii
         z7BZsMtLd0y4IETWcYIR6eEcngjAHRdTHwTuRFvsBRs8UKGbhAiYY+LsqSv/kJMua6mS
         Khr+hAO3sLQ/0StcDdp573I1lO4XFpYDFvoy0bATWAy4+7GA+o8pk6osPtU9AjRxScHW
         2XW+cT2oXdJe94/XVm1Pg4288Ali/KLUV9T4OL2bb7hqNzfNBv3vM9rB7bwvxlC9NVje
         rk5xdd3v9H8z6funPp1tIkUezf4z1WhqvA7a3XzimBLyt0H//9GeZfaKRHBlq5G32Nec
         zIHA==
X-Forwarded-Encrypted: i=1; AKwUvBwgWWrhmOgp7tGBiYdQJwHZwFl/c90iNooeErQ1m7A3WDEZ/3+EYXrAeA1lGABZN3HTYjQ6VYh9xMLe8QFA@vger.kernel.org
X-Gm-Message-State: AFuF++k8iPNOLl0rNd+0KpS6SSJxcEF689k97jU2dFvcHs3Ogp2aRRYW
	6Ukn1UNva9O5IIW1Q+YbAuUql/v+sUESIBUTs255nGnN0a3YQyDzRuAGpWCc99+SNEI=
X-Gm-Gg: AYBFou14Rh30E3BBsivaMIbhfu9/QVYWfjJRwxR5tWi/N2Tf5ufmqmw9/EETESKR9Is
	kSaQd6I+pCYXbdFoLdlLReTaiYgWWvyuLX2zzuGl/xRPXGgCSsEXTrcY0Zn/lCjlLDkcHXCrXAn
	Y6eEE86Y+lypNw13jRq2NpQovOJW1dVs+Npd+NudPE5q4DxMd1YKQyJlyfDf0JE/pDwWJyDIYCN
	AFHJCKOnGmPhJQXpP0XdU4eZF2iYQHxcUGKwvLBcyDQHu0fGU2fKm6/d4N4CfGTuPMTt0hFd9zV
	yzw8AH7A1YMESuiNkZfoef3mORgw+TjEbxywbXRfZeCWYRkjLB3unPaJhxMCX8i+jBpm808fUob
	85rM/MXC6UB7QQktxP246tWgNiTpSfN57mlCdiydq0lzTQzx7DVKU2SRdxEdLK2JILHYEQbVNdp
	+O0nrFQbsKvCVrBOfyk0lgttQfrJxMRwJAt/nAwgNcnrS3hJHC/gAor8W5nU5GKTGDK5yJmfFo8
	s7xklPca0rhoF32p2X7Ah7VjPYvnWp1kQqrTkQqTA2Cf9TnOrS7tIxGjsgahFfqf3/86nZrhhbc
	eA2Zv/dCHQgl1V4iFxGwg6/A6EmEOo76MgMICIp7rhBRG5Ag1IyBeSysxDIjwT2Hn7Erw94GRuw
	=
X-Received: by 2002:a05:690c:d83:b0:855:37f6:a73c with SMTP id 00721157ae682-884ad33b089mr5792907b3.1.1789071196769;
        Thu, 10 Sep 2026 13:13:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:2670:dacd:b84e:82bb? ([2600:1700:6476:1430:2670:dacd:b84e:82bb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8847db40648sm4125197b3.4.2026.09.10.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:13:14 -0700 (PDT)
Message-ID: <730a395bb6eed86bdff7eb21668f4f1fb42f664f.camel@dubeyko.com>
Subject: Re: [PATCH] xfstests: exclude hfs/hfsplus from generic/339 run
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@kernel.org, fstests@vger.kernel.org, glaubitz@physik.fu-berlin.de,
 	vdubeyko@coreweave.com, linux-fsdevel@vger.kernel.org, frank.li@vivo.com
Date: Thu, 10 Sep 2026 13:13:12 -0700
In-Reply-To: <aqJ--AqubS-CWiV-@infradead.org>
References: <20260910000449.747189-2-slava@dubeyko.com>
	 <aqJ--AqubS-CWiV-@infradead.org>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-10 at 02:57 -0700, Christoph Hellwig wrote:
> On Wed, Sep 09, 2026 at 05:04:50PM -0700, Viacheslav Dubeyko wrote:
> > The dirhash_collide generates filenames from arbitrary random
> > bytes (only '.' and '/' are filtered out), which are not valid
> > UTF-8 in general. Catalog names on both classic HFS and HFS+ are
> > Unicode. Feeding random bytes causes fsck to report "Illegal name"
> > or catalog corruption that has nothing to do with directory
> > hash-collision handling, which is what this test is actually meant
> > to exercise.
>=20
> If user file name creation manage to trigger fsck complaints, you
> need
> to righten the input checks in the file systems first to fix this.
>=20
> We can then find a programmatic way to deal with these rejects in
> xfstests, as ext4/f2fs in case insensiive mode probably have the same
> issue.

I see your point. And I really like your suggestion. But what is your
vision of the proper way to check the validity of Unicode symbols?

Thanks,
Slava.
