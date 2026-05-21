Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897F3C5DB8;
	Thu, 21 May 2026 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364259; cv=none; b=rYB96eo3gbpUjdIp6w4HkahyuW1pef2a+dFBKixNMU94n22KUagAS51sr2qzxqiaiHmtI6iVrZuyF3fVjg4EYl34mHnXcV7mGD6M5F5tJ+J/eH4zJ+Va1zOYQ4v0HxxQNgMR/7p26ZqA33f3uPkF2XgC8Ko97VGLKs4Xc+soD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364259; c=relaxed/simple;
	bh=46wu/BQ1dJ9x/IfhbitVCxS5L/x16bf2eQWkaOr3syc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GY2TttqTrXfyfk0mf+lTDU8a+QrPAumgKeONdjOne7TGQPCF4A1fOhnAudwZODZZhQvoD2XJij+pXt2d9CapeuM/8oBzmfPLoltJDwQGPN0qp5QU4Ybo/LoXEeeZC+R853J+H5Ooi8t67zFB+J4pEeULb4/RqVUNyVm20RNGYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=g2m2dhZh; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="g2m2dhZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779364249; x=1779969049; i=spasswolf@web.de;
	bh=46wu/BQ1dJ9x/IfhbitVCxS5L/x16bf2eQWkaOr3syc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g2m2dhZhsvU9BmiHakEjJvwj2z4Zw6EDPrvgnQuWrHUSCV971ozHZqiQv9OyGAC6
	 03bsUDMnIxR+pDuX9zVUjH8kKB57hD/1RE6ApiD/IXAwsqsh8/6uFcNC4UvtV6Rn+
	 U5N4gSwmnyJe8VYBfrMB0CKAaLvJLgBcB41jMqQiN4UACwT1oIZbjv4OO6AX/HeJj
	 VtsDWZmAOFqrwrXZ3hQNCc5tpBZT2AGNAxBY2dHAigPJHZw0gLxpbi5FwYxKRthDO
	 js3P7ohIwVFLNcb6Bn+8yiy0jtTSag6iu9AvDriKkl0M6AbQp1SQNQCvgMH6YfXN0
	 Kfa9iBtimQJBsROAqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFlm-1x2vNL1V8k-00j33x; Thu, 21
 May 2026 13:50:49 +0200
Message-ID: <70676dae700e6a40989315bf31ea269a509ddc0f.camel@web.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, spasswolf@web.de, Christian
 Brauner	 <brauner@kernel.org>, spasswolf@web.de,
 linux-kernel@vger.kernel.org, 	linux-next@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, 	linux-fsdevel@vger.kernel.org,
 adobriyan@gmail.com, jack@suse.cz, 	viro@zeniv.linux.org.uk, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>,  Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Date: Thu, 21 May 2026 13:50:48 +0200
In-Reply-To: <CAGudoHGk1CP3gRQLCV85AFHKx6vBEyKySOn4J+AZVAP2FkrN3g@mail.gmail.com>
References: <20260520225245.2962-1-spasswolf@web.de>
			 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
			 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
			 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
			 <878q9dvzh0.ffs@tglx>
			 <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de>
			 <CAGudoHGk1CP3gRQLCV85AFHKx6vBEyKySOn4J+AZVAP2FkrN3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b0YjzjBbpycIh+Vx4jEqQGJJi9mz4mrX9EVOFfLmdi44KkCTDCa
 Z7R59O5GVSigRauHi6BxJ/Qp8LQkfUE+W2cAjTwrSk6gPv0Wqic6NC0jQZvrPRekbYblJ76
 I16JEwdEMiyoVCiowLVTYeeLqv/GH+5+Q7hT1ZussCLnpaHP+9e7hocFxBszeOWLPZg8qHI
 SBQDhxkKTPiWZfiWVKonQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BR+z4UO6B9g=;V4J3w27dCNHtvm6ooveJF+qh/wg
 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
 YMjb3A==


>=20
> Can you please do the following:
> 1. go back to the known crashing-tag, add my fix, verify you still get
> the amd splat and then try out the fix provided by Thomas
> 2. regardless if the above helps, can you boot a kernel built with
> CONFIG_KASAN=3Dy
>=20
> fwiw I verified my patch works fine with KASAN, including by
> intentionally miscalculating the size of the target buffer and seeing
> a nice splat from it so I'm confident I'm not corrupting anything.
> However, as there are new mallocs + free flying around at early boot,
> it is *plausible* amd was getting zeroed memory without asking for it
> and it worked by accident.

I think the warnning from amdgpu is only displayed with CONFIG_LOCKDEP=3Dy=
, so
your "improved fix" does not silence the warning from amdgpu.=20

The additional fix from Thomas fixes the amdgpu warning.

I also built the kernel with CONFIG_KASAN and get no error messages.

Bert Karwatzki
