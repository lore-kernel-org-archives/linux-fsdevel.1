Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7CD3F7A84
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729133; cv=none; b=ixuEHWiOX6lRSXwNXi+iFMDHR/6KgRUKtFnRKEvZatIORswznWluTEilnYo5psBHaOcLksbOYYtQnGZQ6kZ7571pBYO3jADG4zI0TlvSYP6g7EDrpVfvZLhaUB346dbmaI6vtIIHudSV3V6y/l897GzM4iae2/RmkIC598xh5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729133; c=relaxed/simple;
	bh=vdSPim0shdHWLwUEXjFLrbGBb5LBA6J+PfNuOCQi4Uw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=URIiyo8kCla37Ag+UT6pEz6BqrekrkLfAxrfGbB52mP912yvBl6ucX2mp0/Z5ifctM+I8p6S6UyCmmYgggbsvXwlXidXOgU77jA9ntxxuc5A/YJWcmF12vxZ0ELIlvjT2gAiR8xk2+OF3/n6oD/Jk2IGUU+o0kblEqa0tCBTLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhYisJef; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQnWy3g3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhYisJef";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQnWy3g3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779729131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdSPim0shdHWLwUEXjFLrbGBb5LBA6J+PfNuOCQi4Uw=;
	b=RhYisJefjsl945xmGJfgSF3Fk/BQQYhjRPLgKjfugJHawmpdh/qw1WrXwMcP9yVN21x2MI
	yKftkvRc6bZulnMYbO1EzJa3SmE8Zw0iigtyTnQ1UrjyoWnE7PIJEZeuF0dtEM9AqioO71
	iv2slWBVy/LS+6jKJzoJV+tv9VouZDk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-uy2BEqBYOcWHHWw7QDPKUw-1; Mon, 25 May 2026 13:12:10 -0400
X-MC-Unique: uy2BEqBYOcWHHWw7QDPKUw-1
X-Mimecast-MFC-AGG-ID: uy2BEqBYOcWHHWw7QDPKUw_1779729130
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7bd7d24b175so126384977b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779729130; x=1780333930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vdSPim0shdHWLwUEXjFLrbGBb5LBA6J+PfNuOCQi4Uw=;
        b=gQnWy3g3TO93C6RNpA1hTdikIw7Uki9Y1Qy6FhoDNtkbcAezXqcAAEC644Dc4ZJPbV
         Ep9YK1gmjIbZQzEtO4zDPFFILMiiYlqtfg7AQJjnmr9gMQeIsMVTVJwr5QG2IAr71USE
         D6bsW4xYd0OQy+i9P0cmg/Oavc9uIKCREMe1bPeq8bQ48myaRrKEPhngA707edE3kWYF
         vZANRZVpb94CVaUk75XRKwNNzVl6LrWmc7buMpr8DTThX9qQTsfIKXS8E+gyYTr4qJ0D
         EFhtErtChfnE+unaRiy6K+7KZsCzbYsEA4XJfiQkG0b6VvqW/DbjbosIxYApiiqPy+EU
         GVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729130; x=1780333930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdSPim0shdHWLwUEXjFLrbGBb5LBA6J+PfNuOCQi4Uw=;
        b=YaAF6lOresB7PHsSPUhpwBC0/ADN+GMmVfRQjUfN5WHH25ZnwTb8EjW19l96gL3J77
         voNzywSj6WgchhDu+4UFHHMHjDS6Yo7KI20v0zJdYTbCXXQN1lk2g9A+BatPb2eal3D2
         nXhAO2w0ZN/+xmr0EcVonsTMj9fs24hx15teRYWvadZ7oX4Ld5qCBVtrR9HFL/9qH9ga
         UkO9Jg74GCTMU3nGNlTSB7dOiORh3OucfzmaT2moXl38XqSp9PLjHchRcPVaNHM5EpQn
         5QNR0ee22OwDFgRxu6QJnUdeVuapUah5f4Sk+xbwamzrljIIarJfxoYAMUaqvQTddE49
         H/tQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YBoDZhkncx7QIAH+/rdyW80JDx1/FunCr0nc0nJh5CEpIkIoFiwKjrVHNX85nfMSJ15im7M8LwlrnXY9T@vger.kernel.org
X-Gm-Message-State: AOJu0YyI37b/ZqJSdO+fpDF8bAci9+z98sVloWY1OMYpe3ymQFNLHdp/
	2iY6FhY/THre0yi44CEsHdIq5e6CxcLcCFU5Z/AOgUYYtgvi10hqxRpF5RmxTyN1ZImoUIw8iYb
	z9773CkLyHGOtkAz2X2ZiOi79GYVgHJuD9HVtb2bGFcdzrFQrMc1IwA9Alic2SFDdCWGAvPkS3X
	M=
X-Gm-Gg: Acq92OF1fKLINLH0ohZs4XPPpUmEF8qJ6VDOxvhrZNkONazBI5TZ5Fl4T1sb6EZ8HFj
	jeEnhcy4DHys3glHWy0amcd5zyJKtKpCL5Cbvq1QhMMC4Wftsue9qCqJ20s449xW8OGc2XWLHur
	JW1C/5j+u0aLzUXEcgc/fqBU9FRfvahomLlgGhwoiiODwt9aftQGrI8Bkr/Przmb517/bRBt3mL
	vn5jqzN7xCgCx/G4suwgOiA6pn1W4qgYNTD9OP1Pg2TkWlOfRRRbD16gh6Tst80mP26Jy37v9No
	Ed982Rex0rw2NH/70hATLNgUuGnqY/Bj0aNaFMhIsOrnss1+BpiNal3EcjzeXKSLqj+ysO5h/rw
	jMXvFxEBnnY7tboFkmtBmc77rc8z+yF28rnsOT4Ev4Jk7NBO1cNLl
X-Received: by 2002:a05:690c:4483:b0:7bd:5cc4:1962 with SMTP id 00721157ae682-7d33b03c490mr148242427b3.48.1779729129655;
        Mon, 25 May 2026 10:12:09 -0700 (PDT)
X-Received: by 2002:a05:690c:4483:b0:7bd:5cc4:1962 with SMTP id 00721157ae682-7d33b03c490mr148242177b3.48.1779729129204;
        Mon, 25 May 2026 10:12:09 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38be2dc9csm48481197b3.24.2026.05.25.10.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:12:08 -0700 (PDT)
Message-ID: <155a19235c64afa717aeb19c8d596d2b45887df3.camel@redhat.com>
Subject: Re: [BUG] hfs: crafted image can deadlock in hfs_mdb_commit()
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Sam Sun <samsun1006219@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
Date: Mon, 25 May 2026 10:12:07 -0700
In-Reply-To: <CAEkJfYMB47v1yOWHB8q2dc8kf=uj-rLO=+yMyudwPguJ8Kd3jA@mail.gmail.com>
References: 
	<CAEkJfYMB47v1yOWHB8q2dc8kf=uj-rLO=+yMyudwPguJ8Kd3jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-05-23 at 14:49 +0800, Sam Sun wrote:
> Dear developers and maintainers,
>=20
> We found a reproducible hung task in HFS with a crafted filesystem
> image. The C reproducer and a small proposed patch are included below.
> The crash report shows:
>=20

If you would like to submit the patch, then, please, prepare and send the f=
ormal
patch. Currently, this message is completely unmanageable.

Thanks,
Slava.

