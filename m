Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E92DB7B8;
	Mon, 31 Aug 2026 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164638; cv=none; b=KreIxFfgn6IRPa0Tlprl2KPwvuXKH5Sq0OI2MW38RThUwJbDc1+1I5tUrC2TGVxummjkmYdrYELYvBFjmMwVxKYoHYjh2NIeSZ9s42Fgtc7frFpNGfeFooJKkQS96uDhbGVXzYsqAmeRyD6Jp8ixFs1fuCwtbcOsbxdBZ+FBpBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164638; c=relaxed/simple;
	bh=O3U6jl1FsQ20QEmaCCu9M2CiD3EMSeS2jI+V5lorXIA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xn0/MI3vm0jUsnejMgLUTWOy2SpbCbCZpjtD+4pmx6FOlBTzhkSI2dkhRuLa409HNo6aTB7RBaajvfEpGjnFr6WJ3Zh/NEH0Dxx7gPC7YRE++gUKTtKXY+yuPUxIUQA93gq/Ry5o9mrkXNRwgvHFzYTykNrv0y0Z2NdrueUXPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8Dal0Tl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8Dal0Tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881481F000E9;
	Mon, 31 Aug 2026 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164637;
	bh=RZUCrtIstjeiGmqc0rsCB0jvqtJ/sbXH+wl3Xysrzg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=g8Dal0Tl6i2ZW4gkTDKnbMh65hU0LPXaGCT6YMVuLp6qYI2hCLZawMR2UVZxfNTFn
	 MAQD9zPcQwcAAeJgWk4dMHk80hb8EhgdkKWSYr8KZFN8Tzf43YAmWWh2fiSnRjdxb8
	 IWzLippRLNGEGVqNWx2LjDrOZTKF1L/0nb0SYbx5HM1Z3JmIOskUfaAwd5ZrGPmymB
	 Qr3Hepxj1/pFeHYQHKDI+LpmiYcIeXjNz5sMIpABzY4n5OMnAr3PdYSbMvUxtTFNSn
	 GXMrFHzOPStL6Wv/3uEKilpopM+JHYDjc5f2Isghimd7ZJxYOYB7Zri5HyQIcaq74v
	 CpxSgrVaxLgCA==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, bcrl@kvack.org, 
 Mark Sercombe <sercombe.joel.mark@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260813231455.558829-1-sercombe.joel.mark@gmail.com>
References: <20260813231455.558829-1-sercombe.joel.mark@gmail.com>
Subject: Re: [PATCH] fs/aio: fix comment typos
Message-Id: <20260831-widder-eingaben-kennen-145d55096706@brauner>
Date: Mon, 31 Aug 2026 10:23:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=836; i=brauner@kernel.org;
 h=from:subject:message-id; bh=O3U6jl1FsQ20QEmaCCu9M2CiD3EMSeS2jI+V5lorXIA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNtZJ+IJaj8bdVuenAkT/19qHt1ytNQv7OdU/XWLGC/
 eXjSU8COkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS+Y/hD8cCbm3zazv5v3Pv
 3zYv1bxZlj+vOKL3+A25E5JL1i/PXMDIMJVf/Gjl55Rzzq/MD/vrmz5ylXO+PeF65R32An+lu+8
 W8wAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 14 Aug 2026 01:14:55 +0200, Mark Sercombe wrote:
> fs/aio: fix comment typos

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] fs/aio: fix comment typos
      https://git.kernel.org/vfs/vfs/c/5321f6c515d3

