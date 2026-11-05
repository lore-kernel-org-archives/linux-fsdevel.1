Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871285;
	b=xlA1eMAzy1eiSzBCIy3eWA+VH1GYiscpjMIB98Mda5eoj2SXeyBvWc24WZG7JYYFfwFh
	 kjPyjov+pORHSIvld5p7a2+u71BFw9Hs1EzoRLiLEQiwRk2qAOStE9Nzqn3o1W75EyGHD
	 7KA8PkR9wI+pg4fiQCiE3ZLnvR/J/uKfQ8MqcZnSce9FNV/bsjBOIZCuZWkQgzo1q8als
	 tnazb1B8bRpfrnPMBS2TtOq/AxBuzHINpkTuHe6Keo6xErmYoBQ+M8c9VGJoxZWcvLrld
	 pFCznnH+cyMCHTpWynQUC5kW8+9Kmb5Jh2GbX2W16XjQ0t/lQ5rTWRjzNg8e1w8f6lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871285;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=DpLYJIWgXoS5zQrloj/RgE/cGCpS34NjW3pzuN6S6xY=;
	b=3/6GVEq9BB2wxSDRvwGh7R8KVs9T7/iz4++aZyEIp9E1HNN/6Qh1sf9jjpWbVQLR4ZY3
	 Zcs/ylCW5OQjD23hZOzohUllpvXEuvYf1MDhVDuqB7xI/7576hl7bbGql80gSrxpbO4LZ
	 FiAlUIuCA2F4xoHlthlg+Lra74X/4p7/MtKhyO+h5/2A4HpRfn6kUTpOIu6khvmhpBxbv
	 5ehXczPrm1qmkz0cBB9eNGtYrf50f/pdRW5rnlF69jxnM8IJJKjhgnGW700hGogK48UML
	 7RAxbKXsDu7kEigu05epDxdt8jQiVAe1UNnOj9zg2iK/gr3qEg4EhCJZZshq2KuziAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E348606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 09:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E348606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7c33cc572e6so359495137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 01:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793871283; x=1794476083;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DpLYJIWgXoS5zQrloj/RgE/cGCpS34NjW3pzuN6S6xY=;
        b=a947SxBg7G7VuegvPUjoXMS4UKkf2R4c0PoH2O2ct774jH8nXXXbJ0nicvPJjAVpfr
         15rl0FKl4ZqNB375DQBWANagQ9Z+sWsONDgM3iaBOD80xU1CHrbAVggwhJlkxH9erSPn
         MDjlu8SY12UIFgYZQRscCvEyVyf3NZdBRMREtiQ3mzijIwWaxHozhGKm27qogIKGJrWQ
         ytnp8eN71SqhpPLVbFZzLvZHCTUxgq9PYDiChaVNgF70RHPkz5WKiuDrgtViBKIriPNk
         NkShi5XYwG7jxaZTNtwQlieQtKD8NgU9Qp7roaaPGkL4mvUxyu9nftGlJ3bYB9sO1PEm
         VwMw==
X-Forwarded-Encrypted: i=1; AKwUvBw6pgqgHUNE4LTb+IenLlihwcdiSzIkEwK0VIqU6xsp3di25ylFhO3DqqBVKyCtv9SUgkGrFY5oSVlax4z4@vger.kernel.org
X-Gm-Message-State: APuU4Z+NYQGFT8JWb8cu10bG3nzlqyze1h8YiZWcJpaS9c+BB7Cj+4aA
	BcdsPkxFg8rNf9YEJ7MtvFgf3pjYObtf9+WL34Jkma2ED3j/ROGdvBsCfNKxsGNDFAs=
