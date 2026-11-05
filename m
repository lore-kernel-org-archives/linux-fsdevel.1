Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872498;
	b=UhP+ge+rBFfyVSnE8ytm0pUFziDtYxC/tDnvvK/yqqYYAVrzncq7NgjFKmj2wpRCc1vM
	 dYmdMApBn3Wd6EgsPGD+pUmMY0j8jFT0TUas+0hjb3Vdtq7/Q46nfaEaxIqO/TUen7tdk
	 ViVH7p/SVyV0LIhWTV7aU0CGK/NXwL8GCnjOwxf2/4vSdj0F988C3aFcTVq4fn8dtZtd7
	 PolIdb9xZ29jmKAUauRJh6dednHQaoScDvhuW17xVbP2fcVQMypeABuT0rCGrOMLBHXB2
	 qJK2R9NiE8399+Ud8FeFoRsjFxuYMPgiL4hUFTLD/gLPR1lVADh82q7crbPU9qDDG6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872498;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	b=yKqK0UVk4clqKnpEa1sX7Hw5u0dahBhhgqU3lBygPFp2g3MKIJ1p3ZkMu96RtuiXM3lV
	 NPmBU/Z5wci/injN0RK2J8kbWDT+HjW85NMGV+0adYjbjP7Q+ZvJnBw9Lp6zQw708w6GL
	 m9vn2HXBWydvTY6LW1Q+6+7K7N80EU/vy/Us5bzlo49NJilRM4utWqEIvC3KjLKe2O9eA
	 3q+bedOq+huZ08RXOqpVScSdZQ//PLRc8ZNmRmfX9nzRY+0ay8+8HRc1/DdtarPx8q/Us
	 +XqsGn+DeYKskaSSqbNZY/JzQOr1ppgmK2aBOwzS7r4ahviIFwnuUk1EidgNzsuSdIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA0606A32D
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 09:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69AA0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-745497ac8fcso581017137.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 01:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872497; x=1794477297;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=AW5tZq5zOJ2ANMa5N+qooadz72lNC1s8zpLkP0+WfI+Uv/gHOsK9FjU8bn5QcBHbe8
         DC7M+UW5VCHJaO23o25ySYrJBgerW83aIBEkoP5MiAZNhtjyUwT2o4tjtvPD0M3fosFL
         +J8FR+CQQsVSlNeNrIWZIDDZDqAQusMvpdB38eNMgKTA9Z/J7j9XboBqd22TMdDnbaZ5
         NCtOvJsyCGvoBZ0STwQ/gMurWwiLhPDfqC++mA71KX7Nut4ztUovS8ubptTy0yynuFJs
         wGUlYEM6yWmfA3M2uwEUmWwafO5vLuHVgkOQDunal5wio6dbNN4qdSQWca3VxyE7NV0D
         gU1w==
X-Gm-Message-State: APuU4Z/0xi8TYxxa92v9JsTLHqxQ1UUZjRhp8gUgBSHQjF0rYAEPXt/E
	VeSg42sNZMAX9WPj5s/dsDUNlXxy/9wFAEzx4mMUYFJrTMmcKPQVeVK16nhTHMqGiAo=
X-Gm-Gg: AYBFou24lmw3MJozRndL4GtNrGpAlonULL1ujpAVNNJ7GrutP5lefX7euY6g2+Y68s5
	MqmgsBqt2761xR+I0i9d/+oTIkDZ319YMeAAOqxnyxaMrG7ZUhebYDkRvXJ4JnNxbxbMOEgkRxb
	MpwogUsp5JPcg0mAnJwRIe9rvoTQzmk28NZiHJeRbDewgz4G5ZX3vojQY23gvuns+IENpQ9jixA
	cr20zopNOMMOREpUMH5FP/qeD8L4uxbCyr0+4a65lW1hv7kb9Ud0zatUw+t+scYOgKnCQ6TvdAQ
	rxMMHZQBV7Ewatmb2pOWfbed1HTjqzcLLpd+JLCAKAJe4MMkLnFRJ28k25NQgcckpshWS7OCQRk
	yK4GEO1W2wmx60o4daYhW5086Wy4akxcqzolSQvgKsgpx+QAY98zscHdMF7jwWrzNkc4rhPyvOq
	wu3oWdrrW9+UD4uQfLrlsU241polEDJMcgyRGhgpaYjg/w1r9xweQwMkTGy7fTkFZmEjzcS2umm
	Cm0fGgzqsr2hbe/HAFi72S7wLr+BJVWZCFlCg/m1j9hh+nffh/AXFsqEnK/9bWEU7karO2CuaeJ
	3yRlB5ZkkstkyAshfxcz+g1y6T9RbVShrtP8PUkzNwRvehZ7oGUHSfsdtpZyWK9eIIcJ0uFRCsU
	VFIN5lawx/n2BgBA=
X-Received: by 2002:a05:6102:1481:b0:7a6:85d6:8ae0 with SMTP id ada2fe7eead31-7d0727aa79fmr8141721137.1.1793872497423;
        Thu, 05 Nov 2026 01:54:57 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26faf6ea9sm3759553137.1.2026.11.05.01.54.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:54:53 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eae1276409so540502e0c.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 01:54:52 -0800 (PST)
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
