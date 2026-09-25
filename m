Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342134A21;
	Fri, 25 Sep 2026 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349878; cv=none; b=Z33gH9AVvJNwasjTUVHRNDBdupbJivUDLX2fKFiuruBwXyLAi2Npc6rvXQYDx7wpmjez4Kq//cQCPAUjB5ItBRdkkfx/5IN0in+uxSGU8VMm6w0PdW3XRXBYP47MXPJX9Q1dW/c8vvEU8QQwsLFCUiKjt/x7JW9PW4h4fC2209I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349878; c=relaxed/simple;
	bh=SKuQ0cWB9eqwbxsQY7UShY9sEYurh6dzKKrnTLL7ZrE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iScrzpxg5VshK95AwQgr4cUe91Hs6o4KPwX9vIuShYoKNV3Sptd/7935QfEEwSJ2R4cLX7CYMHXW3Hd1lcN5i1U4ngbCVnsklx1T7iSk7MPofT/c0cDInPU1YVLm+9IkbgcpKJwWvYU7ES0JIPOWZKwGgVTCaW4+R4chNPKYtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpVjwt1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpVjwt1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188001F000FF;
	Fri, 25 Sep 2026 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349876;
	bh=f919PmY4NUyCdox7ic7E4A6qYrpfApExvayBnK3Nzr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SpVjwt1B18yugnaDWx7JQ6dDsSLVCkm072FvGuxpBbqPpwuVfDxouXtUTJo58ub/9
	 A9SemIlOXEFPU3jEH2L/owkM5NbtgMGou5aeFUUOSOWc+HTP4o1B0i7SXcLQ18CHF3
	 Crwx2Ojsrce62UrNgsou7H0VShGsp2ft3LZQL905WaZcMJk3CwOyU/W3v2gTn8hgFc
	 7l6wcA59TU72q2fE6sT2VsWf9k/DS/Em0IIMrLLlP6XGAXf8pg6lKxUCGMuQkH09OL
	 rCwM1HR+tOqXI0lMMuIkRhSBjj2B+LC45oRNIxil5zRVe8Jp7HrI59Qp6nF8R3HVUY
	 BbmDXpnXhjl3A==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Yin <yinxin.x@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260924065443.1650126-1-yinxin.x@bytedance.com>
References: <20260924065443.1650126-1-yinxin.x@bytedance.com>
Subject: Re: [PATCH v2] writeback: size foreign flushes by target wb dirty
 pages
Message-Id: <20260925-dastehen-abgewandelt-narren-3f22e2c163c2@brauner>
Date: Fri, 25 Sep 2026 17:24:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SKuQ0cWB9eqwbxsQY7UShY9sEYurh6dzKKrnTLL7ZrE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtm2S45d2aafduCiQGuzGtemV5dNu7SVWpHHlTy28Zf
 Yp10JDZ1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR7XxGhrufzlafNPXkdJ3z
 STrPQXtxa7NTxnS5kHWhHBlyr69vO8vw3+kNp5cnw/0UARmzQ+bSJuecO/U43wgk2m2ac+WCTt0
 JLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 24 Sep 2026 14:54:43 +0800, Xin Yin wrote:
> writeback: size foreign flushes by target wb dirty pages

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

[1/1] writeback: size foreign flushes by target wb dirty pages
      https://git.kernel.org/vfs/vfs/c/168a8c13159c

