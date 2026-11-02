Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793635902;
	b=sN7IzjJnkOcaZyx1iAZzTCxchuH+qvHIGtwgKUUVM8pXRyWj2aw4wJZFl3cYuunFnNPP
	 rzOi+AvzzZcW4gCVoxfqNKN4buB52euWTEIYol3bM3FVgPjrnqnNr+poM0wm6kU3g/P9z
	 tTBDq72fYmA8I4p+Pic+j4gRv6mmoEbsI5s3+h9GGcbwEorqCLXxsAZ/1H+0/xpkGBbYY
	 Wjcp36MoFR+hNQWOTfKm6GPTa7M/C583YPJ8W69i7SCxeC8QYFBTmFnU7ZubyXg9dJwpJ
	 Ii55s+HEo17HcGDHATR2XjgSt52fpdlC5BorPb6yGzdkchO7kp9jZiBiHvtEYdFd9pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QrJw+lkmXdlr2rkeyObnD9Bf7t1jpUUa0j+yv8MRcbQ=;
	b=ddDFSImKUYdO4F1aH5Fbe/lt8m4sqVlkA3zKRnUJrFvjSb69SbNKMTbQx2Yz6/yb++dV
	 f1AYwJddRpodogD5l/yIkVrwQcTizizxnYEgEuYKq9AldCVa/z5lmJsWBe0lyFuiA6YXV
	 xeREv8ztMKR/mH/sZtB4Hdm12CBI+XTIFY6Mi5FumwPBrwvlACjWtOmALS0fqvekuA3Ia
	 /7EX6jtJb/AnXO/mW+KN9zFrgum4VHLx/t49aZL6fF9wXJEyZFZ7eueYzaN+p3aS43tP3
	 DT27frUtv2zIi8hp1CtaAlAsNsznOclxbotcokEZ6HE32lG53rjSWO3/+9oJeGffDBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UVShwcRQ;
	arc=fail smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D426070CAA
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 16:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80D426070CAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UVShwcRQ
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5383c97c8cfso447351cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 08:11:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793635901; cv=none;
        d=google.com; s=arc-20260327;
        b=JF7S+3wDXAZLdkcDYsZMtQoTFXisWMotn75LUDhBO2ZVnyCcWl0F2EHz7ZpMZneX/K
         8pGJ/UX+sUQNbIpwaXyFGxh1Eo1i+rU+tw9bM7K+uoGjhwaROa4CXEqLzi/Z8xTSbpZi
         i6Te+WiIxp57zIOmmewlLmGmtFx4mCIfTLYdcJnTpuhpl1HUq6biZ9WCWwWQmIToXPLC
         32CPyND6kwzQOnqLRx2oy25sUX25At4EDHlnRfGDGu2EBMxbNmjviKXzHOrs2IvM0AQc
         oxSKtTZdDPgEXXwYcB1N1owFMHIBURp9wlrTHA3sam64rwL8xM+XOXYhKr5XFNGL8uG3
         TcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrJw+lkmXdlr2rkeyObnD9Bf7t1jpUUa0j+yv8MRcbQ=;
        fh=UIXEjh0eA63Lmb4LucJli/2FxtM3hKgyaBiwgSvfZrY=;
        b=DeiA5J4EdiQ9KsrQPsYHLnLKZPo7kwvoBRUtPikUVA3B51XqTOr3WqQ7PvN1sHpuAE
         7H8MELfhhgeJbXCnoT8a+5DE+/4+3QEAk97V+m5bnyXQfOf2OPvzRDs3HTM6ARtp79SF
         ezvsxX1CdfS53YgutRkZ8lQIfebmipVKUPM9S5aq0fdX/HP6ca80+0pXTGXC0Bk3frIc
         gdUi1jHWz3Zs/XxN7hBS9et0FqNPd5EjilUv6olNM96vBvK7kuSrqIiw8VPQNtu8vKRj
         WSz9yccJ6qHm7sA1W/PDRFbOf2U1LGW4sT5y/JqxOumlv7i+5ZopYVM/yWEW6tRP5UCq
         P1FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793635901; x=1794240701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrJw+lkmXdlr2rkeyObnD9Bf7t1jpUUa0j+yv8MRcbQ=;
        b=UVShwcRQgQcFvI78rGXvjmJNJ5jGiyxdNlYitzKvC90onJMRPN6vJmAdgmfOh56rvV
         q1LUnlMPBCUk+9GhMncjTbB/QpMn8t8BKt8ENL5qJr7N7+wLA994/gSuKa9SV7uC+G/g
         xnCOgSLDlLGDlD6RbNJvT6QtObRDeqImMAKSWmrRm9l09RPpQFScFxnPQraGSnK1j9HO
         BZVP/RiJ/DURRx/QWflVJ788P96U/sUHI+41MWIm8XoVipfjJ/YPFAFdm+gvJLsnAeyE
         +H+AW5pw1DnZgtL5Cvnrz0vzU4NFO2aQBJLr3mPNmXox40a6nuD6BypvDkP7QF0/wCiq
         KMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793635901; x=1794240701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrJw+lkmXdlr2rkeyObnD9Bf7t1jpUUa0j+yv8MRcbQ=;
        b=IT9yH1tMcvLCfXVcTC6n7bIewyH4nQyeeAErDxB1R1nRImpb21r2C5uePuzUylDdr2
         XgWMRMDbC4K3Se2uuJBpu6JBWeHjNHseYft7DZKAn9Bh0qefjRk05LCzY9JEJBj6LQjG
         hjrA96c+r/AFfFXgt2ZlHSiEydAFaTORNZsQR9g1OEmvigtqR9Eg/Q11KO8R2zXBFdG9
         u3wHNcBC3WYuxQiyUe7tSm/kJS8i+JlsElfdl1cIUylpOgyu8DyX/+0dU1C9SHzMm3OU
         mttFHOWhsJUxcyzRa8Yw+DvhOfKxW3J5Lm//twNi8SuF/rSxxXvrfJ+BH6ZA3nveCy0k
         2rdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxH5gc0ox48xawhbJLLpCJcTSHRjG+LBdtCJ7j3gAWFzw6LuepdZoRFmDfKPTouf3wBdKmFa7XW6MFJDqRq@vger.kernel.org
