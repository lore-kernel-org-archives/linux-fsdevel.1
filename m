Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9129E11A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041516; cv=none; b=YTW4DniD5E/IZGjmpZqgq22xUAW+GOaeZ1S/hgJszzKD/eHX0qZXDzl0BWTc7+Q9Xdm6FmdFfgYWP3+a3IpFDip2hkbJ+NXjo6XY4E9aiFZrECTJDOulDel3jeYXs2Jg89VWYj45BI9qPKziwQwbZudBrycan8OgnMdOpc143P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041516; c=relaxed/simple;
	bh=MoKxMu3trW179Mtx8T4bCvrDvhYRCia9C6wY8DzRR0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYvL2nSE3rtlKQeDfGgODBNbNR986X81tTitutfvhQxj3av4lGot5Zj561xU8xxMb5mmKGmHfaQY1lwjkDuzb3lgtmGK4BLPBi8rxUm/0Ht1hpYREfZ8RXLJRQ6Dfgm+RnGNDHOVz5jEEIub3zoSmrA88FtTpuyD1acgvLzwtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvKG9+94; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvKG9+94"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4980dc26022so43817175e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 01:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787041512; x=1787646312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MoKxMu3trW179Mtx8T4bCvrDvhYRCia9C6wY8DzRR0g=;
        b=qvKG9+947OEymD95nqWCTSTa6+9aWjlcxfnGFM/3eCE5QYh4j41vIvS1Bao6h1ZPEq
         Z3zN8vuTaTq1BZAorKCnsj+LRSMd2KC4PafUtK9lQp3iaABI1Cp3Wu+Bh6ghK+Oge0uA
         SWjSQbez0MabHBqfoulRqacou8Wl/88+MBVaUVhKUVmEBdKikyv4L1pxzAJnPDLhHNuY
         E1msif29CTbVZd0xlh58vyhJcJRsbSyTAixDtUAV9RubUzBj/bRBX8Ytxi3PNhyFD+6o
         TfuJtPVCtwFebPklZOTtEg0YpALYowMc1tt058vn7Z4Wt4kgcTOL0p31XRzc6k3GrhTd
         VrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041512; x=1787646312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MoKxMu3trW179Mtx8T4bCvrDvhYRCia9C6wY8DzRR0g=;
        b=SAYo318bFG7kQ/FQOjK9kYmbYTjmUdr2tz9t0guZMjCeEqQX9V5alCbtSWrQi5PfrA
         TZu3kYDkUD/3jQ1N+wjbdb2juCANnUal0e2cqM5ezbYCC/zIYZkGdclLJ1ZH1Bq5Dm3C
         H2TZ3Yf4gIsg+JdiHrClHoljuqITr0GHQadZC6oX6mol3isxh0Uu2MnJNmAIKC673q8b
         q+isNPwNwG9JEoFASucZ4fK8kxC1xMfShwuaLfUHPEmiANOq8KtCA9KV0n1BqXB8F/Hl
         KPbPlccIcW7w+tkF3gqKTwchhLNX46vlDW7t5SXl+rrFMDiH/yI806zmvjg+Op82inUC
         7z5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrdIxQF2frCOTrtFI8+3khbjwWbawDemi27yqsbVCtroatNNolh2OHEWluWihhGLVDYrKlonF9A3Jap5Epo@vger.kernel.org
X-Gm-Message-State: AOJu0YwD44NkL94aIHjSSUecLY1s/549QmBelJ/HQdw23G6DBUplzrFy
	mVi6v/j7/wxaDCOy8NKmvp7pAK00iBXGs0S8Bji7jNR2mEirJ4nD1ywi
X-Gm-Gg: AR+sD12OnoSygh2gF6usy8NXmSEErcZ6jBky7BQA6ixc/Y/RYe3PwqAPw3yXdXTfoPo
	OHPn70MZWPFa70lRHNU1InLlMO2hcqGA69P2ziI9t4HqYNqOy4yvGXyzH6pxocrMO7Jr7/8wsXu
	XnML+hncB+pwaZ+AxXxWlH9KhVDVLW6QLC57nLFQZPJ9QJWU8s5J2x8Mxa8yMCpPhHzUZFWkKWO
	l2RKUKy4YprE5rsYoXedz+9xg8ZPs0V84tvJr1CsbElaC87z9UK0W+YkRFQam4oetqCT04GghCz
	obmkEJXzrbdF7iWzVxKyN4TTxEgzcLJ0grOAi4/cS5qLpEgEUlokK9MPEIKhRCtFoDsp8vX36qG
	uWiJmBQIkJUXH0qzC6yoWs0x73RwpEPpp/Rq2j9tyNe30M6TUudvXHWBP+4P4NtfqnMcr9ajNMh
	/BgNyzXdPWYR9ZPMakJnDYnB3fZMOS9i/jQ3UvhTfOkVfn3w1TqEv2nVMUNfy1GuaseQTTTW14R
	/oV
X-Received: by 2002:a05:600c:3f06:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-49987961c32mr517262115e9.9.1787041511977;
        Tue, 18 Aug 2026 01:25:11 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482aa084a64sm4907363f8f.17.2026.08.18.01.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:25:10 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: utilityemal77@gmail.com
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	tasos.papagiannnis@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next 2/3] bpf: Add user memory access kfuncs for linux_binprm
Date: Tue, 18 Aug 2026 11:24:41 +0300
Message-ID: <20260818082441.4091-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <any3wCj66dWbwgwT@zenbox>
References: <any3wCj66dWbwgwT@zenbox>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review!

> Would it be better to handle that case transparently rather than
> requiring introducing a new kfunc / leaving that gap open for NOMMU?

> Either return an error or perform the copy from bprm->page[].

> Unless there's some reason I'm not seeing.

My understanding is that there is currently no way to use these kfuncs
on a NOMMU system. Although CONFIG_BPF_LSM does not directly depend on
CONFIG_MMU, as far as I can tell, no current NOMMU architecture provides
the required support to use them. For this reason even if I write that
code, this cannot be tested.

> It would also be better for portability across NOMMU / CONFIG_MMU
> systems (the exisiting kfunc is never registered, so a program using it
> would be rejected rather than able to handle the error).

As you suggested, I would propose to register those kfuncs
unconditionally, move the ifdefs inside those kfuncs, in the case
of NOMMU return an error (e.g. -EOPNOTSUPP) and allow the programs to
handle those.

Does this sound reasonable?

Thanks,
Anastasios
