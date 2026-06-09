Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77A3FE663
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005505; cv=pass; b=mh1nhy4dou7XjjfPifWIaq5Wq8AzubioPTOZIdVPthres1k1Axd3D8HGQ1pS5lCXhR5oKcfPKU5EG4oHS7IGlOon5Awl6RoPz4qqCo4gnhVgbW3CCABPA6LNaAtTc1Hm+Z54JOLwUIUib1qO7jOmJCjvMTkWKGR2RIkiY3poSWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005505; c=relaxed/simple;
	bh=bmcdeAxKnivMBkeQA31gq+YLS8YcZ5ljNOsCAWfPEAk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UC97HEXKau7esbovJ1crkYbE6bkNW1MzCYkt6wT3htYuQsF7FE3B8M67y7TtzZYcpeHxsQW5fVKSD8NNyfpwgEPekkv+FsYeH7u/kNYSWKwhpjAey6H/OxSsYuEJfFSRiQOaZzmXuWh3kvbVXgMh3Pw2XO49d/DJun5eCspektk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cut3s8oQ; arc=pass smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cut3s8oQ"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-9158643e538so485841785a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 04:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781005503; cv=none;
        d=google.com; s=arc-20240605;
        b=VRxRnfBpbXMXtoucdruvd/gmYoez2bcAm9OC2CPVhP3vHp2mu1cC4FpKynRNIZ5/7x
         psBjpH97UEzs9tknF8549vAh0zWZlpqrDflvoEoGVzJM3oiEX6hhBPJFjpYYA57ru4Ws
         2TxmQu9rPXPw/7mM8Tzc2ntlRSowOgfsN5gLnWX3IiXcpddtrwQ+wOTOE/paxDikrdyO
         oApavgT/43UBNyHxhWMzL3Kxs9+jIp7XiR+fN5nod6ovCQx4UUwcjOyByy0La0nEriGa
         FsPEeVJk4Q3GdnnNZihcznA2J7VspzdNAIE94R2Uuy7KPUKIYww4gnqIHG8k/t30t0DD
         LyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=cC/IPfVSxcJJ2OkOU2LH91y8K2wZvkUsn3BRlzoD0Bs=;
        fh=b47tmV2QtrWmwcef3BpASdWKH4X0ZFvH7Yv8eHm2PnM=;
        b=AtQUIg/jWfBgXmNZq201nMwUL2kdPzTvEYj4oCTetJvnP9+gCiI2pmePLDNVo8Rtkl
         MHCiRHB9+PlRo5atuTQnfugXLMKCRalksdZD0AekRbsVVwsc6aeqKFQskpqRdYYic1+b
         ZBprGy1flf2nf2otrhw7x66A2UHjbgozuQ4ReDco9Hj0l90ds0ZIiYCvjX2Kut5ubgRU
         Nx6KOIdZCj7GFkNzjPlEgwJpHwnVvUmK1lrXrfvtw+6b95sG06FZn64QtROPtwn43DMy
         5+vbQT1iANlfLGEMqT3qY5iio3i133GUDL5aHDDRnRaROeiIPqOxqUUA6N5WOkvduvHL
         nH1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781005503; x=1781610303; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cC/IPfVSxcJJ2OkOU2LH91y8K2wZvkUsn3BRlzoD0Bs=;
        b=cut3s8oQb5TprBB6zCcoi5ZWtKGVFj/6xK/jnCdicZNXhG3SJnGlu4SdQUvkl8dlC/
         2d/rd8mY9MchbtApU2J7v5IROOiVODfWXyPmZCgtO/1/+VwKAy9OGrdvvlXOlNzVVYeE
         AraFthz84hpEg787Ta2vL+od055OArqCdl4eH7Ybds40AoQUAxhmNOMXSSqnNK1Ziw/0
         PqohxCcZIJjnJJ4VWhtTbEnR3NJEEHoMuH43VKob4w+HsMUfNxnsI5SiVy9W8Rt3uzq7
         SC+bpXL+JA4QvtvKiZ9RHcCM7D4U9vY/ltk9En30/hOBAUhxAhMzw17xhL5WYq1oBWpV
         sMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005503; x=1781610303;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cC/IPfVSxcJJ2OkOU2LH91y8K2wZvkUsn3BRlzoD0Bs=;
        b=YY9sN5EipUr4oHRETN+oR+tNiOIWvZn60+b6NVYchPSQqpH0oLez1XLNkg0vtQ16ta
         lwp7pxHlKLSdiNZNwfMW/4yJLBPRpoAIt+wKdRW2+IGuoy1bsRnhR9L0oTXY3idBTaEU
         S9SQURrV03ka19RbaWqw80Zi0QyAgwgIgUxdTjxh0oTD8hnFGYQSoXrhfpyb79KF1Am3
         GI5P9B2UYheruxGfxPJeC3E9FMAA6+27/BvRpk/PSX2oM0Tm812kyLCiNlJCZ725S7Ps
         ZwCHbCJuxYItONLER9JjzVaRzaK6NM1EHZIuMLNJsfOKg7NPnwdWua4FBZrl4jnHwL3k
         xjpg==
