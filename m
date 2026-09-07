Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771BD372071
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764699; cv=pass; b=ub6KzrYjlCU/j9lufrWIRj3kGBNqbFvcKrqihmLorANEJzn7VH3rmpx80USX5GeZ+6sSora1D0Kjp/1k8wyUL2BzXRyjfoYJd+LpdUwLN0Wk2ZSw9VAoALywFzJrWcMiI/ebt+mJO/DKOfbQPFHAEu02jZ89oTvOyu6pRS3Qat4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764699; c=relaxed/simple;
	bh=0CCGiiIeWvPb4311KaiE6hW5g0F/hpyy4lrowmZQ8TI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j/duoI3a9UWvX4dYbCqAli9vnxzPthKvBV1BnBgxXyu+2fkIkBUW7nWf756cJzzOd71fIt41/uq2vT2QgdsWzLnxQdfe0djlnCxU0HAP6WHPXZBIgemSfp/BQWj/UWeDjcIyuzPN1iUchrPmfiH3Is4qNetAgl7ju9unOziijyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAY1doR0; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAY1doR0"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-478622cd851so395093fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 00:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788764697; cv=none;
        d=google.com; s=arc-20260327;
        b=FuDkdd2K5oVVm4Xth+eZjfDbZtaSBgGvNgRmBcU3CpTWcO45xUeKHhBWezdrGVQt8L
         Wozvb41A7RjgSKpLLqETLIR8Du30e9BzMbduq7kX0MaVYuhA7cvPDBCwfnSL0n25u6kb
         tXetL5RIvn0Pp3qFHuQ90ThF3lRr0Mr9qpX3caXThlFsgRd6aPXRtQRN4tb96qgMachd
         dfFrGlKTHHq+0VhT9MqTwv44maE6/js9sK1U3Z2rT7AB1iIWw91rvRmUEscTnfEg9JKN
         anqH22srxOQJHhYGOIuzalYygAcwg0/deomWnp5R1QOK7N7V4TsBn9gJiWj0plZ21T4/
         VnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0CCGiiIeWvPb4311KaiE6hW5g0F/hpyy4lrowmZQ8TI=;
        fh=5IEC/Mn2n0wwfaCJ1Z4kNK0VRbVUu0ormXKC5KddTss=;
        b=qj9G3P77k5bKa07byzkgW8R3RjTq3rY17vS+bk7QXGyXLfd46ipRu1KIC0VdbfQYmb
         bfmgeUOyqjcMUqX/9nZkteq3S6hSX8S0ts3pAQ4oqROxlPUBClWpr4es7f8sy3UBhYLo
         TAPaSnYIg7NPpaUIL53HtqUEozQwjZD+95laOULLSjTWYmXlbb4tVauHyiZ5bdGKRhWX
         gsAgbhYWD82vateP6/OrW1+wwI3tPN3wVvP899VDEqDGanPBQu7PGbuOh34PBb3uXOSO
         NmBBa+mD+rz6FUBlviYu1hN8fOg0oGpdBXH4RC1kq913o2dS1poGCxf5N24DTJoK/YjA
         1TKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788764697; x=1789369497; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0CCGiiIeWvPb4311KaiE6hW5g0F/hpyy4lrowmZQ8TI=;
        b=EAY1doR0vKrpWYpSiaBF8N8ri23sVrcKuYybaKmUXn18GgOEvsycCDz0FjumUC0rEX
         rvYizNu/pUos5814olQY2eHLlvdMG7ZND8i2E93LhG7eSpbd02NjIE1QprW4axHNHUhY
         dCEYCpIvVHTVidZdnSXlfSgGyS9aYeM5Vbha6MElqpL4QK8MorRJ+snj16BW7NTdw1zS
         j4qfbAUokwl/dVpqailJF5/4QxeSoZ68lLuNwnocX6bh8FeUF9GqWNtgBBKkUBImNXOy
         H+jHdeN4n42zizYK6N3EHi89O+eQURIkQX4caOG4mVSdkHnJyZAO1sQBaLWqk+vhuHx3
         qpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764697; x=1789369497;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CCGiiIeWvPb4311KaiE6hW5g0F/hpyy4lrowmZQ8TI=;
        b=gP21SxIraKLcIcxYtiZDGjGOdtb905bLh4ZCWagniHGoqju6yATrG23vZ6aZYHOzSH
         G/ms5yNWCixFNGTubIG1JAq/4COpo4X9J7zqWpeM0wbg+96OgAO1opBF/EW10mmzlZk1
         EeHPKrgrMx7j0m57zUYC9EmnuQgGF7nM098gWfDp56cfqlHsxVbFNuWs8WSgFBbNTHPb
         mYLCcaBZR8dg77Afmf6HlLnSRMGFEAd150tdq0VfnRK0iZggkjZlWLGYA1OzBPBcgeeQ
         QLdT8JwaWA4mpsoNIT4vp/wS48u7kkWuARmXN2OX4xAaY/mKoLrJS9RcsRmXVwBF+1/6
         z20Q==
