Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793537857;
	b=OegdIt4Gf4mEBQt2aUsSkCEtVMwdOmUcYUvAoCp8oqHWtqavwqWUXeXRAL4RUK6J9Fql
	 aovxDAQPg+SJbywekcn4lQeHeu80mJF46z3quiEB9F3d8oNnYAi+VJWzQCCnBk5PxwMcW
	 ALtIaaO6VFN7S0FGUkrne5vB1Chw1LDICdRsaS5g0/GKZqNOBIH09YLubeFnNTIUfh7Ak
	 5UUZf+r88AzD/Rpsrw4ZrEMOG06Ujznzb6l/F745qVKDvXXRmRxbeZKUW8exUd8htEu+4
	 ygFa4sEkYri0mnBHmnmVoRs/qa8g9B/+OmqkWihxDG9WQu8p0wHQjAS7BgFcNbHmMFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793537857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CfVTzZ3V32lHVKoOGse9NLw4u5NZ8GkugNXlom4S+B0=;
	b=F/Rr5FU2uUcwM6oVo6sFVf5PPO2JYc8++LbqVkRTDItOqiZKnjgHunYw7nR5Q4MVgDa6
	 wJPQigtmeIhkcZIzAPJnwBhME6sAYgc3IHFczbMSGGNF/YwoOJcCbo4drn/1PNNDKPW4a
	 x/GFRBQsq1MzULuYOJrDtCwKnb0Kla+Sj4WjGRKQ+gP9adEhkhGHQCMjxP0xubuWBja3j
	 7AKK4w3XmoRGMoDAm0W1VhP1oEGfl9Cs6P7sj9HQOrQleKz5fa7qPQeNoO5OL5096DxW+
	 FErPkekX4K6T/zyp8rQxCDjKBgaORB1N3DvFLaoW1K59dKSJk6QwwVw5i0tmUHqansg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wRd9PeAG;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3E606A325
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 12:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5A3E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wRd9PeAG
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so4636895e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 04:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793537855; x=1794142655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CfVTzZ3V32lHVKoOGse9NLw4u5NZ8GkugNXlom4S+B0=;
        b=wRd9PeAGDNu4HYaj86oZWrxlQJGYtVcvxZtho0H+ysJz9EqFEOZ7X/al3mVFYXd9+s
         htRkAD/r51ArqUwpfazFo0BOql/cYM+74On7zFmHG7pL2vOrllzwa1P4nPklmNxQi8XX
         9jMIR/GCnPxkjv5cFnldEJ2hdHPJ7gsnW5dIA0zcPV8VVVB2Rozhw2M97n+POZDixy8P
         SpLgcW5pFpamxD/L9H/q3VCcJ5B43PZpUuWXCPbcYNekRuUv9MEi9JVJsc0uxIahSxTN
         Wh8SsmWKAl5tdDAILA9j1roJFK1uksslGY9/BTsbJQztWGAzEopLQn7cHeHgtWO76VTF
         8rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793537855; x=1794142655;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CfVTzZ3V32lHVKoOGse9NLw4u5NZ8GkugNXlom4S+B0=;
        b=orcrbR4hbmmW8dW/NCnr6G5EoQyJrEskp1Oh55ZWgJ+gSw/1BAixPOBP8BlWDyWcwJ
         zSafYn1mDVsYjUclXXIEjKAolT8LtpC3bSlHcKiKnHZNKEMk+gBiMHxHFHHBqRgUuf6S
         xYbsDjVFjXrlpXvKELvYrMG/AB8orz013d4LGpALmmKk77USsxO4gw9QmYH7BWVnlYWQ
         ZhVvFgpmF71//YDt76HiMhVKYev1M2LlVvROFgNcaXawsvHbl9DJ3+z4OZInvh60t4PB
         y8xWIAEnmn6Yv5xvS7NikQ6J8MSp4bj6ahnHt+1JHHVzAJVT50g94qgrXS/RBpH3HsJX
         HlQQ==
