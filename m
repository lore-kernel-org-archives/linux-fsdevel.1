Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793646897;
	b=dUv9LgQt4fYkgXHlXXA22SLV3o/Sg4Dmp7x4/JiC0yaTtaYzp1xsvfWREYs3U62F/JlS
	 atPun47q66pWpHhLanIxkLxEmVs7b0dt4wP28FIcgSWYVXllj78cXUBaVy89CMldPd/Rv
	 UEh7jSsDLt4naQzZZzeFYoB92Id5nqRVLoip51p6ZqC7X0cow2mOrYeQVZPR2BTLikS+8
	 n3l4JIqa7+3hc2/zwMN/BFLnBXDzFFeKgwX3teSFFkYfbE6wQ1mNHwN4Y+UHjmhw8b1hL
	 HbKBdmxYmbmDuFxKpOd70UEnbfwOpVvAvhqCmXSsvl0FtxpmRC4840PKjFZP3u7GjZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=B7USxQeBWqJIvk+TNK+EFuqKe9jxWcobFGDrERPiumU=;
	b=Fq3xvF8XlCf2PfnxdFbRs/6HW18iPLstRraEfBQb+92vY8EyUvPr2KAOBwywQiSOeakC
	 NKor/PVoP23QR827I8nTK2t7gXuRQ2nr2PHhLy+gTW4Pqidibk14gjC8N+BtLPLLqtkG4
	 pnqOFudZZahS6dXE9GrzyO33PznfAuhWA4magSQNi/qmyUwClcCutQ8/KR5kobLjwS+mI
	 SW9JYbmxmKCfgOv1LGucYLv8JozWT6YgLVz4EUSZWsqtwxIRU3g2+euNKvSiY+jQ0Kf+F
	 KwwpoA4Y1zLdFR0srEs+xsuzFxwScRiks375k02LCBOW/f09J/YxM43Z0+6vpomXNxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHR6+QKn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C003606EE9C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 19:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C003606EE9C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHR6+QKn
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so4641952a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 11:14:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793646895; cv=none;
        d=google.com; s=arc-20260327;
        b=eRPZcrELCDttQ4uRVJkkRVTlLiPiDFaiZ1GLbSutkqhO7kDKIwVtsPqoDdvdbw1pdB
         gXzIcfyaxUtkYMsPtAOpMc3B32qp5FiieG9ChOno2EXk9Dn2uDl+mgWa33H6OkdEcA0q
         TEKpr/assXUaQgnbm+f3M9+pQUj2Vyn7rllL2BVeA9aJ1HhIJMseBqToAsV83xRXhBla
         yL5gubDmJemYuKDpIX3UkOZupAHNxHPE+vmvplU/flwyvTeR8upS6OU9lSH8pOERwmrs
         9/jHU8NHbU2N6/WhuTzNAYhoaDlzEkAmI68IVwZU6CNuc0HtJmNE96PHv8BMAthtymwp
         ynhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=B7USxQeBWqJIvk+TNK+EFuqKe9jxWcobFGDrERPiumU=;
        fh=O8xqVMYpOOjcdzBASpvq0DUa/+rgI8pFMaU22NN7oXM=;
        b=lwEitdLlfSzfcta286L+eGA+hPnS5GYqr/CGntx/JsGx9PgzkHsn+e9jpyu0HfnxWH
         gU9GfQ7Q8K+7ofxM++LjcL5/jRrGM6VqtxxTvc0/sQbDoy45uZ/o0dGPAd1rkMK7l3uk
         goK+uZthDb3UMPqTjMAd0EofN/CERxxoPdale3zsdzW4lGiHlLAW3hbK+n4MRYMnZ41o
         tciYSYyKEkDMCQx+6IzJ5/9N4Ed8MV1Lnv/N1WnyurGn5Y8mhJ76VuZYlwfbCYML3NI4
         jYF+wJ9RK03DDuBRwEboJXDc7HLpuvtJftmAqE2I0/qOJK8O4YqqjjLJniLn6wbHBWmq
         m5Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646895; x=1794251695; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7USxQeBWqJIvk+TNK+EFuqKe9jxWcobFGDrERPiumU=;
        b=yHR6+QKneSTyYA1HkIcvbRXbKcCV+7xObIMy4aVMdoO8LeQzN5KjmPbxsjnQbZESiS
         3K0Ru8IQ31zzoTVqJwb/y7dQ/ISvpdoFbuDJWL78hF8nzMiPp4k/mT9V7FnX+PTJ0MZM
         qEF3LuxiddQS9mMhTlgNHN1bSwxnKMg7Vas7A1fmMMsOLCn7hwUtP4nr2NEz/p2E2BTt
         AOHZpppvmcwPt7mtR9KPI+nGPNrxQrkhYjVRLGnEqqb0+4RkpS5zZ7hiJu5R84huE92e
         i+dECqg8DbDsFDAHGVObjqFle03hSpXCobVZ3rbYfq8eU3N6wDUoY6+4MnDom6EwTHfO
         n8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646895; x=1794251695;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B7USxQeBWqJIvk+TNK+EFuqKe9jxWcobFGDrERPiumU=;
        b=vOD0OEU9cIR4wvVjHhMp+vbb3pm7ZMXcm6JIyebaBrCDwS1vFRJ7Qx8kKQF/sM5CN+
         X3vUUNo7sW3VTi6/fn9NQRVjPbL9WPuyvVFVUfwuUPoCS5zzQnqDI/Ih9KpEf6FqCZxW
         bd6wNqT7VYNDZiJAW1knqZ+j8zyGi0sSWn4b1r8p7l4Cij5wJXdEVGi+BOw6zt3RXJ3t
         1UjPl4LdtjoOtpr2UJ3ygNdU9KWESNJV4xDdwvk0QWtu0YYSetcj236gbjD4PSqszV/F
         RRV5I8qPLpkUch0yLqziF8CYd1PCowjmCunwgofD9aFIn87sVyqckNiCcG+hPUpc2Qu+
         F/VQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmcH+4mKMXHsKFHpwN3tvEDecn+ziHiDDgaXuKB1zHDzHl7CydHZPmQEqbBrYpYKBxZsYyviVtCv1XOQbN@vger.kernel.org
