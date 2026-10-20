Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792478024;
	b=KJMWA6yeYdiUt8Pc0sVfm3tpubwDyEI+JWYwLTVX2d2SVdc0JprHXB81tReLSnU9dJhF
	 covXMhpjmuTrByiRt6TfCO8K1FATxVLzbh7+5yFFU970/pfosbHLaJYcdyw9dHte/lAgN
	 kpUF8Uj7m/YnImJARe0puw8x1IYglLmldxV0oD/UD95YaAyS+kgFbjVHZuBB9Nj/zrjhh
	 4Kxi4edXtX28C5kvjN5WUxhQ2GuLv3pk2okPNqg0lvEF2dccuOgDP/LVMyGxLpmR8/LaS
	 JhkgkV1iBts8a/5pZjHi9iVVXCFflJzt8Qk+8M4pgWqKMJC520SyeBIHFTMQ8/PPLiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=exeTp1cAoNgGNBzHpnK0Fe4gV+c26CWlkIC+95vHT8w=;
	b=h2OvaweSJv7GV+VcZfTwLtUX83GL6GhbRKir+d1zOnaFJzGJ9uGskbbQeh36r0bpuhgy
	 WR6F3DTYokJrzYEaU/gUMbjJ0eoAlb6ek7PF7ew6KoEWoQSa6nw3FyOZy2wXy165tHcR/
	 iMq/yZnPe5642fZHfOumNvUAXyE8SXpcR4VK1Ans6xxLtkOlflPLR24pHvczej/U6nnbg
	 ceWTnY76yxW2HhEFJYfOhUGbcFlK7Xn3i8e03GDENg9jYtgAqbnXked7SdtuczThdx+Yk
	 uJiPn8IgILGYT4MS3plE8pSozXK09t6b1tkMJV4vBUOXPcypBgMBCFXzLnxH7sTqquA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=owltronix.com;
	spf=none smtp.mailfrom=owltronix.com;
	dkim=pass header.d=owltronix-com.20251104.gappssmtp.com header.i=@owltronix-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=aXnphUCd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60371606A324
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 06:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60371606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=owltronix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=owltronix-com.20251104.gappssmtp.com header.i=@owltronix-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=aXnphUCd
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so20029155e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 23:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792478023; cv=none;
        d=google.com; s=arc-20260327;
        b=m9ZUwXD4OHr8U9FoAQJWSgGUVvbaYv5HLHj1JmUhutlCbRNFoENwo+7VnVWoXmZNo5
         Tyq8BalQUE2139fGSBrsNNMn7kPyaIE+D0mSfl9H6DQrYB8aWmyS9KZRk5bcnzzOTo3f
         5VhwaaSOLLY5r7RTI5c060iT5mfb7PbGLKJzRxZgzST+PhdEx/tfz7LOKxsUTq44y6a2
         5hvkfMRXdoIchaaL0SSJnDxHxUZTF9Ryk/vqk5BnDLjDbzkbaCR+PXlTgy9Vqyqjol7b
         xnXUKz2oGQ3yjTuBblOKznkqCBIDhRWf2F45BMMPx4oBWTBgS77tuFjSnI+eA6Os8TPC
         Zo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=exeTp1cAoNgGNBzHpnK0Fe4gV+c26CWlkIC+95vHT8w=;
        fh=Qry/+bM1tVGiee9+EwpGlef5A0d0Ztmpg1ygN48TYd8=;
        b=jkeJ0kTe1uXLLCgVHxYfXp76hP60yTAYFqOUhNjQe3K81aPHcejw0H63uqO7leYHmY
         8fu60U6kU8EfF66sJrx7gMg1IGACEmcOzC54kshqpwbeKY0LbQByYyiLv5d3BF5wx4bI
         NJIsl2lHbkdVXSEvcQ6VwwFlO3Tp13DdH0Yv/5O43ZqjkVcySuVJ44cmitCVhSJ5g0p1
         sv3eYIUm9G9LBvRBE0A3Ur3NVlGcKogHneP1dkR+OSC+FSdIqNx+f4uDj9F7PZQq+D2Q
         aUcPSTzJ/Cl2Cp069nbBSM7zlmoasfjebZoYZU2ug2+W7iknAeEeBSRY14RiqwdQ/KLD
         VxkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20251104.gappssmtp.com; s=20251104; t=1792478023; x=1793082823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=exeTp1cAoNgGNBzHpnK0Fe4gV+c26CWlkIC+95vHT8w=;
        b=aXnphUCd1OxmReadwWegZwBmMEXcQoL5UXzvHpS6C5j3EWlIRvjPWPNunlqO+IWQel
         TLjejB3aKqyeGJcs2XDFWRVHO0NShXeY4QCocXkRzsjqySq9g68Hcn5EFspP6iqw2DxJ
         pun+vmmO6V3eUuwc18zX56uanSkO/w++vt6zjQJScnjIj1LPa6sYimGT5H0t5kOz3str
         ByLPtoXIji412AHh53PuTjgh6Lf+BweNFvTBBdK/wZgci189jV6FJigATHzDga3AJlxM
         hW8D7sRhOEhR7g+d2s+j7Xh7APye/CBgRphiwifOaZypID1F/l077nZMfaosuEAy4f1u
         m+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478023; x=1793082823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=exeTp1cAoNgGNBzHpnK0Fe4gV+c26CWlkIC+95vHT8w=;
        b=jwsVbN72MTaNaXQWBMLQDjwgah+cwDGw2nCqPRMaxeYpsIz0BlGjvigl3qftiQyCaw
         ZMoa2ElTosvHgjvsn3lxc122ia3tdMK/pNrEhS+j0uMGBvp/d/jfn4ohj/NonPxRo0H7
         7TwwWha0sPQpVDZrxScsRFlb5YVbpa4nnieyN1UnQ8kfijnZ9BBz1YMQumhOX57IJHEz
         DhuE13NIvYVTEewT6+3Fnb4EgtK7bRLMPOXMC2WX+HyT1ZPK7iVDUcE9PVghyr20//Ux
         N2ivFXTypHt58FaTqIFqh34J7Kw5NKdVeSx9EDW9gUlce2GbouCfxPW/fqrA2g08kk3E
         nMJw==
