Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA76B1DED42
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412773; cv=pass; b=EPF7pX4mvFqdV6EjWiek5aEWgqqKSs4nROI7a9H/hx689VvDFlPpk83YbrjGpZWrMFgnm3D+ehbHRSToDLBzxdlfMXe2Mfv4Vl7zNeKCP0Bs3m4tWnxPBpaaS04T67zms3VLx+1yx0X7B3iH4U2/iZaOnN0KZLN6BIpdvH4j0lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412773; c=relaxed/simple;
	bh=sJJ6qRXJASQg0fWEF1LqLZ2QXuC8vC3iSXfNlIz0VPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It8K22xvCLBSnY0Z5rQqdfXhz+VvtED1v6TQof6+BCPs08wMidBPK9A3apzvG/Wwa7MKla8CpjMHN3EDhiO+l1KiVDuf+uo3lbfyrUfCvuye3OuhIJLJWTtCWzg/QwRkikT01PUyGctvb/Ti7FN7n3eZ5xlVSdaVeC+BrOlfQXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=LmmFGeLX; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="LmmFGeLX"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7986e538decso19565017b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 07:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412771; cv=none;
        d=google.com; s=arc-20240605;
        b=Alu1491wSLiTuJXj0UhCI4gJXtT7HO6a4D5ZlNqBJolkhIO4h6AEvwbBmiEEArJ5kD
         4TNPgIrHYJlbE6QKFxBJbj7bo97kDkvLQF5qlNf8ifjtLOGqOjdftBzCtG6505t7w+Gk
         P8fTYeTQMG/AZU+FTX/uV83T+obkwsRqD9yGopadV2obCrsEHSeYgtXTASujsuqdBaIK
         VeORz9lNtuusLPPsPTNyUot1n0/nCJHWG8x9nnqL+pgCCuX7BwaQzzWaJiP+om9hSL3m
         wWdfw/8F9Lb2JqWDhK9fWIKtBhgKjAxEF8TwWtTYQjqYC4za3k5AOBr2FwVVQcnXSZC3
         VGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJJ6qRXJASQg0fWEF1LqLZ2QXuC8vC3iSXfNlIz0VPs=;
        fh=p5QOMISVBLu7WzDXnV54NGhp9l/MJr3aKicpCBnBYUU=;
        b=C8LxltmyQdHlb4nwTd8CvM2lWJaTb0pzRGaq4I5gLr23kd1MHHvP6Uld05TMMMwsK6
         aIy25skuHKEJJmNV4ApvUEVcxfRyl4iRsN+Kw6W0PEEtOG+/vY6ALHqmciT09ys1A+X9
         Z+30C6DgWX8/aOfndvT8FGTI82QWX/XonGjlOHVGZjAxfZaDBuDEqcgXErNJRtLwT4Cs
         UIQTh07CpoxRE6C2smmWSfOplf5uNqwhjjzT9FB57t8rX6T7sxMIiC9EmrML5Wt7jp/T
         dC6jitCH5RNNDTjL6rCMHKW3vXLHRY2Cyj6pMIFF+OkRMyKZMNrIFPAE4n5p2Cx48DZ7
         qusg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773412771; x=1774017571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJJ6qRXJASQg0fWEF1LqLZ2QXuC8vC3iSXfNlIz0VPs=;
        b=LmmFGeLX68MaQCVHRoiBScJRc+2bBTtuGfZzW55OTdRHy+O6Nejo6e83x1OTBCv1mK
         w15uRBv9bVhoZg3PuZdELW17y4zOw+StTsflfsS8kiac2tI0Q9vFMR3nY4sdQBPLNKul
         PxrTZXm5d6ohN9xxVrGwZoMKOSDbYprSjDreYvS6weQMhkysNbJVMY8ne/8RO2i8h3Yy
         V4nsJPsSViizQ1Z2gu/DX6+gzbLvgBgysvnJiPsd8A5OFsOhVv6TvU3zjOFAJxGOOslf
         AyIiKVv8Z9KZb/QJGjAxNdau9DfWPyWr6i5AB5Su22ye0OdAL5reZ3mvwsJyiZTLS87P
         BGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412771; x=1774017571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJJ6qRXJASQg0fWEF1LqLZ2QXuC8vC3iSXfNlIz0VPs=;
        b=qBbMm3nI9VYgSZcx+nFmBuoFmBpuRRN8JQcwChUXZWUxaV1XxzjKYvHPXRJ06UbQ/v
         LIoXubRGgjIusj0w3et84rqlPizHZidJfU/XrVm1h3UhgYInR+5iKeLBKR5BfYh1+30V
         8pFysWmSr3O+12l6ULimwutuOQSpAbxlPDGRV1kvar3KvcYNMHvS2lHF0JYI04KG7d3w
         oE93Ek1ReTTwCEE0slUv/es29sR7mEyePbbV1INry+z+icuzUdZBGgJJfC6JvqNUAPm+
         BJm7BkpGRE51i48Ld3Uwz3q4z0A9XwA2ghoE4wiZ0iw3CKTA8XZqhAnBMbWtcr5fthiF
         0nig==
