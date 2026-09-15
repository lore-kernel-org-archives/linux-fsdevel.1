Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F473B442B
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473669; cv=none; b=dnGCBcOJ2K+0UMr/D7rcT20h7UeG+bBtJVbw+AUTsWuUswymR/5YUDcjIkOz7OhnTR5Qfoj0X+jpgvSh/kjI43oafn+62YJOl9NIgPJ53iJONMNi0xrv6K5MOiAbXlq96pRyMAUhWz7cFb7NeKY/FOsgt/hEzE//IQ/dz36encU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473669; c=relaxed/simple;
	bh=JQ/yBgCAUcWNM14es3udFCXtoQZC77jRMS5iOTMYSu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVZHCtDETsUoETJZs4/hoJASh9g3tSB0QnHBzPRz7MFzvsa1TRzqSY/m/b342dmY+tkinyxReWb+LIZBapU80F0p5Wp2AnKAzATthG+Zndo394IXpjNDNxfri2W/ZOzsdcX5Emk5cMQMKICYFSFVhxVFBzVhUqs2aIfxfjBw3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ZFjjE3j9; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ZFjjE3j9"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633ecdeso158106f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789473665; x=1790078465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXnLznxt+LUzVKSpuZUKgVMVIlvhchloL5kq22Pk3QQ=;
        b=ZFjjE3j9PqOA2kembsSKz8nsdmpJ98MNtQayaQZWOadL/gX0qxugq/eVqa//Fj7/UC
         JsbtVfR0gfQG602Cb19kLDth0UGzDqvF+MSXt1yyPDUiHF89MQV0t7HJ6xhXrKIjGZgy
         Z0xtHzdyYQ3lAPxsZLsfgAIYXzoCCC7mSIgtcG2a34ETCzhNY1FT9gOzcOZ2nJ0q9dQa
         bhqIBcTXMBAhu/xBAw1NjQBvB6RaQueDozW8zg4jQLxj5nyOebk0tsBU37sIwDb77PS6
         oMUMa9c7sbKadd8WBS+Ad8rfo235LQbNOKtvgRociPZSCfD9Yip8bgYDGJ3aD4jISn9w
         bNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789473665; x=1790078465;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WXnLznxt+LUzVKSpuZUKgVMVIlvhchloL5kq22Pk3QQ=;
        b=bqc3LVaK/SYzRSGo70Q6W1VASd8cuihKtRkdE0OkdZovQjh0LLdwJ5RW3xBjs/O/9P
         9Go46r7x7U4pqHQ+QG0RRsWDC5LMliG8BYeOC41ev02HG7+fj3Y6LkWFZiI8LmAspRbY
         BKhQUHJfxm66twhlO1AVcHDhsbICCn5Y0/FPUxzsjIhXe61Tvc8u0TiqtC8uS4dSCGmB
         xYN3ZpxJxvtxRmRCNtCKstY9lF9M1R18K/ho0rANEGSCFEqpmsCemD2Hdn/RgDBB8sLn
         6vtIRpRWKCy6IVuy1zYV52vfo47QVIhNm5asq5eL1p71cnwke/b0ogPyYs6oELh6SnUD
         voAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKueahcNlVvmaKbgcDoll/DK/OFlNKHvCN07w2DfECD5HHbjnW/6qAebkualKJzUd0xAsOO2NSHfTfrRfh@vger.kernel.org
X-Gm-Message-State: AFuF++kNiRy14zYvOJb+lBDpTMhbJh308ooEW+3a5V4n6O6KK607pJnG
	9yl210jorHwtaKhJrHe/2dl/r0PZy13FNB3+SG6A3HQYdtX+W9eM0/L27bX/xMJ2IQo=
X-Gm-Gg: AYBFou29Dp3MHpQrRjDKPOkG0vn7YUVGAGTp0sNRy0kxl7jVP4F6IN0UOcWYNC1EYxL
	8C0hVZgaJ8dmwnLqSfeJMcosReRbPHsxlHJ/avkNdR1wVSEgzn8cNcI0LIuJWyNtQo6j04p5Ihh
	gG3qNhvTrF9/FCUq8SfoT10kxtsy+sWhpqkKm9ILx4TaKHHbIlEIN1UbLyCbVDaQvFXWrKUwGX1
	w/xGqtbXNHmBOOP5n8ja+Rge64mKyflj8lzzgotR3bueizAcDXNBtpuXk/rtg6zGVHmOCihbttD
	8T/F7nn5NcxT1fe0uaecS6nG8uNpWaEh08WJqPGamGGyLaeVpQD7p5tEyuKotK/3AZPBTvS2lF3
	UFuC1fNKR4hPl24IPwveK+LOS39pf83WOeXzKjO0jgKycerEX2fDh3RjDYWbVy5F3QwFCliwNMj
	BBATvjGQg2pchdidhZ9mCOj45xHln5TcP1Zm9QuGMCdTtumPCxMoXn8lhOIVavXh3mGDq8D38wx
	Kuu7L6/8fuRNJHdUcahLZQ1mn8uD52ak2zyEGNbhGzi586q7l4ZJMuDAFfalcA8agHKGVoe7M0T
	ECO8eXqKKXv05UikLOzgsP4tGQ==
X-Received: by 2002:a05:6000:188b:b0:485:8bad:fb4a with SMTP id ffacd0b85a97d-4870a952919mr622437f8f.7.1789473664622;
        Tue, 15 Sep 2026 05:01:04 -0700 (PDT)
Received: from [10.160.16.196] (150.red-80-32-100.staticip.rima-tde.net. [80.32.100.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35bed0sm35665221f8f.32.2026.09.15.05.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 05:01:03 -0700 (PDT)
Message-ID: <b860e9a8-9a3d-4a4d-950d-69bec1792144@kernel.dk>
Date: Tue, 15 Sep 2026 06:01:02 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] coredump & signals: an impossible affair
To: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 4:22 AM, Christian Brauner wrote:
> Hey,
> 
> I asked Chris (Mason) to look at some of the coredump code with kres and
> he found a couple of things. Some of them I had already found and fixed
> but there's some good stuff in here.
> 
> @Jens, please take a look whether the io_uring fix makes sense. That
> kres thing added some patches but I found them all not very good and so
> came up with other fixes mostly.

Both of them look fine to me, feel free to add:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

if you want to carry them. Or let me know if you want me to grab them.

-- 
Jens Axboe