X-Gm-Message-State: APuU4Z8WxoOGBKMRj0LUh1Wd360HY+Ib1pvQ5ODsumj6o6IboJ3KwV+6
	Rm6dISjGx4RhUHmIVQyj9gxWdUt3E8pkxLlOfACtTbSKv2d5ksakguVqPwGgEAJQayaZyfcoMvC
	/ovgGvsxU45dksP6eo/xfIMKL177MoO0=
X-Gm-Gg: AYBFou2Afckx7MCM2nOOh0VR0OvQxZyWPUqXZTIVX2Gie6fx6VdhjPD2gH7hIGxkktI
	65XZMuz9Mz/YbHV2lxPbrMmx65XAGL64Q5TXGAKVvTLK8NHTzoZCaDULNMcXaUKfzgIfcFMC+O4
	h+tvSk8PGiLyDF2ThA+k3uPhzELoD7SGyVVcJ9atchI930i5jcPpbFWpwr9oxLtUXEYIvsC2hs0
	hPV0y2BIkXlDD8ZDbc88ej4E64lZGGEnjF2dXXrIIbBkHiDKt1keYB9lddK1L2gEB6vxGGZEDHd
	90Pn3d2rAQPsB8v8BNUYd4v5l0IWTYK/69PzZGxmWZdHPHoHMOEdp9wiQxF/gkv2v9fQ5A7joQD
	AKhrjRCbY8cgMXCRlY/XdQj91Sjeb+rbYAJ2zVQ==
X-Received: by 2002:a17:906:f595:b0:c43:ae92:9a9 with SMTP id
 a640c23a62f3a-c4ca7aa3e0emr937269466b.33.1793646895408; Mon, 02 Nov 2026
 11:14:55 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023183434.9109-1-drifabdelmalekmohamedsaid@gmail.com> <20261101203113.74d0204f6d57deb81cdd0dc5@linux-foundation.org>
In-Reply-To: <20261101203113.74d0204f6d57deb81cdd0dc5@linux-foundation.org>
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Mon, 2 Nov 2026 20:14:45 +0100
X-Gm-Features: AclHuK_Sn4VZsbOYzKg1RApQU1YaVmSKpjQokS2EFefzJWNdN-jlaD7qM-TtxrA
Message-ID: <CA+xk8n__CCNUE=ULkxLWzdW3K1NnxeUdkrU5PUeSX8xEidBaTA@mail.gmail.com>
Subject: Re: [PATCH] selftests/proc: proc-empty-vm: wait for child's SIGSEGV
 instead of sleep(1)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Andrew,
Thank you for your reply,

>My review toy claims
>
>: Separately, tools/testing/selftests/ptrace/vmaccess.c has similar
>: sleep-based synchronization. A delayed child can make its attach test
>: fail spuriously, or let its vmaccess test run before the intended
>: blocked-exec state. That deserves a separate fix.

I just checked that file, it tests for a hang/deadlock when a ptrace
attach is run against
a child with one of its threads as a zombie, so they both hold cred_guard_mutex.
This, as far as my understanding and testing locally against upstream,
would cause a hang.

Is this the intended behaviour, and if not, is the problem from kernel
ptrace code or from the test,
please let me know which part of this i should investigate next.
Cordially,
