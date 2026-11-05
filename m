Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916105;
	b=XP3CDD5WhfUs8uOGcPTIId3DPRAM2l2J8ZAhur4zDpzdfXWZYrsmxRjcIAZoIzSXo/Vv
	 xOPyQitnrj+YY07iOTrF2wUHEk7D9GeFW4hrnK5F2+/uVh2vuEbkVzcTgThCdH/NEKbAX
	 1Tx+aiC7FEPA55KfYqHmk05cD0Jr9Uu7x1mjqmYMtNQSengfO6qU6oodOV+B1QoaNCUW8
	 pZoJLxPR/FsETNIy1klCHUmkoqQYNk7yeZd0SSSGsgDjsCxRe9w8IJCXj2gLmQMZb+zdQ
	 UeXQ2xRHB3q/9/YmLxWr0vCLL1sZxQi1q9tXY9UH8r7c4tZj9G1cI1iI/a3aXI7bB2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916105;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=0ssD89ibuYFdykDCSINR+WKonV6NzYYUz46OQQheQ/U=;
	b=SxtYMuYrRpJfdRD6LETn3+tJofCLQa0JxL/TJ7PQe/lVDnmgt75+JDTfSZpHTZ2CYtT6
	 tmYMhXB+RIG0u9SJ3qjiIte2+rj9iAXKR7JhZMMrrrR97kqjDtvlI+wwQ+VW+j8/WocC4
	 4js83nW63srdP9bOL6msA5lIpIZbBCEPvl+J5AcVXL/BDOlTdHm/XeQhbf7BRKTQtNNFx
	 OFCe6zHdmimjKjvxupQNdD87BIwXQFb6VfwyCE7NdCUXZRy+1GLycMe4Opw+FyIIUKrM9
	 5ROoUAj/q11nVTH+9FXGFMtD/lRwdEKwSChh8VuUS1LonK/bpSUH9ZY4+qIX1NXa3cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqn30Nky;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B401606A32C;
	Thu,  5 Nov 2026 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqn30Nky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F0F1F008A3;
	Thu,  5 Nov 2026 22:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793916099;
	bh=0ssD89ibuYFdykDCSINR+WKonV6NzYYUz46OQQheQ/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oqn30Nky2mTWRez2YVjvyepfagHyatEKmE+yfGxiuwg2gfw+XPkXcAr58qvQ7zKIF
	 0in7LiVprrOn14NY4TzvMhzh2qpRHP9KISenHoDh5RIUoA3pD5jIkC2ragG/eeUIca
	 Yne/z8Ioyvgig8JD1N25tUMNrX8afcC3q/5xsBHVRfMWaGAz29wan1LeGTsasJ0BhX
	 Sij+SltLPABwFJ6hPyEwRzpPymq13KkVoHKeZik6o3DyASshrBK/9PJ1c3LML3nQDF
	 rdZYmWXBX0m4NWYI39sba+yulTXdYptiPrgJg0qgUjykPgfhelY2B9p9Huqp+ScLsk
	 vyn1RtiZS28vQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261103165419.687806-1-sashal@kernel.org>
References: <20261103165419.687806-1-sashal@kernel.org>
Subject: Re: [PATCH] selftests/fs/mount-notify: fix the indentation in the
 fsmount test
Message-Id: <20261105-vielzahl-visier-denunziant-eea115f62537@brauner>
Date: Thu, 05 Nov 2026 23:01:35 +0100
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

On Tue, 03 Nov 2026 11:54:14 -0500, Sasha Levin wrote:
> A few lines in the fsmount test are indented with spaces instead of a
> tab. That puts them deeper than the ASSERT_*() in front of them, which
> ends in a for loop with an empty body, so clang warns:
> 
>   mount-notify_test.c:338:18: warning: for loop has empty body [-Wempty-body]
> 
> Indent them with tabs.
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

[1/1] selftests/fs/mount-notify: fix the indentation in the fsmount test
      https://git.kernel.org/vfs/vfs/c/5e042e208dfe

