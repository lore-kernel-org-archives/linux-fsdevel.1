Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510621;
	b=ME9ZC7xsTlcDq35y2p+EO3syilfnZ+gu44OSecIMnHeYNYKzqiGX12yNICHXMYudh1qQ
	 NC2xOG6gFYhe44XNwSaCYfpUeH41A/Hhhe3w+hqghnsZ1RCzhU2A6L+x9c6ef4lAujBUE
	 f/HfSRG0vgM/OmjhOHUvwF+pAdWvtOsnb/kvg49FMRBmEE38xAgSmfOoAbFWRhJT0JymK
	 zObmD0RBhIfWpZji0i9s357eSgKCCUQ4vPEat55UtkKvWH8yL+2HjUKAsLC8lNFJyVUrk
	 b40F0AlJF8MGf5juUXfbHYq8WPnq1dBcX0JHp2HnewQYYIo6EQAEebnmOiumbMINESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510621;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=BiDOWQWnXjiTVlwWz8It4XU8j0IkMRXtLOxSJ2sBmUk=;
	b=QOoMg69OCxc//YbsHfwqivehovleP7NcKOXqfWkoKeOCy+JyxPu+iKXbkQ0IxmcVDxEX
	 Of622bM8vmKhL4LuR3QXyiIKWpaldaMNJM1UEpfKxMc0pnitjn3DK9VcTqEhl8v40IxnG
	 4yR6xDpfUBnWQZVe55I1WNGu3Y9wOE+I6eMvjM6wIxnH2Yu5qiUSgawzXoMqNA8v6oXXL
	 4aZS+FounB/jOnLUwYxSVOnq7icRBQKcyYCWDBCfCQvjdKz2ydocTlIVJq5FaVYXrVu2v
	 JLldbMFDvQIoTrYV6KiWTOHFn3e6V0d0ol2+hnw5vFwJJJbg1UvHybFpzSUo1r7c0sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26D60A2623
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 19:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB26D60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so67346241.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510620; x=1795115420;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BiDOWQWnXjiTVlwWz8It4XU8j0IkMRXtLOxSJ2sBmUk=;
        b=plYIg4yw2Q9ohfJtbunZ86noLBL0jZCnIvnyUOoryFFc9l5sNaRMwMfNyvfdpELyzD
         SdIhei/JB+vy6DXS2Hx7h/4EBN3lk9kSWDW0cCrg8jMid0XfpeMGL4MIjmbkrRaBL/gN
         DTwaC7K5N6Uzha1mQ9lGGlxJ7au/khdTOMEHDsi1bgOPI0xD1kBprHJ9gLWkRHjiCdE1
         rCPIBWdxwRhgClj0j86t/N91ViUKxxvJfpMf+944r6zGSU19GCQcJBokYLZhobL38Kk9
         X6RjPcuLsD5E5qjd1F/OrSp3QG0XChNfjcQi6hVY2xXsXGeiFrnqPOAf06Kv31ZU+nrZ
         NtKg==
X-Gm-Message-State: APuU4Z8DHzmP/VP5tuaSUmr4uMT8g5OTuXy2MPSt3lisy0SS/2EXCnaU
	faU717QehCdbTP0PVx42brrd0wIGUaq43BXiPEkb0dRI7k5XscFNVEivEPDn5PRDdJQ=
X-Gm-Gg: AYBFou0eUlpeU7+9Kv1ibHQeDlXgAV5F67cF8JqyXFrSSU3AVgypxUwnvBCd2ESX498
	3DkEwcy007pMq/lP1mG/47B9qPOvoA9krW1MlGvny8yqjBv4Oe+E/EYdo2hRtAICpVLQs1h0Su+
	KfoohTkO6O/8w+uZCeiKOcXMkl0X/HSDWx4PShIftA/T7dH1c3XXnoEKyGhdDc983ppDJvXMWN7
	YSad6RekF6kzZtz4zgA6L3JGNo+EOjDnXzs8tRxkQjBbQXZEANK1lBew0y3ZbvquV5R989e/1l2
	0I3AUgBIHCTERI8EFPXQL6Ty0UvOO6rv4pjsBLk7RpRnxe4ZrMSDMmmwiOnBq/TcEWXRGhT63Wx
	pCS3tr40BygCuWBfQTx4SrPexEBT2yzPqMnTHxrUU1RRCs6pXgeKryMyjlAhsvEwSgDP2l3OSu1
	DihT3yaCF12l38YjeJKzrnD/Zl+/LhWzIBnNLTw2mvxBjop6SliTfSpc6rATG8CXwQYMj1fALqm
	HXSMCO7BYD9wesf9Y5yk/zZX3ReDDvc9/5CclLnqBbSch+AtzYob+8NAqW33DsPSsinQM35sKGv
	btKgcTQY/2ff+vEhv9IADYsiFwRn3zXXG32VO+ub9buj+kIvP9tyrOy2BmRPph2/b1U=
X-Received: by 2002:a05:6102:2c85:b0:7cc:232b:f5a9 with SMTP id ada2fe7eead31-7d64d80d3b9mr53383137.24.1794510619664;
        Thu, 12 Nov 2026 11:10:19 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c4c4fa5sm228915137.8.2026.11.12.11.10.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:10:18 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7cc91ddf447so28273137.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:10:18 -0800 (PST)
X-Received: by 2002:a05:6102:5ccb:b0:7ce:5952:125d with SMTP id
 ada2fe7eead31-7d64db29605mr42432137.36.1794510618289; Thu, 12 Nov 2026
 11:10:18 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org> <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 20:10:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgM_TMX7HrpsvDaQi96Ht-K6KTBu5PPRRBpcCegf3Q9g@mail.gmail.com>
X-Gm-Features: AclHuK-k7G9fpVKu6BhCbcWfXavvnldoQZhCl9e2eioRf49lg5T7xpzAfc2z5gM
Message-ID: <CAMuHMdXgM_TMX7HrpsvDaQi96Ht-K6KTBu5PPRRBpcCegf3Q9g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in copy_oldmem_page()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Chris Mason <mason@kernel.org>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 17:39, Christian Brauner <brauner@kernel.org> wrote:
> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without checking
> whether the mapping worked. If it didn't, the copy reads from an offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
