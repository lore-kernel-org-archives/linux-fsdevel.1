Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022638;
	b=aHH+5nb1hiiOgDczAaBeGzrY8SZxGts0uNlzA7L/rvSlyMWVSzFJw4FrDhXAMCWY48P9
	 M2g+BB4JVh4kwGEbGab1UstNhI1XZNayCKU+03VwK0yn2ZkLu8Wnn/zQ+HPgS3ncNFWIY
	 mROjoknKqkVqG6yAM9VxR4VHMKZ829/HuWKRm9tA0K7ZmFAdD0UJKUE4eJPIHe2FroB+O
	 wSDyVmH6oyCl61S1jtCzfeWrzkfmmbt8gvH4XQ5NbKQSzlwDaRywL8gt11v0nrplgQ+5y
	 4R2UWvFvLIv8HBR/9SA+Zf/B3uAPoE7+R1XqyUIV7IsS/Ke89OX6jquKppLjoXUuzaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022638;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2RksEooRSQy8s2okC3wauXTJ94u3NPIg5qK3nWOQ/to=;
	b=ybY4FbKtsJ41vWv+oCqEso56JiNbbspJ71+uR/wmiNre4D4sAWvDAL1ixcdopRrqPSCq
	 nJ3hGhl1QVwMAli8Fj5r4iMbI/jnbGAELu9z1xYmFv110ND0kyxvl+3LYoyaRYKH61ohz
	 8U/CIO1s1OTKPoIwF9LoSsWpoeA8oMvb/cdvD9KUZofhpCer6V7D5QNiQO6z6Suh0JH6b
	 AYsBCZBX/AbMhJNIWlgElwdSyT6zsB817NKTZFFWjGb0bUKGH+mkz4VMYJyyaku+jnY8g
	 ELGYy0WgpXLjMrt1ZmtAYs8ctFGnFY4ERdIhnT+w0500B1RRaiwZzCPJtLMV3gqtwgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzAdLeyM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC0606A335
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzAdLeyM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059B21F000C4;
	Wed, 18 Nov 2026 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022638;
	bh=2RksEooRSQy8s2okC3wauXTJ94u3NPIg5qK3nWOQ/to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DzAdLeyMCA0IjTXMenv5yUHQK9upvBRXD0/ev8C9zXTwKQ6RGLPFwCnjduWmzTfQe
	 v21/QKXCBz41YNkNxWaVYQAHFRhmoXQA1xnSSvNYhq+5WhuWZ7XNI7zW3+c6VR6lGR
	 pBVootEX/n50Wtfdo+x+arPW28e0xXin2GYylhv1c5yVdSeWVdjMyDzMfzt+SLDsvn
	 2pENgB4hbtd9G8L0K/fU1rBQq8eioycTSYdG4OKfvxfBVS1UCkGjKFdldoVR/DcXoi
	 RSegnFC+91vRi3gAEDW5qE6c9s3xmbo1yA1p5RP2AdqaCDtJJu11dryjnSjdifxf7b
	 laenvWxknMxcg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5E770F40066;
	Wed, 18 Nov 2026 12:23:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 12:23:57 -0500
X-ME-Sender: <xms:Ld_9amQOu9lfEQ1w8TuLhxzrxXO-oNmFGxSm9S6Fbw4877dVQ3syIw>
    <xme:Ld_9aqLiNROPBSKcP6TqXh5mCEGXcXSAEqV5D5VrcE7C6HEYnDsR3pSQ7_2UnsuYC
    2OGqFtc6svNbYhQF3dBvutJ4YAfwHwA_mCNq3D_UKXaC_A0s9zgCeY>
X-ME-Received: <xmr:Ld_9av3DUnyQmbqwEcvzWSlvRcpHU0vHSlmnq6CyudlWXfdf2SvUZ7F7mQZDuIuS7gzPvcM0YDNF7XjuV6jb9f-AFcP-qAyJ>
X-ME-Proxy-Cause: dmFkZTE+Ncdsmq9B/GZ/+WChSg2xAz+aE3Ph6S7mbrG1mDLu84NH40Ak7PjFmaYnj0T016
    FRJtDawBaIJ5zps2vaNYfmOc+AjKOloVVfD6S/jYyZePRUnKfY3Q74rsarXJtajD0dYNI8
    Yv19s5Ga7iCGJ4QB6mx6FaIcZhdsieMALloXLuhaIoHpr2QaCOEnaNCEhMoGhWFDavUhVo
    h6/ledDzrALW33YNgQEq5ySdRf9vSAZ0RTMSGntUqqJX91G6xkjoAydnSGnu7RyWyYHRya
    IAZTk7KCvMJ2RZCZxjrNNv6iY3kLG6g46H/XIYs+efKk6I4aVAMGQMrL4BkYIeG5BFaKrR
    cnT0gh66LPNsDS6Tx+YTUZHvXrqHYITJA4ylzqaUfm3w1E2/FF2ih2A249eHvhO6tWzpac
    V1Yjuxur/dehwODwMWI0jHV5JkQ+hCxwZLyyTQNKHI0QGtlkGCXAaQMdz4SiACCWLxAzu6
    0Lbc3w2gBShx+DxuK1SY6QT2U9q932VEQgvo39gUOyOUxy30rytwa0Mnu6OFvAm3yHXrsu
    XEL/NgWRyfLeCHGINJPdHmlIdMUinEIKtboQ31an8PplshkX/mKK2+I2Q3GxqfCTQQqlgA
    glZJ7ZgSOdiCP7cxmCZRhTmQffwunyGmp0S993vXr1YKE5LU566xbas3du5w
