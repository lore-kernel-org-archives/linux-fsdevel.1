Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5F3A7858
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616209; cv=none; b=BDUpQaRu6U+ZBeXWDQCgPt3d1fjReKCdAGqw3c0rNAqSBdJukvIxZUY1Uj7ceazbMHapL8jYlRlPlOnJPsqDNLBjhuxLD4Qg2ltwVwuyy5GV4fBa+RI1+ssk/i44awtC6/1wISbAh0LlEzoX9NjAqCIc4RDTIawZ/1sp9/ghzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616209; c=relaxed/simple;
	bh=icfVQZTDpssRWG9KVcnT5QAPQw3lAHsnDTRA+hX/t/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VopELy5DEabLeVTGzD672NR1BMe3LwW6ZnN7NYUVZS4NIV00qNgyFiyfdfm05wyTONItskoAlnL2e2vaYXRfi3rLV4xmIxPD1P1UlC+Ne6Bi3MgnNq8Q2ypLi42xOyFwgS//6A4H6o7OzmjERTgL1irwhYSJaQ4FBba0hzFLFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=RoMHqMkC; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="RoMHqMkC"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479d68a9063so2240911b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778616204; x=1779221004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sFjsl7rX9xdwkM4JBePDQqpzlupaZEv/JzhTJF06DY=;
        b=RoMHqMkCDa0J5TOYNDw5ySapy7HT8ta6dSP8gai1NHt6+tZnvx3jKXfq9V8UM681vE
         QrRcKMw2axa5ue46xYUedDVq/zFCHE0Y0NuaHdk9GaxSQ78GEFQeZflydEAFaWBPdboc
         hfOi30sH/y+Z6EEBUCDqSPxYucpywviE7RAxKNpVOMQn309Lu+VfkRPZWI9TaE00h/So
         L2jhxzX4zUdTvi1wqhLJ774Mgph/KwNVs+x5po3zaquh8AuRnyIQ+kwcX35nsI+k7hYi
         2VvkRFWOFhoLK29MpAa4WtK1b2hN7d9T2OIm6dmIgOzZHuZXSnayrfWAa95eO72kl97f
         112w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616204; x=1779221004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sFjsl7rX9xdwkM4JBePDQqpzlupaZEv/JzhTJF06DY=;
        b=gLITtp5Iweb73dldtVtvSe3A8keKr+L34Ixfpti/qf39FmyOCnG6mao8wMe7XteifH
         yVNd2dfLeJu62f5eZEd8AxfAOYINOAaVpzd+izM02BpKRg6K4rraqJKFypzdjCfA+Aka
         Z65dSe7QROsfX65w8tfLH2rQtJsl/ToN8792cIDOyH/e8EwlSngHoXn79oqPfprfsFVh
         6bQVQv2V1eJfTB8U6HzEBKRI5PPM7+UliMKhxOo1V6fIbsNBRuNfh+K0c2/mB2tJFMAA
         99kNUn9nZIvHadC24TFj6bsAnhHPk+WkLKf8m1RI2cD3N65bPgrZyKQQN33s+oLkY0yi
         KOgA==
X-Forwarded-Encrypted: i=1; AFNElJ+ysioYNd/mDQJmaH3cFYVRWsepdUlHalYjV9VQK6hyLK2PuJB6IAhwKRFyL0KxbYDDLPHIlwNwoDdtjgTX@vger.kernel.org
X-Gm-Message-State: AOJu0YyDlBd6zx3EavVbeFIEpKxt0N45b/TLuEj7gMditKWyGUGStncE
	K5KxxUEXq7UQg1glvnh31pVmxeITH1skkcC9N+SbttlXKcFEoUBHiYVIfZ6otlSEAio=
X-Gm-Gg: Acq92OEtVvGSzchOG/dtHY3QZB9IweMoiNUib1FCYWJuImeQirv8YOgRNqbzoTfo5gu
	8CVw9S52HdfKRj0RZ4z+ABKcWxyVKD3X1NdpiU4ftl9HHqM8DKfNPt6BbpUcHkS9gEOoLxGK+bq
	l84jaspYxR5emmPE3uAbdw5rWE2ERU1gj2mWWOczpCTMEAxLql/PAK8HUQiWcJdPeXARCCPnVhj
	IiEwodo0MEzjh9cpr/sivX0mAM7pe4+ZlcfGfLgnm4PiD0bNUlV4XV0Tfd56a/iHfWFwXwtgsJL
	tCAxmqez7pXN75qTV32ik16Jh3DH6vgb1b6RZUEggM4kXJufEakrehglySX+xY6F4CP0dmA4s8H
	GTU5p4zEWGXpxipO5BknhgTrfEXjzqVFcbcElBOjzEqIqKrlvdfr/QOYI7uS4UjEmKbd2Ca0pga
	gFZ6lpQ7RlXEtRk45OiS1Zjh6wmbZIdfS8eESmROtyxqAjYEUDfl5BJ4N8I4Yh6E9+LGgtlUsPX
	yFbNJUus0DDLA9EbLaG
X-Received: by 2002:a05:6830:6310:b0:7dc:dd19:7f69 with SMTP id 46e09a7af769-7e3da4427afmr94184a34.17.1778616204344;
        Tue, 12 May 2026 13:03:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d8feb1sm9193403a34.23.2026.05.12.13.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:03:23 -0700 (PDT)
Message-ID: <0eed0ed6-7e56-4dc2-acbf-7a221012e08a@kernel.dk>
Date: Tue, 12 May 2026 14:03:23 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] eventpoll: add file based control interface
To: Christian Brauner <brauner@kernel.org>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260503085101.112698-1-axboe@kernel.dk>
 <20260503085101.112698-4-axboe@kernel.dk>
 <177861542130.846060.12151691690322065378.b4-review@b4>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <177861542130.846060.12151691690322065378.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 1:50 PM, Christian Brauner wrote:
> On Sun, 03 May 2026 02:49:14 -0600, Jens Axboe <axboe@kernel.dk> wrote:
>> diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
>> index 7bf30e9f90d7..4a6fe989810b 100644
>> --- a/include/linux/eventpoll.h
>> +++ b/include/linux/eventpoll.h
>> @@ -61,6 +61,13 @@ static inline void eventpoll_release(struct file *file)
>>  	eventpoll_release_file(file);
>>  }
>>  
>> +struct epoll_filefd {
>> +	struct file *file;
>> +	int fd;
>> +} __packed;
> 
> Since you're exposing this in a header now can we please rename this to:
> 
> struct epoll_key
> 
> This weird {file, fd} pairing is strange enough as it is.

I'm all for that, but let's do that as another cleanup on top. This way
we can keep this one purely mechanical.

-- 
Jens Axboe

