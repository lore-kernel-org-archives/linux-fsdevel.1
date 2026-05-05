Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F2D3AE1B9
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000978; cv=none; b=Bhreo/BOStjPFSqrKxMOQu6KbuyA8WiGaMHQX+OJJUgAGN8GgCdKXsuXclXjFRSQ5eXsWVmc+bSDevY3GfOPI9LvrPCO3Wjyr4jOzxFOP1HLEs8WWTIvoE74h35bLiZ+UXk9/w4RVrXl8QXh7Ru8vJL8M936DFJHxWUZndDPXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000978; c=relaxed/simple;
	bh=3IzOvHwnS1hWFqQ73c/CZIyZVXZ1QDNcTIoxjObBN4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOyNMkpu7ksidwWQ7q339+D4npx6hv02rUHiKWMYNq+vVRd9CVKBfVbkZDr3kCyoMYjiPoHHzs3AlxeS652qatrUgXXpKQxPYv9MlwX+Y1yufWdcvLimw1CmHKM+MCE+4YU0wR431In+XBk1GxbuJn9LEXkq0c9RVDDIxN95YKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BcrApQJe; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BcrApQJe"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso5660310a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1778000975; x=1778605775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4SI0ve6DPikOEnjOv3AEgY0fhZ6kWI9KucnWlT3Noj0=;
        b=BcrApQJe+/dCDw9h3fdu7U6FClLmsYwM0uo+8UpEFw5UB17Pdy6r6n8EHvn+ee43Lv
         0QCi8BTFG5el88omZ9Q/O0b2QhjiydANrHRN8pznpczo8lVKBZreqZlOT1P904KC1j0W
         IHGlEqYFzmZu+5mmVk7es1+a8AYmdQqAvVIOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778000975; x=1778605775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SI0ve6DPikOEnjOv3AEgY0fhZ6kWI9KucnWlT3Noj0=;
        b=d4apvHGoBeGRjRTKpABdCYAYfOd1G2IOTFKznBofY/VmekRMotVuxMx5UnADoVar8J
         Gs9g1JFWIknOei4njkShrpID5DwjY1rX2S6oSBGtGlaKKHBodm6BHZJzGH1y/ssO8AX+
         x1Lt5Ts7gKalUrTiMbUh/FEV6pRYtLTxRz6v5m0UBSgpF1m/GvGPX8y/neAXPI08Otpy
         G1x0Iw6/1TCKCQRHedAMUzjCTRA4+useEKOiCvbBRvmG78W2AR0K870F3fTzP0FcaUgy
         L/FYI5m04Qh9Od4cA8PLwi7q54hMS/mAImagGENEtDOudFMkzOqHUaHtjxUsiDxiX+n2
         ZIFQ==
X-Gm-Message-State: AOJu0YwvLOIr74yUpMHmhk/yZiOve6UF5QPYC0XNTr1GgY7/f6Ad5EI+
	pDMIRxMYG3AK8h+wGnk6X53hy+hhPk5LKwgY6xREYxkIguWtVcEU/UUB2E9b+MtWNCMkS1Ju98G
	y613WpOQ=
X-Gm-Gg: AeBDietn5GpoVBfGTDoVNv/5sS/1553kUDcdt1ZxSp1FHecQI3B09MCfEPfP96AHU7m
	LThxa4cdTg/Kef4gp6LB0KQpaOuplh3SjnME0D4Z4172F2xIYiRhj0sDDyesJTvURZxUYcf6by3
	vrZGh3GVUVs4yegkaVS6DZnxtR/wdMUu+nssAbkLXDFcLOg4JHVP2ybyUsotghrk9XJJfIbVOXq
	U+brzWrjnYyacUbFQNe5rEbdnqhfhbRE5TfslkMOthblTBs5YnGoTP9WsCCaUUvz6Vm1mMI6zYH
	GGBajpd/1m5MFBr6iaqRvCdjrEmX44h/wCABDd8XNVDZDSg2zO0+AKFDSPUq0eW77yB1XECH30O
	9EJD4FWWgPOx2x37X1PsCsqcqZHKNKumudMvL5GpsSZ6JHDlInkQaeaOheiioCPDouChS6obsdJ
	IMeughLGudWdw86zyXK9PEZ0karpEHw90OWhJkwS/veHGnRq4FQJAkr+XM+JciDIHkWkd0IxuuE
	Y3gfeUnB4Y=
X-Received: by 2002:a17:907:3f87:b0:bc3:c9e9:1534 with SMTP id a640c23a62f3a-bc3c9e91747mr326771766b.30.1778000974603;
        Tue, 05 May 2026 10:09:34 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1dd343108sm256784466b.63.2026.05.05.10.09.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:09:33 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bc177ebda91so483196866b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 10:09:33 -0700 (PDT)
X-Received: by 2002:a17:907:6c0e:b0:bc4:d795:5bab with SMTP id
 a640c23a62f3a-bc4d7955cd0mr156098166b.16.1778000973518; Tue, 05 May 2026
 10:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 May 2026 10:09:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaY30TwQQtNzTbAZTmOck7mZhdPLpQiFsfQmXSm5be-g@mail.gmail.com>
X-Gm-Features: AVHnY4K-g5RSX-8TbOaaq0_sTLVotBybIDZg8eZOBm0-Md0ZUDmIJEeGup8kmkM
Message-ID: <CAHk-=whaY30TwQQtNzTbAZTmOck7mZhdPLpQiFsfQmXSm5be-g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/25] assorted dcache cleanups and fixes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 22:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> This series has grown out of trying to prove memory safety
> of dentry handling; there are followups sitting in the local
> tree, but those are getting reshuffled.

Ok, so I had negative reactions to some of the patches that I
documented, but on the whole I like this series.

None of my negative reactions were deal killers, and I'm perfectly
happy to be ignored if people think my reactions were a bit odd. So
take them as you will.

                Linus
