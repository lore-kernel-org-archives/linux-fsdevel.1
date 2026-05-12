Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0225B0BF;
	Tue, 12 May 2026 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615433; cv=none; b=IWK6ZpqNL6DRdqgBmiEqsuervOO38pPlywbt4SomywOxVOYwG4SEw88Srb3/pVhk9bRhgUQQRA2/Foe7IR0FDa2ripR2Xx6wuWhJ7LdNdrd4Yk7dStIo8nrBTpeF9ummidmfZyBP4OSfvBa2cWOzXasyrXDo+HoGvUmFV9fk/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615433; c=relaxed/simple;
	bh=ueTjcatTsr99WKN5k9sgqczsfjpovapH2vxvjrhe5gg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rmyoGkKFqAcJw/xKz08O8UXjc2a30pIypn0F8Im8sHTI0eCHSG2htVR9hErm/ZX6EEvjSQMqMdh3WGjhdZw1b/nv+PiWJWjA+WpK3nhmUbwRbT1Rlj54NNPPg/OlBDETxsQjgS+tYpBMA0762kh+RNqHxp7IiCGloYDWOCvHyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjNWo1WT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjNWo1WT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB934C2BCC7;
	Tue, 12 May 2026 19:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778615432;
	bh=ueTjcatTsr99WKN5k9sgqczsfjpovapH2vxvjrhe5gg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=sjNWo1WTd9P4KVvbpXOhBxq9rnE2qnOGTKwUMQRthj5YcgX/L3ZeqCyEMxmxiYYPX
	 Vw5uw/vqgvFh+7xX2XanzGBgKjIoeNlNQHEAiWj0E6iP02A8cAkMGtxaJoq21fjA0r
	 QpP7urDW/girfNqh3gV79EKIsvMLc0KQqdt1KXOOSXDbCEaS8ZtraEnVTBh9EpSha3
	 Vv+P4wK8S518Q3/OsGEMumpPhdsI7pF64d/lZdsL3tdF/roKuS47t4lKOKNdO2EUJR
	 fcJBOEYxvXXUuwZI8rHpwXXYP9BqbIblbyrrNCB91SQQ85jVV4QziF/Yz03o3wAYhW
	 zxM5xo/DeEobg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/5] io_uring/epoll: disallow adding an epoll file to
 an epoll context
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 brauner@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <20260503085101.112698-6-axboe@kernel.dk>
References: <20260503085101.112698-1-axboe@kernel.dk>
 <20260503085101.112698-6-axboe@kernel.dk>
Date: Tue, 12 May 2026 21:50:21 +0200
Message-Id: <177861542131.846060.10743549776459529700.b4-review@b4>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=708; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ueTjcatTsr99WKN5k9sgqczsfjpovapH2vxvjrhe5gg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxtzTOKGrZMf2CdM3P/c43NF4eY9zb+VLptdHR9W2K5
 77ubZ6o2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARR1VGhmZz85X1ZbbG6RvX
 sPDKy1pkuiUF/04/+UHjsXwM+8HlnxkZ9oYe/ej+Ov7Azr9h/5Zt4975wXud0ctQQY8bfZfe6vo
 +4QQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sun, 03 May 2026 02:49:16 -0600, Jens Axboe <axboe@kernel.dk> wrote:
> diff --git a/io_uring/epoll.c b/io_uring/epoll.c
> index 59cd4f009648..42057aab9124 100644
> --- a/io_uring/epoll.c
> +++ b/io_uring/epoll.c
> @@ -62,6 +62,9 @@ int io_epoll_ctl(struct io_kiocb *req, unsigned int issue_flags)
>  	CLASS(fd, tf)(ie->fd);
>  	if (fd_empty(tf))
>  		return -EBADF;
> +	/* disallow adding an epoll context to another epoll context */
> +	if (ie->op == EPOLL_CTL_ADD && is_file_epoll(fd_file(tf)))
> +		return -EINVAL;

This is the same pattern in epoll itself.
Might be worth also adding a tiny helper for this that both codepaths
can reuse.

-- 
Christian Brauner <brauner@kernel.org>
