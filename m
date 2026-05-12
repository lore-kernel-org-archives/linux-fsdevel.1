Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E925B0BF;
	Tue, 12 May 2026 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615429; cv=none; b=DEMWoe879ScdqBPEn9r97oltNmk87DDX2CwZ28+w+PGaCfxiwbi2A7ewsAWDslttDNtkkYFQ8SV+C5pILoa2mrXy9UBzssmCVJ6i8iQAA/w3vd5spDOTYNaeSA8p+EXikT4aRCe9rffLkPZOTw+x1T4Eel40YcP1hyvTvHzuALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615429; c=relaxed/simple;
	bh=xD5oHY2kBwY8+xhSB0HxeGN5kHhk+kjkFpw+L/n+UAA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rhZKpxQLYnc7pWSP7MkWvY5FaB+nR7WWGd5tpHLBRPZJzRRyIAgo62y4EJv/EFYSag6KILp9oAaHgUg/pSFRc+ginXJmwrm25rb7XhhmhNfWzjI2nbkj6ImcDgadF7Cbon3Iq7HxzxClzdYZ6r2EJL1Ona+8rNisl5qxfYl7wg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpFAE5+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpFAE5+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96E9C2BCC7;
	Tue, 12 May 2026 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778615429;
	bh=xD5oHY2kBwY8+xhSB0HxeGN5kHhk+kjkFpw+L/n+UAA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=XpFAE5+nOiJMuNkM76hyYbuko93QEpgS3ZrtbvPGqzoO51aFsMf3gQAm+aY67SSvP
	 Kh7sgIux7XQbbU+2EZPbRDbSDTvHoujyr4ZXFgeQDtQYaKiz/mggCEBEa7Lnd0Rn3V
	 vy5PXtA9xH1O6cC4zIPbYKWD7Ifv7IEV+aG+0iqgOPU2HjBFQzg6AXqlzOyThu09NX
	 wSIwRGI7qmnmT3aAy7DPi3XSFhqYVDnlReoateihdquedEWrEUVqygr90gCMm9uOqq
	 PSI4nFatWgAGB3sNKWReB9jSOPEogwbGkgemj3R+g5x921kwwc0jX9lA03pgWRczrZ
	 CBcT4DX9WZvFw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/5] eventpoll: export is_file_epoll()
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 brauner@kernel.org
In-Reply-To: <20260503085101.112698-3-axboe@kernel.dk>
References: <20260503085101.112698-1-axboe@kernel.dk>
 <20260503085101.112698-3-axboe@kernel.dk>
Date: Tue, 12 May 2026 21:50:21 +0200
Message-Id: <177861542128.846060.17132431592313870733.b4-review@b4>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=647; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xD5oHY2kBwY8+xhSB0HxeGN5kHhk+kjkFpw+L/n+UAA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxtzQmP+S5w2Yz16yMZzPTsusNnJ3MjfYH5zx4xfi7q
 HJt7MZ/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5ycbwT6Hk6MR0v/MVHpJz
 Y299ChQKfrSv1Pr8ohX/o7i8xe8J7Wdk2PTPRLu/8VYgX4N5Q1MdY+as3KmPRVfxupX3rBCaeO4
 BBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

# Add your code comments below. There is no need to trim or delete
# any existing content -- just insert your comments under the relevant
# lines of code. Lines starting with "> " are quoted diff context and
# lines starting with "| " are comments from other reviewers.
# The final email will be reformatted automatically to include only
# the sections that have your comments.
#
> Make is_file_epoll() available outside of epoll. This is in preparation
> from using it from io_uring.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Christian Brauner <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>
