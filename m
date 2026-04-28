Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A73D7D98
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368755; cv=none; b=cvfh7gVmgRdixNVJVANrJ/aI8Sm6Ay52BXe9cv2t82H8uMizFfLZK1detaA5PpD7hkqlN+5mcIVNs/x4eiAPtr61gaiGPiULp5QZ7pt/pkr1hjeCapw4xGwXNd+tzDY4WEyOERzQOq9oEoF4nnTWj1EWMuzRTgt2xs3Z8uIOFUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368755; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl+aS1049hao6P5yM75ahAJS1U4rAC5Qyhwzotoks0JGNnJ3iNq8SWteYJ8/TG4qRoXusZuhQFzqdqHyaziK3vWeirk81jFDhAPiVFg5DLwYtoNi59QP3GjeJBH3XODnLBnhyz4I1Grn16DcFIJoRXYf81U8VS54tXLi7/w8SzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8f97c626aaso932685666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 02:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368753; x=1777973553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=WvOL+3kvr5jUpaa77q3wEztFn1cwoNcpoWCJ42a/WRkfjqSXnkW2lyFnb9dGBknZ0n
         bBETZ725s3rFAQ1dRDs+9zWhHkwi2Wlzqa2TqSTcb2Ekf0vIDn5EdPwwUmnYiIMFF3Eq
         wLSj4v8YfbJqBcenBEHdzYp2z3F87M/OpbprIWXUSoOtslj6+d/h3rKT6wLWa7xwj8az
         gKmbMP1Y336HZwNeGerHx2Ge7cBoyrANiHdrw+oIjBqCVauEouel0q17tCRq0TTnX56J
         33UT7ybIu1Rk87MmNbyNdNnqBYaPCB3aTFIZy3CEUEHmNDuGMGdKcEXvgryccbUtbi+P
         cNPw==
X-Forwarded-Encrypted: i=1; AFNElJ9lRxbn7WYe1brAJ5K+rSxhWEJUHlxSD8xkpVxRnafDcfztuOLFd4lYfz/z6kntgJKenF+MBieZpXQ8vQ6J@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0eUv1vhRRAGYU0CfmFCkRqPfNJCVdjz5t0N1IYSaYO8dq2E1X
	EY3PCvdPRSCoHPTFqgwu0oAp4WgPEulej8Pz3vov4/jwWyJCz7ZoWHrvETO/8KHbve8=
X-Gm-Gg: AeBDiesRRxmx7Cy12yVi3vFa2N+Nh3uwkQPYNzZXMG4Bg4g1yLAl6oLk0bKVsEF0pyZ
	Tjwykxhh/EkZVjvF1GaXXAWc5JVHyT4IomIXRzFp2x9QzcN/NLmcVuW9QHFzSzivzlBditqq0W0
	FntQkMia500m1ItTLJJ/IUdG6xYrGn3cUjiIEDhdLUK0S9ie0KWyIIu2GwsxZIKihR9+0clc4wm
	BK5J8bPglESw/9QRmQIHmGk0eG2h1112kQWz6QQRrctPJpwlHeXJuZlmvPrasSCXaKcDVmvuyIZ
	8+KPaD2ORGEVlu0zJF7skzl30xxEk7oKDduq7Y8D0LloXlOdds6jg5baDfBycfBEGtSqRKkkTYD
	hLU7waCIzDQwueHF29TQozDPcVJsoZJAb1eBG3HiQWASlUtQOVaNOK2gMIRVdlcbGtCrnmth0yA
	6KwNlGmDBxMIWh5LGrvJIjyX/ye2+3zOGkEgPOOe5vlWrySFBCNVRDLyKCfK9OgFJbK8ub6h4=
X-Received: by 2002:a17:907:8b95:b0:bad:667f:efa3 with SMTP id a640c23a62f3a-bb8026bcbb7mr100887566b.11.1777368752612;
        Tue, 28 Apr 2026 02:32:32 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80c181787sm71553466b.59.2026.04.28.02.32.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:32:32 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so19507477a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 02:32:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+RsPc289bhiQ8eyUZz438JgoVwAGks8ZH5R6ke7/v7PbdB9IFqtertNNFMJEYg4PCP3548IDPAtx2X6bBe@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