X-Gm-Message-State: AFuF++k9xl/iwUpH/qCmnm7GghI/vQPzCOZ0dwf+/0oC6G1V8X2xS4WN
	eBd8hbzq1g/d1SLLKyFHB0WSWfFeG57i/vRpjDDFXXmyHwKWjvl+0sdEO3JqNTuPimnQiFXjYBF
	copAuy5GxPdJOc7LE5NlBwkaT4m81bppe8w==
X-Gm-Gg: AYBFou0nNUrme7vzWvVlSMPyPQwjnhqPI9vPwVo9SDb2iLB0BvQwKla4SGr0UK/T0eo
	S6B/gry2LKAyK7aGPAzlgsJS8VWG8cIkAeynd9caqs/EkWKMddE2VKmivRZgGN6iTRW+bGf2bR5
	dAdSyelBdlaLxJW76z8/4sqq/x/DKLPzQFhhCxAZn3zGjd0NY5cvXC2FYIw72LJIEcHA9Dj262O
	pMtLOVAZ1UatT+YQ430DDCVHzOFC/82fbwkjn9F6xhbT69+HsbEvXhLQGTmjLukkAIq/ASxW2ly
	MEIBRnUlfRiNvfWXGkWhLSKKAIGVGKLTN4lkraHHK75itA/bKQ1VsCJe
X-Received: by 2002:a05:6870:1d1:b0:463:aaa2:3b8b with SMTP id
 586e51a60fabf-4754e35c295mr15228955fac.0.1788764697367; Mon, 07 Sep 2026
 00:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 7 Sep 2026 09:04:00 +0200
X-Gm-Features: AcwNN1WX3ynF3X-j5HJRN244xmyDUXV8w1aYNehSUD95Bn5SbhY5Vc28pCQPFXI
Message-ID: <CALXu0UcHNQMV0nfuGKypCM+rR0t5Jovj+f+h50yffQyj0eO+EA@mail.gmail.com>
Subject: Linux VFS layer+nfsd name cache case-insensitive filename matching?
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good morning!

Below is a FreeBSD question, but I think this applies to Linux too:
How does the Linux VFS layer handle case-insensitive matching in the
name cache? And as an extension, how does nfsd handle name matching -
callback into VFS layer?

Ced

---------- Forwarded message ---------
From: Jasmin Dave <jasmin.dave.math@gmail.com>
Date: Mon, 7 Sept 2026 at 00:54
Subject: FreeBSD VFS layer name cache case-insensitive filename matching?
To: <freebsd-hackers@freebsd.org>


Hello,

Does the FreeBSD VFS layer name cache support case-insensitive
filename matching?

Thanks, Jasmin
--
Jasmin Dave - Math (Quaternions!), Coding, Simulations

--
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
