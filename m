Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822CE420898;
	Mon,  6 Jul 2026 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343269; cv=none; b=rKJgUc/F1GkyYiuAE6x/7Wo5tUMnmD1nbfK3893/xVHSs2rzENV8JAZ7isXbO7TY9CUzxMHuzOybSX4zZz1Wna8ZwsYzwTR9+C7XLVVOWGhs0d5CLN/neEeEfFWY7272+skeqBlyB0sYTLVouTLYRo5BlX84RGAq441o4K3KEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343269; c=relaxed/simple;
	bh=h8Br2ufRAlCp/fA13B3yvA3CyiMNsY27X/v1enYMQg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VWYUSUoNIDDAaFaXBb1ZStXlH+o2W6vdJZitgGD4vIjcmEtjjCg4N1bvy+uKHAH3dbT4o0VoVHrD8nvec6Fj7QmeDGKdW9sQZLma9LQwrtIvJx5fKKJy0BF+EAxxXpKXxcVTzrmJrny4pl2CzaYWziHP4MWZHF4J+TXCvqlx8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVqOrZ+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVqOrZ+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E821F000E9;
	Mon,  6 Jul 2026 13:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343268;
	bh=/kDNSAwRbyzM4Ydp9g7uJ43nrMxko8pEAfgmYA622Zg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TVqOrZ+hpqbBIp8nS+8zUxmK0A+mYvvsce9x5I/OWB5PQzvUl+J8Xf6oJOhLRuPAH
	 xEw7cRnvuuvEeauqE5aKwgHoXISSa4zTEhqsngRe49JXRjR5tDhlqkcHPNT3P38Tqv
	 Sy4nazGrs7Jn4H0qahbig8nFo4IkGDCAFyWu2yuL1QTMKYYUcaJJ89EHTL1vems67H
	 DrpGBG8mnvI+nDDNS3cEX32a9llh7TanXYtlm/kclSiZbWMUsj3yIUOl2nAKzWBZCh
	 XYEkdORIh4vFJY2MMjYqzA+aRNENAFWLtlPaSZ0g401UTxKggnbFrkzQw9Y/hlWrAr
	 VnrDz4qU8z5aA==
From: Christian Brauner <brauner@kernel.org>
To: corbet@lwn.net, Yuhong Cheng <ceohunk@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20260705072609.1692-1-ceohunk@gmail.com>
References: <20260705072609.1692-1-ceohunk@gmail.com>
Subject: Re: [PATCH] docs: filesystems: porting: fix spelling of returned
 and instead
Message-Id: <20260706-anmachen-roman-hocken-f5eb3c55b506@brauner>
Date: Mon, 06 Jul 2026 15:07:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=brauner@kernel.org;
 h=from:subject:message-id; bh=h8Br2ufRAlCp/fA13B3yvA3CyiMNsY27X/v1enYMQg8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR5r1hcl/swKby7QGXtpZYD7mJLm+/18F5JmqIfe33Vu
 zCR1EmvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyyo6R4fRzG4sZSkZrTkz9
 UXXy1qc7a38u/vb1aAnjgbd5jYez9zIxMtyN+Ra3VnhhSJnK5IfOy9VvT15cVHsrNd/2np/17gt
 bPTgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sun, 05 Jul 2026 15:26:09 +0800, Yuhong Cheng wrote:
> docs: filesystems: porting: fix spelling of returned and instead

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] docs: filesystems: porting: fix spelling of returned and instead
      https://git.kernel.org/vfs/vfs/c/b5b1c2739f73

