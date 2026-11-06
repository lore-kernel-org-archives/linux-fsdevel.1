Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793980357;
	b=kHihEnlWr//r/LDZyiyvMFezecuMoPZyAYvK/KBbpHEsO1hcsRcn+b4yESjnsF2QAx3G
	 5CsRXVJD6JvdOip8vzTCbzkAM7AOs1JCeffbPSV9zN5RzY8s6hS69FDU7OOFeW0GtP8dX
	 Bztej1VPHYfN9oDGT01TTqk/l6tu/FTtMlWBjqCy8Q7Izgt7azH1DTCIajzpCLACHUVxS
	 wLlj/HeN3wT5Dz9gnfLsk3+n79L4ZZi7eRaeXT99jUo+H42Z1Arh1nv8v/Uq8hOM6QfCX
	 F4qrA9uICfGpRGrxlcqx8H4OY1gYjsrJOvGNKMgOz/NjsLe79fCyXr7EcoA5t/4z9TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type;
	bh=imxiLTdOX5HC1rp3c25qmGQ65Qq/V6SkfQFDiRpdc+U=;
	b=aG+9qSFSDtxAmybno66zmpFPOkenzuQsrubGz33t/fo6G0P91v34wLDlStoKRrKFjCK1
	 aNDLImSiovmLKK8rI8Ox0xp30jWJzwKK6fiZ4Hmt8GKF47OFye2AW7MyMFRb5+8mlIKh1
	 ewhZMeUbQAXERibPAeJONUr5PkU8FH9tqRRNjLwnWpO1HfgJoA8t3pSdPuvujNEDUsd16
	 mMS/yW1KtnsIOy3ZDeYPS0THz5AIJynTOBiZhwQ48+chOKk9nAu3vrxA78lqmR2lsoPyc
	 AF7n5JoVcUUJeGv3wCrxXEeh46kjrlGMgBT5KwoLuDDclMI1VLcen2OFvjb9wNz4+/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WyTdu2WC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A7606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 15:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A11A7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WyTdu2WC
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c43373ae89aso122001766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 07:52:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793980355; cv=none;
        d=google.com; s=arc-20260327;
        b=CykahvLrv4LoZQd8FhrWnA2ZH8Ouo+oUjLAAgnSex8EQFAceFUxr4e+4u9oWjOUXKh
         2OTOkE5Dl+7xrF5fZzuaVDA5GbOPOGFrx2ACSAJ7yWlaeAhEd3JMf8J6u4FNeA4yKg3Q
         wVBJqli19nyjgti4dXCe4uwCHST+PTns9gcM3RBNq9OUssUaPzlOn5BT20i7+VkSXdXH
         N/wdB48RxnBGa89pPLOBUXueYj29BAsFxf8/9mvADXrrbcHVtTT/tPVXQ/VIQMqNIOs7
         BxjialgqucFps6dyKt/lgy1g4Vh3eWUSGvImq5gYkbu0lp8qND4ToESzd3lc3bOpRywz
         OLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=imxiLTdOX5HC1rp3c25qmGQ65Qq/V6SkfQFDiRpdc+U=;
        fh=0jVS+qKvi5HvpvEhwRwkzufIC6QKXPBK938Acz4Rta4=;
        b=nnHREK0abUrEs9z1bW+KwMEEVF4te/c49zDRB7dsvU0T+GxF0GWHzX8VRNcBmfqIWc
         OzBK4eNxSaeVe4vhSD1fsdKAlCIrJduPHSXdB4KE626lY69Xoo0TwKqDTt8RWMwNfGrA
         kPpSjsYspBd27kRbnulVGHQoZgQ+35l2slCgVpPL3LOosVO2suBdolaXJSzXnXv472Mi
         8AI2OAXSO7a6kF8bPb2dFsRU/GDLY4TKFWsd8jayZNlnWLwl+JjaqwcyBuOTm4f8Rt4D
         j7OY3N+DVfaWwJj76KZHdIoq5N78PSn3T0WkGpOFK+GDYV4/EcT+ZTIxLXnOXRx8rnZs
         5E2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980355; x=1794585155; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=imxiLTdOX5HC1rp3c25qmGQ65Qq/V6SkfQFDiRpdc+U=;
        b=WyTdu2WC22mzje3irwikGleidsXg+3oVHnL1S9iAAs1XkonNIHenxnpJssyPyKP6Yw
         W6RW2BIYr3jvM/MrXJz6P4yhpzDNqHn1/4vKE/uJWmB2hJVxyPwU13GetZqqdHl9mmV9
         y9kroJk14ILiSDv0Y3AWgf3Ka9YeKhCNQKRDJv74TZlZiikO8baQGodnQOLHCs48+MUe
         sIr94GGPxt6yDTWRLP3hPp2HgM4+2yGvs5t9du4+bKZBybp5pwe/ARqX65L/+yJ40YbU
         t/UCYE7DoCgrsLIfVvpIQcqiSjGLfu8qXp7bzblvXGp7B1Xvua1/uAUHBpMVg8gMgGIi
         5hWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980355; x=1794585155;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=imxiLTdOX5HC1rp3c25qmGQ65Qq/V6SkfQFDiRpdc+U=;
        b=UooZ/g3ak759OFSV5aGcJqeYHxRxvmOJrghQyLKe9Bvu2MdXl5LPD12dyHzsBwaU5k
         yTVBqpSDLfYwjR3MmC95ybjP6Ht4/FnxEBveaZY5Turo0GMuW9yW2MAxIuyExyGpiet9
         wcxu54qE2sITkY1PixN+e4zLr0rPfYr0Fo2c8Inu6iHSYSubh/Dm5t+vdxn+QG9Q2Eva
         94ogoy2UaehW7yVv4WWbeLgaoAZnHShLiQX3sHc08LkV3wDvfeVPAUmDtLUzuLLvvRwF
         uKoQMy914H11zUvsb7WGFCiNGofvZLQXcjnqE/UCerN2gfxLtCtJKurSyRYyNYvrPLbx
         lvZA==
