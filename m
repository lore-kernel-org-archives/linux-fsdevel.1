Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43082853E0;
	Mon, 31 Aug 2026 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162767; cv=none; b=FyMasRi+mKzVtQouxNUOzMY0t34l5lFxeic6SVvMdnpgftV2LaoNF/CX0bZ+Ug2cNKu/Ynz5y0+kSSyiSgIt3f6G5jE4TqayhRt8hCF3HdK8485l92KrjMpv6t+lQobIuxWTEIE5hw+gukhfVQX6hdXy4ogYwtSiPNSyNu8IQYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162767; c=relaxed/simple;
	bh=63gm8bn3zGe2TAPPOYo+AF5EfeETWpHh1/QdV0+f9UE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oVGoglO/sQTzwdgHRT60IbMgqu9f0JeKKxjZuF5I74TphTiquF7SR93rkXzxbFrPQ32ZDVMksPaxKndbJyItFMnmPBbSU+qQGaHNhj4WeshttrBcm1FhHFDyxiYU40XnCF5kFOgrMwZRZIJBVKcaTdQ1Teziom0E14l6KPNrkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8wIuaj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8wIuaj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC8A1F000E9;
	Mon, 31 Aug 2026 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788162766;
	bh=0R4DpM8jzvBHu4j3no4Nkvv7aHntr5kBWoO3KIxycKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=I8wIuaj1sYDj1RU/eR0Us1Q1RMFiTrPL9yRyRwD5HIFLMxN6LiUbHbOCAenfiiiD2
	 qPUbUNkLvPJmhLE1XXwYJPvmFzUt8XYKVMv134sBa3YTi9jGPhfEuGUK+bl4w2olWn
	 YyN9I/+UJIB1MSVNmZfTiei+wivvsv9UqfY69gb+HYf2o/g/Pa4t9ePf93LcRT27Ev
	 O9ABUDr7jkhUgh+0oEXxIbOM/IaNoXnIHY1WY3PlNA8whHj6ZvajtggJ3+CZg7OPdP
	 +KocrZ0e9tH0WDPZPAT/cffsaA6J8O/y9YEbqXHjKHGPXPZIt8TAAS51Q8OtuCiKwN
	 RmNKoU7XWk65g==
From: Christian Brauner <brauner@kernel.org>
To: Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org, 
 Daehyeon Ko <4ncienth@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260813133843.2933127-1-4ncienth@gmail.com>
References: <20260813133843.2933127-1-4ncienth@gmail.com>
Subject: Re: [PATCH] aio: prevent eventfd/epoll recursion on poll
Message-Id: <20260831-leise-strand-ehebett-6002c0e15756@brauner>
Date: Mon, 31 Aug 2026 09:52:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=872; i=brauner@kernel.org;
 h=from:subject:message-id; bh=63gm8bn3zGe2TAPPOYo+AF5EfeETWpHh1/QdV0+f9UE=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGqVMsyi+gyzHjLq0dY3BFC04S2PFeUuLrpqK/fm9AVMrz7nd
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmqVMswACgkQkcYbwGV43KIopgD6A1zI
 iBxMLC95UUgHt+tfxR5m7/kQChJ41S+nbb7Sb14BAMJA9ZFWb+bNzeIkx1r9u55+cql9DebCIGZ
 ZQdPEaLwC
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 13 Aug 2026 22:38:43 +0900, Daehyeon Ko wrote:
> aio: prevent eventfd/epoll recursion on poll

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

[1/1] aio: prevent eventfd/epoll recursion on poll
      https://git.kernel.org/vfs/vfs/c/7d70a1eedeb4

