Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84D5474F;
	Mon, 22 Jun 2026 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782097158; cv=none; b=i7Z7NCAScTMHSYCnfRtjipHdNIM81yCzBJfPx7WveHd13bSEmjJ2iaFNK1RfgNWITd1BMNQk7CJx2osNG1EoC6zAr4Kl1eO1x8vwIjTJWzPs5Gkf0WYHm4NoSDaYV+KBAVPxPfIZ7yRxSz2jcZ6e+CIbL5fhAtpe3/HnX3sWK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782097158; c=relaxed/simple;
	bh=d8LkBW2Qkro30f2BJQLwqWqVw50NysagpVzyB5AdHzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7sR9T0sernz5DfVGdaVlsbPxqeyh+NaVQAH7mGNDdq2GRkwqPraqbJ4R9Llqitrmbs/Tv7PRgMOK33hQxNcyEFrrYgJXKRJn5U3HK2NBae5U8d354+u0AcrAsBbDrslM0nHmgsZ/L+4RKnBiO8rD5CCNNhUEieT32/KfcTSDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=LnvtdSsM; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="LnvtdSsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=d8
	LkBW2Qkro30f2BJQLwqWqVw50NysagpVzyB5AdHzk=; b=LnvtdSsMY1pyYo/kq8
	lz2Y5z9vyzA+iTzg9BQltJyR2jC/uiTVXSRjsGJA1nE9B0K6k0EBWGGKeR4IPGKh
	kRbBi4gML27BP/XUHdo9Ztzka1AeSw1K/CYxQiqq/MM6YKheWdvLbjjaVzgThud3
	dxr2tTwWKfh5POCrkdj8N5rK4=
Received: from zhang.. (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPSA id Ms8vCgD3f0_hoThq71UBAA--.3323S4;
	Mon, 22 Jun 2026 10:45:54 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Christian Brauner <brauner@kernel.org>,
	Ziran Zhang <zhangcoder@yeah.net>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] FAT: Allow 0xE9 near jump in fat_read_static_bpb()
Date: Mon, 22 Jun 2026 10:39:53 +0800
Message-ID: <20260622023954.5719-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87bjev2kvl.fsf@mail.parknet.co.jp>
References: <87bjev2kvl.fsf@mail.parknet.co.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgD3f0_hoThq71UBAA--.3323S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIANJCmo4oeO-xwAA3I

On Tue, 05 May 2026 01:35:26 +0900, OGAWA Hirofumi wrote:
> ping?

Hi Andrew,

Ping on this v4 patch. Acked-by FAT maintainer since April.

Link: https://lore.kernel.org/all/20260412070109.5197-1-zhangcoder@yeah.net/

Thanks,
Ziran Zhang

