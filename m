Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510501;
	b=Wt0OVlJiE8ZHPuyjRTuscn38KWX6HSlZGdmukN+QbZbvmljQarv+/cCtS9rMwe98gV2H
	 o92/og//Psqwkw+nL8wm2hKp44PrUl61OPehveoyEPwlw70RkswF5tmPwgHLqN0HyOqOd
	 UnNEd7KN25/ak/x6aNkI9VASTAg7VK/NePqn7QltabVrYskfA2wq2BHcIvoBjFEEIb708
	 CeXqq4dRsoWOftw+fNT7weXjBEd0y5CU7ylsZBDpW85uvdEG6kOzPh9h1CHZw6EIZOof2
	 b+LAZDCJHSw9jqWeSWeiD6qDJrwSakH2JlaEf1TJRSpwCTA0ChDE1eGBvhjnxnz7cGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510501;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=x7avfF8CE7MQkedzx8waSCJsEYoj4qczcsv6b4mLDHA=;
	b=x1bV+2htJT1Ya5k3VX71WhZWKwtb/qb97IpFvc8WI7Tt2n1CAKqn/NV2B5l5cJVEHY15
	 6+lCMQNyVFYCINk03wkcZ+iyyMQRarrTBB3QYvJPjK0HIcUbMFH9QDnRpCUhRDreEHJB9
	 5ZiB/rVTSfYpI7crL4esMIhqELiiqEV9UtvTFDhCZkuc4K6P1jVg5Fp/qu827OTOh+lfd
	 9TTMkKT76Sr2FB79JsfdU1serxl3FsS3VGsLQH/OvC9QTdCO0HmgqO8ZPKB5FNiejrNZ+
	 zDQ1nW+/IGSpAVHoUsWA1rWtkBKz2TvQNfn/j0BnHScAunpWV8zTGSKilZVclQ3DE0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DE606A333
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 19:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 082DE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so175085e0c.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510500; x=1795115300;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x7avfF8CE7MQkedzx8waSCJsEYoj4qczcsv6b4mLDHA=;
        b=cDsdJWcWj5YbgQ0L0vWiOI7ReGML4DJqh+LuKkf2jKwnKjErX+gvgi2UHfbF/nosQS
         JEIJdXWlQq6Rbv2z2q/nhhuDor3PxcWEbRGq6s5Y6F7OKGyfki5zvMGYuESgdxeGoVVE
         dI8/9wnRZGEQBygeQWtxZdIE0mvpfw2mAjuqQrJOWIyM7bNNJm3OiBGYdWv0Z7DIRe1/
         nfuKI2hS1sp2AIsD/sILqpBuGMIXC6Fv7R/F4E2gCYt3Occycm+O37mFAV6VUbmVvlz2
         3x7LKXCt27BpHWiptLrq6g0sJrEaBVxB6F9Km6YzMH4wFyiTD9/iX+UkNRz8Yf1Oas/p
         1nhw==
X-Gm-Message-State: APuU4Z+Tb2MqqA1XbEL6UPTGWgZLKGwHIwB2y0Kk+AuCqT77Gy8eAmaq
	4goQRlGop5cDqNXdBtGEqob20TVIqi1E3Li925Pm0bHE5p1CozAzBgvyKp09kNJnZ8k=
X-Gm-Gg: AYBFou2y4TPy9OGcaJauDI35zQAABbWBJkXsinFnNucXopE5q91TTY+SSC+GuliyMaM
	Q8mP0YjrCaswQg0afJ6KfuOBGD5PkCdeq7M5jj1RKZ3zCTsIfwqZZf5yhYMtBR/bGnwIJqtO61l
	JiAgNsMCKrA34GvWG7gG7ipqOkw91I2w9ElTG4Zw+RHo1fOsr3lSZhECbGTI5t8FCxVZmZ99K3Z
	Lyr66KoiDSQhcmbfLYHtCkkmFjKOkxiv9iyxikpskUTNi9RXzQdRKO/l9w5BASBFlcEp2WKBO84
	7UiYq5QOTBoUna0IugJ/vx6J2LrOBnnrgaPvNWpHzEUVBIHaTd2Wm9WWTH8oOQoiO1ZZIScQryb
	dohFJOFtUFQE2PLoN7f1DWrxU21LWJ7u0k4zfqkZCWyTTaNGA5yhMPBOq5gDPXLleQ7lZXWbT5R
	RjZjBpCKO3iOvbwmEL1NwQ2rrNfgarg2g7k3SZjGWsiFRP2OqJzjz9JbucJiYZkLHHiGxD+Yyg8
	g3LWp1Mq9ZoU/Qa/SqfJD/QQrD1KpELf8gRGvZrmLQGK/Kk0oF2vhUG7r/Ztxe3/n6WdxY1q/0I
	e1dRfgFYG5eVeaR9X3dHsqlrMkFKZ9xjMC+G1TAgjGm4W42kWGT6I7vglHlwXtPmvCk=
X-Received: by 2002:a05:6122:311c:b0:5ec:c186:d22b with SMTP id 71dfb90a1353d-5ee34aef024mr38598e0c.22.1794510500086;
        Thu, 12 Nov 2026 11:08:20 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee341b5ce6sm84377e0c.4.2026.11.12.11.08.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:08:07 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-99075306daaso157006241.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:08:02 -0800 (PST)
X-Received: by 2002:a05:6102:c15:b0:7d2:8dd0:2eb with SMTP id
 ada2fe7eead31-7d64d6ed886mr73919137.8.1794510481935; Thu, 12 Nov 2026
 11:08:01 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org> <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 20:07:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgOGjwOUMxSabUgtaVeKZW1wx78XOJL8joGKkZEj7RZw@mail.gmail.com>
X-Gm-Features: AclHuK8l5OcVstuPYNpoHJ657hIuMQK5i9ySH9sE9lHb16H-lVuh0fnzCqi0JCs
Message-ID: <CAMuHMdUgOGjwOUMxSabUgtaVeKZW1wx78XOJL8joGKkZEj7RZw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in copy_oldmem_page()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Chris Mason <mason@kernel.org>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 17:43, Christian Brauner <brauner@kernel.org> wrote:
> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>
> Return -ENOMEM like the other architectures do. read_from_oldmem() turns
> that into -EFAULT like any other short copy.
>
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