X-Forwarded-Encrypted: i=1; AJvYcCUJs/wCy8f4s2BzdMUPif+eawW0BXDaGK0Pw4l1MO0V6sv0lJZqDoJ7INsxMbpn4IOcnZD7gOoeiBJNljBi@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRP1YZuGa3gxFXN1NHq6ydplYVgqP3GcWzVJbIS+njvfYualK
	LUqOC4jwJT7g64XtzO61tGR+iucScDQ5tEm95+YWdw+/mDwH0jrmoMMBWP4N/S/Uhj5lEfwGIx0
	bvEYwl/BTwDynAdCR7khjeTCKziqlx2CD8LTeeSM63g==
X-Gm-Gg: ATEYQzw3N5YZbrJxj9UHl8gndFTAGxM6hdWwGii2reYrHScFdILcAjSdZuBdRW1xNNk
	kMkMsH7Iax9WC3qYJ3Yajwa9Axc0rj/jUgCJpkO9CZSca4+6IZsoE5vpghQRIA02oXpzpAz44XK
	bf2vvi2lW0+O34iOw0osvxLV0htZNDA2jjXDM7UjvVsiNBbLbVW1e5xk4Bj7ZL085tVl/FDPfQ6
	GbFXGvkDuSW5VzGO2BbYgSTDr3CVVAB7bT3z7A0AYrF7M/obomberXLwqll7l0xtPoDIUraccm2
	8NtVBouc4nH+huktggmiyUT0oM7Df5moR/PRXyzMQA==
X-Received: by 2002:a05:690c:306:b0:78f:9801:7606 with SMTP id
 00721157ae682-79a1c186f23mr38827757b3.34.1773412771512; Fri, 13 Mar 2026
 07:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310031138.509730-1-r@hev.cc> <349671d5-f5aa-48a2-9bba-00aef167b836@linux.alibaba.com>
In-Reply-To: <349671d5-f5aa-48a2-9bba-00aef167b836@linux.alibaba.com>
From: hev <r@hev.cc>
Date: Fri, 13 Mar 2026 22:39:19 +0800
X-Gm-Features: AaiRm52VWGkrpgV6kr1pOmEvbPempDQO61pMP0KiWiSuLBaXj1WE2q1TEU_x85I
Message-ID: <CAHirt9g_PfEM+PzVrpsZwch44_6oeGQ4_abvYMAtjM3eNg5CHQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] binfmt_elf: Align eligible read-only PT_LOAD
 segments to PMD_SIZE for THP
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <baohua@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Dev Jain <dev.jain@arm.com>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, usama.arif@linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 4:41=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> CC Usama
>
> Usama posted a similar patchset[1], and I think using exec_folio_order()
> for exec-segment alignment is reasonable. In your case, you can override
> exec_folio_order() to return a PMD=E2=80=91sized order.
>
> [1]
> https://lore.kernel.org/all/20260310145406.3073394-1-usama.arif@linux.dev=
/

Thanks for the pointer!

Cheers,
Rui
