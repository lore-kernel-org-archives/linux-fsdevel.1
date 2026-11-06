Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975618;
	b=Sc/MfEx4oGrEXlnCtWYHHVi/XLISsYzQthy/UeslXdWDiYEx1aKnjcxl1CJk/3w51ZWm
	 1rpHCRoDwRh/VnEYT5FUM8O3sd0Bvt67TwcxarGNcwoi7YeJ2D2l98LlBfEm9rf5OwmIk
	 3sMsfg+Pr7e1E8VWShaznt94YOrcrdx07Op5rilOFnzoN6tleurqUOyKha0+tfbWFj6P+
	 YDuxsJQuB3tHx1hrlSM2w7YciK18aYw73yBQXBLt2o/SMDN/rnB2MBxj/CtzTBlokHkWD
	 wlygEjXlAc7VM0BA4omxyGQ6XcVJn4inIj92EolCcRrLW1QIllT2q/qahr/VMTy5+ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975618;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B4XNy3L4DiS0VOgFFaGkN3FHMYkcb41nJ3LD6BrmGbU=;
	b=f7dqSJ6t7P91dnGUJHvyOZ6RyZm0ym2Z6o4R214QSj0lt6j/WWz1xpNQl0RvWgdQNUVx
	 mWajd4x4csaq9qYSDRYH9IBTKpt2lpmxgItFju2g6tJqOllh9wQCo22AMLlu3TZ4WWKuc
	 qTYc3FzFvYSytqSW9m6lVapVcmbdt78wgpSWJ7GgZAP//Q90XWxsK1C40gGSO/fMbHTtf
	 2i/7ZI7h/RMD/PdcxHuzkvKS3LOqpM1DS98HUkTOP2oEtCRAsEbZH5wn1XZ9d0RwLs5zd
	 G/S74qwZ6VjBngdr9Izh1MdLNXvPNAAajeFQ2iH421UIS46nyxhVV3VxLN//F0iGqkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWijCGZq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658A606A32F;
	Fri,  6 Nov 2026 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWijCGZq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256061F008BF;
	Fri,  6 Nov 2026 14:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793975617;
	bh=B4XNy3L4DiS0VOgFFaGkN3FHMYkcb41nJ3LD6BrmGbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HWijCGZqhbAtelgjD3VeCTRsVo5RpMetPJUJzJfFZb7ukTzIUhytNQCnDzQC5oCEb
	 kFmfykcy67jMPtt6BDKa7LKY4nfxvigtODakXGwxr5JEJxkJQhF4xjQplEL/IGUriM
	 beyLO9UuKSd1RfAcrXovF/QkWtP3/h1EHk1NOlw67NBAXAzs1ZuPjT4J9iUZayYu9+
	 2sdR/HJqkFyfdQqw6gqWlaRHuVwT6kIe1kAHDWUZ+LXw3Vg5syw5B4I69a3iY+1Zyw
	 xrqltBsu9iA+143EinlDULKk2PQjp5s7GwyE7pVl6MGBQ2Ietx+sEvbeI0Hj5mMhi8
	 tZ90sNP+swCqA==
Date: Fri, 6 Nov 2026 15:33:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, neil@brown.name, 
	cyphar@cyphar.com, jlayton@kernel.org, amir73il@gmail.com, shakeel.butt@linux.dev, 
	gregkh@linuxfoundation.org, tj@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20261106-sitzreihen-ausfiel-lehren-933c55082314@brauner>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
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
In-Reply-To: <20261024213539.1307600-1-jkoolstra@xs4all.nl>

On Sat, Oct 24, 2026 at 11:35:27PM +0200, Jori Koolstra wrote:
> This series implements new semantics for the O_CREAT|O_DIRECTORY flag
> combination for open*(2): perform a mkdir and open the resulting
> directory; return a pinning fd (which mkdir does not).

Pulling this now for review.
