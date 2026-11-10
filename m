Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794315215;
	b=0Soitfhk4y92DE1OITBQgaz+M+jZTGUp4vLvPm1448UIHdob3E385UiN9fdzdAWDDuAR
	 F6shwmnTNyZ3tHtoId8CumVMwBlm7Z+lTej0pnzb4A0YNWIM+9OxieHDuWDvVO4HCIskt
	 eGiQwt3nFO8EC7HORqyscfopITeV+tyb+hdhJn17Ac2iG7NTRTNrqyNER/zgRrDvwP1co
	 01gsZ+pEOojmFRUqO6EC801QAVPcj5WP5r18XvMY8a0zkavptE9/oupOzdbswFQAqwwOy
	 uQ4xy9xs57wanfusIbVWEZfBU8KvEhyhEdQI5MTWnDQFkMUg0KP7kOLD9Ig6isC3xdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=28GoECiSpx4IVB0HDzc0QHmygncCgnFuLh5fsE2WXLg=;
	b=fqk3AW9gFE5J33qTYO5m/Uu09OuPe+oo7+Qa4DQp2NQ9i3vpuA0QifWBxqZR/CrOo6Fb
	 W5SVYwdAHUx/I1bPJdk78aUYp+qAk6/FVvwlCbKUJc1mR9fQQs0FmGqou1jsLNm9pR2GH
	 N4tXwIfb+lQ/ZNIttC2Qvq0yJzfUreenePWtaVqSrwYnVfZ00D9wWLP9y0GDMN5lF5bTB
	 lO2XsNcykHxsI2WLN8oPqscSvo+NELA65U3pa756ix0uD9yWpJFrnvudyAV6fzirKA8yl
	 dLAW6xId02oceqk6NtTGxzK0CeKt8pmGOXELF+nXlhQiiTwzb3EAfpgyT2LAFAd+8Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWrRRuhh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B560A261B
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 12:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A84B560A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWrRRuhh
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35159e0092aso194419eec.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 04:53:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794315214; cv=none;
        d=google.com; s=arc-20260327;
        b=VqIEhiMDf8Yb/GAbs2kNbjoWhYMKYv/6QnjTzcFkNGg4BbQUMn1Nty3/VaKUmc/u8t
         0IWe5PPsAg7S16yOqEruhvpB0qS50LGEnA0m1lgW2ruSvB/lnSeJ7+EJKaqlAZXUoUDi
         5+lguCh/Rv5CxManKV9NzZWup5AhCfTIwOCmgLZj85yBj5z/0yrSNadjsnRQyepWlmap
         2e8ePTAW4d4f16YJNBdKq2AuTZvgSFu7cZhRpNwqBqcMgfy3lBEObJfBoUMjrxmT719e
         zot7TTvBx4c8RdZr6hfx9xyPTsMQtUlxk8/2pMrtIDjCZWPJ0o4QmfnNJfnwVFaa1z0i
         id/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=28GoECiSpx4IVB0HDzc0QHmygncCgnFuLh5fsE2WXLg=;
        fh=wR5qTbQJ1/VHXy5WvgjGeTsq8P/vkBoOJJsDOYBQhNU=;
        b=c9eiNMVxObITovVQdvFBpa4cbvn0GA5QT/E+sl3fh6HPftCrpehrX7H8pqIIv6as/C
         6uPGbMgqO9VY9w1QuXv8aTdfy7jL+9inyd11qo56u/RMgPpXeaG15z9P3k2oxpU8XCEX
         ZVwWGRcF/1vgCcXlIYd7tyGW4pGvPns6z9SBzHMArzeJAthlT2irstA1pjUaC4DaAZgo
         7B7aVTt/sbPJnKJOQNXfmdDtHkxXVO7i6WiOEoPPLvF4U+nIpkvjFrPiyM4qkg6Lbi6D
         azj3C8BrUuWp1wlL6SlWfd1xwFQnPrLRA0tbRXojkNRXnHLfDG8ZEjOM5cLTatXo6GAo
         JiNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794315214; x=1794920014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=28GoECiSpx4IVB0HDzc0QHmygncCgnFuLh5fsE2WXLg=;
        b=lWrRRuhhh6EtAXYSdTrI71Ke2uMKfLFTWSIPQHitBs1U8yk/QUoHYz7VQTSMtm/6Fj
         UscIoVERTrjxLoOY/DMvY0yX4WmfFZ4VOS6OVTUjFiBH7nE/aPXTuMVYuo79b7fk247F
         GugOBzQbmqsm7gRRjuMwbiykhDuAgcjLZqjbsqmsufiW4BBl6VNbQ5pGh3MDz8kKuuJy
         RPWuueEaVQXGCjchwlKqEhEj6lJwWeoHgpIxBbz3kRfFtiW7ykvvutDdOzkLYQwemwKp
         lI0i/cTR2t+/uNKFKeiyw30lG0/gyvcajUF/645yaSm2Q+eAm/ZnrX3zLBy7Rv344Zxp
         VY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794315214; x=1794920014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=28GoECiSpx4IVB0HDzc0QHmygncCgnFuLh5fsE2WXLg=;
        b=ML4IoHCRAf5IdAPXMsdU9/Rq2KgI61hzHq0PAyS+g5LhUB+9+GidJjj0D8lDvelnao
         Y0lpx0CQrd6wwmQLiQL+fBGoAjcApFHlC04KH00lgIxpnrmAxMn05TwtP+8UV4wuT5HS
         9vKQfkYjtWJBlkVO8mgf+WI6mUbObC1CXSIFv3Ug7l6LB8odiYArErPYRXZe1QZbqLIu
         CZzcdXwt5QqKQUi4I9RVks1r3yVRrMRmkpyM9Y8ookYZTqy7UzvNRpobYRi+jPyGxX/j
         TnNNNMStsWBM9zVQJYNRtiAQkb03modZBVf+yQLst/M3KHxHqaVnOrx5uMsQOafeOiYM
         k4jQ==
