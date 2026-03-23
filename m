Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675F1A680B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275659; cv=none; b=GAXF1q9b/J/vrFWjn/dmHKqkn5bvo4kXLZ1GTcf4ogsKdnuJRdJR6rE1C0TZBYr/gmDDlfnZYaVsuEktJWjfIE9l+hkn+MJeo4yzgy/kncBMBOE56Uk9gmI7JUxsFqYMcU8ahEkiSZuWcnXWPdqarzhTnzlC7BSBySWP701jwkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275659; c=relaxed/simple;
	bh=zASd+EOD13ftIhyXflTViXMTNoBklIHpY3QeXreZJdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GO/fg2BaBe2Jev2JItfWqjVCJMdNaCZoxCjlI0kpiSzaqnHCFrGWsLAQQodEIiSpUkeFr75pVsH0EwOA7eQ6nrwfmviDGT3CaMESZwes6DXgGl0hPPVjKmDecrfiGMoJbFijRy3478xEOUnzbmUP+o60Cxuw0Yvz+frC5vD3eIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aZ0nyrmf; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aZ0nyrmf"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4645dde00a7so4100565b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774275655; x=1774880455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEq1d5NT4C1cBdRHUylNiTgQKOSaQf+PeJbEdc2Od9I=;
        b=aZ0nyrmf1eOBguV+l7xSHrXEiVYNi1mlCoj1X/HehYuH8cmnnWUa1IlKRvfwuVKLyD
         aS9gaB86VJTtLyUTYnD1r48iBVaPhpnnyvoLPzFMB1WnvNVZ1oRXisYep4uSOH0dk3K4
         FFPmSrn8B97wbFk8NsqelzgE4DXt8ygobirx5kuQIx9t24/zY4Klaa7ZV5+lXrDjCsMn
         Bjowt3DgIh7RpUyQBvTU87opCZQY88pLKf5ICRTTeMwxYpflCFaxDj/7Bh2G9+07v3Yr
         26zA6BI48wSyMGsUt1Z2HGb8qnCEmbFhcVoyhfZRshYcW+Zzj96nQIRB3B71ssfwSp8X
         jIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275655; x=1774880455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEq1d5NT4C1cBdRHUylNiTgQKOSaQf+PeJbEdc2Od9I=;
        b=IdQvBWv938/i9F1gbe8f2etMzwXs7jotPWnT4PajimejmXQASe3ZqPRIhVKcaVrjMo
         CPD8+frjDgQs8ZMbR6gANriOtZ47+j+ZqM0cuPecOodfA+s/Nu7BBm9zJH5onw/zVStU
         WliyOxw3M0V5YTj7JCfJs4q8Ozxt2f69cy0VRSZ99yEAG8tzIWc7+5W3urVpXNidBBdU
         AyvXmoGcgsvXt969epwNSgwJvJ7MnlOQWCrSl7PGfUQAfymI4LlUKU6ce4fBveVmS83G
         ISxY+NG4xy2A5uOoR2uuJK73K+K+RiHib6ZUlR6N8l9cEhq+BN/rv7U/5uDKkvrfKyyH
         YMIg==
X-Forwarded-Encrypted: i=1; AJvYcCX9nM3+GazWpFtgoPHjqFLFiM9f2UvfcUecP1VxXkZvR1T7NnpoH6+S+0DgyQAWUmcOvUXnYbNC/30vJx7b@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqH0Ww4Et9fiFM5VnunC+kgYqXbqZFxYUuGhH3Ad8xVAU9K3Z
	7jYKKx0pq1xDR0glzaQibLY/SKNa1jLTH+3qMLMCPxszVh0ufIsslyUqDWg72EdKif8=
X-Gm-Gg: ATEYQzwZU5egF/IjWE7KGqTj0y7WGo6AdK8BrgFoJS4h3uCU9uz2SFox5oYL7W7NM3p
	p/Fk0cBdOmaDQSXSnsmy+4ImDntdfYyv0ytZczmEX6HVK1JrGaYI2UVJEmKP29xpmEShIKoQsfr
	q4DvneSlTFlpqb2wpJk/fP2DFmOyVH/Fmo2AifJvkgIXm5sWh+Y4st/Kh90HIHaszzz15dJB9Kn
	/hJrzUyy6ToOl1RdwLpNMwTw9+ujZMpWgKPdnUUMiSn/Puz7Y3hWYB5x0leU+fdbUXf16yWbS43
	G+s7jKxIN59021BmC+pLX0QGWkW/ROwrKedNiIJzPFytPv2NT758OY2c5S+eeUsMrwUWkLdJzCR
	JBsZf6uB98gJPEHF0wCXL743mSwFj6Nu0bFwPRugVyU+khTVZZ2n6f5IkCvUed/jvM0sWi8Ka82
	6srEEjI9DdqwBLFwmtksqYjwHNaEAAvvDTFIprqapRV6ySvfNRLxmp6c5Qny8MKUiW2DSd1lOu3
	0wGm6/kfQ==
X-Received: by 2002:a05:6808:17a5:b0:468:1f2:5336 with SMTP id 5614622812f47-46801f2801fmr4546884b6e.28.1774275655162;
        Mon, 23 Mar 2026 07:20:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c148a90f3sm10715182fac.1.2026.03.23.07.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:20:54 -0700 (PDT)
Message-ID: <4970a06b-95f5-45d7-86dd-1055c1811ed6@kernel.dk>
Date: Mon, 23 Mar 2026 08:20:53 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] fs: Export new helper do_replace_fd_locked()
To: Christian Brauner <brauner@kernel.org>,
 Daniele Di Proietto <daniele.di.proietto@gmail.com>
Cc: io-uring@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
References: <20260321232142.911280-1-daniele.di.proietto@gmail.com>
 <20260321232142.911280-4-daniele.di.proietto@gmail.com>
 <20260323-kocht-meisennest-ac89063f104f@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260323-kocht-meisennest-ac89063f104f@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/26 6:00 AM, Christian Brauner wrote:
> On Sat, Mar 21, 2026 at 11:21:41PM +0000, Daniele Di Proietto wrote:
>> This is a new helper that installs a new file in a specific fd number
>> and returns the previous file that was there. It requires holding the
>> files_lock.
>>
>> In order to keep ksys_dup3() simple, this commit introduces a new
>> static do_dup3() helper.
>>
>> It's going to be used in a future commit.
>>
>> Signed-off-by: Daniele Di Proietto <daniele.di.proietto@gmail.com>
>> ---
> 
> I think this spaghetti here is really not acceptable and the export of
> do_replace_fd_locked() is really ugly. Please try and come up with a
> solution where you modify e.g. replace_fd() that does like 90% of what
> you want minues that "needs async" shortcut you have.

Fully agree.

-- 
Jens Axboe
