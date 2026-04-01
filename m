Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06335E95C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074741; cv=pass; b=Y1QlCB9HOqtVbtBFe30sqqN/ty+8khryHq2zlUfgoaGzFSM0RJUE8JHO0qluAJcpeOdGSg7Tm2CNBfIBNwZJjcwfSmODJFoKu0RhDO+ECwmisG/TuIxWvN7fezP2g0xlUK66fQMJeISn0R79PZjmNPCiCeA6hyIBa/9dTneNCvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074741; c=relaxed/simple;
	bh=0RWkmcKGQKzkbQVJKxZLDVKzUq2IyT5qTXvlhkPcTtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/2AfofUV8/j5xfOYeG31UU52Ag5mw1RjIQRZnpTBJcM2Vf/eTA4xxUPxcxbQAWPxPMrsMGfV6NL5fTz2eaK+QY6dPBUFEndv752HRW1Kls0LphysA+B2ak62NZSVAmm1yq3n6Hq16w/jZwcfJG1a33ISqtpok+0zLVh9WL+el8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQQiYbjG; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQQiYbjG"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9358dd7f79so25468066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 13:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775074737; cv=none;
        d=google.com; s=arc-20240605;
        b=G+DTsJPLnRqb2nukcEfVSccggRHaeh3bkJbcqk/FdnM7WVQ6EKOL2q3ZSmhAE4ouBx
         R/iITPT01aMQgmzx1aNoJ9fdoCcfmsEHy+gqngX6HgAWHnkOSqccuWpVJxcE/BUxCV9R
         QR2tkDfrTU9VY3SUBivq9WpWo8UwCzFHzgh02rvdy0gcCda8hDeotMGJym6SSqlH4lfO
         5HDAUmxDc9A/hp9iNMVvubuiuFbllAiJUrVLqHL/nC2wwQLUXnYfQyKvBEoL8W4Q0lt6
         Yv6zBWgZDjOQ1rJD7LKBCTbz0xVAGW5/vmf0K1Vw4I72lmovJUfYC0gRyxa9T/8PZ8TI
         9VZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0RWkmcKGQKzkbQVJKxZLDVKzUq2IyT5qTXvlhkPcTtk=;
        fh=JhIqiyzeJBn+p6tm8R40QF1A8awkaqV73QNkKmO9NL8=;
        b=JuzjWiTj9SXlCSGeVUw5VoMjQIqdSaY9SyCIBZAvXBdpKSD+9RKc6eab6EHvqDsrXQ
         /coCEFMqbk3OjT9o+e1nxPOLDhMxtIS5Ugxk7ITi5NeCAt8HWT6jMCo92rYAv51N64Mo
         83rqgnuZL7qua2ZYcuRfViRmHXvMfp5di5U/liW+Y88HCbXetg8icTnTT+cOiAL2734C
         80nvIi2ecyFsY8AaPPXdWLCrXEUSExaZf6oZcn/lnKegbQGSxfRqJ9SEH8f+InpeqWVk
         sCYvsPbdixAWRHHznLpcsyWsRYh/g3WGVh8/ulC+x270tZoGmTpM5OJteiuHtHJfbMIB
         116g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775074737; x=1775679537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RWkmcKGQKzkbQVJKxZLDVKzUq2IyT5qTXvlhkPcTtk=;
        b=YQQiYbjGgCTJ1tmEgrvY6nWZKkqZ7YPArEY5G9LWBvHz9+N9HNNdfc8IvbkEA0dS8T
         FmIkh8PW98wm9WBBNlIzV6EHYhOeHWnuBXO915tjdljtj2cHXyPFasr4O9U0/BtW06Gh
         P1A108GxAYXw0T2ROCroJI1zYuYlMPwZgYxEGyrOZbR0txpwZtCGwSiRmDa+IwcjSEhr
         M58HMLBshJ2gYO8DD2MaSRrUVtMKL2hFtYtVZ3gWVc5iNCMSQ6Ni6/1xfLkMxwpLga9T
         bnhVAAxt/R4jPCBUq2IPlFweTZcTOa/hB0cYtkY3uH3Og5Ud10XI4divgeccIfB7xb5R
         Fxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074737; x=1775679537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0RWkmcKGQKzkbQVJKxZLDVKzUq2IyT5qTXvlhkPcTtk=;
        b=WYFZOOX7nk7s1MhuBJZYohu0nt0M1wZkztym3AGFXHyA3DH4R6A+0K4MKX7I9TTMnS
         UOXjtWPNnKmcr1bPlFXzht8KTzS9lHuepn23LMdjztxIWnnc5gRI0IhlUnjH9bTzUMRz
         LvcDWIWbcwvQg6M2FEPJf42loy7H0g0KpGAw0GE13hhRt62dab1udyr5uWfF2VphtBXG
         dNRbgenrY5EgNbE35Y8c/ptCYxknJIP7lJn+ggI3jOM2w494PEm7D1ad2nAcGLGOzCBR
         1T0puOrYB51PQPb71WoDmpgrMT9RXk+8/BsfVjOgoWokkHOp7AJ9LwmDHMc7m7nd7dZS
         o6CA==
