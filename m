Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F0492529
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999638; cv=pass; b=bsSHRAJiMAlfmIv9ySQrKKMgy2jvH0RdCa70vPq/ysn55kqfSf+KRkJBE46qRnnOzrnVjneNQwS9ZkrbArDhjqgFSEEU3vROPKM9XDYfGYYvjTfivjHyW4uL18iD4Qu9FYc+yGmCL7zafG5GSgRgpyP2gtzpYV/RMIynDvTSQ7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999638; c=relaxed/simple;
	bh=RF+OVwxZlsdAGjnU1g1R/+f08mnkaRREz85fWtak8AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dif6i47NEzdbz66j5XgIy4yFwQsGNpsLmOGj2jD8ba4YdbRQs6teMaacxmoZpyqE4LlFAxunVldVOjX33TXNq0TPKlg/2iI3l6gJpm/GZWhfTGkenNlDNPwIAiv8lAlgI0CH0fSwkW8Hxx7bIcapUHcNemv2ae2XfS/+LuoWKM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OKgRSpNF; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OKgRSpNF"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6729c6f0ca7so7083457a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 09:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777999634; cv=none;
        d=google.com; s=arc-20240605;
        b=YW1IdtGYaGst8BvEsZZ0MlxFO7MZW+zwp4lP4Oic8dLGvMgJr4dUN9+DIry6Vl+ZeD
         3gv+uctHu+Yl73sz04KJCW/9eaZVDjwfdsvksSsWTlpe/eJCfvfSQZL9XPqJnOUB1pB3
         r9Yc8OxU1F4HhqCDBscP0xgsCujRZBC2EICfDyvengwNBpoVXPM51DRdqtYN4oHitr31
         MAJhyUnoJOB+ZuFH29dBqCneiEwbyG9rcbaU5S/SQmkoX8dBp/eTCyVq0JkA4L+z+e6w
         FHeinYYzcLVjcsAc58gea1KOatlVfLZQNZLeDvM1EIlh+qDe87KxOdygs6ZPJylL3CEb
         ciyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=McdSPSXacFf5FzZbog5qvklaFijmxEAT2Q2F45M5VE0=;
        fh=ks+IUZplPW23ItDsHw1BbaLO8qcW/tS9pEpxUCETsns=;
        b=M6lAubEV/UaMi3DuoxcynblY/rLXMNCl3k2j4VyKf6CoHK02OglanP4iTRJGuuE8ZL
         yN8Bi2fznR95KEZosWWr9rukHFumQDtNHzQOIMrLUadY+PiX3YDo+TZxZLsSkmy3+qhQ
         8euzueiV7m3nyuSgKrzpVkCpM1UqTX10N0EX4+Er27BZu476ggmmg0011ez0RmdWeTIc
         0q6o/cJ1cLWvuZosRf7DsG6KR8chpCovzDRjLS16/erTZ0A1tt4ZTv6amLEEnofV79vL
         AlujGyzZ1IjvotO9YtPgA1Cwd4SXyS0L7Lw3bblbJfwrWxakAGqQzQzA/JmqQwLZ9ntu
         MXHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777999634; x=1778604434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McdSPSXacFf5FzZbog5qvklaFijmxEAT2Q2F45M5VE0=;
        b=OKgRSpNFvKt51gaF1LWaOE6q35lelp2GBZGTlS5s32IebFlFK47dnIQFdVordwQSVA
         EE2MIffFPYNBRrY5M+VNRQavSVpXixPCsepIkcZ6V1Di34CawogXJb4GCI/nYHNrwsuE
         wOKDOxS1jfxnqlhocnWKxW2C8PmSkvBbW75nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999634; x=1778604434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=McdSPSXacFf5FzZbog5qvklaFijmxEAT2Q2F45M5VE0=;
        b=Qoj/tRT8tDOnoVmnfchgOzare8YamVEk9FzSeCf2aW9SxH0aglAJSjJvkIWinvwPzh
         OgSsWQeNj0wrod4EWsfXGOnheY6EclBmfQhP65YGoAqTegc/iZ1oRJbt42qc8mKOvEfW
         7R7XuHCkDZTs/RBROfe3iSvkvwzs68iZs5KuMwqve6GdPRFTXfcl0XgjA3NKnUaTGNEr
         D9huWhTPqIvuJdDX7Ci/kEKszd5BfAWtM6nbghNP8ofWFpyQ4KwSl9ManIXzPrOhe5V1
         HP4fnMsf8dFPHqDg27FVQDoNqEJfRjuB2iVj3AGoOkH/VMbL5OGizP85CUw0N300offy
         SkyA==
