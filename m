Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164794;
	b=D0wArcndZ3WY49nGU+Dq/M8A4U3XAUlnKb1bLlRnu/sVyrzyoKr3mCEerSWKk4Xk2/+E
	 X6jGJZ5IXkmgdiWX3wcDwIAr4g6Tkr2UknUY/Cv4DqDVXIdDkob/I5fDOfaQDX3sK6DwC
	 QqGFIqgpRRx2MgHMMIFzwNOp+Wt6GFHHywK1dyz8V/KWWkVI2megxYFsT05Zyfh8qv/YO
	 Ysu5zvWR+qGk65Xgqo3BihJgXH/PBVHLxJVKRRpzukT+DdSLKDf98TyzdB3D17uFbHGtO
	 G066FvUjfd/ueFfIYUwdMnl1eCmBQJC0mG/96mXKQeFVVOUlYTjrOibcmmroo41kf1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164794;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VdnM+IqSgoywu0k8tUj2MjfonoiMjqMNEGteBCHtYOA=;
	b=oyMMSFd5w3MRklRhXr3/ggtNrABV0U5+TO+MWPNvqkmq+W4Ydw7PH1jjBZMh0LKb8Twn
	 j/xJFMtiEdACOimqR64kGFBrJ/lyhQQnCYyosBgqOJlYi9S7G79SIB60RHwOdN5qIyUYg
	 m8g4zdjzeCpyoxHSTfqzU0KbPaXMgRWF+qDcuVD2VVbxRiMNsBmnrLIC4IdXbUmqBlO9c
	 z+eLtyiyNuaeSFMLNiNKTfrjvEzKlhmPifdDsDbWHIDCYepNQa+HA1E5u/ym6fHAEGzes
	 5cdKE4ZKNn7MMyBh4Co+2o9tmSW6XC0jGyQv3+zNXzzfbcPiPNKsaJohixM+l1HrgaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfKEDvcM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B5606A326;
	Fri, 20 Nov 2026 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfKEDvcM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B671F000C6;
	Fri, 20 Nov 2026 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164793;
	bh=VdnM+IqSgoywu0k8tUj2MjfonoiMjqMNEGteBCHtYOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VfKEDvcMLKfY2sS2wvSu3JKM2jHN/efPT+k6jdsBBvwX9EcrNn9jBXd2rCKcNIkyv
	 HRW1pT556iA9gtdjdDYxi8unHgPCyyTR9do8jyvO11A5LkDxPcuhmA9lnbVpC7Sve+
	 bTDVlFAwKx5RfkrbXttP/t/zDitBRu1vvun9hhrthXrXXFehtklqSrXv6RlyvbRH06
	 qeS387n9vbQYOIb0/j0vCuXCL0NSWuinx51cRxbTSy3mov9i0GDyqjYMjhkSy2xnn1
	 WojgplVyfwfmG6+XplDJYQyW3XuEaVWhQwqDeVXayvOG7GYaNYlTw05i3oSSDmTRd9
	 Y2HDaquYKiLWw==
Date: Fri, 20 Nov 2026 09:53:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventpoll: check the event mask before taking ep->lock
Message-ID: <20261120-dazukommen-ruhen-fahnden-32e0d2201db9@brauner>
References: <20261106044624.278356-1-jiayuan.chen@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106044624.278356-1-jiayuan.chen@linux.dev>

On Fri, Nov 06, 2026 at 12:46:23PM +0800, Jiayuan Chen wrote:
> Check the mask first and return early if the event is not wanted. The
> comment in ep_modify() counts on ep_poll_callback() taking ep->lock, so
> do smp_mb() and read the mask again before dropping the event. Wanted
> events take the lock as before.

Then this should update the comment too:

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 133a764..8a564d1 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2029,9 +2029,8 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * 1) Flush epi changes above to other CPUs.  This ensures
 	 *    we do not miss events from ep_poll_callback if an
 	 *    event occurs immediately after we call f_op->poll().
-	 *    We need this because we did not take ep->lock while
-	 *    changing epi above (but ep_poll_callback does take
-	 *    ep->lock).
+	 *    Pairs with the smp_mb() in ep_poll_callback() before it
+	 *    drops an event that isn't in epi->event.events.
 	 *
 	 * 2) We also need to ensure we do not miss _past_ events
 	 *    when calling f_op->poll().  This barrier also

> +		if (!(pollflags & events))
> +			return !(events & EPOLLEXCLUSIVE);
> +	}
> +
>  	spin_lock_irqsave(&ep->lock, flags);
>  
>  	ep_set_busy_poll_napi_id(epi);

This also skips ep_set_busy_poll_napi_id() for unwanted events now.
So with busy polling an EPOLLOUT wakeup from sock_wfree() for a socket
that only asked for EPOLLIN won't update ep->napi_id anymore, e.g.,
after ep_busy_loop() reset it on timeout.

Is that intended?

-- 
