Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677035CBCB;
	Wed, 12 Aug 2026 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520833; cv=none; b=EXimphR5rAQ01hs6ohYrUcJu2iywjMiagr1OkcfacI2pcqogjt9BkbeZgytaLt7pUQ5Z98Qfo57QwUmwuI22PcIZspNvYSmnbk+OIEBGM6yxIbwHoNItEPvXEOZDJp4tNqpgWRFFRWuVqOEbnLFFn/BaUW254CSVt40z8qgZKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520833; c=relaxed/simple;
	bh=YAO7/Z3FwVPhLTDNo6IBHCdZaFTioqw4FGAPksXEaOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FvPTDpUxQVYGgoodM3TRu6q37QP5eBzuYymdeIfxPgQTI/i1lpyM9++zYWvflWRWm1WEDpRd4bT+DKwx4DxRLut//EZEI3+lM/boFiOG0CYWuFwcyZUW6ISj+iuC81J6cLMXT/9DIsEfpPYjTj/C9AEbxVJAc6Fwpq5OldnwRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwlJFuTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwlJFuTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FEA1F00ADF;
	Wed, 12 Aug 2026 07:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786520831;
	bh=7+4xqBQZFNKYLiBulFqJHuUElTToD0WrY6Nfi/ICEro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KwlJFuTw0uvX78gDZDSkAh9GYTHB/ga2dPLBWo43THKZKQgH1nZfdqwBjB+WRBQgs
	 edVNte8LHVJw8GqtJd92PgeVYYqT9FwvYM2VaKENRwvMNRkx95MOiC2Ik+Bs7OSTQ3
	 DOmv3I8qQo7+3aV11potFs97CQaYAbeF93h/xXsGBRo9dSO/Ax8ffJhPuT/AdXkRZa
	 VRFze7ys/oCQwCmIrIU/12oZJ0n/BVz0EifHWk+PpY/+JbPIEZ1vqmkimSqlr7X+Mp
	 quBXu44O4CXKgOWGvKFmXXWzcuG0n6f/AQga18PN2oX817S97Aqy5Hpoa3F80t73pu
	 x9bACNiqEEAxA==
From: Christian Brauner <brauner@kernel.org>
To: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
In-Reply-To: <anCNoW-x0bcB2ggg@redhat.com>
References: <anCNoW-x0bcB2ggg@redhat.com>
Subject: Re: [PATCH v4] pipe: only enable the extra wake_up(rd_wait) for
 EPOLLET consumers
Message-Id: <20260812-frust-wiegt-gewirbelt-988f24d646be@brauner>
Date: Wed, 12 Aug 2026 09:46:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YAO7/Z3FwVPhLTDNo6IBHCdZaFTioqw4FGAPksXEaOQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVqPyZ8fqfRkz3CduJZVk5ik8y4//3nX+TItidNMes4
 rKcmlJSRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETeezP8r0iZuHjybJ6nGzoN
 Q502V4s7HDqkNkkrReI+m0hGbbazPiPDpv/5buuS/qrbKroem5EWn8394KLY3pTvSTPatH5Zql7
 hAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 03 Aug 2026 14:46:25 +0200, Oleg Nesterov wrote:
> pipe: only enable the extra wake_up(rd_wait) for EPOLLET consumers

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

[1/1] pipe: only enable the extra wake_up(rd_wait) for EPOLLET consumers
      https://git.kernel.org/vfs/vfs/c/07c3efe20e24