X-Forwarded-Encrypted: i=1; AJvYcCURbX3U74i8DDp0z9RmzWAplUpSFkKrmbWDYn2Z1soZ7ZyRlhw13wFXTFvIzkUbxd7Mj5oyS5ZhfNsueQSn@vger.kernel.org
X-Gm-Message-State: AOJu0YyTdR9aW4yhgazc00ETTKJ48Q2qzsMqiIdGTL5Ko04YGZ6FjMNm
	ToJTbd8uk4h4YoGwYkxH34WPYW7kds5AuVTv4k1eQQLuPXqYmcRPsr+pvNJNA8tYAcKIaUGMXDR
	jgOIalmSH+K711co+2mMYmCyRKKxL5Ec=
X-Gm-Gg: ATEYQzwTNGZghgqTgk2izT2PjGOicJ3Y1MUKzf1QsJA4HwdEKNC0fJHd5/yR5o4Bp2r
	Af/z7xEgbRMcyAomYcT4wywD+fjsz7WwaN8hjZ0xukQtgljxQod+USb4geXtOfxKVmVPRTX5ayt
	swVJXjfmFGAGBCUuR1pfJ6e5dMHW7AJhpnFvQVtmnqNicbA/CnxgdWzObB9NurLJMDbOMf1s1l2
	QW6FlBTS7IZ+ZRqR4eIF1UM47hD71l9Z+An0JpeH95L9qRmg/heUOBj5XiugawhoTV4vzL30R+f
	YzgNi/zJCcmdZGW9blmPCizeMFg/j2XL1vooHQo=
X-Received: by 2002:a17:907:a70b:b0:b98:13b6:38a1 with SMTP id
 a640c23a62f3a-b9c13aead54mr277517466b.28.1775074736896; Wed, 01 Apr 2026
 13:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331150701.3844815-1-mjguzik@gmail.com> <4natbslv5enjgukekzr5cewvdzgw2drh3yas64tdcn7wnqjfak@bvmjc7xarrdm>
In-Reply-To: <4natbslv5enjgukekzr5cewvdzgw2drh3yas64tdcn7wnqjfak@bvmjc7xarrdm>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 1 Apr 2026 22:18:44 +0200
X-Gm-Features: AQROBzDAN6uAR8bC62xl2vuMc3rZnB6z582br8vce8VOOrprBU_rhUtcTiDY_7U
Message-ID: <CAGudoHFeRnN1yc5kBkJVFcLdq1oZ9eJA3rdqciUQm2z+RUJ5VQ@mail.gmail.com>
Subject: Re: [PATCH] fs: add back TODO concerning printed info to dump_inode()
 and expand it
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 11:27=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 31-03-26 17:07:01, Mateusz Guzik wrote:
> > I failed to notice the change which added get_kernel_nofault() usage
> > removed it. It very much is still applicable.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> I'm not strictly opposed but at the same time I'm not sure about the valu=
e
> of such TODO comments. Maybe better track it in some kernel-newbies proje=
ct
> or something like that? I know there are lists of beginner's kernel tasks
> out there.
>

This is just few lines towards the end of the file, I don't think it
should bother anyone.

I can't be bothered to add this elsewhere and I'm not going to argue
one way or the other. if this patch gets dropped, so be it.