X-Gm-Message-State: AOJu0Yx4h21a0rslJhiuhHOyhP6VjDL/hYbtlXCGG/3Hu4LHR/8/iNWL
	zSUqSG2XjWYUVBLJWuaKWt6pjBgz3WOMP/B9BkigXSojFXxRjW1HbM29DPo7bo/iei56n/1uPTj
	4xz7tTrYiuWzE0FeLRqPQDvsNuYyrRynFrglRX2RoAw==
X-Gm-Gg: AeBDiev5I9KuPHqYIMtnE5zqXWhH57aNLbfKveictQ6hUT/Sgapm4rL/U0gkLyEvRDY
	zARWkJk6e3XrwL867V0aQXfryrlcGPg8+4hcrq5pkLEvk8ZTPhkl8b/XHqChlt446eFu/eVvcwz
	eMdwWwjK6THhiEpFTivkq0s0Gze899kAm8AFTDHpKc6jErkcgzpGv5IyYzIwelxacF0e6QzKmDe
	yVc5RlpZwswqJSA/XG8CGk69AsBDETwkxaQXJoj5/Ft0xvff/dFrPx9m3p8wGvNG3dTaYdXUaUo
	Sb1rMNiA6vl/LbgQlUfTxd299ZpFCLFFCPesJIfhoSAVKw5JFg==
X-Received: by 2002:a05:6402:1ed5:b0:66a:19bd:5cb8 with SMTP id
 4fb4d7f45d1cf-67d4aa651bcmr131197a12.18.1777999634185; Tue, 05 May 2026
 09:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk> <20260505055412.1261144-13-viro@zeniv.linux.org.uk>
In-Reply-To: <20260505055412.1261144-13-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 May 2026 09:47:03 -0700
X-Gm-Features: AVHnY4JxU4QkSkX7Vp95kaVhw0A3nN6YV61EIqz__2rOlzoJB-nleDod8_AW-4o
Message-ID: <CAADWXX_dChuduyjE2=h4JsRkX1Tbjhgw47p0v9KOSbHkWCs7ng@mail.gmail.com>
Subject: Re: [RFC PATCH 12/25] reducing rcu_read_lock() scopes in dput and
 friends, step 1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:54=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> This one breaks rcu_read_lock() scopes in front of shrink_kill() call
> in shrink_dentry_list() and finish_dput() call in dput(); in both
> places we are withing ->d_lock scope, so doing that won't change
> the RCU read-side critical areas.

Ugh.

Ok, so I see what this does and why it does it, but I still dislike
this one intensely. That

         rcu_read_unlock();
         rcu_read_lock();

pattern is just ugly, and I'd like to see any actual numbers that it
makes a real latency difference.

> With that done, we have all calls of shrink_kill() and finish_dput()
> immediately preceded by rcu_read_lock(); next step will use that.

Yes, the next patch at least removes the ugly pattern. It still
obviously *does* the same "drop and immediately re-take", just without
making it as obvious.

Honestly, if this is then going to make some still later patch
cleaner, I'd prefer 12/13 to be just combined into one "change rcu
locking semantics to be better".

Because as-is, I think patch 12 on its own is just ugly.

It looks like patch 14 then uses the thing to clean up dentry_kill() a
bit, so that combined patch wouldn't trigger my "this is just ugly"
case, adn would still have a real reason for it (outside of a
theoretical "shrink rcu region" without numbers to say why it's
needed).

            Linus