X-Forwarded-Encrypted: i=1; AKwUvByF8cYBuIQEia6hz+6lKGFM7eKrZQ/2qHFc7vtf5WaxDTghW392XCZsBTrbUlNrjHWsBLXjEIrgEK/2C/Sm@vger.kernel.org
X-Gm-Message-State: AFq9FYLHncPd4wgt0g3JlN9n6rsaaLT74raCAILXmn331Mfx96qJuZbt
	jB8CcqzeZ3RiyIuvWWuiIuobDFYqRAaWzElQ2VoErej+uvYlLrhRnoo=
X-Gm-Gg: AYBFou2PjaDTInjZTX3qMgkaS3KRTI9y2VuR6kTF/pQmpDgH86wGNrD+IYBZt92O1nX
	ebsDzZJzo+EbcOZa4cdOHxNqWtQO8g0n6yYHDpIP1sVG2VaBsY9rOCVLdRo/odgMUYFVfocXBW/
	PDxPSlZqvxejOYHn5IbrdXA0iv0IdgrpMZQoRYiB/MTOYL6Z6c20HFOSLSwVu/YCZQhMTbCXSED
	OkPMjIu+B0Z8ZsRu5GFLCU53sxZsp7cmo2R8FJy8Mundx/ZjNJtFzPFjVwvjBMZG47IdsZiyX/D
	DBWOSwjLsKbVcydd36qJg1m/LXX+eidr5qrdkthKvyczkBTjFELqLONOl7C9g6uoiCFv0yicrNS
	bsiqZ49xsaxY+QEEINxwRqKG+f2sH5Zz7WNJBjD6N3IR0qoYd2lRLat/ZyuHaKlQimmLDA4IHTX
	IE1fruIQCU5GoKofefSd9idNClU3H6V941MhV3pNjCIZNzd9n//Os/Xe1dItizRyHBEaP7vXKMe
	yTxmzaTiNrwasnLuvGzODJQSur8gssyw/4V6gqWpO9KpoxuV5lAqYjimkDNg/l3BdNvYHHFG8dy
	TmZ4iyj4ciSk
X-Received: by 2002:a05:600c:848c:b0:4a6:42cc:bf65 with SMTP id 5b1f17b1804b1-4ac1709b206mr183360695e9.17.1793537854992;
        Sun, 01 Nov 2026 04:57:34 -0800 (PST)
Received: from p183 ([46.53.134.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04785sm273172295e9.4.2026.11.01.04.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 04:57:34 -0800 (PST)
Date: Sun, 1 Nov 2026 15:57:32 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/proc: proc-empty-vm: wait for child's SIGSEGV
 instead of sleep(1)
Message-ID: <65faff9e-5c1b-42d1-a450-b9c66b08ba25@p183>
References: <20261023183434.9109-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023183434.9109-1-drifabdelmalekmohamedsaid@gmail.com>

On Fri, Oct 23, 2026 at 07:34:33PM +0100, Drif Abdelmalek Mohamed Said wrote:
> The test had a TODO asking for a reliable way to know when the child's
> munmap() has finished, and used sleep(1) in the meantime.
> 
> Unmapping the whole address space leaves the child with no code to run,
> so it segfaults. Since it is traced, the SIGSEGV stop is reported to
> the parent through waitpid(), which is exactly the signal the TODO
> wanted. Wait for it there and drop the sleep and the TODO.
> 
> The stop is now consumed up front, so SIGKILL the child before the
> final reap.

OK I recall what's going on here.

The only thing to worry is child pid reuse but child is under ptrace
so it should be fine.

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>

> +		for (;;) {
> +			p = waitpid(pid, &wstatus, 0);
> +			if (p == -1 && errno == EINTR)
> +				continue;
> +			break;
> +		}

do/while EINTR loops are shorter:

	do {
		rv = f();
	} while (rv == -1 && errno == EINTR);
