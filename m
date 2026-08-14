Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BD220687
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698606; cv=none; b=jdOE9QCDCvOzn9D0kG8paZqq6PeeLmS8XsO/V2faTQEXW+F/2U02/LPupU9T5hNSky3Ve7X98tjQ17/MsXbva1Pwa35A3+ZP3OSrConH6sYeEPmEy4iWKHHT821ZffP5P5hKTaHCKSAETHFpWL4/4O115KBgDvlQH0IBMuYM2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698606; c=relaxed/simple;
	bh=6Jqj4JqO9BabMyvxuodPurcPg4/V882ZcQOZjyroQic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlXwFvycifMCJd62VoCp6qNvP4DSkyDCL2/90czVxsQCFuHHyMiVSgAzs84JZsixkFyWZV4YPrUPZbAbn88pue2lFEZkFSjw7vPVyoPpSjB9W6szynK+/JzSukAI2L/UpzK3TiMFOyGSDaE46VBlduY34pIeQMpbLcMZmJ5uMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-74ab99038afso508933137.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 02:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698604; x=1787303404;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Jqj4JqO9BabMyvxuodPurcPg4/V882ZcQOZjyroQic=;
        b=T9VD1KIamTZe91DbuhqlNtgWwrhlFhTihGyMwR/p4K61TKpKIcmn4UDL/GvOPuQVqW
         ZEI073pKe8+EyAm8hq0pwqTIk7ALSMWuvH49a7jDwaIG7R5gXk0rXo3ENZWUXns5Rkms
         8VHwxxj1zAcdZa+9lO7vwUUXShTXwcpvBEGPKKs5uTLO0t7/8Gpo8bofZoBC+CsHRCy1
         7TtzJ75AAZgQG79UnHX9v4tK/PWgqW3vzEEW54iXdS9xOyk+aVI73nAzvdAapJHNc25i
         rlfNRag8CcpgT7nPd9PTzeI4yZO0KBomJQH0OJFW+kAskREDbR5nvF05B1lcUZvAeMyv
         ayFw==
X-Forwarded-Encrypted: i=1; AHgh+Rrol+Px6/AKHWOuVqY7sTgG4/zw3D88MSN9S5Qy3GGo4RyIDAouWyfIdqk+LZZbsyKC/iRaGpqvsReloJ5G@vger.kernel.org
X-Gm-Message-State: AOJu0YxjmQT8/klWpA3zutuW489d4221gUfDH43i8nfVj0lugggWd4jK
	NUIN9JL0ek1xhWi2xGkSLBPc1kljm20OZcUmcPIYrLkif7rgNy5XdcsNLhhsEudrq2g=
X-Gm-Gg: AR+sD102HryNVkCkfVYBbRAC6ksEWqZiKhGNnSJ4yMCL6faNdIo4mM530c7WZjrRjzG
	l1mnf7MM0X982AemCpOgHebyQK416RiznRkEyg3ZiDm6cEgXUDg56p2hsIngzIrNLdRBZYLAHrD
	OOqhHDB38dmhskwe/3PxWyIP6UW/yH6si7/73537Kz5nFlYesvGEdiwqKQnlVNYeWDRCWEzE328
	1jtV/0+0wgaXRelOVbJpw5vBXAeM9jdTprlyHRt3NGv7NNr8kmNG+ex8oazAFRlg269huof24IK
	nWLJ6o9RLUruvxY3tpURcap1BVQ09ed5l0gweY1al3RVv+C/HK2fYQsX+7ebLzyGdMecRCQ1rGT
	SOvNoXTfdGMGPuIUV60hXdCoks9OVMQwjb01rN1KCYn1J9uFxX/WpMRYrrDZSBVjuBZXypQ4hx2
	63Pj025bid68ghqzLV95I2iZzLk5YoWMvXh1wrvCuwQWqEm2Jam/5lToGTG64Eg2B5TmgYqub6J
	FVlqCPxPMXy5u5k0WuYsIfiwQ==
