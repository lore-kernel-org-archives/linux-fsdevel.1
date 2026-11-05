Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916281;
	b=DDMCgyM4RJjraEuvK3fuKjvT2C/456pXwbGTlpI1o7Bure1KgSH94IwbRPHZXNkbvSgK
	 wKoNPSfZiZ1gjEIqjGV5k3lZ0mlZiuvboJEb3t0K23HOTs0s5rHzSaut33jbrdaGP3U9q
	 6exdQl8DUkHs4fM5cbe2GUIH7akpF8O7JXKLvfaybPhR/PxOeutts9KU58vLNtztLkBwq
	 8W8MVc4J2Lkdi0CDxbjoK5msXI7x31zFPf2fHsGhQXhPZ/p6RUdXUlMHnoHxV4B88Gv2k
	 vwGwAzN2E37rL71e2PpFCPavo1Qu543OBGd7Hm6Qx4HPxY/SJP5g5dQbEEM28vwnnkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916281;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=PBo0qDH7yFB1KquCXkt9kw48HwJydxIe7xp7oSsyQ8Q=;
	b=dpD7AL1Yx01shCCpI/tYWYbZvXpIQpUxreTtb3kywQka2xeonbXuqbDYJlSHorB9+eM9
	 +hA8+xnuJWPjvYc2n5lnWGOxq3YZjuORfJWmpvaN1eNCJO8fAEWuin8xHleNDWL4/bchx
	 OFlK4wyUoWN8nQsDMlR174eA7yixoshFZe5q6NgpQKEOt3uGEEfo8Sduuwj+1rYaudbZW
	 c2kplwTNw8bWzqBnQ+7Fb1MiIOoXOZFa9cic0OaZj+z724Utazm4SjWoL5NlmJ5KUXCQS
	 LjPT/wIfXjYhM50s8lZs3IxjTdF8E9sCk5Ae6KVy/f1QzfUsHCpTSS6k5lK0Mr8M1WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxbnhUp0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E021606A32C;
	Thu,  5 Nov 2026 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxbnhUp0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381BA1F0089F;
	Thu,  5 Nov 2026 22:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793916280;
	bh=PBo0qDH7yFB1KquCXkt9kw48HwJydxIe7xp7oSsyQ8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VxbnhUp0gnxWXBOLnvjc6cws8+jkPEkRKqUJFQN9tqbuJs6kVcu6PJCcqlnYhGNTn
	 eb525R40VlIJPm2gtAy20Hr63ZeTByNVa2GCghv6jR/1i2AK35RxWgBoWT2hKXtLgM
	 DIG7Hnr9k4qp2P2GnqdzDXQun0fO5yPzw+lXKlV5H3IUr1WNg5U7ETZkszKUUhjDml
	 BgGQUfuQBCeOgVPol1VT4H0QHyDzGAd3FU9XY+82SHbTL8enb0EH4SKAdADCaN6JL5
	 Hx1OLPay+kDffZ64fJnX5AKvIRsLKcFR4yXzto6ZYTJkgn6GSnifDmjMujthVmqUr0
	 CirmZJ5AuWlPQ==
From: Christian Brauner <brauner@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261103165419.687806-2-sashal@kernel.org>
References: <20261103165419.687806-2-sashal@kernel.org>
Subject: Re: (subset) [PATCH] selftests/filesystems: remove the unused
 list_del()
Message-Id: <20261105-mahnen-injektion-blamieren-287b89614455@brauner>
Date: Thu, 05 Nov 2026 23:04:37 +0100
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

On Tue, 03 Nov 2026 11:54:15 -0500, Sasha Levin wrote:
> Nothing uses list_del() in utils.c, and clang warns about it in each
> test that builds utils.c with -Wall:
> 
>   ../utils.c:106:20: warning: unused function 'list_del' [-Wunused-function]
> 
> Remove it.
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

[1/1] selftests/filesystems: remove the unused list_del()
      https://git.kernel.org/vfs/vfs/c/65c9cbad74a7

