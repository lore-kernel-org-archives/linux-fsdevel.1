Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234738;
	b=tIGBPgRAy0YeKJBKtq2hJHe3CC0dZrij/EpAntiPUngd5jxgLXyFi5vz3jAxF+22tO7S
	 MRar4dXCZH2sKGAS1gss19YKSW0gKAEhL4F4diz4XDmZDvhGsnFzNCVynSFjuuFF3eWY9
	 RiLFHOKfc8YuvcLlBcbZk2Lb3QZmzbFAIH5dwyVYigm92jLwF9gsFT0aribqBy17TLtUu
	 Pe+u+39dAYexHZsdk8BfDh+xatxzvA/wO41BUjPC8PVNpkjbHU4FKa0FUkPKBeMm27W7W
	 GcPYDXyQEUQxfrfbGDJ8wRSBmrwHhRY1qzsmGxDqLcmfgc8a3T1NzoBQ811hUTm7i9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234738;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=hy/assV2qCh/Fr1BJVMQll7/sc6E6wbrngW4FxNE0Xk=;
	b=YI2dKR2xs+wMIX6ANiTj9//8u0HwQ+ZncHo/Wp2JTqmVHO1ACJulLbMmgc3CAuByrzRh
	 G2MjHZy7H3ewOkECToe13FzHfpnCtYd0IEy4akThPC2Rsw+3UgdcxL1ZI/8Uy1DJ4lpIk
	 cW33SkoRWCXXfWtqslB280UMS7XdxPQt2DGu4QK7lF9jArM01cNp9+zObdfJ1FdIvYlgt
	 VepTiMTmalATngJGICB6iEDilGK0WQJh+mlnSNg9js+QSEhG06D0yD5z4tibEIwYJZrih
	 kyYlUhVCUeWIRfbclz5yX6Fwtp/XQGFezLwd4pob83mOytVATJvXg3Uh9LZw64zA3iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="gX/ki3el";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB989606A325;
	Mon,  9 Nov 2026 14:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB989606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=gX/ki3el
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hy/assV2qCh/Fr1BJVMQll7/sc6E6wbrngW4FxNE0Xk=; b=gX/ki3elYmC3UDvKyPcEjFv5xl
	shbpqoOj23faKXZY3r2JeP5Tv4saQeb5MAhUWWsaCX9yhkA8bWaWzKmuuDyrCUew2449iqyUOIFfK
	IH32KerSQioGRYuVkTL5IGRsh+AIlMNq9151SL2E1nZEsnTbWOvVC3sUAPM2W9qizkuhVyGbLvKGy
	NxmhNrwiQtWuLm5fYNG7sf/AoPDcIK73PloKTNS7JYDcicTt05ki+nzfykxIU1Fd6l0vsvEYEmKJ5
	hW7G2FhYTmhQNt0JfuncM3FEFURQqeNcmxtrOLMbpJzMNOlyHtdkdAnbEXnsoVHIbZ4G1/ZWAaRHg
	7nDV1yMw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQQPn-00Bgj2-1X;
	Mon, 09 Nov 2026 14:32:07 +0000
Date: Mon, 9 Nov 2026 06:32:03 -0800
From: Breno Leitao <leitao@debian.org>
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com, Ran Hongyun <ranhongyun1@huawei.com>
Subject: Re: [PATCH v3] configfs: fix slab-UAF Write in config_item_put
Message-ID: <avHZTuXp_WatC5nj@gmail.com>
References: <20261105165055.362-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105165055.362-1-drifabdelmalekmohamedsaid@gmail.com>
X-Debian-User: leitao

On Thu, Nov 05, 2026 at 05:50:54PM +0100, Drif Abdelmalek Mohamed Said wrote:
> v3:
>   - Removed redundant null assignment to parent_item

Applied to for-next, with that assignment restored, so there is no need
for a v4.

https://git.kernel.org/pub/scm/linux/kernel/git/leitao/linux.git/commit/?id=c971fd2d102e7d081a03c0d2752afa38b58ef5be

Thanks,
--breno
