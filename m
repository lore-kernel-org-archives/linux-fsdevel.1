Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794606427;
	b=BiTprXomsd1igJuXiEtwjfW1tUsdvXUbw1tDF+WBKBlsg2ROWYkST9b7wcFR5jB7K8Tg
	 zDu2CZtuTlBgccCD37HHnFbB5VwBPbkEKpKHL6SQICMNCVAQHClzoJXh1MNuf/SakSM4d
	 uODY2QPYcr8qVQ+dB1rYpqf7kOOOxiUc7yQhDxvnuofA3EAQPa0DdXaOiP+LKLM1vIKeL
	 3h3okdhTUnKUk/qU7UtxlQYh5/qSXQgDZmqBBcdo2/r4mwXcXqv1SfynPqPULYrW+RXfp
	 4EonzszpB3hxYKFLsNjoi/GMSu94oN7fh6hxozoFatAeWbooGrFR2YFYFAzWb0MzAFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DBuZUW5YrwkUb17SSDsBVeP5Pci0JiCkYJrKClP/tTg=;
	b=dQKJ8q73Lc5WNLig7Ap3hm9hHaEaGALY/gQQHiA1Qe955/Avkgf1qFtZo7xmWsBzNGcJ
	 QCEH/ksTdJox3w676Uo6n4hMee7CiznOtFEgoIkE/qh/qlXQXZxXOi2/FaaJX13us6KPN
	 ZERcEluJf1gctpiG0mEiy0ipRtfndQt9CVHzwCdnXkXsCjs5vjNznbk1DaiOlzA3LvE5E
	 R+A3RObLcg89leF3HajwAheh1Mwsrjwyzpg6LhZIUqAlei2/YvQnihu/fHYebFQXqFP2x
	 FQqxNNgRSNCT9/fjI162mx4BUTKqOTf0rcuzdIyaME6OEMEkQ7rFuOLDpIZ6vqRjW8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ubuyyXyz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757F606A334
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 21:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7757F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ubuyyXyz
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50604721c8so313106966b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 13:47:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794606426; cv=none;
        d=google.com; s=arc-20260327;
        b=YtFVsI/BrtZWrGq7q9f1bKR8cWNy3aOfuai3jlHrYRTMV/ttG1J31sclIS1HAb4Xg5
         O4iik3bhW2QmCtZfoR/389OqoXfIpkQfrDm4E21peBAuk+lAGOxRY7JzNLLZPUgCW+J/
         N+H4wseJ8Lv/Eztiv1Mkc6mJm0049R+Bf3JtJ9REnbxxeQfkmLww4V9F1DdHpvN5zIIz
         0YdXKFn3V/vTDleGdFy0FlNCAPZduh117ccwe16Am3dvfyUS0/x4V5267hqtuLZ0a1fQ
         b88/vqMakOCtkorc0Wo6AR6lJSrl3bsu16BAwpOEp1Y9BmSNa9s16Dnznwqp0HjZe/wN
         jF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DBuZUW5YrwkUb17SSDsBVeP5Pci0JiCkYJrKClP/tTg=;
        fh=vo7M7fCASzF7zss8WihHoLacVAQI05YkuxObgLalatA=;
        b=krA92mIlSbCVi3ZqMBNSpaZX9+hutSU+OTcqsr61Mw/XjCW9+69YrWOhVg5UhOnyfy
         y0nvnCD15nxEUi95dbl45l2/P0nr27+17niU5zPDa9dtOF8+FOsjNgv2c543Ol5zW6Nx
         3LIFXwv/TrN8nOEetTlDOR0xUvHm5OzKJSGcggH15X7WUR4S3gpDPPZa5Lth6x4NZxFH
         oHZhH5C0qZ8Yj5+awefzZP7s23ItZIP0+OSnItZv5e7FKvxYPadb+4UqMxISsg51gJCP
         eHGRh4NLegKY7pkWzOttOOAkiDoZY65thjR/8jxU19pcA8S1KJ5om2rv3egGoxR4X0qJ
         RhLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794606426; x=1795211226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DBuZUW5YrwkUb17SSDsBVeP5Pci0JiCkYJrKClP/tTg=;
        b=ubuyyXyzT5OSCtWB96K99IEVqPlYAj8LrV4DLIV4rQi///6Ohl/keT3A/do/aE9s6k
         RHJjZWpR9mgWSGLTEn7aprq+/bGawopLISvapkhz3gK7/rHLxS1cdawsRkZBZjGJFrv7
         ZRbyj+l2rZa98O0uPI6mHieSONdNuGM+cCr7VOr26YaUOr5zPAogwWe4MIAJwQDtICCf
         lEiqTMS/6HA4skjiKJBRl37EgVl5OoVATkUG53wOVY3mrNQ7NMyHLhfZRjrC0zRz0kmf
         xgWo4+x9LFZfomJWLW98R2dSMvnuMuqNnOZfUmiAbNfCOev5wE1slKTbMsEsPQheZFaZ
         HFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606426; x=1795211226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DBuZUW5YrwkUb17SSDsBVeP5Pci0JiCkYJrKClP/tTg=;
        b=De2Y7VxxDcVNJFiDJrQFxhcvUtdF9WY+YvVQhaLYN9HJ6rFcyCcsH4PtJuNb6Ejzf1
         GwNzOTTAxjDkrAfQRYux3emO6ZSLod8/8AqasgxvRFDrCRnDaQIBXwcwL0vfcF8i0/BE
         hSV1Obu8BxsQDkGGXkar7h8NyHfRgi12eWmSbPQmn01d4h0pbkEPVwmnVcBDU0ypizby
         CRRM3a9mkhJgP1OrwE06os2394uYDNYnMoVJtG0x4C2uE+puAiNTZsf5vlV153N2GBaq
         Of7jqbu2nl8EaoModY9zT1aENSsq8th4FyC9vH8ZKBc8eShqR9h6oCVMRe/SZ2GZPNe/
         j7/A==
