Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3E3431E3
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337226; cv=none; b=eRFFV870TmmnwY7dZowv0ilGSTTGo9suOhJFsIdV3yE4dnuoafoRDqGhxwSgy9EM8+hfeHA72xDyZ+CQ2W5MRE4CWfqYbHSBAKJ++aLjtlTzcPSXj2l0JcoU/P9qzw1zXxIYOPVI6MKriFH34ikeDm6TCVbymIe+5ny56Q7FcqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337226; c=relaxed/simple;
	bh=QqRyjMBmDnzUZnIY23vMQ6AFOZE8h+6eq2IWzLNGPW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkkttAuv0BtosY317EoFpgr76WztpbA/J2Iy67pj+ZefcEcmDzWGYh85wnW7btIKCvfv/FWPOes/x2Zfts3agfBsx5UmBfunasp3YyS9i+G0U1ipPoHesBiXrDVK31r/QdNp+bOj0u3+tfPtVFq+ctgfovt03hy8SGkJ/Kxs1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvvHePSK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvvHePSK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so39577245e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 18:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337223; x=1791942023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDM/IhuAZ+mZ2yb1biv87C3WVL00TVKLh/5oVRCg27Q=;
        b=NvvHePSK9eieI64Oh38DAUfK3HoRWV06UYAWzkC8SqEbpbhdAhj2B8NeZXrdun1wkY
         TzDJKJ5m9e5QJ0w1e2PEdC/Xldzu2bTc3cCwn0qZNgNXrQ4Ha/uL90ifGsFtpd4Cr8H8
         ihV4UU+XRbKClZpzjjotxkr5ROZ42ueTHmhiV54NeghBUUePbJNIKyfnHKnf4q0ELvWs
         YXZpbFpvVuidVnIkRVB4Bim0gAYnbB56HB5FNBm59VsGXdwwMOqfUHDkNZfMVIZHo1zy
         poXUg1itGYmhLkY/YTrc+4hdxkPU7f79dAlRWCrzLQE06cw6wRneyVPpgJ4ywRBb/0yO
         ImLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337223; x=1791942023;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDM/IhuAZ+mZ2yb1biv87C3WVL00TVKLh/5oVRCg27Q=;
        b=qdf1c9wF+sjifc9pftdKm407/9Upil37i/oNN2fkc/w0ve0mTXP6DqpnyW/m53MfcL
         bA93XlWxwGALH0PZ3z3MyuzcDkpVO8yTu2VSBPMfTh+mAmdy/B9s2rRvO8gch7rn2EXL
         t5Ff29g8ImcwbbPB2qxi6sfD6sNOxZ+YKm0xhvOctuks3MSMNIvX9QUmA9mWGin2M168
         XwSdUk71/6/I63FxZsVbFUDUvvHaFJ63apUZsl0oEzKN4IopEcdMBRcJdUazggXqQGNH
         /l04W/teOJzo9UAOp7G+a9TACTFtQOVt0U1KeKaewfbiJBsSgPZv7vg7/PXo5UgCUEyN
         xgLw==
X-Forwarded-Encrypted: i=1; AKwUvBzQeb2SqgtwKgZ3wI+2JVtKogQ8K416Vd+i6jKKOquIxXLBcDEB2rsBCX+sMpYV1RDVQQbfHCoKvSi4babJ@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8D/6SOPyGU19R94UZCX7WAJEFHv/1Nlf7KQy/+vKNe5XuUjNN
	toqr+lczL08SWECYeFl0LIaKk2V2cgSuibg/K/zpi86/ndyYWuTAaiBQ
X-Gm-Gg: AYBFou3afjONnvYgWLSexp2CEYAdnkpWxl7R2vD1bjLVPYOJW+04eWRiNbRrrgY7DKF
	P6/jg6/ENj5Z1m1vWAeopLg2KsEcWvDS0fBdEnPXKegmMlSf6p4x8rN+MEo/hCwJIwzhMzLUjzC
	0TFYTMjEspxPs1n+X+0SH0j5BSpAOzAXK9hqMuitqQnqAi4MbQyVv9rpVSFg5waBRJOVFBjSENn
	nZIkgv4EFXwExPiJizZN9r9DNBy2QEoGjZFVnph83I4D4uSjRY1PbUYP+m1y4yzSpvB+vbSXJSv
	OwzZSrq+XxFGMt4T5xR10oCkVTdi9lVS36JDg/Ks62LK5YcQ6nA2DXLfpOb0Ak+tawarDxlkMJ4
	cEHnTsY/vf8TbogPWjDMfBPR2pBfNhhtOmQ8xhStKzyyJ2UmqNlk078Z4qZNw+fGfsIWPCFxg9o
	o9SOotQZ8Z5fOVOMGt/Frhiwj2H4Y/x6h9mi92UubTjnMlMfoEgXzl0z5d2ltBXCWtODoigBBnD
	sMG5+4JESh9k0SBOlVaswY560bIcLwOyePohD9+1WfAWtACdnp3qNzgWHH7CbsvbBalwwqYdCPX
	0R/U30m8I7ep8ZsKSLUDj96w93lacEdgNUODxru9bUIG1DAV
X-Received: by 2002:a5d:4b10:0:b0:488:8546:d0b2 with SMTP id ffacd0b85a97d-48c7289605amr1226256f8f.51.1791337222906;
        Tue, 06 Oct 2026 18:40:22 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c7202fa0bsm2238873f8f.3.2026.10.06.18.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 18:40:22 -0700 (PDT)
Message-ID: <38719270-2ee9-477b-aa31-b4f90bcba020@gmail.com>
Date: Wed, 7 Oct 2026 02:40:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/13] Add dmabuf read/write via io_uring
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336002.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/26 02:31, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.

Apologies for a messed up submission, please ignore. I'm going to
send v9.

-- 
Pavel Begunkov

