Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A468369D56
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786174985; cv=none; b=J5Mpdr/FOuS3Esnm/ukk53hp+hwkidO2NnyRsI9TljCz56pq06ja3uXz3aqlhzSZc+iS02XjdKIpl3iX20nWqIYWfFm1yDxAU6fPQbj3TFce1BXk6pfnsC9PtY4/OYvAs8cqDju/sJVaNf9qXwe51SkgVsbmbmZbM6vXnV58RUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786174985; c=relaxed/simple;
	bh=MfmnU8YNJLwpfs49CXSqe/TGoI8poFdoJ4O3as++6bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrynhtNIvrMqGGfKa7+PgjrJZYVQOaRqV98yOUF5tnRZkCEGfnuewGDXtJRBtqW0sNRL51R26mVtPaXWrjWk4/JnS2HDx0/+CwH01Nn6YN322yk6pG4HD5nbPqjAfqRlW7mt2d/sx6BZgyyh8CYtGk3gFW3eiSUpFqumFR8YKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=K+cTBR4P; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="K+cTBR4P"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38759bcd877so267008a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1786174983; x=1786779783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TtyMmNLD5kYHkR25F4J0okBlAhxZuviH4rvHbsosVac=;
        b=K+cTBR4PSttFVR7cXfwdM7Wcxf96D26huTsvWdscq3LUH8CqSXMsQ4zHA39r+uKFCy
         cOfUAJsoD8ByLh8RAzhBLMFgGVd3d/aCpALF65KxJuj8K07w/fyqhhGUc9iegk1sgxew
         AMJ5nQbgQugiuw9/SzL5BwjWdFnqHA+HvAuyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786174983; x=1786779783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TtyMmNLD5kYHkR25F4J0okBlAhxZuviH4rvHbsosVac=;
        b=iSAMqD8hD3cEL/o2yTFi12KxjkeEIe2kohdJDWiOW0ki6UWS2Z2Di51Z4eHaZ88QWf
         2YKXX6A28KNmztHCTvYSquOO/sPj1SIhRFEAtOO9bJcks0Nd8T+qugz+q8MbxP3pdqOW
         oUuqfMGLubJvUlyb9ZeW95hw1MUqTq45nneVnkhY/EwxC40cEgzg9LcNke9eO1nmLs6V
         JI/RaQ6o01b/FAOqyo/9sMK1YxVmql0WpuAvwY9cqUdA9ZjFGfAKotGlKpEgVBsVm2cR
         axP1XWW4lDeUz5gJiRxYRAoyc0UsbXJR6dleGV/JD++UXkmr0TyL/AD/qYMZ1EaF2SZa
         HYPw==
X-Forwarded-Encrypted: i=1; AHgh+RoOkTHUq+bygauvMqOrlqn5n0BqMxebpuAT0RAw7y+3GRmf/1IBguJfV4dtLrG10U7tFUNdywMPOlU7b06M@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqzfMoJshqjFthScPpS9+y+GowOn3fBpXUNROe3wgpX1Q5BgJ
	wGGOK7roy3AocmYTwY/bvytT4uYTCbCRFQZvX2JGyhwMUiwqP8EGwSAohP7JylokXlQ=
X-Gm-Gg: AR+sD10XbX9rnSpExY+o2fAR/1KsdJ5iQNPtfvA/Sjaa7ByfAw1QwHurYZJGXihNd+V
	RwzqNy2S8coCLsrbrDuRe8gSwiuzZiYnGQDfg8aHLBPvpmBvV2C/tdMUYbXJUb5RucstUi88UtB
	5TzswrEEzbxiYRxQQ7RiKEMadcFgcX2pgyjZbpgcatvAQIqVwcFIq++kcmrXv1kyMl1A6Uh964J
	NE4KmaEPQeCIduzqbalXMOoO+AbWnlHh5FdhLBvDOEQ/T8lfNEEzkim8AwYj2gHRul6eN7d0X7D
	NPpTfomeJWae/yBagRwlR791sz3lMvJli/J5vl6Rm2GV1GUdLFVoxUfq7bOdOPNXkIzw4wqwoie
	LPyW3+I+LwjVUAmB7x0uu+Tgpw5bvXVmhVWLSwNjzGWTP/U4+ZKPeV1IzcjvqiDAPlrKfdqwd7w
	vhN8bPeZszQog58O8Lu+TlJjnDSrSVj7hzot/FNiEKxxyMA08T2dd+NyB2n560WO+/5xDAj/KJN
	PDQJbbg+jLAtAO72bQ=
X-Received: by 2002:a17:90b:4f4c:b0:380:540:d499 with SMTP id 98e67ed59e1d1-3903c5381e3mr26493795a91.6.1786174983338;
        Sat, 08 Aug 2026 00:43:03 -0700 (PDT)
Received: from localhost.localdomain ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39086164982sm7523449a91.16.2026.08.08.00.42.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 00:43:02 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	nj.shetty@samsung.com,
	joshi.k@samsung.com,
	anuj20.g@samsung.com,
	tushar.gohad@intel.com,
	william.power@intel.com,
	phil.cayton@intel.com,
	jgg@nvidia.com
Subject: Re: [PATCH v5 01/16] dma-buf: introduce initial file I/O infrastructure
Date: Sat,  8 Aug 2026 16:42:27 +0900
Message-ID: <20260808074245.85757-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com> <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 8/1/26 16:46, Pavel Begunkov wrote:
> +	if (dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
> +				  true, 0) < 0) {
> +		dma_resv_unlock(dmabuf->resv);
> +		goto retry;
> +	}

Shouldn't this be <= 0? With a zero timeout dma_resv_wait_timeout()
returns 0 for a still pending fence; only -ERESTARTSYS is negative.

Thanks,
Sidong
