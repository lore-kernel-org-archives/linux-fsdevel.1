Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401449EC78
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347395; cv=none; b=Ffmd4UZoNItM9O/CtrxRl4YHzv9+TUWUbsWisAUikSq4NF7WxBs8S4n4r/Ax1j+8b82szOscGwkEaEGT5aW4v6uHB1jBhUhy8cU4unbxJHUUp+NKIFaTlnJmtmWgRVsaWMhn/iclH2/LjJCSC1l5oevzGLl1wzsXvkbuJCziMTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347395; c=relaxed/simple;
	bh=MoJ+yy3HvlTwCE9+xPpycoQbbxJWHKv8iZvy49Mvazk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=plAmMovEsKS9aR1b1EJQMesqnFG8tmJa+7o0tPcT3uj4ieSQwqK1NP632RjXGYGBVrLqNQ9lVW2U6gDJIoldzPuW23gX/cy4JAei2SMcNhRJ3pLBE+g2SwREQW3qfjDy0isyJJKYDmyjNjT5QSPD02U2H2F/L0EdwlThCSNwwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFeKqqQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFeKqqQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FFE1F000FF;
	Fri, 25 Sep 2026 14:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347384;
	bh=jegzul79EURwuU26jhV9iLarnnA/lW+GkfwriYh4mFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XFeKqqQjB1Vismhgrn6UshT3jRcQWNGRbFTAPyJW1M2tnKm4BHmkPrCZjfRfmtaCi
	 jy3MvXS8/6O5Of+kGV0jbXb3oPIXhdbOgAFzi3wW4bCp38kZmZLt7hckDw43ykwQYf
	 09SHuXooQd7goXqGM5BB5fEEaNwcl4WQ/Oq/stTs+kB9poOLK7EsJeE2X+HdFBmoo/
	 5Dis1rYkcucCN9EO2wHm5j8rlNbT5Zh8iTeTaVc1FV08t7qQacyU41qYh4n5EB0/W5
	 ZrlAV0AP/xUf6GPah6x2LfAv3UkkuSI09WM0U1HCXM8NvJhQYUjQAyyNYKhhQmeCjI
	 XngDaHFTwcDzA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, hubcap@kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>, lkp@intel.com
In-Reply-To: <20260915163027.500798-1-hubcap@kernel.org>
References: <20260915163027.500798-1-hubcap@kernel.org>
Subject: Re: [PATCH] orangefs: use ssize_t instead of size_t for error
 codes...
Message-Id: <20260925-duldung-klarzukommen-lunte-8eaf4302024f@brauner>
Date: Fri, 25 Sep 2026 16:42:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MoJ+yy3HvlTwCE9+xPpycoQbbxJWHKv8iZvy49Mvazk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRt6yg5MvWCvZhd18t927LWS1mcEuDv3frllKRC9FGjq
 vi30/SDOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSqczI0NA/S3PhaT7e/4v9
 zWNuPtTbmC/KJty6Jk35Duf3vt+3uxgZel4e3HFEjzPzs0yrrNMddllRu7Oyejw8mbdle1zT+ib
 xAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 15 Sep 2026 12:30:25 -0400, hubcap@kernel.org wrote:
> orangefs: use ssize_t instead of size_t for error codes...

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

[1/1] orangefs: use ssize_t instead of size_t for error codes...
      https://git.kernel.org/vfs/vfs/c/0129ac825a37

