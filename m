Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35AA3148C9;
	Tue, 25 Aug 2026 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637076; cv=none; b=kEcu5k2FeDQOxo24d1jBuVisxcYxMCxGtFTv0szrp75rtXV2gbeFwuPksgeBUudqSlKV3engpwIgOV6W+zNf9QxsvRUkiFLjYm9Uljg+JzkLIZpd+uzwEJIywdWoIvMK+4//9kiWrw4j5ZuJUBrbLJswf4g6Vz1z0+WzpDqdYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637076; c=relaxed/simple;
	bh=GXRDjZvyXviFQ1q07wdlta5R1PnPjftf7fjiyblzc0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXza1V27GQ1To+Y9otZ6dnfxZLRyW6JZbS87Wv091FzwlPJcHBxZ4O2ScqajLtmNnPvJTFr9TFqRuF9tI7LA6Dvujzex2IRe1cXghcxuOtN37/KnwZG4p5fhMqHWK13u5BYNsKGEDFNDsD4NRzaHqenFcZwaXjLZEEXMMSZ6Y0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aQW2A+qT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aQW2A+qT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xe07FiCWfltz8tvcbhP1SGjcJiiYGr2DVatqGMVrJQs=; b=aQW2A+qT1JvGVzEu3VGAzpxDsk
	6z7vawl28tnzP8ieLmXbSZvmR6YfIIsUvevPshMlaR9Mn1B629ThORjXx5GAOil3TLJVcOFsn3NuU
	cBJTqsCh2/lQR3ltEmIJl8ljEzR3OUqUdg4almDagjqyUOQDJvaDTq0Tst75YlYTKQnHPPFFSNxi7
	T5hgN6tkn+T0rvrqDaE7ezBU+BUpAiJa/JejA+JFaAilmiuhiX465EEa/Eu1oT7RlVwQbtbLlUohJ
	UyebVfS1zR/NBTK3xrON24b8PSf0zgye9vsY79aL9PjWfxBwDB86SVIgSRyQp/ffVSFPkDc8lmI7r
	c6+4jZCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyk41-00000000CiN-02xm;
	Tue, 25 Aug 2026 05:51:13 +0000
Date: Mon, 24 Aug 2026 22:51:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Timber <dxdt@dev.snart.me>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fat: add noflush mount option
Message-ID: <ao0tUKyhsm1wNYCx@infradead.org>
References: <20260822173732.10230-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822173732.10230-1-dxdt@dev.snart.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Aug 23, 2026 at 02:37:32AM +0900, David Timber wrote:
> On most distros, udisks manages users' removable volume mount requests.
> Udisks is configured to always mount FAT volumes with the 'flush' mount
> option. This is largely okay for populating directory in small sizes,

No, it's not.  It is an amaingly stupid idea that leads to horrible
performance and flash wearout.  I'm not objecting to your patch, but
if you care about the usability of FAT volumes in this scenario, the
more important thing is to fix this default.

