Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC5364044
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778760; cv=none; b=mBSOL+fgo+EdB3SaHXvXhaP6mKMJKmCtcscSGkbiX7iTRMHScdvI5U2V/jVtRdD/l5UBXza3qlL870LgrndZcwQBBxv0uVnRScZAA3d8tZ4+3htJpCRLEznc7uO5y4noT47cspIaPgUc5UUl2pXDiAHXNRnQmfIoF28fUHAtDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778760; c=relaxed/simple;
	bh=NDGDfJcvHQY/dLknd5LZMdxKuXfhjbJh2t1x5x/SpJI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cEFTLMFEFn5RZYfx0fQHsBiVROwmsjBd/0+j9N4oYi6ajwBd+QIg17OIC2UWxtYon83AZaiId3nDVpfuXP2UqkpzBCCVC1oBFnkY68ARpGIsm0rWz7D4wquhqfWkF5yogDO9Y/Ptp6w36Otjg78/kS3W7Wn6tDOSDfl6lpk9fH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyRF5MBg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyRF5MBg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf50c6f235so2840025ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 20:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778759; x=1785383559; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JnOvPtms1RLQR9UWnggpXMwfANAdvGkfvfRA3Dni8Io=;
        b=nyRF5MBgmPygt30iC3aB4MM+TlTj0WfAK9Vhu4FbM7FaQV4yL7vF1xS5bC2bmI8zxR
         EhGN/bmkMRgdfYHi/h1A7+qrGdEmOKssMicIttdgyN21+WGSw9viQdnDEMZ5n9si4a53
         4dnz+WGAIZL0sC1r1Kg31DfvpCadIX62SxoR+nzdHP/uIHtkHy0uA35Gx+L6XpYQ0rH4
         VVSRjfGCiCz8w48wpHhR360Xrlj0SxAwyYPlb70kuTDsALQkLKxtvCT3Ji+m3xUsCR3n
         1Vec4QAu91W+fFSmDms3FgIh4kKXq6UYqWzjCHsEyygHu7AsrKTN5KC8S41fYCY4DsD2
         yddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778759; x=1785383559;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JnOvPtms1RLQR9UWnggpXMwfANAdvGkfvfRA3Dni8Io=;
        b=Nl/oPcPod70ILMaxWFzg7/fyx+2qr/1yIzku1KmuT8ua6TerftfXyq4TJ9fkulgjTf
         /eJ/QmG8IcgnUB33DxY8Z4n9ZBDjVJL2MS5ZYqMUZpVkAtSOJ5TvgwlmlOOJbAclZ1HB
         GoUL7tj/5sRpmWVkZx5871FM4EgK1JdXSeDip1zb/dzD0kDCiVU1FcVs314fhkhkkqiN
         j98/H/7tlNrMZiYg6Uj5vJ2B91jMJVKReiQklXEprh9yt03ONr5yxJHAmGdJQmN8B4aj
         Jb2TuqwX+A8DxzSBFuJ2UWQzl2rNHA/oviNH0KA//HM6rzrn37tZnUWANaKpuCfkAylJ
         LnLQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJHuYIJzFu8aPA9PeoZMAi+1jMzUWU+rl6YwjqjjmU+u5vUGo4yNGssYyXaJgdHqIKx0fXcbb/IUd3esTX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9khYf9UjhDtCbEkTNA5kSrXyUFSJM9XSBa5GfNbMbrcAktCag
	E5/9ghWRudBj8IAE/UgQXVnL7q4CmeM/quoAExFv3c2/iMTI3R/Iu2xMPdICRQ6P
X-Gm-Gg: AR+sD10GLIyycVZwlsrfAOjDPHDEwOtHUcYiKC/hOiu5xk/yAow3x3OzVo5M6hBVZKo
	R0UjhMDDPJOw1zUhJtg51TeB4Obo+VMLDX4H1SplaTfrSScpRBvyDLzgLfSxVzJLyT4+2PPRUsb
	quWwqMMkLwv0Wo9HImXDb0V18qrIbrt+8bah8bv5kNCEXNlmVl3S/4xwZBhSn7v193cRrElW8gg
	bCQJY0v+GC/R0a/TvdpxZwFydU3HV4fSkq99+ZiNoHPp+/YpdgzUOnVeGXdxh0OekqY0xT1FluJ
	mWkmMwD8ywvYcJ4ISPQYGe6WRf9jYQw2P2Da0hBuoJ7fj2b1Tx1v0e6cDK5+F8ojl3+4+qcFQ4O
	fXwpaBJZ644oLHf1TIlalj0AnXpj0L0OFdE+POGm9c/H5l5T02ZdRoOx1mRjbE4kLLo49jbRyMr
	t8FLr42A==
X-Received: by 2002:a05:6a21:2d4b:b0:3aa:c964:3c27 with SMTP id adf61e73a8af0-3c44b1c86a1mr1373005637.46.1784778759161;
        Wed, 22 Jul 2026 20:52:39 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm11497359c88.0.2026.07.22.20.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 04/21] binfmt_misc: normalize the per-exec
 invocation flags
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-4-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-4-e57866e4ae0f@kernel.org>
Date: Wed, 22 Jul 2026 20:52:07 -0700
Message-Id: <178477872731.254289.6997696289699732480.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 21 Jul 2026 16:13:46 +0200, Christian Brauner <brauner@kernel.org> wrote:
> A static entry fixes its invocation flags at registration. A 'B' entry's
> load program picks them per exec. Since load_misc_binary() branches on
> which kind of entry matched and then applies the two flag sets side by
> side every flag is handled twice and each new one has to be added to
> both arms.
> 
> Translate the 'B' flags into the entry flags they mirror and let the
> dispatch act on a single set of flags. The boolean the two arms
> communicated 'P' can be removed.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
