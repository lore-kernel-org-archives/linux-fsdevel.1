Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235254772B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625046; cv=pass; b=UYYMJQgj3kI/Cf4QlPNRChpO7fH/zz1mtZjVdxoapndyMJPR0FbiW2OgmOocWvJ0Hp3jDE993oc0nu3B5VWmI0m/KD/s6s9wIKuwviiv0Am0J1LXTmS03mUbXpg4mQaqfdqFT8U7Z1inA5bN+T1XJpqk+djtJ2XgYfGPkbzwKL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625046; c=relaxed/simple;
	bh=8MzUWj3rgn1GnbdJfRHSG5hyWrOQ49fk1AOnT9UoUDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AW24sVhI3A7ZZ2LKmncJQR48u66r8oPOOqYfGmcQK+hUCU/NYowccT7GZ3Jx7sEhRd2ocemK9ImSfgU+MIe723MAcodqEc7tXEUlP514ZiY9V4mihs1DMfFpuKKDo6hEbe7dqFMndX8ka9O60rkilyrWnXCydPct7qGFaFonsUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=JR8iZQWh; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="JR8iZQWh"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8111c0c7561so23886307b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 05:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786625031; cv=none;
        d=google.com; s=arc-20260327;
        b=okgvmJbkEA4RtbB1zpv2ZvBCgww6+0g9zGSN0lUDeRyOMW6hdeUVrSkDvb32tir6X9
         Q2LgICFxMbdcvRkhZ5o9um6TtyqmRbAgSD1GeB8Ec8ze8Ji/c0gLkOTmE0n3i/jJYJIz
         iHzVJ0Gh3VoZlbtIqR44H7wOn0QMBKFjCcu26hqzbwTwhQ0iUwXu3RM5xVjtjZ/B0xVT
         DDqLotmmRpD9vRHofzVaPYqscsAxjE0nZNpKPUxPpAMu61357W8occJ4b+WXF6tjKIYU
         KU4YOYehxKN0JOesVppfHgM4wnVYvxFMoXPu5jN3pLA9RkUTjjdnm15gl4wqz2saWRdZ
         zeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8MzUWj3rgn1GnbdJfRHSG5hyWrOQ49fk1AOnT9UoUDs=;
        fh=gNiVuuLlrBzL6TFgmbbrGkoskbkBaYy8oIX8SCT3KYw=;
        b=erpZRc+IjNaqCHEm2UsQDl1TGpZi1mmohpfplvGHcR84hVE2lfU+Jr7VcRLKH0Kvog
         ou9eafp6QPbc3ZzD9SdfUyh1zgM25jOi1gHjyLwhYeXav8zaQGGEhaDGaBNNHnE7r+8v
         yqK5sKVk4YSPpO6cWKr/AZ6NfTgftr/MsCDkd08JKInP661Eb5SOQDGxEf1UP4mqwtak
         XQh7prJ5S7aF0v1XelwBhuimajGZM7OtBSVJrNmle3aWs6Lj8zuGqU5gTJuDukoqNZZF
         EapSdPRMkQxwPIWCoMdu33c3mk+DEn57EEcXB6/v9sQCkwUgiKmp8OIbcJWKS3jSg/O+
         0sdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1786625031; x=1787229831; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MzUWj3rgn1GnbdJfRHSG5hyWrOQ49fk1AOnT9UoUDs=;
        b=JR8iZQWh8VCxNhPa1AL2YL/+TWtG1REZ4nNx5PGGQWhUsZefUFx6//+BS9WBHE75O7
         OJQfBuM+FmXS4Mo9uzfeKDoiSsySFbH7/mYmjKABLSJIOjVjRnwdRlbjCeGsk6904SR4
         zdJ9LHF62bQvnZ6FOe3ZJOyIOY9gM+yZC/cYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625031; x=1787229831;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8MzUWj3rgn1GnbdJfRHSG5hyWrOQ49fk1AOnT9UoUDs=;
        b=H+W6NDdohHVX5dob+cPDs07G1KFBKD1/W7OTfvV219oVV6/23puh0yMgXECLigO2fO
         HJEbcBE/g7RGUA/7F9nRx3Avg2w/YQCSiZ3hLC+2XopTwI2onX8gpQLnpI8EIHzQ96Ym
         uw2J1wkbtgDdplxpXqyoOHKe54oQAZiobgpFhFLtHcku7QSXZRF2CetR4LlIMvGYnWFb
         cUdPuu5OIJiJ+sFMnADNXjlp9Yi1JgUiLBEHw2WU/GzwzjOGKv3lxUt8XMmscOmJqu9N
         +GU+8U9cfy89kLk0YiMvNL4x8SsF5J3qdKTG/EuTV4rFzQnUApAmI8QGZmLPuP2jdewb
         G8jQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrdnzl7ld9Ef63K3YjkCQAkb+5TRFVvM3CMzPh7YbZVyX2tbK/bNcRYhrTpRs2MVpBWRfB6ao0bIzswq8EP@vger.kernel.org
