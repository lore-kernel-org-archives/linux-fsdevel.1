Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660657;
	b=rXqKF7Y5BEv3+n9g7O1M5XFPVtBh3nNyIqdm7IAibSrUpHMXBvGJbx9jtXVQSBurYHtL
	 zfmnHc9JfBWIfpXB5V4drNPD8+bilC3isdYcg3SsX3OuNBneaAj6Q2MzgcaY9jqhzyWKV
	 SFOtqNVtOc8eAKetGssrmoQuytpwaC4OJqpqEkoWCtcqjyZ7w5kKgHssNfHd9JwqxsL/F
	 02d20Q23okKmzb8oWsUGfq2zgebgi+WfsCQb8W/gSEXgiAXBZ+FfElxoY8q8kUcMW86E5
	 zg8bSFlXlpbM0ab0UajiI7O4Th3MOwVjd0BMfBituVCJ8tpDmfC4ookAFIeawlvaayA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2kq4h8stbmRwpSHkkjko79M5iC1GcJ39BIlnO54OGxk=;
	b=orGGK5Aweq4dFSmBEUN4TZ42s5oUa+2hKl8KhBAc59s7eVQ+60dtrEuU+Cp2jZxVVAHs
	 MXo8NZJCWOTca8+fOlA2n3NOPZoUs9RZLVQr2X6BFvcmjdAY8LKZbLVXsgPFHkDuac+Sw
	 YXkqTiF9e2Ofpigc49N0+H5k82I5y5ukzlWo3VDRB//OtkZyw5xgSaDf7zpKCr+CoThmB
	 WBIPzyNK7T8+JbqlWUGY23SiSwV9TPMH67Es1XxxUCxvAYHNWAnmZZTzhNLd8BrsOK7HU
	 MDiPr6ND7RE6Z6nrFrlramLxv5Fdb3wc5q5QoLfzDxiDuExUciO4eU+DaCNLmcbe/ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=fLmbAXN9;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054D606A33E
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 12:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6054D606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=fLmbAXN9
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91ea0c05c92so33758396d6.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 04:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794660656; x=1795265456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2kq4h8stbmRwpSHkkjko79M5iC1GcJ39BIlnO54OGxk=;
        b=fLmbAXN9Iqc0pev45nnyURfiaA+qA3Nhv5XHVN6XKwwH5o58M77MBRgCGRM3yj1WvD
         ieMQnqFCxluHSTdhv/WRaqSI72EjJuhgmqDYa6RnD+T9yebaSrS/578evDIxUfk3hsZc
         NKCwWfuYP4UnmcxbRxPGeYEE9B7quhJoDRv2cRRmrnpCCMVyDAk2rpzvUYuO0jbCykiV
         jeez7BhubtWySp/YT+hiAkvuRJIRBXXI3HnQuOPAePCDEEY+7MhdI0mgTtMRyUcCkFaV
         vzWLcdIBp0x1VHPSRs/bHgBsLTnEi1h4tOIUrUmRBdF8hgHoRY/th183N/nQDmhfm3AU
         REIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660656; x=1795265456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2kq4h8stbmRwpSHkkjko79M5iC1GcJ39BIlnO54OGxk=;
        b=jb4ycKvZn63y0VmZnezZajSGFzSoY6WdcK3ahRw5fgAIMzAIbKscZ3KnLMKKQ6ruO6
         pbKe5EcpFLy3zdxpNHSsGv65CZx5gtMobmPpMZD1ioIZ9gWvLmqYvkj7Oh4imR6M35hw
         LBZOIxwnIMB4A7zMAiMy48t/i16pdKxI43EpTtdQrEMjB0vtWeBIXNMsbvp1KqXVx77o
         /syCUSy8TkgVzmfxqspjGHryypt8I/SRDlNcIBmUDHC7le6UbcRracC038N5RCIEY/vj
         E6zmy9FCEmlUmWYwwxfKmnnS5tjGlnbJpiPgs44/RwD8ZgkuOVqM9TSalCZ1YzsjbCoy
         llqA==
X-Forwarded-Encrypted: i=1; AL+hErGRR9niyLfehsSrp0FC8plUAbHWVWLPPSdqHKHbf4U0yKIKCoq7+02hqulW5UClmIfAHhWPkx3lpkE9fpGm@vger.kernel.org
X-Gm-Message-State: APuU4Z/dAU3dHAOHJ/tOp4R/j8VCymLBu2NOhfWvUxzfUOWgddlboVbp
	kM5B7jTbplvjdyN909YIriEOAP540tdp1tcNb6ex33+OFeDNu9c77w6sLUHXk9QeBQ==
X-Gm-Gg: AYBFou3ipqRQ6iHnN33jnrnck1ux3V9I7GTuDVz6j7tBFGQArBZj4o6fqYqQA7DYQKs
	MAXFQ1g71XbNMsoqQIiJbRw+Y7eT/Zku1zbnSHw4KH3WcQANgxWwmaqd4b3ag2Fhs5VoW3Zxfcd
	E06wIVql1gmPrWHIkhQM8PWYzRmfSbuFUPLIvNvu1E5OlWSfxoRHcujlDujLHwZqSR8hzM2KFiQ
	uVCF0ePj7HGaElYMaVEirmcHV4u7liZWpgPxQZ0PwjpZd6cWigPNFUIB3WS7STPWTiUAyImteGr
	psgvU+9mm0M6Sc8gT+le7m3UZomKCTY8Lt6Xnmr5TqDu9Dwqhhbb61aiVXm0d7hga+8yGEb5o4t
	km68fdWhXztEAz31HMovo8UO8NdCPYtm7N+MIUzAdXlF6jydJ8joUSCANiPaPv74uDolUXWBZWY
	/JE/J2XxX0b4wVHMBXEa4qKqtdnC5Joew1MCOsYFqMIazRmtbJ0wwF53o/GRF/t8Ox12LFQFJ1B
	dODWWzUSe7Qtl33AzhWtwNb/0yG5aq1mNQu/C59yWGY0pbZXljfimRZNPNdeUjh/qTsf8M1/Kd4
	qIbgjqZLi3cFtdrRgCjJbPUzCmg2KmKQg9vxg1H4z30DFCBdutpO
X-Received: by 2002:a05:6214:4b10:b0:91e:f04a:b237 with SMTP id 6a1803df08f44-91f242135efmr89847176d6.39.1794660656394;
        Sat, 14 Nov 2026 04:50:56 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23dbf30dsm42338146d6.44.2026.11.14.04.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:50:56 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] hfs: do not end readdir at i_size after an unlink
Date: Sat, 14 Nov 2026 07:50:53 -0500
Message-ID: <20261114125053.466665-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <bf79e0f0ba166bef46dc5d196b0877dabe252248.camel@dubeyko.com>
References: <bf79e0f0ba166bef46dc5d196b0877dabe252248.camel@dubeyko.com>
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

On Thu, 2026-11-12 at 12:45 -0800, Viacheslav Dubeyko wrote:
> Currently, I don't understand how the issue happens. Could you please
> explain the issue at first?

It is the same issue as in HFS+. I have explained it with a small
example in my reply to patch 2/2.

Thanks,
Hengyu
