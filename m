Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915841;
	b=ieHxTd6Mxc8bTAxsJ87EyBkdpJUb90112HfBOK7JAJIcuklD7jNU8QaAt3PSIIsbf6Gk
	 2vwfS6HVwEZfwmdVAYXK4kmRsJPdQeZ2iaXQBjwU56GQ7T+VMF8/v+YgK5iJPleQgTI+E
	 o6HJlE0ylJqhgTfdU+rVwwpWXf/6cReewhpPDsiikDvh84qEbvZRDOfuyhV/8VOfHodum
	 oYxP9D0GL/g+D2sdXYqhhLFHzn+eMjaaHmEdtqYIHlCcku/PGbo3nkv5M4oc/z2vjXZ8o
	 hzTbzCe3HlPoaVq/5zHsVO0gzh8AAREQvFjBt3E4sqIlG4fIA583Riiv1ZLILFemxTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915841;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Fzb6DPv6rvszZtR1lcbQEGQt8Iy1DvZeVZPw32p0vzU=;
	b=p1Uq8kkp5S6muWbBnoEtJ/hAzTCoETLM8E9gDl6hsxSSZWBJTbffSw2X21GtEv1wfgZT
	 y+WYc3mpIppHonyteoGIKGvIjGQOA6fnsZ5YCS7QxS4OllFPm2vahWsDFUZ7ccU2wzZ2Q
	 s/vfaPMyORw8E22Zefrbp0njdhf7+AdOZxiVuJtlFnvcw/FAgQTf9Hrg/LNoXNSci0XrL
	 YVQILADJifriR78tfgkLXXVugHCkPdMcloji8TNSSBpEhHIh3qzdgW5TD6i64p5PybPFn
	 /g1QaQMy6/SozU9HT9gvgx1nNoyGe01HiFgqPDapaO9s66kVfJ7gxxV5sUbknsbcaSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5FamOi1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF8606A31B;
	Thu,  5 Nov 2026 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5FamOi1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38AD1F0089F;
	Thu,  5 Nov 2026 21:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915840;
	bh=Fzb6DPv6rvszZtR1lcbQEGQt8Iy1DvZeVZPw32p0vzU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=j5FamOi1MsOaENu3xSwVJ04TLD3HrrVzjDWHxOYL/NKtHJtB7g7rvY7rSNQDnA5E6
	 HPtVhKU3X6qDJ8YngIMRK2yjZugRA0PuiDY1e1kj52LZlxPp0JdJZMC6ZvG+dKqQ0p
	 PsHReqSpOgPLfU0HuTc209Cm88wEobVi07E3rcBJ1J3kN+bdIYX076t2otf428QnT3
	 T4JsZsKmcaLxj/A0v5yoCmMeEQhfmch/emExugF7VIwVKfy+Zn5l2w42EqtFRdTmdw
	 jEgGQct8SYnyyvuU1yGUloKfqYkuiqdSi9jEqksOhCt1gPAkc0thN2S18zudMV0vfG
	 nE67/dbqcYhvg==
From: Christian Brauner <brauner@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: Aleksa Sarai <aleksa@amutable.com>, John Hubbard <jhubbard@nvidia.com>, 
 Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103142756.132111-1-sashal@kernel.org>
References: <20261103142756.132111-1-sashal@kernel.org>
Subject: Re: [PATCH] selftests: probe for sanitizer support in fchmodat2
 and openat2
Message-Id: <20261105-erlauben-zureden-fanartikel-4e2f6df8cb89@brauner>
Date: Thu, 05 Nov 2026 22:57:16 +0100
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

On Tue, 03 Nov 2026 09:27:56 -0500, Sasha Levin wrote:
> The fchmodat2 and openat2 tests are always built with -fsanitize=address
> and -fsanitize=undefined. Toolchains without the sanitizer runtimes,
> such as clang without the compiler-rt package, cannot link them and the
> tests fail to build:
> 
>   ld: cannot find /usr/lib/llvm-21/lib/clang/21/lib/x86_64-unknown-linux-gnu/libclang_rt.asan_static.a: No such file or directory
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] selftests: probe for sanitizer support in fchmodat2 and openat2
      https://git.kernel.org/vfs/vfs/c/e00d0eb8e3e7