X-ME-Proxy: <xmx:Ld_9alJX6h40VeSsorBAJuKbawe0P7q6FL87kaI3ihzIIXG5e9fCUw>
    <xmx:Ld_9ann7nFn-SIJTP1aaqBbq16acvKpGKi1Uh7jYotguYpvah17fSg>
    <xmx:Ld_9arN8YL08SKNDokiSHaraFCWJ-jbhhSf4wCzbDg4os66NEYkLxQ>
    <xmx:Ld_9auz32_97lCeyOqaOMoNffeG5qHwfKEh0jlpkAlCYKrzRjCRr2A>
    <xmx:Ld_9arlIyGRCiHI7dZ6B8XbaY7UyBaMbgFJdttPJzPfe5feEEx1_VxiC>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 12:23:56 -0500 (EST)
Date: Wed, 18 Nov 2026 09:23:55 -0800
From: Boqun Feng <boqun@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gary@garyguo.net, aliceryhl@google.com, lyude@redhat.com,
	daniel.almeida@collabora.com, work@onurozkan.dev, ojeda@kernel.org,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, tamird@kernel.org, acourbot@nvidia.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] rust: sync: add WaitQueue infrastructure
Message-ID: <av3fK2ybemq91riD@tardis.local>
References: <20261117001507.1611984-1-dakr@kernel.org>
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
In-Reply-To: <20261117001507.1611984-1-dakr@kernel.org>

On Tue, Nov 17, 2026 at 01:14:41AM +0100, Danilo Krummrich wrote:
> Add a WaitQueue abstraction wrapping struct wait_queue_head, providing
> wait_event()-style methods that take a condition closure directly.
> 
> This is needed for a (subsequent) DRM patch series to wait for in-flight file
> close operations during driver unbind. The Tyr driver also needs it for "CSF
> firmware responses and other GPU-driven events" [1].
> 
> Convert CondVar (and PollCondVar) to use WaitQueue internally, removing
> duplicate code using WaitQueue as the base primitive and add
> wait_interruptible_freezable_nonexclusive() for subsequent binder usage.
> 
> This series is based on FUJITA Tomonori's CondVar timeout conversion [2].
> 
> Changes in v3:
> - Use Delta<Jiffy> for timeouts and treat negative durations as zero.
> - Add might_sleep() and caller tracking to the wait_event() methods.
> - Gate the WaitQueue KUnit tests behind a dedicated Kconfig option.
> 
> Changes in v2:
> - Drop the already merged workqueue patch.
> - Make as_raw() public.
> - Split error types and use bindings constants for direct C calls.
> - Avoid condition rechecks after success.
> - Check the condition before preparing a waiter.
> - Add non-exclusive wait support, including a CondVar method for subsequent
>   Binder conversion.
> - Handle zero and expired timeouts before interruption; extend KUnit coverage.
> 
> [1] https://lore.kernel.org/dri-devel/20260721151423.444175-2-laura.nao@collabora.com/
> [2] https://lore.kernel.org/rust-for-linux/20261104235929.1282640-1-tomo@flapping.org/
> 

Nice work, thank you!

Acked-by: Boqun Feng <boqun@kernel.org>

Regards,
Boqun

> Danilo Krummrich (5):
>   rust: task: add safe schedule_timeout() wrapper
>   rust: sync: add WaitQueue infrastructure
>   rust: sync: convert CondVar and PollCondVar to use WaitQueue
>   rust: sync: condvar: use task::schedule_timeout()
>   rust: sync: condvar: add non-exclusive freezable waiting
> 
>  rust/kernel/Kconfig.test    |  10 +
>  rust/kernel/sync.rs         |   8 +
>  rust/kernel/sync/condvar.rs | 154 +++++-----
>  rust/kernel/sync/poll.rs    |  19 +-
>  rust/kernel/sync/wait.rs    | 546 ++++++++++++++++++++++++++++++++++++
>  rust/kernel/task.rs         |  23 ++
>  6 files changed, 664 insertions(+), 96 deletions(-)
>  create mode 100644 rust/kernel/sync/wait.rs
> 
> 
> base-commit: 60fff02883397e17439c16f0e72b2f8c5f6eb791
> -- 
> 2.56.1
> 
