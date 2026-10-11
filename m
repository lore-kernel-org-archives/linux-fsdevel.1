Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9104E35676B;
	Sun, 11 Oct 2026 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744950; cv=none; b=r5g3BuarFFCK9r3JjcVW+eok48AWAaYRLvstbi6mC0XgqNW0hZrfQ4UU53X2+hWtCteCWCjaSgmji6uaVnqCHCzFUEZQ8opRAxPZrIOBMCrvxMI35hyYwo1YM8m5eIUE1wifGgHWt7od3athVJJS2zNx6EypJK0RC2LETWcvpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744950; c=relaxed/simple;
	bh=AICaXSSwbflJCI5kz780Q0B9PDyUAs/MpxyuhALtp9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H11V7cr7e3AGmXuRsgs4oFifEJsmjdfljusqRWFpe3bSOroWBZhT7tONGqjcgDqFoBSJ/nQtk4HALdTJeH5o1MCRnBoFlNjsId8rL9T/Krk5Bu8wWMHgmpiJAUFL4DrXYQw+iNPpeEF+/XG0eMZi9DtE+CtcFWCOXbKTksgM71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=HiwBKg30; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=rzCHXli3; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="HiwBKg30";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="rzCHXli3"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 9A1F326F7695;
	Mon, 12 Oct 2026 03:55:42 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1791744942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QiwgYqFdrZhXQrXzsN765LjWb+cNRzsxePPe13rYQfM=;
	b=HiwBKg30Jmn8JKpwm4xhDXhRmfEUoQ6UUKQukB+AHF7+Q7h+UcVsbJ+3IObZkSCLbIKTf3
	X8ikFUx8g0iHWpyQiZjUjztiSmoxuE/hU4H/Wlo8t5IdKHMqHHAPn+ooooazXjdra5MgEK
	zGAfKVBd0dphPzAOYXqe9raszc7atINZ3a44stglKpMzHsJwco+J2CR/KTkf/A7Qm84lGA
	tmtuGUedUJZPzIhgReQDNmMq5AI9A5ryK1yHzximsZxvcQefC3dhW+4vLPV5z1U/VA3H7G
	n3LR/zXcCbESPOfF2uOckFTS+hKiTuuSYa78kXYLZtMtihhJsQKL1WLQBIDkfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1791744942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QiwgYqFdrZhXQrXzsN765LjWb+cNRzsxePPe13rYQfM=;
	b=rzCHXli3Qjt1Z+ISwy3CsT+2zU1l+wv6t02z4lDTQiHFg5l/DZxHk1bsB27NSpqzukC/pE
	5pV0fOJvSyPBUpDA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id D7637E00134;
	Mon, 12 Oct 2026 03:55:41 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id C3B6022000EE; Mon, 12 Oct 2026 03:55:41 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] fat: allocate multiple clusters in fallocate
In-Reply-To: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261008020941.55784-1-matheus.aalmeida@inf.ufrgs.br>
Date: Mon, 12 Oct 2026 03:55:41 +0900
Message-ID: <874iesm5hu.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br> writes:

> Hi,
>
> This series adds support for allocating multiple clusters in a single
> fat_add_clusters() call in fat_fallocate().
>
> The multi-cluster TODO in inode.c is not implemented, as doing so would
> require speculative preallocation or an iomap conversion.

Is this to improve the performance of fallocate? If so, what the number
by improved bench or such?

> Matheus Alves de Almeida (4):
>   fat: remove cluster allocation size limit
>   fat: return only first cluster when allocating
>   fat: support adding multiple clusters
>   fat: allocate multiple clusters in fallocate
>
>  fs/fat/dir.c    | 20 +++++++++++++++-
>  fs/fat/fat.h    |  4 ++--
>  fs/fat/fatent.c | 61 ++++++++++++++++++++++++++++++++-----------------
>  fs/fat/file.c   | 10 ++++----
>  fs/fat/inode.c  |  8 +++----
>  5 files changed, 69 insertions(+), 34 deletions(-)

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
