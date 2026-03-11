Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FE1AC44D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235445; cv=none; b=DkXvrfz+kTih5gO+0LMFNgErevB40DLvBMn7IBh2dRpV8e0fN1Y04A9CJVVIK5wkDGRO65ggEsrfNXlgLmrelrMpIJfpkarx7fUXfXDRBh1yDerCpwxePEv3KTNbo/Hj5IvJp85ZvYFOiTAGtoVUT9SvPBSR0ARLFI5vkj8ftgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235445; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoP7zzfs6GVUnI34TfuoNMM9AJWQX7DaOl5Fjq+oXP1Z2sipu+CkaQurTNP2kDaCH4P6fdifd4pBcJaKrqNClWSdkecduG6g5cUb8VWahH2F+AzZvYXUDw6zc8qWf2+1QEc/3A4VDP1DDwNz3hkFrNDDZkkBzw9Wxi+N9lgSN80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56739adfa1aso10530979e0c.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 06:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235443; x=1773840243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=YOkEAjyKo9cfxCARtjuaYuchcwUoReRMP4sFH6NrnaIDkTYuzFJ6Ea/ZZyVj1KHIC7
         BINc2f/TRrpAeBX+JX45T5seTYupMpBqcpC87Q5zSVlUi5NioAX6diaqyPKezikMN2+l
         qTRmdY+e1NlDJLJs2dyRHDyTcJsv3h1zGMmUAGRdWslUnDawGeDx6wDX+TwzPT6nchGv
         EJbM8DqvkEzFio5S2A+xEai/yVru2EQsJFpvBfSBlzW3jLJgzy9BPs9+mu/4iIZBlyba
         e5V7SunaujAM9l+xHfYA4CPnw1IEqbyjF82nj15DQMU89NQEgAvacq7vNPwrOc3WS1yH
         K+VA==
X-Forwarded-Encrypted: i=1; AJvYcCUdaT6OW2H6n+xonzEQ1t9snKGNIzt7jDLAj5xe9P9y/7ka1kW93cRpfQlWc4MpiFvlRNja1BglWnan/D8s@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZsZN7FbDy9k+WpNlt3FNzmJkGH/pzCDtlH95PbEWswSeboFR
	b7GrX3eefI3CbXWjVPDxulBJYyrrUiBqZNHelJ8kgbrPZHent+tyOiC3+T1sUwV6+cw=
X-Gm-Gg: ATEYQzw3ZOZ60ShWnRDRlnH+i9cR1Ou7CQnA8tAeLhqE1c3xMmD03R8GA6WjmPK7oSo
	GaqWVVjdFVFTtzJX84SpWSxU3utCrD9544cK7ALlVZPevR5lvY1//uXGJRM9YbEpoq5uelWq9WA
	VJNxzGiRmI/y8l0i8hZLezuyP3+HzxZCxpnfDFieNh7jjC2CBRzaErj/X+V31+ImeTxuOO3sE8W
	UkEhUkBOd0oZ70AztDPyAkjJAoNvbuldmmEUasJmoBXTphGM7SqBqcdVrqnZ2nVp9mlcoi5R9Pj
	9uaUg8d91gZqkdiLqAuKyUuUB00mP4HOQTOY5vbRBmEVXmJMsu54YyLiJDIeWvZ0fJCWBmFoug8
	ulL91DgSAGGTFinKwrwN437zJMPkreIxSCji6TGUc1SDlpAqVisTDRpkE4ygAyeZHs+3C0S89ZN
	4lPSDNtu3ZgdSyXoLpuxUG9ditfhwIQi7BSOG+0nsTVjQVnEDA84bFLwqNXMRdQWwN
X-Received: by 2002:a05:6102:370c:b0:5e1:866c:4f8a with SMTP id ada2fe7eead31-601def4dc13mr1003580137.20.1773235442856;
        Wed, 11 Mar 2026 06:24:02 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601de89c65bsm722280137.7.2026.03.11.06.24.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:24:02 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5675d609621so11792803e0c.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 06:24:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0J1YO9itWgLEiZLnlCGeamRAYDUesPrxz53DLMoZmjGjpmyRA1DbQ+xFU2qtZPTzAhHadf6HTlwxWF/rI@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
