Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747D20125F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275793; cv=none; b=DNE8sHqfWOiuS2rM+tapYjopS/uyMb8tK0NQaFlYwuuSly0vZsH8xXYcfsJX2YwSspN7UQOYaPif7c0tKyr5WBS4qVFs1iR4Z8ntIzFYjt5qLG4gbvXTTVAuGW8VXIktCUohbiRFQyILxKHfbwhWgBOjyUoBNmK+AIDh9blL0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275793; c=relaxed/simple;
	bh=C+9I8qKss0WgLUFVKxwU390YrmBUMAcHGwnzXZi12Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqhXIBkEu8Nz3YV+uFZZfKo1eT27ALqGw7PTWH0UOmobRjBXfKxqO8i2FuqMhUXf/BAS1FrS3XVXIBbnIElr27oOQO2R+RKIm+NZhhzoXX8EPgtk/35WzLnBPI/VCwDbFqvFwEJJBKoLXS5ekQP/WCyvi9iWRT0iqZBuLCUZUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jI7GABMN; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jI7GABMN"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40429b1d8baso1370047fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774275791; x=1774880591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zm+uLazNQIplB8qIgyuexcD83A6/QI4uC1344ND9QI=;
        b=jI7GABMNhA8JVmNX75DdYanW8D4zZxB8EvshRZRCRZ3rc8ac4ASQqjSJELsMWrhagj
         a2iMY2e0b9w6+OlmJ7MeHBWc75m+66sdYQ5mHf0AGefKjANNWpJ7QplVdim3OLfkk72Z
         aG01jykkr6j3/T2HtFB5zH+goRdVA3MjcGC78M8mN5dLXjGuUSQXeo3kmmd/BqNy7Ykw
         zmqBBvcNns0KbB7VVZyhovPcCZJxR/K9mSIn4fEs+nlO2irQKVY6nghRT1t4FsNgXhD6
         uJJWN27G/cexXSjuhJvEfMeami193uBRdMe8fRbk25Z3Zp4yMBHWFd24H4F0kEjvEtpB
         BtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275791; x=1774880591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zm+uLazNQIplB8qIgyuexcD83A6/QI4uC1344ND9QI=;
        b=d9MmvTWM2JiNGcAKv6+dVI9vGwLeZzSFH9Bh+r38O7e/fCC7prxjX1CU56ezIV8A3Y
         eqHLKDCnOLAzAyi8JEpa1wko+fz1OpvQDeOkki6wTjt1saAh2WPgeEn+/+dfkJAcFqcQ
         1YPBpYuBtlpQ3U3NXXbCPkNLin6nn1Q+kzPzplrW/F/2gSg1EOGQbTuHnZ6yZq/DcO7+
         0bQ1v6HHPk2vmf7XBex00M6EHJDWnFa5T+D/WiUoiV0lvBRlUUmKytPRkHr3sKxMA1eq
         MeIN0P661qDk6X+OdSGfcIOAtEWEY1YlaavrtmjYU9jVaToONVKdJcNjOuO6ywuJWZxM
         Qkug==
X-Forwarded-Encrypted: i=1; AJvYcCVs8fHHztgYofIIJZhgjEe2cZXXeKFjtAnxp/uy61kRJ0cMMDjNo21TFtjb4qiA+OaWahixFkjLdIT0N6S0@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTLsZ6J4apt7b5z2fHMXID+Pot1gPq1EIPsYhOkz/2rov8e6X
	yD+JP0BpgDmQ1SCC5guMOyhsmONZNRmLy8QQZx9vvXYfCAK6Vos8GfkFUGcanBDaYZE=
X-Gm-Gg: ATEYQzw9YVfmpoPTuc/7yAL4E3EGcChe9hMWRqR5Ne2W8eBn/1FPn+E9bCEe7yWUC8Y
	ADph/vnqBc9kMVNqaKkVWNwNf3h9fDCfBZfrllcWFStrlRnv5dZrOzyH3maAzRqYZv0YvZKuWxm
	6TbKrqyYd2hsvmbRE/RGGnDAr627Yu5lSnXejOTquoA1JFuAvxeURlQypWdCdHrm9LKglUifA/k
	EXONcQInsim7YFwyyyvSQWZSyJELZPE/nXVKc5L58G3vjLZlCT5QXSxjVA/nmP/jLA4kZKZVujq
	bL2/QmH0wMZAlKQfWJlgTLYDLP/WfrGQCdEaevgFeTMdhn57no6H4lGsOWldKLOPQMuJdGWETH7
	LfEcizTZzrJNXeb7vMGK/98b1kv0GkuTQUy80avaXK8WbejW39lLUbL+7GHfXFZwvuSrKF8aMUj
	M8OHVxRBuVa5JCButna/Ebfv+z7DpXGwFZhm/sgbHeBL2P0w1kpgYnw1pBWx8wnierBQUakwINC
	DrgmvtJfw==
X-Received: by 2002:a05:6870:51cd:b0:417:359c:292e with SMTP id 586e51a60fabf-41c10f84c98mr6864368fac.12.1774275790874;
        Mon, 23 Mar 2026 07:23:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14e45213sm9682225fac.18.2026.03.23.07.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:23:10 -0700 (PDT)
Message-ID: <4a3cf1f2-274a-4ceb-9980-4b379e81394a@kernel.dk>
Date: Mon, 23 Mar 2026 08:23:09 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] io_uring: Add IORING_OP_DUP
To: Daniele Di Proietto <daniele.di.proietto@gmail.com>,
 io-uring@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20260321232142.911280-1-daniele.di.proietto@gmail.com>
 <20260321232142.911280-5-daniele.di.proietto@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20260321232142.911280-5-daniele.di.proietto@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/26 5:21 PM, Daniele Di Proietto wrote:
> +	if (((id->flags & IORING_DUP_NEW_FIXED) == 0) ==
> +		    ((id->flags & IORING_DUP_OLD_FIXED) == 0) &&
> +	    id->old_fd == id->new_fd)
> +		return -EINVAL;

I think !(id->flags BLA) == would be shorter and hence easier to read.
This is hard to read, at least for me.

> +static int io_dup_to_fd(struct io_kiocb *req, unsigned int issue_flags,
> +			bool old_fixed, int old_fd, int new_fd, int o_flags)
> +{
> +	bool non_block = issue_flags & IO_URING_F_NONBLOCK;
> +	struct files_struct *files = current->files;
> +	struct file *old_file, *to_close = NULL;
> +	int err;
> +
> +	if (new_fd >= rlimit(RLIMIT_NOFILE))
> +		return -EBADF;
> +
> +	if (old_fixed)
> +		old_file = io_dup_get_old_file_fixed(req, issue_flags, old_fd);
> +
> +	{
> +		guard(spinlock)(&files->file_lock);

I did suggest a function, but if you're not doing that, at least use a
scoped_guard rather than have some randomly inserted scope here. That
looks like AI code..

-- 
Jens Axboe
