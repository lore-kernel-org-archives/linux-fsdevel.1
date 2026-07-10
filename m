Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579CC2E762C;
	Fri, 10 Jul 2026 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693390; cv=none; b=nwxcCieSc8LgLwiFn/FRiEDVP8bmMzJs/r9XgkT3mnpO0J8VWhkUqc9ZcWp6ATAxZLgwD9aY3FGWC7HA2ybFCHO3H0fjBGqMv377zJ4lCT4ALGjJuVx4BKSxCWBlMtelw6U7UOVZfUqdSd1jHv/TlnyIqxkjXyOszFtmGC9rCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693390; c=relaxed/simple;
	bh=oOOKiOVebIlobLMIAKruzvkluU8pmlBRpfWOBD5+Bh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4sbw1q7puWFISLD0LDcLIwNc/siAPS6nD1zHdU0J5pt66bxbNASNStBmGSSr+9gny1pb3CbIuAMTWdUW+hgqbxOLwGW++D5bAvr2xv6ZpOap/0jFfwOr8iwoDw9vQ8guapqQUVJIQl3cTNeklXrhyUXs+mGFOl2yKnAHX7Rfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDk32fZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDk32fZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576341F000E9;
	Fri, 10 Jul 2026 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693389;
	bh=4zyigozW2XJuMHxUx1LRwgrRCSh1VLl67e/E7w+QZzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hDk32fZeMgzmPnGNoP6HeCOWM4GRx0wvzZ7PStQ2TSwlTBXM5ez/tTQKGLxRTl/4I
	 QkBc0RDv0nD0Lc66yqvsQa0pHvXXNbHYnxrULdE6sqiQXHrOs7CEDy4i0shhDrRvhL
	 AkOBE98GZT3VYpNtPaq2bLKNc3tGh8h25U95a8qCstIttnk3MdXOHiNU4NC1S8pJiI
	 5jF41zw/Ud5xKxk0rB4ndtLsriEMDnqTuL8nXJEn1D8EQwyMsqxoWuiWeg0k7MxwCT
	 PBZFuZgWs6DtmzAVLAZcQU9iE7cf28j4wPp4QAE2BoL/qigac0hAC9jFJl+CkC28Q2
	 C7OtqdLqj+rXA==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9402FF4022A;
	Fri, 10 Jul 2026 10:23:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 10 Jul 2026 10:23:07 -0400
X-ME-Sender: <xms:SwBRaiG8_-41vVevjFBAF9twrVMCIM177GgS7Qhb3Su_cbXbRCXoZQ>
    <xme:SwBRaktXb_Sy-5H8fPfG4CfDLbmSbp4m6H_usVbOz5pIVPcJE0ok3Y4eDV6zXvXgd
    ssPgrRJZArJUVkzeS6NMxoWJ3qb-sB3OsA6gAxsz_vHyw4egfky>
X-ME-Received: <xmr:SwBRalZMsDpR2KNxktXhHL77Wv9F5ArDYWNayvgO4t7tkwzNnDZPK4aI40phtlKYh_YyfNHGSJ7r8uyiz2gMnJ-lkGGxlj6k>
X-ME-Proxy-Cause: dmFkZTED+bREg08T9XRtTY12MliPGRoIPw3CDmOu5rtNcTMSDW3GzkCNIg/FtDVssJV2a1
    dqIVfYBHtJxne3Yg7lMoliBcR1KtLbfJTL20V8nZnHSpC2uvHsMhrdmObVa4NP+QyrIO8i
    Kvfc9PEF91GQDLPB1BM1I4m3THqDVgx12CjGKgZ207822CtpBjqbcv2y1z4F9VW8lz4uWp
    HS8P5V6kYDLoJVU2+mhw3BNNKalT7V6VlJwc2n1O5UnnStNipbZUYO9Hqu7kksb9Wt53wN
    egKer428tG4GeLL8CNMh+JtV8VRgdudjhMaJ6uWyoS9HjnkKZKdayKw+o/fp6RectpUcFu
    HzHdRFhUl1b/VgOZyjhTKdQjURFHr+ntHCe/sW2NXyovVe/kg6aKAI1L/eHFbqP7r5tgkS
    3Ozn585tLvrYaY93qnBcZ9NR8xo4wMzv6aKPrMoKXIY7hnedfbryeIEmygKwl6xD34B2cz
    TiGcx4sHviBU3Y/zdbIry/pUllz9/gnJNk9i0DEt6x42mu0AUUKkwC8LM7JOef9rSuhstb
    NMvg/UvONs3u+VqdKJbozNcJCTw9q98WADJJHR/DmsmxJYpPsmsOkePGMJIpKn6zO0cYf3
    pMZqnwGbQDjcYnJq4OJzCHHnEPJD5lA0l6i9Bj6ZpDzCdzUnGWFCO9B/Tanw
X-ME-Proxy: <xmx:SwBRakV75Fich9nIFKzlqhX8VXGubIWJOCDI8aMt6LK-2P94f92juQ>
    <xmx:SwBRavKDSq9It3Xrew99PBkM08usLOQ4fshgYETi3hyZ6_-1RNCWZw>
    <xmx:SwBRaqH3QCkJEt5Mp3vqyXZuw3en7HgeXA7c18vx3fUL2SpKXJHVLg>
    <xmx:SwBRasxnf4c2ooVO5Gqp17dng1DCOFFedDm1wcR0qdxCRfyQcSNycg>
    <xmx:SwBRavixRuVbYTnsJ_zNw4-8UpTNDqZCc9FWwh4DrIDeVI_o-lcCd8Gk>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 10:23:06 -0400 (EDT)
Date: Fri, 10 Jul 2026 07:23:06 -0700
From: Boqun Feng <boqun@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>,
	Christian Brauner <brauner@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] rust: poll: use kfree_rcu() for PollCondVar
Message-ID: <alEASpx0UvbYnxqy@tardis.local>
References: <20260707-upgrade-poll-v6-0-4b8fae7bf1d9@google.com>
 <20260707-upgrade-poll-v6-1-4b8fae7bf1d9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-upgrade-poll-v6-1-4b8fae7bf1d9@google.com>

On Tue, Jul 07, 2026 at 10:43:12AM +0000, Alice Ryhl wrote:
> Rust Binder currently uses PollCondVar, but it calls synchronize_rcu()
> in the destructor, which we would like to avoid. Add a variation of
> PollCondVar that kfree_rcu() instead.
> 
> One could avoid the `rcu` field and allocate the rcu_head on drop using
> a fallback to synchronize_rcu() on ENOMEM. However, I'd prefer to avoid
> the potential for synchronize_rcu(), and Binder will only use this for a
> small fraction of processes, so even if it changes which kmalloc bucket
> it falls into, the extra memory is not a problem.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>


Let's switch to a better abstraction like RcuFreeBox later, but I don't
see any issue of this approach in general.

Reviewed-by: Boqun Feng <boqun@kernel.org>

Regards,
Boqun

> ---
>  rust/kernel/sync/poll.rs | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
[..]
