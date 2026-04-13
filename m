Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572F21FC8
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168458; cv=none; b=Kp1uP93DuTpSWA5myiSkWvuT6CJ1c/u4F9anct42kJWLRCOAWSfGR51YlF4Bww4xn7AoQ8EpT7X9Tb0muFiEACzLQ68g+U5Kmqaox738M0uBVtGX+wJZsLORaVQSghd0r5Hljx6sxYK5KqAuC+GZacj7L0KrGNZFDxu+erDuuhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168458; c=relaxed/simple;
	bh=xyN07penaBjOnqjgXRleGdStAPrDLYXA2j+8PcQ2Ym8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t2Ns8LTMIEjC+/a9UEAuDkTC7TtOjOtniyqAEwjm+Ttt6+P4yoc0E0yHg3cnibwt5AHdk+CX9n7FHQ/rA+j7HEcvU8n8TDFNAqWUZ9xW9K4iKmAF0KdBxHJ4HpGk22sZFOfZOi3puKxDAPYtJJB8WN2sY/kIg7wHIWzHN711nQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488822b93c7so6115465e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 05:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168456; x=1776773256;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyN07penaBjOnqjgXRleGdStAPrDLYXA2j+8PcQ2Ym8=;
        b=n4Ho6rIGoEejfPQBqczl+GzARStUjzQ85QycsSOmSzHpBUMXiEWGwtoiDCPGE9osTr
         UKnPNtqk9bXE05wN4BTNLPa+GiRk/Ncezz4hzlv5igRU6HQnY56Ufiad7mGtNt9dx+4P
         hIpT/TezEHwJZvDze4566v7YdPghpCFuMvaIiv+P6GSLtgGMWkq1DQzphrkmHRh5s90A
         wiEuq0XE79IFPZuOuxNgQNWNEOprrgtFtkuffbpvhbrLomoxMXAjIaO/iY7SQwhNvHcF
         +NMoDsYF6WijUyo2yYOjqpXxePYsewa3A4jaCs9GB4D+xKEJE2RQvFAPeMTLMiU7DaCE
         lLrA==
X-Gm-Message-State: AOJu0YzEJq6wrBdGLMiP4d0KO/OTkUYVnH9dh0MeJTJgX57kxjBHOGsr
	0qzzvHfuX+5/p2Wa9MRj4qDs4rDihVLKc0iooAgDEgUITYjT9xOYqE9eeVgidsG3
X-Gm-Gg: AeBDievlSR5MZgG4m3/J+t/c3wnFhyd1JsbEo1/xwb9D4JPp+VPemHK6AG54lAzb6b1
	limR6IYVib26gDCIsElFjf6uzVqdHs6iGvZM4jo0b/gfbb+C3CZILt38ij/s0d1dSMGNL5+kbL+
	hYFDB91ro5bj6cfzNh9cBFaJCH2xTue1G5upVzzYG5yZBWCRNxncBRg37y6V0NT0Kfpq1mbphDR
	WYiqxOojobEk+VjtTnYQVGmDpPpmMULDIsJ8lWMUaZCvZ34UI0pOJl9NHltp4QIlhME3JDyQwm1
	IHpWiNJXP7R3wVLZO1F1zeMnoWVoCcwEA5AB1/8UGQ4PX6GfUE8pT38kfD6NvYH21tXUrHkvnKb
	6yblbL6l5Sj4ezV6K8UDcQpf406mRXhflCvack1NNQmIjw7JQYt5D3VnWzbA4vUcKN3Y6WJrVCp
	f7B1yXkDXO8tSGB5rWMvg4Jbn98TwwnFyBjgfKlsyclX1SdTeNPKHDw44R5ip3fQXL53Qtmvb8B
	kvZClBc1vuxnSUg
X-Received: by 2002:a05:600c:19d4:b0:488:7e7b:dbc2 with SMTP id 5b1f17b1804b1-488d7f2509dmr120055815e9.3.1776168455497;
        Tue, 14 Apr 2026 05:07:35 -0700 (PDT)
Received: from hackers.camp ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede24977sm46608195e9.7.2026.04.14.05.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:07:34 -0700 (PDT)
Received: (nullmailer pid 47961 invoked by uid 1000);
	Mon, 13 Apr 2026 17:26:55 -0000
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 01/10] ftrfs: add on-disk format and in-memory data structures
In-Reply-To: <20260413151158.GW6202@frogsfrogsfrogs>
References: <20260413142357.515792-2-aurelien@hackers.camp> <20260413151158.GW6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 19:26:55 +0200
Message-Id: <1776101215.268662.47960.nullmailer@me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Mon, Apr 13, 2026 at 05:11:XX PM +0200, Darrick J. Wong wrote:
> I don't see a block header for indirect blocks, so I guess this
> filesystem only supports mapping ($block_size / 4) ^ 2 +
> ($block_size / 4) + 12 blocks? IOWs, 1049612 of 4KiB blocks,
> or about 4GB of data? Why is isize 64-bit then?

Correct. With 4KiB blocks and 8-byte block pointers, the maximum
addressable file size is (512 + 512^2 + 12) * 4096 = ~1GB, not 4GB.
The 64-bit i_size is inconsistent with the block pointer scheme.

For the intended use case (MRAM/NOR flash on embedded space hardware),
files are small and a ~1GB limit is acceptable. i_size will be
corrected to __le32 in v2, or explicitly documented as capped at ~1GB
with a build-time assert.

Thank you for the precise calculation.

Aurelien DESBRIERES <aurelien@hackers.camp>
