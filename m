Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C24E1C7E
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836510; cv=none; b=fliN/t1tZ+rlIPBh+ZM5YXbNIkAvCC/y+POsLaCf7HusQG3BXbeYpjIdf3jYeTmsYuNXdJ49tspv85Su5+sZrwlN60frvFaq6A2BGySFwSFS3tzW9a4PCmXomUcPGuhmUP1LMrc4Cofd079vsC1egJkLbAPPGrSQMF+tcZ0XeQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836510; c=relaxed/simple;
	bh=lli5ii/H/rCG9APVq9ZvpYJJiJuxiuQfHiO8zLh8fqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDScyJStJ7Sp5Bx6ECWsk7xXH6SCUEdufh3Jza8Kdb7Cld0Gbt8hQwAmIfdNOFDzqBb6HT4Tk9BsgjZGOxVs8sR36e+FZ+MwXQoRZE1pEg33lfexgCb9uaQLR9RtiZjMa0J6wKoJ35qGHfGbTYUHvPMm0LcQuIdwcSQGPNI70CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=dpNRzD9o; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="dpNRzD9o"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-823e4047037so1893504a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791836508; x=1792441308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6hOwSLR8cfh8cDplIOaHfJc8wiTVy6P5jX2Jl3fTgI=;
        b=dpNRzD9oqiD2g38Y4s6mxqWYJVtG69bGHyzuYTGsW8oM1V8yoKlk97Ad3j5/x+wWPv
         AX7rzWW9cpneIBMISFHU3tnG2C45XuYPCn4yA2MNVoxg7KuhpCdR+8Xo4wfNB6oRfTmJ
         xdO4sajTy/mgAciKkmBOOF6+xdjPrA/pAFajI5mNvAqocwC5gvDvofV5iSzoedgERboN
         huuX6PAdWKAnjgItwe1MO2T9YIBKFkS8Ifk2y2hNyv3hGtFqKbfawUxs3LnzgaQN93fV
         1K5jW1IPgvQShzMmN2YoH20ZYM3Nqv+fPONh+tkzeOPzwBlkqcZVxddIf0N1RBBRiIrs
         Eu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791836508; x=1792441308;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6hOwSLR8cfh8cDplIOaHfJc8wiTVy6P5jX2Jl3fTgI=;
        b=1NSXfEAJRDWJe4jGg0HI8Xi6BHe3p6ueDGU/cp5ivBx6DYIusDSyq2oirkQ9HMBFHn
         dyJNYGhlJPfRBQPoJ6m7f7bSK7oh9sYQ/OskqKSQcQTVOsegN9sey9nj9KWd+aFCU1LU
         rS7pg1XsuzdgQ3miEEtc9FVwPH5VGz5eCWEDwlOD7jWu3OujtzyVSgUPC/sBVim2H6uW
         5AF5/j8PWZLzuHdCnBV+1gLqdyWcDWkZqi8rLkjuCvagZ/at7JPGV4xCOoGAbjKfveJI
         lVwerHdffvb7Xf8rO7pQW93+dVEnSQn6M2pUKDSVgiuOtkaTwq/BuiZebKkTxnTIQRaR
         SsWA==
X-Forwarded-Encrypted: i=1; AKwUvByZuCtmUEsZHg+xRz8JOl1WNIxuetAp5w+/9rdZF2vlYJoS8/VcxjC5Cfg/OmU6EhZm+ubNOQqOFs1ZOiek@vger.kernel.org
X-Gm-Message-State: AFq9FYLKcc19fz2CrOZsI297dpuiasYkYxNuw25G+jCy8LpOdZ39RW5V
	Z9YjxmubEwZ6slkdrprJ364/9++mUz99JqLpPGgi7gGmDk6vq8PL5R5OACOykX4jmqE=
X-Gm-Gg: AYBFou30IjNX4zhofZwkVMuWl01jEPoiJ2J5rFivqBn2tVMD+Q7cAI3zUz+7jBMEMvJ
	xmkyg8OfBWLaHR77stR8De00bo88rxeGOs9Ea4c3Te9EKqbsfp+MEjH4S5xhkbabAjFhNrC6bJU
	fWqdyKSXd2WLml23bTAn+Hk2Okl9FBtu+1cZ+5tkyqOnPOWvgpnS9AH8CSfKfSAWofrkSTcaoW3
	xcVLkkT0DSQQ4TwOd1ebVMQf5V21ecnPqnoDDbtMBdl+cKmbKR/evm7mS+5uq3A5BMTg/zv1bL7
	LH1AXNwMZOV21kUGuTu7nrSY771qQn/pdBs0BCSh+RR1ELwP35vfcas2PPMJm/IzOz5giB+wnHe
	Jqq5hKEGiQaqfve8UMNGtvgG+7ieQUMITq0veUsGgjWZVdU4EB8tuv9C+TnX/Bbl6/Mw92AVabj
	XqBTmSPj4XkydtWq1c/qI/QrZUAjhlCl1cUv2+kzuB2MXxdHnM+wbBynJ2WBjkkqov0Z8cqTfPk
	rMp8TNm7ugMKRE9HdffemUDVuVqwJT5DRW54+tXAqeVIvB5lU09rT0x0w==
X-Received: by 2002:a05:6808:f88:b0:4d7:17d5:6c9b with SMTP id 5614622812f47-50c40a3e034mr9500602b6e.9.1791836506735;
        Mon, 12 Oct 2026 13:21:46 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c167544b5sm12396143b6e.3.2026.10.12.13.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 13:21:45 -0700 (PDT)
Message-ID: <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
Date: Mon, 12 Oct 2026 14:21:41 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/26 7:42 PM, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.
> 
> It's an opt-in feature for files, and they need to implement a new
> file operation to use it. Only NVMe block devices are supported in this
> series. The user API is built on top of io_uring's "registered buffers",
> where a dmabuf is registered in a special way, but after it can be used
> as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
> requests. It's created via a new file operation and the resulted map is
> then passed through the I/O stack in a new iterator type. There is some
> additional infrastructure to glue it together, count requests, manage
> lifetime and implement invalidation.

I've queued this series up for some testing, in a separate branch. JFYI.

-- 
Jens Axboe