X-Forwarded-Encrypted: i=1; AL+hErHuskli9no+O0ga4ti+Ir6y7AYkDMANzYgkaYP8nqnjlNU/JjNzrms4Pc4GeaXOYOqDphZfkDMFYkrNWs+v@vger.kernel.org
X-Gm-Message-State: APuU4Z8Af7O+p0m9MsE5C1EBRB0i9t14ALivwkDPVvaUAexGCiPQUo9U
	rZ6RPKKhn89Y69HwfYts3T1+MO/0hX8dYZn4nv8fyUSVNC5qs4DTL6m1X4MNpyzo5tR/PticAPU
	9trGMiZuwtOtqGorq1ICIamvSkuuO6vM=
X-Gm-Gg: AYBFou37tMg56soH1Y2EpbgEslMM31CBU0ibaoNpkwu7ny7uwWJFhw5s6Nr1Y3QbVEM
	CCjYuvWgq23J3VjZ57N91QrKjtwnSfESOigbXtQaT1stT5yfmWl22//mQ2BaaZQtVwRhCWoSQxK
	Yj/eh+tRf70R4uQjM1kE19giG1nyyoHzrU/EFUvUgqSZEvoCJhMkqhlmh3LulXJa1VhyG1rTIOj
	GWLbZOBae6nWJwB1FoMX8Z4sB0zT4tuNMUHSqcddv+EeWp2pfTMbkNWH4bzDvU3dxtWfoinbJ6n
	M42oEPPSrfEpFKdlqFu9XNBebYkuLTYqhqnTdqmWRzo61+VeUDzUjTuf5vi/U1XtCq39bWid/wo
	g2PogQifVYWCR4lI+8H7jAevnTha37NLPEfeh8eFuqCrNnE7O9hXOze9nuJbyj5+B/+TWaQ==
X-Received: by 2002:a17:906:9c93:b0:c50:5186:a428 with SMTP id
 a640c23a62f3a-c50963b3380mr372754466b.27.1794606425739; Fri, 13 Nov 2026
 13:47:05 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-swap-thp-split-v1-0-dfa8d4fa448d@tencent.com> <0cff8050-24ef-47ff-b107-70a5acdea631@kernel.org>
In-Reply-To: <0cff8050-24ef-47ff-b107-70a5acdea631@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 14 Nov 2026 05:46:29 +0800
X-Gm-Features: AclHuK_GcWwYOTlOcpKzfkqKUnw8cGanu3KfVChnEYhbBRBs1s-nvvOrFv0vtzA
Message-ID: <CAMgjq7BcmSN=0cLAzrpPatjWP_iyD+FgAMcvVcCpebStWYprGw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] mm/huge_memory: clean up and speed up large folio splitting
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 5:41=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 11/13/26 22:26, Kairui Song via B4 Relay wrote:
> > Hi all,
> >
> > This series slghtly cleans up the large folio split path and reduces
> > its overhead: uniformly splitting PMD sized file folios to order 0
> > is over 20% faster.
>
> I expect (well, and I have) some fixes in that area, so we better hold th=
is off
> for the next week.

Yeah, that is totally understandable. I mainly wanted to gather
feedback on the two xarray / folio helpers at the moment, in case
anyone has concerns about that approach. I can also help review or
test the upcoming fixes.
