Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925012;
	b=PQpS2w8GMfolWz8VWfGWekF0z/aIWF34kwMAS2tMfyM3nHHi0bxM744AMAlicC7lctmY
	 HRZaFAxXrUoNQSewxTWWxCCp65GR7bKGIyRhzkxRDe/KPg9g0XZ4R9bdVfnskqqi7yM6q
	 HEZ0fr5zC4cR1jvY2ZzfR05NNwaSQ9c4AfuwxnRogTKcgNTfCUv+gZVyk+xZhq+mJjeyh
	 OFcxMcKq9NQ+qbA3IeNDAEw1qq2ZccxKCUZ4tqPQKhAZ77dGlRlAXnhL9hJvTKW9EvhLv
	 uW4HyTzirevA15plkbiHeeawDGOK+6yeiz6hprNRsgpsZZiH3ahVRLEvtTbsDz13qvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=8mDL3N+DirypXyizj73343YIMouI63Jigsdwggl20Xk=;
	b=szPalaySn6Yj8L5lSQwiJV+/mp2J/0CxZQdZwr4b7xIZmMdSmJKKnJpRusNGqln09bsH
	 E7xb4sbovs2+cG2e4Nyg9BcVBLSLCpGXXTYHuXOX3MLN9Qn1gdCYG7AzNDydQe3dOItZK
	 KM+RGESqmTRNgnjXF+O5XKnie1TNGEreP2D5uAyvTsGwoIBL3CakXXFuaANeI+BQu23UY
	 6t+MakTaRlLKMc3UNboQbW1VFlolhMVaUgOeOq7EgBcZH7MLsBohdQQci529FDCljX7Q9
	 mIxEB9sTXjjxgollN1eTq9w5419JAyaL5/uUxZxcX0RZQifhu/QRqiJYj4YBGVTGOeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JMY1JauI;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0664606A33B
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0664606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JMY1JauI
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49953abe51fso30232375e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794925010; x=1795529810; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mDL3N+DirypXyizj73343YIMouI63Jigsdwggl20Xk=;
        b=JMY1JauIRJg4BDtE7ceIsP/yqSL31cHZ23/Ik9MkGT4+n2Kw7Cpfte5uB0tyaRX37U
         qsp1cU58hQjKcCLZhOrqKaeF6Pd5DVjJVtz4leic2yneF/nwFopGakk1nE1235R2ZcyN
         6dbc/YX5XFEsQCzCWOt9fThFH6FuSo6wN5Q2p4XCIqobkIng92ewtzsxiUrLo3SVxQkn
         J5XGnM/Oh3R7HY1fs6DsX43BwVPwrwtizcTLumjZPaHLECqgAnZAlECD859fW7BvTFrd
         wFHyqjem/zC2xWWr1NAMISiD/sj8Iw/5r0ZkVdjMJg38L62DK/OHEfGiSGVlJf+TWy9f
         CX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925010; x=1795529810;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8mDL3N+DirypXyizj73343YIMouI63Jigsdwggl20Xk=;
        b=ybVGsLobia56Dy6+801FmbXSN8LAVw+iQxdKsvonxlhBQT7Tv9tBcvWkypMbJrLvpp
         0CDLnICiaUJY76u+x6uWlvFZun6FZdFtUVI4vcfYr/Ajes14Ac0UEpDzoxyTgYb9XEoc
         UCV0o6cJuTA6+6e3QUl12lp8v/ja2rcCcWIs6v5e8WILb0PAri4FWTPXHcZ0yxcwWJey
         J6+PuB6DkbqD6JvRlPBh15uepDhK9UQWW2JKNUybIEDJK+SgVHW9t30+njig4F5sVmjw
         Vp9rz32OyiddPudKnbSxYkFB2d5HSEBE18TGnv7I1gK5hkxk6o674l1NOVJeAPcVhj3w
         z90w==
X-Forwarded-Encrypted: i=1; AL+hErFGwCnXpJ/1bWFR8pj0118o0zVBig1rinV2tR42eQ9lNTfyPFqG0gnoM+H0a0g8p9oH1382IqJE3e/bpCm0@vger.kernel.org
X-Gm-Message-State: APuU4Z/ec+OMCpeJ8n0gQVs9CYIMRT5VDp14BDax/jAtos8aqKya/VI8
	9x0yOXOuBoEOKnVoukxD7OoVLfCXdLi2JHjL5p9v/UEjUALlfL81s4da+4HXPjwt7NpUTwdLdWq
	p584U81ZZEWsKN6g72g==
X-Received: from wmaj16.prod.google.com ([2002:a05:600c:6c10:b0:4a2:d3e:ee4a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a302:b0:4bb:7347:d5c0 with SMTP id 5b1f17b1804b1-4bb7347d930mr100746285e9.9.1794925009887;
 Tue, 17 Nov 2026 06:16:49 -0800 (PST)
Date: Tue, 17 Nov 2026 14:16:48 +0000
In-Reply-To: <20261117001507.1611984-3-dakr@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117001507.1611984-1-dakr@kernel.org> <20261117001507.1611984-3-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117141649.2991892-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 2/5] rust: sync: add WaitQueue infrastructure
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, boqun@kernel.org, gary@garyguo.net, 
	lyude@redhat.com, daniel.almeida@collabora.com, work@onurozkan.dev, 
	ojeda@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org, 
	acourbot@nvidia.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026 at 01:14:43AM +0100, Danilo Krummrich wrote:
> Implement a wait queue wrapping the kernel's struct wait_queue_head,
> with wait_event()-style methods that take a condition closure directly.
> 
> The API mirrors the C wait_event() family:
> 
>   - wait_event()
>   - wait_event_interruptible()
>   - wait_event_timeout()
>   - wait_event_interruptible_timeout()
>   - wake_up() / wake_up_all() / wake_up_sync()
> 
> The interruptible variant returns Result<(), Interrupted>, the timeout
> variant Result<(), TimedOut>, and the combined variant Result<(),
> WaitError>. These errors map to ERESTARTSYS (signal) or ETIMEDOUT
> (timeout).
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Thanks for addressing the feedback from v1!

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
