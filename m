Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB7625
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783728707; cv=none; b=RRNw1EIViBCbOA1nCFy/KCfAxQaI9siopt+/1fcF6LcZUOB4rhMVuVlCBtkNy9V3q8Yk+7aRxmqzTMNuHTOgHxEoYng7DOYmboxRd96beu8A0NaSSlglVIyoGNdiMfbp1fiJGgk9vnJJCPYdi+cgCsuRLmY+PLBB6guY7MGlhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783728707; c=relaxed/simple;
	bh=ytf54I79C79o3jv1eWgW53eSwrpBJFUofzYB8dgQa7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuC26SpoLfJHzJB+b+7xam89xbpv9OiTvLPjM2uFyAc3MqJniDNeFl26DmcrYkcpJxtq18vKaes5U/zhAj6tpxK7GDoFoYZgfCh3Dgqy7CvsUAn/0rWhAOuZSauZYNODjxPJ0wflxAiOwOdPmchtRKK1hHFJwLM/kL4b7o0DGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzhPKIOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzhPKIOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAD91F000E9;
	Sat, 11 Jul 2026 00:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783728705;
	bh=GyhyGqRQKroxfW64L6xRU5J7B1yOFnOg9sGO4fxh29w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzhPKIOz1/a5ZgRJtwQJsSVMipKqRsxh4xC1SafTDqvlf9fYPhaRnD06UzykQwSmX
	 drMaevmaL/tyy5aP0YNVEb9iN+0zBuTr7yb9tKCaPKLsbw5K24Uz9m9N0FefCz8mX3
	 ka+1TM+AVAGCn0E0mHWuHigsuO6qPCocrN58Cdl8lsehK15UwEP32JmCLhdZZFkL3o
	 QIgo9+NgIbFO4HmGWWGi0y2dh8ZMvV+zcwUL8TVS3+yIkK+p1b4vPl7ExauR9g444Y
	 xOgMzG+ChBvEg80rzrcQcrzVyTwiv7tLHMDQfdtnlUDg3XtEG3EM3+Ai4uVVHDD6j5
	 DaMhRZLa6zrMA==
From: SJ Park <sj@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: SJ Park <sj@kernel.org>,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove wb_writeout_inc
Date: Fri, 10 Jul 2026 17:11:38 -0700
Message-ID: <20260711001138.30784-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710051052.1839523-1-hch@lst.de>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 07:10:52 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Remove this entirely unused but exported function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
