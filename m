Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916283;
	b=5hvupXGf3oi6+0WFE1TlOK2PEKSaARBl6FxN7mCq9ZHcBT7Cqjl6fr9OxAMLtAb1Gmwu
	 w0ka7GraLvz5ifiizdHSi4qRf0e2NxPlg08UPYbjR1yw90mg7WBL55nY1erO1IPQgM7Si
	 nH1xM5pJKHWtw85fjoL6CpfjDKuI76ytVvj0zxwg/Ted+JN6d3hHm3D4hPleQ+WZgdF0C
	 jkD7dwE+TTRjGVt5nuGADTUgqzYlj11LLvqDfTCjsKJPw8Pt1SrtmnuJXwcs0F/E7GTTD
	 45RSmrRmwRVkiaYS8vMvMUa5vpnLkho0PBPOXanyIiw3aB75oSTR1HYNmujJxoFa4IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916283;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=zzeGbQmcKYGOMBQOmED5ru3fLNZQtc2Ri2STVwl5x1k=;
	b=Q3Ja5gw4iEABpsf81rQ6ecks1cho2FGAY8geucpCArJwIbNyMMp+if/nBBJ8X80xx0XX
	 neX3wN+xpZdnq5TJ/txLPzZzCu/jQZDfMjPLyoE/bez1cWwoI7p7//p50YNOTKKY4BBRG
	 W2XWcAH1WXxuXO9oG9jsgoOHrJhc9eaOJLOGacB2CHvS3WHXi7XGF/8Xb8gCmeSJFlW3j
	 P3LHyU7jlIiySDptP0iTfiJiFDgMZpLGe99iweop4Sx+d1am8tjVF08XtiWZ4V5J6fhsi
	 ccDu5EXetgjhs2rCV84zAe4Sif66XJWjeEJckf97pTyPcCT8Gac8OTqOHEgygGgaFiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzLxKc04;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1E606A328;
	Thu,  5 Nov 2026 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzLxKc04
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588231F008A1;
	Thu,  5 Nov 2026 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793916282;
	bh=zzeGbQmcKYGOMBQOmED5ru3fLNZQtc2Ri2STVwl5x1k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FzLxKc04a+Pl+nYsvAfXE2uW82gUle3HAoBbp65cLgqFhC+oJM0aRCHhdwhKSAcM/
	 WgLSJW2K0Aebgcat2Wy4f/sL20NkRTBx11R7tgzimkHWMVbxk9ghv3EFaPL+ySF53I
	 bYCuucAJPjnIuUwy3lzyQ7pOuWNfkoQ3g9Te591C6h0vTAja3M4vqBaKt0/Jfmh3tm
	 diI9iB6W7CZoUiTmRyUMNz5zvgBeswgCtR+9SaZQB9iwVLoERZbsQEYGWwNN4lNPly
	 /9TulKju5wNfS1k+oXLPWtyfxbHE9Hpl1/1C8sodbX6Xj9Wza4OOd5E8iEpxnPt1hx
	 r+Vh22o7FVXmA==
From: Christian Brauner <brauner@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261103165419.687806-3-sashal@kernel.org>
References: <20261103165419.687806-3-sashal@kernel.org>
Subject: Re: (subset) [PATCH] selftests/statmount: initialize the byte
 written to the child
Message-Id: <20261105-pfoten-entstammen-getilgt-e551e93cc5a3@brauner>
Date: Thu, 05 Nov 2026 23:04:41 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Tue, 03 Nov 2026 11:54:16 -0500, Sasha Levin wrote:
> test_listmount_ns() writes pval to the child only to let it exit, but
> never sets it, and clang 21 warns:
> 
>   statmount_test_ns.c:334:35: warning: variable 'pval' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
> 
> Initialize it to 0.
> 
> [...]

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] selftests/statmount: initialize the byte written to the child
      https://git.kernel.org/vfs/vfs/c/678e669241c8

