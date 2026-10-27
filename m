Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139008;
	b=LoMULIyRRO08lxapyuhEB4oQq/3eKuKsU21ri7vD5prDuPUYK69mSVR4KtGTqyOySz9g
	 ei5exogYsVnx34U0W9yzaMDnQ92mzViYyY111dhC1Ks852AvQ9NlgMZDuRLAVqy+wawsZ
	 JMfUgvRR7hCvNwBS21BssYa7WjZOV6xJf3L6/tOmq/1fPYPe+SC+xy5+i0DFblhxMWrJG
	 7KSvleuxedtHuCvp9AG8eoyJ1aEANDeaiDBmSNK6ECI5ezZbXwaiqG3AH2XefoU3KZjKa
	 fi/GG29HOIuN7TEQpqm/gMq0GL/vIUxKXfpAHhK7hAH7DywmhQRllRP2XEUWiWS8JyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fT+qwxtE+A6GcMts/RFwLqPXWbldRP/ojd/gLikqx/o=;
	b=ndYKP3DcwcOcyIMJNlvAMDnTRehVZ1KqmYWPkM2IWkDqZJ1NZ6jS1eaOBXZAGKb5J4i0
	 vGOtIE3PpW+zcnrYUwVLV94b5b1YUVawdFKTatliozsuux2JMyC4TzLFTsPIuFImSvOEU
	 L6YC6cwfLbc3xtLYkiW3TnzVnmZtfwaVkfSvFmc9shDojIj7oEnIR+SBsSShjeZM81G4w
	 +AsFf6Fq1NQ9hkQ0+W9iofSISTRoGa88qTGZkU76SLAoZj39GSw67ZnBGNNLLZ/OBI7a8
	 9THEpB7gT5/G8d9Bhd5rm9nMmP+cmlB1RGMKMcvurEyluZkwlymnlGzd2JkAu9yRh4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eK1fsW+2;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794CC606A31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 22:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 794CC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eK1fsW+2
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso2755315e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793139007; x=1793743807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fT+qwxtE+A6GcMts/RFwLqPXWbldRP/ojd/gLikqx/o=;
        b=eK1fsW+2JB+u32dztweW6UknefzXls1ygcl5CLm71Z1p1xr/SQRcK5omOGQRHtcZJe
         AvVkVl/9LOOkxYmhd1abAw2Mm8vOOTgZ1UWGFMO1pLl/MMTaF3XSy260n4/HfsRGpiBy
         JIpLGwoHQExszH0S+epY/KMiGEzSp37mYCQBpt9wYUat2ouWFbcsd5vgCRBiXuhzzqBT
         biomUCwj+SKLC4EhQNWqweICVG5qf43GhQQux8yfd9xRoCGPP2Xr8toiG51npBY3etq+
         zio8FAXRXAeRCiTxpt8NE+qiM7HLaqPjKUhzzFd8rnjlQKjHX04C3xjFWXiBKXVIV8vN
         XQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139007; x=1793743807;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fT+qwxtE+A6GcMts/RFwLqPXWbldRP/ojd/gLikqx/o=;
        b=qC3DAlQvKrOasS5xa1IG1+/d3kzUi7zu/JrUPNyHhzqjsILZ8kuSedtlcKOPtv1PnC
         OPdEb98fZ5Vj+mr6p6Qlf7yn85OTot+hrhSqsUJYJ23hDyypSRqfVfKamfBRZTLLedMA
         XlsQeqJXj/V/rV4IhRXpQ3mw4iuCNoweTLUgkwBprZvMgTn8z54dlPoqgcChgk5C3ijH
         wku1qudB2E/GX4WsbhFtc5iygxurBdJewick+5Wg/XoVq7r++5+gbO/hg9m/D7EK8vLs
         62IdVBLmHGb0y20kEAmPAKVzbOX+yrlVNcLBO60Gj3DcTfmd4k8QWQeZVf3zcPlCufm2
         JVcw==
X-Forwarded-Encrypted: i=1; AKwUvBzoYScoF2Eegl9xiSJaF6+DdapJvJFQrZ6p/i10D4DnPS6s+8FsGbzPBcI7KZRxmdf++osoo14XHijcxsS9@vger.kernel.org
X-Gm-Message-State: AFq9FYJzeJCQZRW1TWV9CegNJviDAkEQXNSgXibZHhZs0P6PBW92Vmv0
	o9rq0UcxpKd7KqwOoBp6MjMM9MEByCWNHQ0sOTNnXXyG91iWlVjL2fFk
X-Gm-Gg: AYBFou1PVZ76VyuWM6+zVefjLyiRAfHc7ZjeQSjagjsbe/TtO++ADB4G8WsSCkEzKTq
	pZpvZvvU9p759ZZmDG/QNvgfX1cY5BsU12bT2R7iPzPUQ0/Ulm3BljnBx+Af/lWGQUgpz94b0pM
	6Z6w6HbO2uP0Rjimb7Ea6b/6Agiigp4Yt5IcX5uoYXhSozJiG+JzhcJHSMrgjp99NqiVg2E8NGf
	BYLmKO5OHGKp8Hf1p4PMGKNoQHgiVSMKMe0aqEKSh7zeU1tAtGmvBFbkCC9Ax+QLibq2GAcByiJ
	2pHfG5pZiQwTgFkhsKWjEDIdA7sUs0ck7AXo1eKQ7xQ36OCbFWgbK2lEZ0dfMX0gpiGulUuQz1c
	dKcMRnRNYXjml7t+BcoAQa9mQ2yhj9TRM+0pULEL1DaUJHZbsy68f6jL2qv/cyZX1Iot5N2gT8J
	uYpaRNvI2CkWnJ0ixA4nRuWYWTg6U01/pnfNqX7iYj2u+wob0MXppBxzzFo5aGkzfVrZUc2EWTE
	D7APVUvHZdYKnxJItFGv8Y4pMi3ajRcoDkV4rgakKt7XrFUcSv/
X-Received: by 2002:a05:600c:8b05:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4a967202925mr5734215e9.19.1793139006789;
        Tue, 27 Oct 2026 15:10:06 -0700 (PDT)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3555sm24526363f8f.42.2026.10.27.15.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 15:10:05 -0700 (PDT)
Message-ID: <968e7fce-a027-4c4e-8a3f-79ddf0b2ba9d@gmail.com>
Date: Tue, 27 Oct 2026 23:10:04 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Suren Baghdasaryan <surenb@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, SJ Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org,
 "David Hildenbrand (Arm)" <david@kernel.org>
References: <20261027-fix-proc-pid-maps-missing-vmas-v2-1-2791cc9fc95f@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261027-fix-proc-pid-maps-missing-vmas-v2-1-2791cc9fc95f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 3:08 PM, Lorenzo Stoakes (ARM) wrote:

[snip]

> +	if (from_addr < vma->vm_start &&
> +	    vma_rcu_iter_may_have_skipped(rvmi, from_addr, vma->vm_start - 1))
> +		goto fallback_unlock;

the helpers make this a lot easier to follow than v1 :)

I re-tested v2 on x86_64 in qemu with KASAN, as in v1. So, this LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
