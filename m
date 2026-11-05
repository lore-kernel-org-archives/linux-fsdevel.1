Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916285;
	b=mCRJ/CJBl5LafiaME6ij/ZMBRtAyMZgLBthdDYQGuECZLYDhe4dEBK0oHrAmhdqhUdky
	 6WXIWD/ITcVmIW1jjh7OG55FGDjjBvF5SPZlAcrGZvnypen+Fc/JXRZD7zWVPanzXSFbf
	 CLIT9QxiHECuhC+xC7qI9//5XtiwagSVp5XIdabN8Y2fGrfW7fBLxpOuwrmgdE0ufJ1LL
	 a8oUo8jUwqCDa1psQAnzj7f7uUsOwHDYsFdedguqpUYzJXdId02/6+wcOMoIWqJNH0IyX
	 djQRvJAltrFw7qTsxozn5LqQu1dCKVq9lSgQICVUDpHfQ9l/mEqO0KtZOXcYXg2NuRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916285;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=JkVJxCsQ2WkJboEQDErenUdVnx9gpZszna0OBbR409I=;
	b=h2f6auL9IBT+ZJJVwAFERsWwqWaABSJRxUH72V+Q27idzHpXNd6EaknG1A7Gkrl0ScSe
	 07VeliWDNzGwL0K9z2vn/XOaO2wpEj9Ce0LkN2Z2K5k+9zTcqmHlLDH1cOJb+IIUNa8Hc
	 bVQUwJOh9ArML1bpl0oslcqmeSEQ4jlJ/mqHHDlbnZfJ4MTwvoch2xqTk2vhP0nl8/+YR
	 ZSAO3xNfxyIHt9j0ps/pc43aRvbi3RLr8oPYTmT/xcRuJkR85Nz6ZDpIAV2R6yAEhy9ok
	 C+y3/a4M+CzmXpk70Q1+5YW3XotUhqD9v3QMW+k7mWCBsWKTq9+xWGfrfHa6skJsPAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGHgroIK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659DD606A32F;
	Thu,  5 Nov 2026 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGHgroIK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D4D1F0089F;
	Thu,  5 Nov 2026 22:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793916284;
	bh=JkVJxCsQ2WkJboEQDErenUdVnx9gpZszna0OBbR409I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TGHgroIKoGPniw/59CQeuWPMBPX41v4IQnSc+9TbqDzBZ8AGBCuwPumeYG/cg+MyI
	 vwqyJBEerV81VbW/XRnDC4HRLjlOO9oDhhhnuWXkBRbkX51n0AxM7dKOkdRvG880O+
	 zeZKZvbidHGsBUtQjbirkWgoSqWWb4eQVDXnTEnyjEvKbAfEOHS/badE5LuUyUCeOj
	 CCLWWzr8MhpAFsMdNFopz+lQJMDquOk+TuaQIRc4xMgolpA/cp/osyOgNxHq2EXF8c
	 UHzdoORUwo+M7ZUVeAUJQdTnlHfj1Ww+aOpJ3bn8DzCXQhGKG4ZXPPdrH3gLqY3pt3
	 X/GSzYHYu3/lg==
From: Christian Brauner <brauner@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261103165419.687806-4-sashal@kernel.org>
References: <20261103165419.687806-4-sashal@kernel.org>
Subject: Re: (subset) [PATCH] selftests/namespaces: initialize the byte the
 children write
Message-Id: <20261105-kanal-chihuahua-allgegenwart-7ef14eca06c0@brauner>
Date: Thu, 05 Nov 2026 23:04:43 +0100
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

On Tue, 03 Nov 2026 11:54:17 -0500, Sasha Levin wrote:
> The children in listns_pagination_bug and stress_test write c to the
> parent only to say they are ready, but never set it, and clang 21
> warns:
> 
>   stress_test.c:137:22: warning: variable 'c' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
> 
> Initialize it to 'X', as the parent does with its byte.
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

[1/1] selftests/namespaces: initialize the byte the children write
      https://git.kernel.org/vfs/vfs/c/b2971bf97205

