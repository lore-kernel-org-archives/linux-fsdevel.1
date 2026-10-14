Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71859541E62
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988708; cv=pass; b=fZGjKC+ANvI2oTB6ir5ugV8aOacUH5NCmRQs+/I2eXjvQ1In5OV+JtgTTLthswMvG82LMsO6mbuvYnwOQeYovvXWZc8H3UycBZlCX+9HWQS4DSp0htG2AKzhnwKXOFu/TfQA4ncnlcZnKXU9JDCRIg77DH5lIYKY7zIl/7udIzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988708; c=relaxed/simple;
	bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLiqn7fiCV028xCS36qWImGRmqKGHD8E8ul0XT/YwhFwK/eIjHIbQKoitTIwAAsxxgLGYPA7CR2cWlafLufoJBAP5vrpICWnVUcy1eunHeCFwMXkLKYNiU4b6Me7mJa7auAUZe5r//n3PN0eTYSWOPjuAVWvjrpELwwi2igbb4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cngxshHk; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cngxshHk"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso1316993a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 07:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791988705; cv=none;
        d=google.com; s=arc-20260327;
        b=QUWW+/bxqI79/G/emYePV/1+cFBOdgvAGNmVFakNpghn97WETmvdj+LgzBZbNEg4hK
         bvIyBmo0e6o5YzCwFJ8D1wEijIq328b2MoQeSpqlmLp7RjFvKDXprI7oNZ7jD39Upu0I
         sISCoT7CgyAxOntPXo6vcCB2c23pwfCBi/ex9FefbBRg36fwMwrQcRPD3LRfZovH/K1W
         TvsggH/NMelF+KPMZLH07jG0K0dGJjjJCceYTIB8nYd+XbmWVuoWvYYeytaehLqMO9Oo
         IhQ62C0XiTELm9AedZsrMj5r5MGjRCngp7uSuIRCprwpOG/zgyBQrwLry02H4LXRcJfu
         LC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
        fh=RvpzfrSx4Rq67b3SQzITkqRgch7mC1mdxO5R/YPKh7Q=;
        b=oNwQubPjA096i4uc9+mZb4MIZkItnI0KUHxk5EIH7gmzRW74ChMweMQQB/Kt+lYdgj
         jlWghyzs87YX9OFTIZn2PUHePfG36T8dXgl+XpmB19FSCEADhzDW8hX6eNW9jSUBCMUR
         Ca5hHnke4mKNQkS6amNoxt+GZdRe+s3hSVh7bV3pIkkWf+lgWknGDWzfTo+SvfsOVCkp
         vAS+ERdmRDhvYcGswhtzzz9Qfgju+8/4Tk1RDTfP3wMDPThdATa3cSOk+7VivTJchbbX
         9LUFb7xV9ir0xOz97lmFPEzcVKsZMigSO/KwwxaZU/u7C4naXePTyenTr8H3xcu5KEkA
         Z5ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791988705; x=1792593505; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
        b=cngxshHkw8vpezJT+yDObXyASEd/+1ZURQ3kSvVkslJTVzG3tDddeyu6Itpilt2JMA
         ec1WM/YYgS3Rq+vyX4T4IeWYoQ6OxvUiPFQKj/JmDAP4bVMSF7iOJ9EhmAZeTB6IBdyW
         hrr5fD+726lY+ajAr5CUAAonz79E10XEa2mHWfe7oiuU+5I4HQVr9qTl+RLPz1Diqx29
         GtSbTklK5jEE1PNTzOz4Evx6U/DUQ6OIJjmi6onPw4b4rseZ8zc4j/e6G/SDgBZfMjcD
         q01QWWumP4wG0aQUh+R5aOlmSu3VVONxsq4Rn1Mj6JpmuA+W5oTi/cpSHA+wcMS+164o
         h7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988705; x=1792593505;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
        b=ExJQZ4r2WINxgWKSTvDURbiL+aTFT8ThqwB+frb0GrDu6d57f2ny6mM7TGBjDOvOjj
         XKP7TnZzEKu/JoiTs34nYvbe9GIIgx+JupShfNoZZh5/KRGmafMaO1PsCRmpUPt9KiMD
         xw7EVYhQjAXhuBiHKELjGW8v8JATBTcWotA1OvsMDXh7GXhUkXbRNTA7/AowTIs3asu1
         hboT83J+uMMstQSzUtNrdHx9PJ88HwNuHQDHSJrfI42KzL/KK8k1ETsCYWSLiJyrLq6d
         5BTD3TQzrXw2Ga+JFCW8vWaYvwa2+gY5UTs9ml9ArP9nVCSce4773CjD9v7jNFDPVVAS
         l4qQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1P0tgKYYiRJrcVkiPUgjFUOj+FJm9+JJAtADsRCMQPqnzeFdBhmSzpVne0TRVi1rxvrG+Ja0DGL/kMD9z@vger.kernel.org
X-Gm-Message-State: AFq9FYIPBruBD/PVZzGbE8HGqJ0zb+j4RkirJGDiGhDAqst7bc9OKG4t
	Gch1gxuaMxh47ry037YN5H8F6b/aneB+Up8+yKE2i18Ju74coOzICnZ3b4vcdlIYHD1HUgt1WOL
	hh2MC6STav0/H6PXqR7IybGmCWVxcig==
X-Gm-Gg: AYBFou3sT09dwsvJq6gh6oPgx9/+M7Yk76gjgDtLEXTR8QGxSouCRdrICFYFISkjveK
	/Ds7ZToXa6xiYz/ScIudq8+9T5csxwhBHGbYX10OXIf6UfVrQLnHyR7tbg1vwNmy+1za00V+KD3
	VtV2g+l3W3L54KjZ603OmMV8mD/pbMfKONX8kNQJ7i5H1OeXJblO8BhRVXn5QZxRqaAzmRp3qbn
	Ld3A35LGXSpCjM8ub42k4Nrq6eLJotuUxHKZCE6hYcN7W/fd4zQaCyZhpE4fdiQFrJMh/pLBdXy
	pCVitswEg9mSMhQ+6fBJ3cmg5AWnvTE/L+L+mi31k6gSgN7iY1o4fmqfIvVdRF1Lsveqv6YHurE
	3Sk1H9K1cf9qVioQ6bXTSjrOj3hbtNMcg1HDLLqg=
X-Received: by 2002:a05:6402:1912:b0:6ac:b9b5:8e8b with SMTP id
 4fb4d7f45d1cf-6b17c2a3670mr12616709a12.15.1791988704432; Wed, 14 Oct 2026
 07:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791975048.git.asml.silence@gmail.com>
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 14 Oct 2026 20:07:46 +0530
X-Gm-Features: AclHuK8DZ9QwF2AgJ3SDr4lT4xl3Cf9evBnlWqjNFK8bj0mT2h6JXCYZXSbhb_A
Message-ID: <CACzX3Ases=5auovox0XFNheDHY9iNmxv2BvB0dugC-W3mnjGLw@mail.gmail.com>
Subject: Re: [PATCH v11 00/13] Add dmabuf read/write via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	William Power <william.power@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Tushar, William, Phil did a lot of testing and experimentation on various
> devices with previous versions of the patch set, and I've received lots
> of help from Anuj, Kanchan and Nitesh with investigations, testing, and
> patching. Earlier benchmarks by Anuj for IOMMU optimisations with udmabuf
> showed:
>
> STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

I've been involved in the development of this series, so I won't add a
Reviewed-by tag, but I tested it on NVMe with both an AMD GPU dma-buf
and udmabuf exporter, using the liburing tests and custom fio plumbing.

Feel free to add:
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