X-Forwarded-Encrypted: i=1; AKwUvBw3YQcYegg7bigPtyXsD2OKdmxwMOiZPp2rECu9fpf19+zXgN31BWG2vZEc/cbMyDgRRX/HgBtFwBsne2Cc@vger.kernel.org
X-Gm-Message-State: APuU4Z+RUAisR1QtvFCeBLRiic71S4JSlwQxs2FTYH+RalhTl3pgbBsg
	olLNiYtcD7H3BdZFfUcXqB8vWqzTOYxVWL9KEN8v33C/R8RlmCJpsNRG24hvreqAm6miG5XNTqP
	4Gk6Ih6iFYaHyDOo+dzR/zGpiCy6GDjrj2Rew26Q=
X-Gm-Gg: AYBFou1nM4OZN9RrdjjOkA5AQNuAa4Jsrl7+9rhCvM1Wz1dMPnxDxPF9o4aCi+P24vw
	Bd/Bea6uCmL2u0Te+IQCxilX3hMEJsok7t4LSX+rJ3CB86J5qJetcS6BJVvvJFRdmftdMpn1ojS
	2D0RVMJvwTwTbhMMcesrzBgcxQaql/2PqbRL3iOTnTtGkMql3Ahb5BZp/7OE+ps2oZiST3L4k7/
	lAXKZevCBPh7TMihpPY9YMIkqV/sGzMmGeFMgX89qQ1JgdTAOE4kcTNzP6/mhLpbhg17/H76px0
	B01CH0EbJ85m2UZs31+Dh3/jY3+FWheURMf+RrqQx55tv0NhxNpZlaJygxIeOYFZBt0ZrYU4jcZ
	2u1eWCh43GTNaI5m4HoB8beuV1GyV4VXRPOrsN2bgK7SmQNX2DiTJYiIizZP52+n9VH3dQxiA1S
	uiucTeUe0nM1PBbxGCh6sL8GIFD4bs
X-Received: by 2002:a17:907:1c91:b0:c48:ddac:7eb1 with SMTP id
 a640c23a62f3a-c4d34cdc549mr257468666b.45.1793980354757; Fri, 06 Nov 2026
 07:52:34 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 6 Nov 2026 16:52:22 +0100
X-Gm-Features: AclHuK8p0HBDrOmkB3xF0AiTXt-CjeYHVOqupnZd0JdVBSmHKu9mDQ6Xg5ihE28
Message-ID: <CAGudoHGEfHXydqneyo94zEWfFZY32AWCOfQL01dYGCQKi0zJgg@mail.gmail.com>
Subject: unstable performance during continuous memory reclamation
To: linux-mm <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I have a synthetic benchmark which stats millions of files in parallel
(each worker stats inodes in its own tree), which I'm running in a
loop. The total number of inodes is purposefully chosen to NOT fit in
ram and require continuous memory reclamation to proceed.

I would expect the total time needed to be roughly the same for each
run. Instead I am seeing massive variance, from 18-ish seconds to over
50 (see sample runs at the end of the e-mail).

I don't have time to dig into this, I am posting this in case someone
would be interested.

You can grab the bench here:
https://people.freebsd.org/~mjg/fstree.tgz

My test jig has 24 cores and 24GB RAM running this against ext4, the
kernel is 7.4-rc1. The problem is not new but I could not be arsed to
write this up previously.

The fs is prepped with mkfs.ext4 -N 24000000 and mounted on /testfs.

$ sh createtrees /testfs 20 # creates 20 dirs with a million inodes each
$ while true; do time sh walktrees /testfs 20; done # bench

sh walktrees /testfs 20  3.32s user 255.90s system 1397% cpu 18.55s
(18.549) total
sh walktrees /testfs 20  3.65s user 376.84s system 883% cpu 43.08s
(43.079) total
sh walktrees /testfs 20  3.25s user 253.34s system 1314% cpu 19.53s
(19.527) total
sh walktrees /testfs 20  4.45s user 423.65s system 1079% cpu 39.66s
(39.664) total
sh walktrees /testfs 20  3.19s user 288.14s system 1590% cpu 18.32s
(18.317) total
sh walktrees /testfs 20  3.34s user 342.73s system 1124% cpu 30.78s
(30.778) total
sh walktrees /testfs 20  3.14s user 231.58s system 1374% cpu 17.08s
(17.080) total
sh walktrees /testfs 20  3.33s user 329.40s system 1108% cpu 30.02s
(30.019) total
sh walktrees /testfs 20  3.68s user 301.85s system 602% cpu 50.70s
(50.701) total
sh walktrees /testfs 20  3.61s user 259.41s system 1172% cpu 22.43s
(22.427) total
sh walktrees /testfs 20  4.20s user 376.32s system 1093% cpu 34.80s
(34.797) total
sh walktrees /testfs 20  3.50s user 268.13s system 1238% cpu 21.93s
(21.930) total
sh walktrees /testfs 20  4.17s user 377.34s system 1065% cpu 35.81s
(35.810) total
sh walktrees /testfs 20  2.81s user 245.95s system 503% cpu 49.37s
(49.373) total
sh walktrees /testfs 20  3.75s user 367.58s system 920% cpu 40.34s
(40.335) total
sh walktrees /testfs 20  3.73s user 298.43s system 1191% cpu 25.36s
(25.361) total