X-Forwarded-Encrypted: i=1; AFNElJ/9qFA4ZMGbnORAmEuRpyYiT88C183uaJ+0ZyoaeTMdx4qCPsIjHMEwOgZdNIhpRQpUq5gDUzyB3JYkUg8u@vger.kernel.org
X-Gm-Message-State: AOJu0YyACSIbtTWYpWKlrFx4VVP3g6fBuwFqoOhzwtsxxS8OBFxvD1Iz
	qaknbIicnqAwxDXq0+qmHXxaDGVr0dKZp/TF2AGGGsZLLMk8f8qSyKwZsiMytHXJjsbQFcOiTMh
	nHHHKNOtsz4YiFlAeDwbhbBso5Mqw+Y4=
X-Gm-Gg: Acq92OFP+ODZvxSG/LYVLfChYlci9Zpbq5y4tZPhh63F4MhGeIk6/KFF2IuoonxEQ5p
	NI9kfpzEt8q9xJSsS7sH1jKNpAv6R8owOD2MfQg8o7wrnKMycd1uxf0OPcoOSGN3uZE+M7ELCzs
	IV2R4+dbHK+q70bfV5svN7K0C9UX4aSpHhQZYngjR0cSy1kkKs6iasrZybF6IHiqWQEhDh+N3+v
	lXrcYBzrraRouI0FJESF9tyMZN/ghEBneMUQy2LOHpyFbdESIIWLdg2pYAva8jJEAyTyBgtzv3M
	LAwIsBmlIm81mZDxnw==
X-Received: by 2002:a05:620a:28d1:b0:915:89d4:df16 with SMTP id
 af79cd13be357-915a9c2921emr3123556985a.7.1781005502851; Tue, 09 Jun 2026
 04:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Longxing Li <coregee2000@gmail.com>
Date: Tue, 9 Jun 2026 19:44:50 +0800
X-Gm-Features: AVVi8CeKzzaPxmjz83uRZ44AaJE6TJ3z-MPvJeHuXm1NiYjYwXNb7XCUk4YMPRE
Message-ID: <CAHPqNmw08zSCwT+QsavaXJinOxZuNr2T3uf9TFg4MLzDBJhyHA@mail.gmail.com>
Subject: [Kernel Bug] INFO: rcu detected stall in sys_access
To: syzkaller@googlegroups.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. INFO: rcu
detected stall in sys_access. Details are as follows.

Kernel commit: v7.0.6
Kernel config: see attachment
report: see attachment
C repro and Syz repro: see attachment

We are currently analyzing the root cause and  working on a
reproducible PoC. We will provide further updates in this thread as
soon as we have more information.

Best regards,
Longxing Li

==================================================================
https://drive.google.com/file/d/1Bx2unEf-QntjVi8g6Zw7QNO6OP4cjGO_/view?usp=drive_link

https://drive.google.com/file/d/1cvpuS8Y99IptkeuAJKWZ50imXnRVxWG-/view?usp=drive_link

https://drive.google.com/file/d/1LDdjEA18US3bYj2kI4CezjM_sxB7CMZB/view?usp=drive_link

https://drive.google.com/file/d/1vJC-NIkO8REnrdJOz_6afUnjrR01BByt/view?usp=drive_link
