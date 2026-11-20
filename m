Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795151705;
	b=GwNMUBGNKjV64e6RsImELx8NN478Zi8XsZ4bFu1o0ivoBlSH7PMtos3H7FP06VljVvc8
	 Ey2056Wx6RiGlNxheqM50XaaZve3xI+CfMQ5Oj77j/KLH3Wnfo5tw+2XjFwDGPX+XIGh7
	 TiWm0AwpSJya1La0o/QhFTbuf0RIPBqAEcQ3QPYdwc6zkmI94iypNev51uR0G5kaD80Gx
	 UlgT+imCLZ4mBLUhix+RwH4tojQTkUE8qlBLIq3z0LP/dAxeA9j6dxnNeyilsc9AjpKPn
	 bmcKm8Sunds3RF7GRrFM3cHssjpUAcqe+eAXmyVAOrRBSUC/HgVdxJ+2QOBLR/FzhJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795151705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=36ch6Rrd/XloF+NZze9bNn6r8ieYeK3dzXudnjNJzhY=;
	b=wOba4ADmYxTgph1WGCiKcuUXWtqQ/qnss9qCmMexhfJE/b0Bh269754COT5vdw+7FX3q
	 07bMLeMj18WR+QC9bVUJRxSFO4RqqCaAiEtcxEHlF6sI93NOHFJDC6MLt/nn877nAJTfV
	 5ZJTax6rCHg2+AFkWtDv1KfwBIfwvLwrhNCM/XQTyNRaRQm+gIEFK+xSBubqZi6bbxoEH
	 Fy59kmqNJVoNxscfspWPNCfVC11dIqXTioBr8jgmqTfKG/dfT5go1iPB/9dIs+570mkJ3
	 IlnTedUOCcviEmtfoWpAa7+WrD54Ed9EDcraFVtY6Eys3XjtEZC/f3epsAZ3Ei6pG6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yEEnlkjT;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B74606A32C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 05:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13B74606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yEEnlkjT
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso209765a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 21:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795151704; x=1795756504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=36ch6Rrd/XloF+NZze9bNn6r8ieYeK3dzXudnjNJzhY=;
        b=yEEnlkjTqdCuqD3DNcfYkcN+9CeNlfHPwaP0afFf5bFX0vth1CqIqxHLznZHBzirtG
         4QPlseyBQMtLU0c/nw6l3dLJQeuEAfVHpFspg4Xqtn2oH5UG/nDCTxu0FgCHp9wd/v7o
         0BITwf0vaT/2Cd2D1rslStVDQQM0aYmUkSaORZDgEDUl1E6mfzDEkMz77yKFqUvS+6HV
         WrjKINqo2sKxoHAem9wJOnssOCGMKmp0RIHBfpAsKap/MFzGnhd0FMBoPaulz3GhKV/H
         AW9Mu/Sjqm8CzZ/BF4rFKQQXeWOJSYto7wn2RJvqeEIWqztCsLGq7NTopfX5bFZnK5y0
         rsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795151704; x=1795756504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=36ch6Rrd/XloF+NZze9bNn6r8ieYeK3dzXudnjNJzhY=;
        b=ex3qRCMKWepPYj9Xnu+X8Cxy1GTNqmxUqpFT0BSdQuizdic3MZWhc93ldlB+cBYFxR
         LB+6AsbIpQqafqfGIZDg1F0EV9xTBE0HPVTNaAa/BkdKijBHHQkkkTQczcgFlv3BKxve
         DhMBTpabtDYRUGSkeaRpba8AfUFdAwDjOZhHPimlLnSvkWdZEwh7EcW0fomJdtxRBT2c
         lST506jcd7Izn7mPca6+W8bewXxF+KPClDwHWLkmd//AogxOiXPjgFz2moyd6O7Oumlu
         bAZqbzsgEeqz7lNPcfiO2iCp+ClsLuKbjaRJ1QipQ6oFRXuBhjQnvXNgYOJRz9Lnlcak
         ErYw==
X-Forwarded-Encrypted: i=1; AL+hErG3esm7A5Vw4g/N8PD8EQoccp9avb5aAhKvsLfDIrGbhO7FMOU1UngzFXdzE30J3y/WF+YNbXFCBi7hFLDu@vger.kernel.org
X-Gm-Message-State: APuU4Z+3DwCu8u6/cN1BqMplwmauBu9W+1bhBv15UDnGuHgbbdQrBYmk
	Rju55MtV+sxKXjnTMRGyAVN59f94fv4wuOohxCOZ/PLCsQ3yk4EeaGHq
X-Gm-Gg: AZFdTZeq0V7+bo9tXGK+vL0SG6URAgjMtYycbR6v5vPprSpt1vnrPQBr1BMv5t7cfNx
	/HFfMDwENFpeGclIwvyMGVW5qYwCQ9jRrmML+eo93G/8/6DRyibzWCvIRp0svuIT2XASasy/p4U
	ZHW6z5Pt8YkBdjYRcbpSnv22++yNxRx1wd0OuH3dQDsp8TsMpANV3ymWdsVzKWvgx7CvjRJRpKg
	SPvPqznV47+sY2M5Hq6axECk+A6S2Y0iVRtpz2boFuf8YX4LtKdRXjAknvDHLI5Hy9RPkgWZL3A
	VWsEyo5wf1lmAsrX8exi1MhNYdd0D2QRhgkkSMcXvD8QcS2/ZJKOFSv3zvHxFXT8wf9SR1YVWrs
	oopg0ZhbTwo71TMcKTX8negy/PWCEqWT+jF5U7MQYvfID4i+jFrKYBn6nXyg/WlGOlzin+AxsmE
	95jF8lIVxtFyj1ADJN9JH9DIOQ2k2S8pdTLJ9qlMWIzdXce7vabxdTGtemKVxLvpFT6VU+EmEkw
	kzontFDrn11a9dSy6tNqZc8VeR8fwRfbdkSAlWEpCJ7h2lwy1eDly2mRWvNyf0O5ORZRr3RedgR
	AEGQth5qsIeOVqpRPKyTK5ix5z3iImHCQ1FwAsnre7XfWi7vpg==
X-Received: by 2002:a17:90b:1802:b0:3b4:1359:45e8 with SMTP id 98e67ed59e1d1-3b41c92c55emr1663704a91.44.1795151704228;
        Thu, 19 Nov 2026 21:15:04 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40548711esm5934541a91.0.2026.11.19.21.15.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 21:15:03 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix overflow check in rw_verify_area()
Date: Fri, 20 Nov 2026 13:14:57 +0800
Message-ID: <20261120051457.47753-1-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFnufp1LcTCLtCrd=iLxD7DPaOouov=BW=Scj_yXJ+Pn96RKLQ@mail.gmail.com>
References: <CAFnufp1LcTCLtCrd=iLxD7DPaOouov=BW=Scj_yXJ+Pn96RKLQ@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matteo,

On Wed, 24 Dec 2025 at 00:28, Matteo Croce wrote:
> Following a discussion on the coreutils mailing list[1] I think that
> this should be fixed differently.
> I'll be back with a v2.

This is still present in v7.4-rc3 (65e4fd942). On a 100-byte tmpfs
file, a read that starts below LLONG_MAX but would end past it fails
instead of returning 0 at end of file:

  preadv2(fd, 200 bytes, pos = LLONG_MAX - 50) = -1 EINVAL
  preadv2(fd,  50 bytes, pos = LLONG_MAX - 50) = 0

sendfile() with *offset near LLONG_MAX fails the same way.

Are you still planning a v2?

Thanks,
Ding Feng