X-Received: by 2002:a05:6102:1607:b0:738:fd01:5b60 with SMTP id ada2fe7eead31-76f2a5dc579mr1005781137.3.1786698603612;
        Fri, 14 Aug 2026 02:10:03 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-76ef849a7fbsm1130888137.3.2026.08.14.02.09.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 02:10:01 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97622cc1f40so382953241.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 02:09:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqtj3Qr30HSjcA630FcauSqmE7dJUJSOW24TcvtU65EjVuEuuf8BVyG2F3QnePSIufCUAGAcpKQ1ec7sS4d@vger.kernel.org
X-Received: by 2002:a05:6122:6610:b0:5c2:bb83:462d with SMTP id
 71dfb90a1353d-5c591d5fe7dmr1060680e0c.6.1786698594102; Fri, 14 Aug 2026
 02:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813063401.1786548-1-thehajime@gmail.com> <20260813063401.1786548-4-thehajime@gmail.com>
 <2026081355-remold-sterility-84f9@gregkh> <CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>
 <2026081308-amigo-paragraph-3afd@gregkh> <an3O9QHUZSSGIiZD@lucifer>
In-Reply-To: <an3O9QHUZSSGIiZD@lucifer>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Aug 2026 11:09:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUNjbiseh9r7bBDwq_Q_Zhuqg5a95W4+B4KxkKYoJ8vxA@mail.gmail.com>
X-Gm-Features: AcwNN1XXyog3dVT-YfvVdAkP7WMNLCRVBkdrVnLyIesZwezC06Glgvjmz4OA9nM
Message-ID: <CAMuHMdUNjbiseh9r7bBDwq_Q_Zhuqg5a95W4+B4KxkKYoJ8vxA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to /dev/zero
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Palmer <daniel@thingy.jp>, 
	Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	"D. Jeff Dionne" <jeff@coresemi.io>, "D. Jeff Dionne" <djeffdionne@gmail.com>
Content-Type: text/plain; charset="UTF-8"

CC Jeff

On Thu, 13 Aug 2026 at 16:11, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> +cc Christoph
>
> On Thu, Aug 13, 2026 at 11:02:18PM +0900, Greg Kroah-Hartman wrote:
> > On Thu, Aug 13, 2026 at 09:43:37PM +0900, Daniel Palmer wrote:
> > > Hi Greg,
> > >
> > > On Thu, 13 Aug 2026 at 21:26, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > >
> > > > Given the age of this issue, I don't think anyone uses no-mmu systems
> > > > anymore :(
> > >
> > > There are a few of us using it for hobby stuff[0][1] and there are
> > > apparently people using it for actual commercial stuff.
> > > There was a session about this at LPC 2025...
> >
> > This patch is fixing a very obvious issue that showed up in the 5.10
> > kernel, which was released in December 2020.
> >
> > So I think the fact that no one has reported it before now means that no
> > one is actually using it :)
>
> Maybe Christoph has a view on this?
>
> I brought this up a couple years ago and he claimed there are commerical
> products which use the latest long-term stable kernel (6.18 at the time of
> writing).
>
> See https://lore.kernel.org/linux-mm/20241122123833.GA26432@lst.de/
>
> Christoph - can you explain why none of these vendors encountered any of these
> bugs or breakages?
>
> If they are doing fixes that are downstream only, then that argues against
> upstream nommu.
>
> If they are not, in fact, using long term stable kernels, that argues against
> upstream nommu.
>
> The fact they seem to be assigning zero resource to upstream also argues against
> upstream nommu.
>
> nommu continues to be a ongoing burden for core mm that interferes with work on
> real architectures on a fairly regularly basis, which argues against upstream
> nommu.
>
> I'm curious to learn what the arguments _for_ upstream nommu are?
>
> >
> > thanks,
> >
> > greg k-h
>
> --
> Cheers, Lorenzo