X-Gm-Message-State: AFq9FYIvWNVbOaM/8mu1/DwV52XC3RG6jq4QB38HjCg0neiVUZfqmDYG
	HvncnvLmtRi4i/w+Luc6odnlVmmvOAQFV25Htj6TXiH+UtbDOepQbSUz59ebaKLc7rDCxAfFxbI
	o9nxCsFB/gGDXxT4dECMtCIYmM54hIOXJS1PlYS7U
X-Gm-Gg: AYBFou3h/RU0VKZ5WQMurWQAl9G6Quf+K+NroS+6cUk0WnuHmQmA9cPSKYVmHjvp8wm
	YnCw6RTmss8egFBny5Z0xA3rEew+nu2UTdbYX8TS0A2uTD+F+zBSAbYLxKBlr6yupVpbwarhgEn
	a+EqcYLxPmq7j2iFRYI4Bw08MD4FRReAdSZxMjtTslUxAq3lVfr5i+P6469vszyYJKFgacTrH1t
	bc3ufHEmmTfHHf1qifmlpcXeAA0jsvSbG21WKmQIQI/WLnGtupMZn0feetNdD+IGBqVVqRwueZb
	khM8CrycRITB2UNIhW633EjA+OPzeIZsXBlzOjirJAs7Aj0hSAoPUYL5AM7dBbgvZqC+hKfV0Yq
	/qAEDvfcKNiNmmhWILjniLZPFuH0iLhl7HVYg
X-Received: by 2002:a05:622a:488d:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-5412d50d069mr12637281cf.4.1793635900706; Mon, 02 Nov 2026
 08:11:40 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101154503.3203036-1-surenb@google.com> <20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
 <CAJuCfpGmPLBRhHa_dmyP10QzyRyvcWMYDLU0+J9t-RCLBsTaWA@mail.gmail.com> <20261102080103.6e3f602364747ac6adb13f5c@linux-foundation.org>
In-Reply-To: <20261102080103.6e3f602364747ac6adb13f5c@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 2 Nov 2026 08:11:16 -0800
X-Gm-Features: AclHuK9GAGsiZrN9317-LnzYplCUiian6VttOAS32aZ3eING8-O8jgvJChN1NXY
Message-ID: <CAJuCfpGmHWiu0Hmob-PgnvWAMn=CD0-xgiyGztP+P=OFrwwfTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests/proc: use RSS in /proc/pid/smaps_rollup
 tearing tests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, ljs@kernel.org, jannh@google.com, liam@infradead.org, 
	willy@infradead.org, paulmck@kernel.org, pfalcato@suse.de, 
	usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org, 
	yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:01=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Mon, 2 Nov 2026 07:43:17 -0800 Suren Baghdasaryan <surenb@google.com> =
wrote:
>
> > > :
> > > : The patched userspace test passed all six cases on an existing
> > > : x86-64 6.18.57 kernel, with a PID-namespace adjustment. That kernel
> > > : predates ca5480fb53fa, so this checks selftest behavior, not the
> > > : intended kernel's procfs changes. Separate syscall tests on that
> > > : kernel confirmed the EXEC-merging and memlock failure cases.
> >
> > I'm guessing your bot was using personality() to make the tests fail.
> > Again, I'm not sure we should handle such use case. Should we?
>
>
> : The concern is pre-ARMv6 CPUs, where READ_IMPLIES_EXEC is set by
> : default. Nobody needs to call personality() to encounter this there.
> :
> : We already addressed this in 0685630fdccb ("selftests/proc: make
> : proc-maps-race work with READ_IMPLIES_EXEC"):
> :
> : https://lore.kernel.org/r/20260808200312.6326-1-kmehltretter@gmail.com
> :
> : That fixed split_vma(). Alternating PROT_EXEC in setup introduces the
> : same assumption elsewhere: RW and RWX both become RWX, allowing adjacen=
t
> : mappings to merge. The parent then cannot find the expected three-page
> : VMAs and the test fails during setup, before testing procfs tearing.
> :
> : Yes, the focused x86-64 check explicitly enabled READ_IMPLIES_EXEC to
> : exercise this behavior. It wasn't tested on old ARM hardware. But I
> : think we should preserve the existing support for those machines.
> : Populating writable, then removing write permission from alternate
> : mappings, preserves both RSS and the required VMA boundaries.

Ah, I see now why handling READ_IMPLIES_EXEC is needed. Then your
complete fix looks fine. Perhaps we should mention this pre-ARMv6 CPU
detail in the changelog of your fix to explain why READ_IMPLIES_EXEC
is important here?


>