X-Forwarded-Encrypted: i=1; AKwUvBzXmCfDixz54nvK6qHwlceBwe6epQ7dkA9LbkJde+V27IeCFnQwVEV8YYnH9hb1dIF74h3hF7ZA9l9VWcXu@vger.kernel.org
X-Gm-Message-State: AFq9FYIcc3jKuW6oV+Xj3HKRKDDH8MLomo/NNEycTAZyBT0hqBnslxpH
	c8TfrbRiH14d/RXXa44hL3EMKeITK9aYeci47fAf6YxP7gx34KZng27sQVE45rdY/8U6KAxUveQ
	fKC23eynRIAV9kpKqocDpBWB/snQkPAaWeklUlX3gmA==
X-Gm-Gg: AYBFou2KBw+wC9RoC36c/hU7Fho1HG/x4SfenmMoc+qozddD2V+Ukl7oe6EhISlODdL
	Yi+9oOtm+IzZc7YCYcQtQqpCNZ4yd0WJR/Sx2CLdfm2DJtjddSsAjKZPuPjOvHxdxXt0G7/yEBB
	EI42YuP4kW3XjsbWUGd4qNpdKNRwtdVhkUg1qHNRGX/86lsbSoHE3y4ub+XuMPeWfuyM7v9jrs5
	qX/z0GSW615APIiUejyt2r56Ye9mYFhjy07SYDKpyBrTWw7alXxjRJT3PRn3tI4Sokbgj8uP7BG
	K9ogY+qAua2cjS71tEwskpOBHl9X5AtQDuw3H354cyIwbK4RC4gbdKuD
X-Received: by 2002:a05:600c:b99:b0:4a1:d36f:1ba0 with SMTP id
 5b1f17b1804b1-4a1d76227b4mr199950255e9.35.1792478022502; Mon, 19 Oct 2026
 23:33:42 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016160037.GA107919@frogsfrogsfrogs>
In-Reply-To: <20261016160037.GA107919@frogsfrogsfrogs>
From: Hans Holmberg <hans@owltronix.com>
Date: Tue, 20 Oct 2026 08:33:30 +0200
X-Gm-Features: AclHuK_ADi3z0cS39x96qE3d4XzZpXIuupVRKpApcCWwiB08hyMIjCfxAVkNnMI
Message-ID: <CANr-nt1btFt4FqSgrsjMW5tRihyKcUKG-irW9su5AM943+1vzA@mail.gmail.com>
Subject: Re: Farewell!
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: xfs <linux-xfs@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel <fuse-devel@lists.linux.dev>, 
	fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for everything, Darrick!

It's been a pleasure. Hope to have you back one day!

Cheers,
Hans

On Fri, Oct 16, 2026 at 6:07=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> Hi everyone,
>
> After 14 years at Oracle and 23 years working on Linux, I've decided to
> take an extended break.  Today, October 16th, 2026, is my last day.
>
> I don't have any immediate plans to drop the djwong@kernel.org
> forwarding, though ultimately that's up to the sysadmins to decide.
>
> I have very much enjoyed working with you all, and I'm proud of what
> we've accomplished together.  Good luck!
>
> --Darrick
>
