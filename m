Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6519AD5C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775079184; cv=none; b=SZEtJvgne+6S8+vmHM9puE8Lr1gAn3dWYYORgDjaGjLXDiYinjMXFKt+2YkbSWoVsHHCyLhCab2K/SY5tnKQ4tv33OjnadTrkV9rAHHUcTvKT6UdmhW/SW2sUKs45kGjT4JH8NBx3TG2ECYwLZa1qXxDzdkOWw+u7rvChyEWra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775079184; c=relaxed/simple;
	bh=qIL5fey++KRHGWyvLyjhNhHZerolhdaCBLr9JU3Gz84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXGmkh8xlwJbeJRpXP7OqriR4LnLmjWlGLG9cAK57MbxW4Y1+Wi2QiKR1nqLylp1O77OJ+5uLQSUcw6OwPndWvAM2Ckf4DIT7I/IsBy6Da2NTzRckDZgto2LqPe0+BKc9ViC4Iu4nFhiDSWcaLxLSnCuUFOn83YpGtHedCDuEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVjKSc1+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVjKSc1+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48704db565eso1860625e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775079181; x=1775683981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVW1XnpwUtqL8EJAcpHlp3FQWpCKwFLG4TFpns8IsO8=;
        b=BVjKSc1+ikg3xMgvoXbUw3Y8Bmuvw5tbTKwDKKZckTK4WvyTwZgfGJBY6bpBuit2gk
         Va88MhnLDBkbfTVHYD89PhWOH560zPEEXQDkAZb3r3bVXuvMe+ARRPUClaVsnYTPI82S
         Oje+KKl8xibcEkO6rzTATixk7EthE/NbamEzj++7HKj8WJrlq3n1ual2BdEgR3j8IHMi
         gQHI/W5idZ00oO9BvZfX9I1KgdO2i1Qho1ATotlNF2KZudGU+nVnw81rbE3pO3Lqw1UO
         XgZSdFvuHaCZLEBoc3MnlyXi/8IudOM4sHCNJzA4QOl7q6azrCFtkDCjqcRcXbMzUy7/
         LWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775079181; x=1775683981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KVW1XnpwUtqL8EJAcpHlp3FQWpCKwFLG4TFpns8IsO8=;
        b=FS+pv778utOusfLddnnBikEQDUNN4C4VSSg1Y194icHDjvbBTWw1aHn4Dsip9xNGd0
         yUZsVXOwNURoms8/Xt78YNWHrDJd3XXs+p8HxNrjX68tIyPg1BABF7ysUJBuDSrT0i+V
         28VBNDSRna8S2HlwAtK5OD5sLmBh683b3Lo/QwffbmralTNQWRTXvRojkigPtt7V1OTP
         3N/1lFL3wJvasgb3NZu5R/ooNwBkM1I8A5qqBnOxoZmhhNAO4GXLnfpQA7EP3p1ULYPv
         MInlImSKLG6fEO9e+f23UhWKDZD2wlHwC1I0zmnW6/pwRzTpx5zNVufIEi5/5aPP+zo7
         ZN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVueD272tDdN9GoqNKqlIk7va2AkXEX5pfEtmvv8FBLtnPDIZlmfQztlbrbBIOxqhNLl0/ssh1oHbhFlIpA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+R8CuSVju2+iGfTqDGIyo+yCLZN9KfLid583qeuNGkhI72sT
	i/wL+ZsrRhN9tFI1I2JjG52M0GG6+tzpklS2C3VLogTlp6kCBIxmCfXj
X-Gm-Gg: ATEYQzzP1FCsi2Ibmz+TETcbFA6gLI06dhHSI5aqtYIqAIpL7Cy4CUVYR1Gt4HA1KCA
	VZZOJ+Fd0F5Qwh7J/ofH/8XYSpJRydBC7+Eo0xuyT/EXMXDOXvdqzDk6qg9NbFgtWA7xzQayeCN
	sWWh/6AaVfCCCD9jbM9gFRzIpyPyopSkPtQZXON3NtVnmzBYM6BaG3IF+CSxBqtgFoPd/P+HcIV
	8YZhrQ5OJRHUqIQoQr0zGmGLtg5Kw9ybsbMXdjzgP0CClQ1se40m1n3xd0qn7JSC5xEvFiO4G2R
	zM4AhAI+uKPK6zKjadLuMOVOke6J6bcPn7shpuJT9VdLfTqC+8nmSUteo1EWx1inTTtBzfXhSnA
	BJdsgL3q7n6KFiYL7SwVyQY3uuhwPav7azZt0ED9iTuJIlnupINcmfeV1qqQWq5BTBkxskYu3Pi
	UA1U/e95NPinBJKfiinKDQcQ0PGO9/wHoOQR8HOHQu/SbqrTtiihGh0iGq/N5wC3LdAbPyj/E=
X-Received: by 2002:a05:600c:1f12:b0:487:2439:6266 with SMTP id 5b1f17b1804b1-4888b7b3c3fmr13053015e9.30.1775079181143;
        Wed, 01 Apr 2026 14:33:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adadf4fsm51766325e9.11.2026.04.01.14.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:33:00 -0700 (PDT)
Date: Wed, 1 Apr 2026 22:32:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] execve: block Emacs binaries
Message-ID: <20260401223259.31d61af9@pumpkin>
In-Reply-To: <CAGudoHEN+NMizX3yF8bDsm6+y0-jyFb5-fFogHWs3=F4MaHOPA@mail.gmail.com>
References: <20260401131226.4011156-1-mjguzik@gmail.com>
	<mxbttfswskgpmgakwz5cja4u3gzroonkqcqf4yggybtfolp5hd@qt7762avy5qf>
	<CAGudoHEN+NMizX3yF8bDsm6+y0-jyFb5-fFogHWs3=F4MaHOPA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Apr 2026 21:24:54 +0200
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Wed, Apr 1, 2026 at 8:37=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> w=
rote:
> > Can you block vim too? We only use ed(1) and GNU nano in this house.
> > =20
>=20
> I heard nano is a company-issued editor at Suse.
>=20
> If I wanted to mess with Red Hat I would block mcedit.
>=20

You are all wimps.

Try editing files in a small 'miniroot' for an embedded system.
If you are really lucky you've got a shell that supports ## and %%.

	David
