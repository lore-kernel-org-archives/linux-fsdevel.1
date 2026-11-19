Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115273;
	b=ZaVKqj4vzhIQZ+yWEpApqK/IPzFIAnH6RMwptYv9huNwLr8Z9A1TevvK+Zmh/WBuV/dA
	 rYff1N9r/L539+IV5OJFlXvPFeAkeUm/3yn7PJ2qb04qWnr/mQcUs96Toei0b0sOYqL26
	 rq2y+g2U75ZB1WBlzB3KsM+hsDzhAN9HyzDBYEoMmThvVErTkUU9Kx5iKPXlRcyqCdWzs
	 OCScfjaDY/+h7N5nt9mIfxdmK5xaXzWYKJKEsPm3hgiOm+/PwNlyW49brWkc7WSFYdTjL
	 t25ux3ZbE4bXJ+1grJy+UVk5rp8Wxju+ZBgH7U0KYpGg3grZBxXxsB86md3gR9ZGGmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115273;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=ia1hpCeyTrss1QNMw2+VU/RxLyalin7koClx8xuiz9w=;
	b=VsaYrHs8NFjw+Gv9CwQzGolye1y/d4Drnv/UN/1cbYBqiHgnZzha87vC1hAKs5dQ5EFC
	 mlIGZAtxw4y7EI5rHlAj4JitvYmK5D0KjfoXBo2Ixc0IDklrTy4oRRTtFA0iTLmeO1Pj9
	 bc/1Dr5/82hfmfsVW8CCOlSnmBN3Tww5Vc0ab5M9FbapmrQpEyl4YI6JGiQHp2vpnpLlM
	 8o3yiAktCPISX4ON5N6N/pw/lol10innTrdyYGRRUhJBTs0a/UFRVW94MmxLnCWeTa3UP
	 qYPQrEt8Cd5J9JAiEvDATEnQx1E0Fu+1kb8i9uZ2kx1lomXMPFz+V7HohMIqVD+myxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTF0k7+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D0606A326;
	Thu, 19 Nov 2026 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTF0k7+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E841F000C4;
	Thu, 19 Nov 2026 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115273;
	bh=ia1hpCeyTrss1QNMw2+VU/RxLyalin7koClx8xuiz9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YTF0k7+1IR2VcxE3Flwbk89wG+vTDkWK5bARD7VzlQf2EfeoP4pz8rwDS6yngP0Du
	 1cp+DZOqQav5PE12hMgEjQ6gWD6r8CxYq28VcQr0m7hpo/UNcgVqPIo81ES3V4GEa3
	 r9kV1o52g35yd/LB+mDmRDzitYj+ok/oIz/Jc/+W9Mou/aHaqGIWnEYwxPdZQrfZQP
	 MO0fEYcBm5veugsLGnC6uUYHNshkw38IeO78/+VEP5p2o8lTZDXrDF+puzM5NXBmsj
	 9QKu9ogGebyNwnZswme2ytmNLOf0QaY2DS2haAmsba+fBQKdZmF9xHa3zQiEGbMaXl
	 iNlXpKRw5/6JA==
From: Christian Brauner <brauner@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Ding Feng <dingf3ng@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261119031026.7985-1-dingf3ng@gmail.com>
References: <20261119031026.7985-1-dingf3ng@gmail.com>
Subject: Re: (subset) [PATCH v2 0/2] fs, zonefs: ignore RLIMIT_FSIZE values
 above LLONG_MAX
Message-Id: <20261119-postkarten-unmodern-gelichtet-33b11d4b1d37@brauner>
Date: Thu, 19 Nov 2026 20:07:49 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-04696

On Thu, 19 Nov 2026 11:10:24 +0800, Ding Feng wrote:
> generic_write_check_limits() and its zonefs copy store
> rlimit(RLIMIT_FSIZE), an unsigned long, in a loff_t. A soft limit
> between 2^63 and RLIM_INFINITY turns negative, and every write then
> fails with -EFBIG and SIGXFSZ:
> 
>   $ bash -c 'ulimit -f 9007199254740992; echo hi > /tmp/f'
>   File size limit exceeded
> 
> [...]

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/2] fs: ignore RLIMIT_FSIZE above LLONG_MAX in generic_write_check_limits()
      https://git.kernel.org/vfs/vfs/c/3f6eaa87ab42