X-Forwarded-Encrypted: i=1; AL+hErEPtFAp567EL6QxeAJCnBNbpmZgnmc7xK5ZNDc69e8Gnc9uP4eDayJFzUs2eGYkQOf2yquvgWK7b5P7tbXS@vger.kernel.org
X-Gm-Message-State: APuU4Z9A7d0i+ry0fW7HIl6Yk/r21v15b0DDp2HGzE2+34Fn5lpZgley
	d8od8qYM07Ji6lLyvoGWRhzryiZSU5lnjzx3OSRG88sWtgMGfC8VpG7QD1f3RmHSlzL4J+MYKzk
	amBtQ4LWSpz9UTzM1bVjdqx4OXexA9kU=
X-Gm-Gg: AYBFou2/cdCk8w5mGKJheHAA96owAdWkXkPDVg0KJAW7I+v1/9ZUB8kU71iY47J9bNS
	JBsCaI4MQDG9+hPbm2TR7ZMty4EEqER2QQ0BzOTz4uJ1WJdkk092CYHzeH1QJBWGic1CxJXDCPF
	QlRDFdoHAXjGXeJUWZ/4+3ZBgR+NJWF2983Ms9TQcH97gMR+G2zOqZ9uFN5P2378m5oyCcZdGWh
	/qhI5Xzz1ap3ObgIF/6hip+poqTrysT6LevIPEGU9XYFziLLeFJ3zfrtXSZ3If4riDoRl8wxUHs
	3L/tJs6Da+WmKLB9kej+HDLQ6NAbkhbZ7cKkpVnUKV9q/sK5RdlWl1r3JiT224XUEe+1shqH8Ft
	mEwpNZjRiuPAH8bDt/bp+0tygqqRkU7oKIBhUibY3sOSUn4OQ13dF7dstgGC1r0GgLf4ErK99Lk
	NqiE784rkbley9kynGyZkNixvLiMKRKmC3qFdTE82Ihf3VAjtmDJyslKLiZew4lOXZtcu2P89Fj
	zZEFyCA/sQ9s9zGWuMuwOBZZxYs2TkwjAo=
X-Received: by 2002:a05:693c:821c:b0:36c:a1bc:6114 with SMTP id
 5a478bee46e88-37519aba700mr4904579eec.0.1794315213601; Tue, 10 Nov 2026
 04:53:33 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105005951.756157-1-dakr@kernel.org> <20261105005951.756157-2-dakr@kernel.org>
In-Reply-To: <20261105005951.756157-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Nov 2026 13:53:20 +0100
X-Gm-Features: AclHuK-pVseIc6DHnBPBDBXyJhILLTldFlfGpbyMvwQl7Ef2kEFTlDEPMhY_FZ0
Message-ID: <CANiq72=xRMO_Q0EeeProKRnjHd_9oGufXUVb153FRrBn9xBk1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rust: task: add safe schedule_timeout() wrapper
To: Danilo Krummrich <dakr@kernel.org>
Cc: boqun@kernel.org, gary@garyguo.net, aliceryhl@google.com, lyude@redhat.com, 
	daniel.almeida@collabora.com, work@onurozkan.dev, ojeda@kernel.org, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, tamird@kernel.org, acourbot@nvidia.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:00=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> +/// Timeouts at or above [`MAX_SCHEDULE_TIMEOUT`] mean an indefinite wai=
t. In that case, the return
> +/// value is `MAX_SCHEDULE_TIMEOUT` as [`Jiffies`].

[`MAX_SCHEDULE_TIMEOUT`]

By the way, should we even allow higher values? Clamping is OK, but I
wonder if we should take the chance to make those EB by adding a
`debug_assert!`, before we have callers relying on that.

With that considered:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
