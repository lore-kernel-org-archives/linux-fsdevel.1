Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA08634C;
	Thu, 25 Jun 2026 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782347282; cv=none; b=RgvDH50q8c0YxHyjmXeM25L7mE2/Fom8LVGSvrbxjw5aY9jN8HfK+Pe7aY05Qdgxj333sRJC3wKy85UP9EcL2d1GMs2EGfixztzlRfGD6/6iRdKtfRC3FEsc2pMY4L3VjBfJXgcMkVie71IaJ35ZQmGbQ+nF3LTQtZ8pg5MD2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782347282; c=relaxed/simple;
	bh=rTy5Wd/eLKaOIJKipO4+QFjaawJFd6CPpQksrhQR2j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sege6hRvAN6s6M0VqAIFkQV6JypzpZTXVV1V02HpjZ29zkipZQTkP58rev7Fq72FbkkleDVslljwkaqz0zSJZex8aiNEWkV+PhbHXMEAKyycLy/HVwk8NGjRVOMygO5r5vW+1trqcrOYYmjb1KpdP8Qrba+il9q0Z//luU4BuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH7yQxsm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH7yQxsm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783851F000E9;
	Thu, 25 Jun 2026 00:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782347281;
	bh=G2j8yE67H/DwH47l2u2y3HxJcEjscsIq3SIq2Unbn1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VH7yQxsmmHXxzNFpXZqI9MMa09EZNg8M9yW3KmCcj0TKRBakaThJKTiZIaphncxiz
	 Ax4k10BuicfqTw+s4gIxpCIcfU5EmaR1SZTmT83WgOtpmjcv9Ncm+HiFPdypx5lyvJ
	 +WlaJFvNi+LTXSq2Tuuu5xmFfRQhSHIjqsy+lsEZLeS7dv7HTPLLeguHg8oDkFiul1
	 g9Mbx3IRM+XvU0Cqih6BFTU917zcQ1NtAdUaVP65lxU6z19NX0ZYVI9NjrfIHknie9
	 HHFZ4Cycp34LjKYEmmRMOfFsNabEOaI5wo+7LbPGh/+ig+2kFzuDG4yRLK1Wn/kn2B
	 e79ZdWLp4pjWA==
From: SeongJae Park <sj@kernel.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	willy@infradead.org,
	jack@suse.cz,
	shikemeng@huaweicloud.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/writeback: parse help before importing drgn
Date: Wed, 24 Jun 2026 17:27:52 -0700
Message-ID: <20260625002752.96325-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624123514.7822-1-alhouseenyousef@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Jun 2026 14:35:14 +0200 Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:

> wb_monitor.py imports drgn before argparse can handle "-h". That makes
> help fail on systems where drgn is not installed, even though the script
> does not need drgn to print usage text.

But...  How do you execute the drgn script on systems not having drgn?  I tried
to mimic the situation and reproduce the issue you are saying about, but what I
get is like below:

    $ sudo mv /usr/bin/drgn /usr/bin/drgn.bak
    $ drgn tools/writeback/wb_monitor.py
    -bash: /usr/bin/drgn: No such file or directory
    $ python tools/writeback/wb_monitor.py
    Traceback (most recent call last):
      File "/home/lkhack/linux/tools/writeback/wb_monitor.py", line 44, in <module>
        bdi_list                = prog['bdi_list']
                                  ^^^^
    NameError: name 'prog' is not defined


Thanks,
SJ

[...]