X-Gm-Message-State: AOJu0YyWMkCt8wHs7Hivn5jD6sTp/q276s6Ihv2K0I2bZU/dFLJ75PaK
	i+QJW2KiQBUaOsCsQRJiNUzfcXRNtkOfrkz94/VXOWizJUi97ap8rygYrvJwHaKhyJf82tP+xTu
	POnFvfBIjPr+19Tjmp9oeFMbWOymwdFQ5dW2GZXsWWg==
X-Gm-Gg: AR+sD13bZ2y/BKIsIWO9dMDS0cAqZePIid695UNgnOlfWn54b7pu1XMdM5ji66Ln6rp
	R3EffE9InR6sQOVgWZLnvsd29/tgB6palHjZBnVDVJ56Vj6Qlc7W5nwt61AqTwbConhndyh8UY4
	v+TSXDvVmgULZvs/68PrI7e8Mi8qO2H2F7ASGcTVoyi6ax8mXgjJhOP4TLXW0uHmeHUP+yYORaZ
	3uRc8HIg7VFUc+iWlw5J54XosuIYwbQD2GZCwaIEseSW2dwexUY7IyZpzVwsFDoALS87GJv9G0R
	LxaAkXxMVvKMEj1xhTnLh+SnJEWaFrCQ/IvlZaM6zLV8IwPz333GlB6E2MinfY3Buuk/PmcH4V7
	X+g==
X-Received: by 2002:a05:690c:6604:b0:80c:3848:bde6 with SMTP id
 00721157ae682-8347604ac58mr25851337b3.30.1786625030082; Thu, 13 Aug 2026
 05:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813063401.1786548-1-thehajime@gmail.com> <20260813063401.1786548-4-thehajime@gmail.com>
 <2026081355-remold-sterility-84f9@gregkh>
In-Reply-To: <2026081355-remold-sterility-84f9@gregkh>
From: Daniel Palmer <daniel@thingy.jp>
Date: Thu, 13 Aug 2026 21:43:37 +0900
X-Gm-Features: AUfX_mxLK2-tTZ4HbMKH826rkOgcLTFpV3jXv1YZv32aeraWoqNHTweMz1gVfTY
Message-ID: <CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to /dev/zero
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org, geert@linux-m68k.org, 
	Arnd Bergmann <arnd@arndb.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

On Thu, 13 Aug 2026 at 21:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> Given the age of this issue, I don't think anyone uses no-mmu systems
> anymore :(

There are a few of us using it for hobby stuff[0][1] and there are
apparently people using it for actual commercial stuff.
There was a session about this at LPC 2025...

One of the big problems for nommu seems to be that everyone is
convinced it is completely unused and totally broken. :)

Cheers,

Daniel

0 - Really good example(s) of the 68000 port
https://github.com/crmaykish/mackerel-68k
1 - https://github.com/LinuxMD/linuxmd my version of the 68000 code
with devicetree like those fancy ARM things running on a sega
megadrive.