X-Gm-Gg: AYBFou0LlvasFm1kClMbwtr0NVMKmsWoL/GCAnMLi5pBx/jwKYAur4wxePBvbJDzwTl
	Y6R8x76wd/3hmyTiwcDxNFHhSq/Styzd63PavPMsYaZLz50e4eHNHSyenct3njHJaU8cchX4oo0
	AyzI8GWHsWJQGTlTzYDk7FzaOz4q8FVI9bMER37IEk/Yb3vj6096sYu3JLB3K9fdF/lYTq4Ek+a
	90iNVgABrgYr4HvIRoPxjbuHTMRkgq01+vWzbeVQWKWgj9BVe3y6yiUZXzXiv4bhIgYEg/hh6W2
	MBoFPKnIEzUBXDdsOdinhn7dzopocytPv9MmJpe9Mf9QumnYG8nIbfkltGQXZD0/fwZHB8FOUit
	ui8rg/iYWUdW+tYfTQx303Hz/GohgmrnNxmYu9EFmJpnJBwH625SsmWZ+RjkmsyUzWsIPBh7A61
	jOxIuEZAAQpuM+xPWncWaO0QzF+BLKvJThankNdN/ocT8AWbd29mlO5UFeMx6M+6a/qOfqtU0xC
	NMRZECAye8pNUws7nBZ+FcBsvx5W+VWOCedaeoe0IxVYUDXRnaKpit4Z6vkgCgME9dza6kpLBYt
	6p27xHY50qzGzXEpCl28JOzNGrdftrlRA0nIUvWgwEIzFF7aQlzMlVYtdwqe5VvPvw==
X-Received: by 2002:a05:6102:1627:b0:7c3:83a9:edc5 with SMTP id ada2fe7eead31-7d2867d0ae6mr952089137.4.1793871283602;
        Thu, 05 Nov 2026 01:34:43 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d277d13753sm3049766137.10.2026.11.05.01.34.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:34:43 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9909e82513fso404828241.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 01:34:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByfKbf0zaBeqX7cn30l/J2LrS/RuscqlQykSuCLTyw7YYfymDtnyNje2lEZu4cUuHAvxmw746JEpy95tRuF@vger.kernel.org
X-Received: by 2002:a05:6102:3709:b0:7ca:5626:11e with SMTP id
 ada2fe7eead31-7d286b7fa17mr1126485137.36.1793871283167; Thu, 05 Nov 2026
 01:34:43 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105044046.52180-1-dennylin0707@gmail.com>
In-Reply-To: <20261105044046.52180-1-dennylin0707@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:34:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWzY9YRnGz1Y_60RYP7TH67q8fxi1VNWwkhhc0EUeSCFw@mail.gmail.com>
X-Gm-Features: AclHuK8PYnqOIDpZItZg042mTleQ6jUe2E1wddINt5GGmEiia8n8vhGDZzRowiM
Message-ID: <CAMuHMdWzY9YRnGz1Y_60RYP7TH67q8fxi1VNWwkhhc0EUeSCFw@mail.gmail.com>
Subject: Re: [PATCH] omfs: remove the filesystem
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: me@bobcopeland.com, willy@infradead.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, tsbogend@alpha.franken.de, 
	maddy@linux.ibm.com, linux-karma-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 05:41, Hungyu Lin <dennylin0707@gmail.com> wrote:
> OMFS supports the on-disk format used by the long-discontinued Rio Karma
> music player and ReplayTV DVR. While reviewing a fix for incorrect block
> mapping on writes starting beyond EOF, Matthew suggested removing the
> filesystem instead of continuing to maintain it.
>
> Existing OMFS media can still be accessed using an older kernel with OMFS
> support.
>
> Remove the driver, its documentation and build configuration, the
> defconfig entries, and its name from the statmount selftest's filesystem
> list.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

>  arch/m68k/configs/amiga_defconfig             |   1 -
>  arch/m68k/configs/apollo_defconfig            |   1 -
>  arch/m68k/configs/atari_defconfig             |   1 -
>  arch/m68k/configs/bvme6000_defconfig          |   1 -
>  arch/m68k/configs/hp300_defconfig             |   1 -
>  arch/m68k/configs/mac_defconfig               |   1 -
>  arch/m68k/configs/multi_defconfig             |   1 -
>  arch/m68k/configs/mvme147_defconfig           |   1 -
>  arch/m68k/configs/mvme16x_defconfig           |   1 -
>  arch/m68k/configs/q40_defconfig               |   1 -
>  arch/m68k/configs/sun3_defconfig              |   1 -
>  arch/m68k/configs/sun3x_defconfig             |   1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
