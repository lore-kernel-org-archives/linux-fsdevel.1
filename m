Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E73A450E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593991; cv=none; b=KxMJ5UU7kwReG6pqLFXLu4e+F3CfOFvAe45NwFeK1UZ1INIj0M4jH79khqwZ+J68/v12Ij2me9xEBon9KH1846xrtwP8QX18SSmO2ULBWjk5GMhGqwR7GAxGA2i/n3TrgM301yiW+lyz+NFpLBWbSyloIOGm0bjLNgkv7E4LMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593991; c=relaxed/simple;
	bh=mJGGc6Ov1KMema+t80ium/pXA/gWJCKRJbuAxLSZ6Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luxbRiipzMljHKtkjgf+mkqgxyt3C7E3B91NzBkJrYsEQ8T8PE3Odyn4DefdXjmtjLnH95Bl1yCeIKr5001zUzhtjhF8W4oMYluRgPPksQAd4vYqTeD2zCtVwIg3ZfFddlKfgivNLu1GuakK7P1crjB2lyfddRGTqjQXTcz4DbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBaXD6T/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBaXD6T/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F99C2BCB3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774593991;
	bh=mJGGc6Ov1KMema+t80ium/pXA/gWJCKRJbuAxLSZ6Bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UBaXD6T/iedBPes+rYtCASamLD4D0liJ8zY+nxervLOhGxD7Xgsrt7zNUtH+m8eao
	 GrkaH4tUCcJmYpoIOSIJXSCx09iEmehGP/FPr/JWcB8ySkcGuHrGxhdfyaoX/fiv3r
	 tOyhOG7HljjZW1U0g2QM/K4XvlIVpUdiwumdq9Vw1vhY4Wx1lE/vHSXA5592FGJ+Ao
	 Ek0MxIScN/svMz6lHXw1vuAeSRccHHE+zqvc3SKW4OQ56Xm9gW3fN6NdMGf+lFoOei
	 lzpyDBx7ly7WQFkjJil3559Z6sZES9IZLTWNgiV2/weLHU8EcGZ7TWl/HFAZrupiB8
	 Jw7OZL90I1YUA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b97ed4ad579so288853866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 23:46:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSr1WKQkDUsD2N+ghmSmVl8q3ajidAFiVXRdcXoabYsr07RSMFfbXcZsaqSc7iRtcDiR9o4MDdp8dT25ZV@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLBndYEwt6Yhgvcq05HkwTEXGWZQgHzK0p3KJADrgWuhrScX+
	mXu3fVnl74dLSsiiFegqMAempAwpOqYfSxpu+ybKA4QaZa0oPztnIIH4xX8XRf/ueB2Koe7XHl2
	jccOePRLgIx9gl2X6orujgTGWzzl6hro=
X-Received: by 2002:a17:907:846:b0:b98:3b5d:e148 with SMTP id
 a640c23a62f3a-b9b502bd3a5mr82196666b.11.1774593989477; Thu, 26 Mar 2026
 23:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260327063316.GA8318@lst.de>
In-Reply-To: <20260327063316.GA8318@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 27 Mar 2026 15:46:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8PzRRbsyNm_NjhSBBTr3xoMyz9G_ibGCZavzy8WEq78A@mail.gmail.com>
X-Gm-Features: AQROBzBwifYwa8Z46YffsxBhM_G8PEa07TLs8I4k9BOVvrm3YrmjXgNCLOOO1I4
Message-ID: <CAKYAXd8PzRRbsyNm_NjhSBBTr3xoMyz9G_ibGCZavzy8WEq78A@mail.gmail.com>
Subject: Re: [PATCH 0/5] exfat: convert to iomap
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me, 
	chizhiling@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 3:33=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Mar 26, 2026 at 08:50:40PM +0900, Namjae Jeon wrote:
> > This patch series converts the exfat filesystem to the iomap framework =
for
> > buffered I/O, direct I/O, and llseek (SEEK_HOLE/SEEK_DATA) support.
>
> What tree is this against?  Patch fails to apply to current mainline.
This patch series was created against exfat #dev branch.
> Or if you have a link to a git tree, that could be useful as well.
You can find the git tree here:
    git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git dev

Thanks!
