Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D53A3802
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032361; cv=pass; b=KtFvbWXN9dXH5ORRC57H+EuYUU/nUM9aWyjUMKt//iB2cZbCbpx/nAjCnE8eAiJqFI88TxWY8o+VN9ix9c2GvFN7wRXkJGWvOIGHMaCw53S5kS25u4+c8b25CYS1+ApjQgLzvUViRBb2JnzYQfOkd+bQpcOjK42lG6+Fbua2Vi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032361; c=relaxed/simple;
	bh=DBTQ0XnCGa77HFVIjvMxdbSDt8ntDj/hYAFFCXzPw3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRQgLVXfsZtBhCiXOYfHJ5yanQqQX3B+fZxUYZOO7tG3ubXJVNOD7VLwtTqxo/SY0dQ7SkPSPoOIn7oaxC3QUHYkm7TjsRf43EryOmpQ1zOoYUWDiOufqOS1yCrZoZC+NoHQ6f2DfANpbs9r3DNwIjnBbkdRNlz3heTOtNr8MBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvyJQaSz; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvyJQaSz"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7991db3dc98so34586697b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 01:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775032359; cv=none;
        d=google.com; s=arc-20240605;
        b=c7ovQxi9D+1v/eu7sSvSLF84tb1oA8THu01Xn2ShqlhAAfKnxJ/CDB/krQOJQYqSZy
         RsF3HfaIBBVUAC5b7oJ17C1xUnNR18jihzCiYbmau+DKjlr+me8fN975hP4ts7XeYkA8
         MdK3HYxn3+8zGy4sYtdg1KUps29P54nTmGdtKBkClnQdn8K8mhOacyGBiCJ/52Z6+aLQ
         9zEfWxLoSJwKNtJcYAQXzWliRXS3lYaiGvNHqnE0yBaTKt/oajtlhgIm4aJOgKxQZadq
         RHLoG3ICtqISIew4mocJ/cj1IPplO6vd0a/FxF/+eT9IDINf8EmNL6jn8UxCijRLLEyk
         pFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QdtkqxfHJaNFL3Xk9GJ3B47wGQDObCy2eMkD4XKaFxg=;
        fh=YG7jDR+PVyeb04gs8ScQ2aHt+loQA1VU6fA2DGPdaYY=;
        b=Dq0zHKrMQHmILN2sGKSe3qGWKZuDyR7jk6MGubQdql2v8/Y/AMiORnNCi927PWX5KC
         ZGsedNMzYXJSmIldXZLU6SE8vOHkURpMOuYp/Vzq6KU5F5GQNqITeKEVVV/QDCk0itzk
         Kcdps4miKtm+6VLmpMGO83w99yeDVUXeFJnOgYgulZ98/NQan+Emet+h06GV+c6Z2xJG
         joS4Js6T2YvwJvNA8eESvGkwwhqPuxivfH27xRvEVyBcziQok6bmpv7uQ9sT82DtOGMg
         ewAVT3GnFW8VnWYePXDh6SkFdqXfvEt2BgIG59/ZJAcWp3IXI7nlb8Bk96uq2qw2i0vP
         gZkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775032359; x=1775637159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QdtkqxfHJaNFL3Xk9GJ3B47wGQDObCy2eMkD4XKaFxg=;
        b=bvyJQaSzbC4oWFG1k5G2XNM2yoAAGB/CyiC8bjQtjerlVIq1cCyGPTl0wZT1A1NQ/V
         QcHPlX7059T3appYahHUcclyNVQzlxXv+L38o12x16wQ7lNGIEIRCvSZgUTsEAC1Uaf/
         sLaNeF1I/3EkxDVF/UQdeJL+ix84o7WyoOyrJ4/Kr5Cnobx2QLkfBNS/0rKXxM/NFvw0
         4HOYELZgVcnrUQs1SCHejM6Pe8bamT0nMiR2JkQzM7QS5+8m29dfZ4qsVN7awa0pzyJj
         5J9rGtr2USzR9AucCGkcYmzCQC2BwUjuy6EDVa6YMu1s/Ntk9qwxSZ6W/zrXJrQtQgZq
         p9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775032359; x=1775637159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdtkqxfHJaNFL3Xk9GJ3B47wGQDObCy2eMkD4XKaFxg=;
        b=QOXq9YxaslAwXHDGR4nPnm/ewhjxzrrmHQq4kW3yas//cY80isxCY1fU00X0dtwbU2
         bWsjmQKov2YXg6QZDaIqfY3fKwAEg972TlV5JL6k3sDiht45GZgPPJyrH43HyQyQGMsC
         lq3W7RC6HIqco8pePtmtFiLtaj8L5m4CGyIdeqZQ4Y30XpAmYAap8Uo/sMIztGnhcyTu
         KZzkddqaHGKOtjwkyJJo0CSwB6Y2fZSv71b5bvIrxKU9b1QoyCAZxSW5ae0qtw5ZW20c
         lfCr88FDm0wtn/cNnXO+y0BaCdrEgc76LoutK0goBDLRickKbhj2jx34P/gKhL8AQa9d
         SwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmNSqTPi7QoDWhBrG7aGKKrqYkON1W1XuY72BHNmBXWY7+7PKYnb3p7z/LfSj8ULDWkPCPxPbFrp16p6uR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Slxhuk6MdJXb/UMvty9u71dQ6z0VETQoQrSAIQK/rVRTwoC2
	bk3nh5ZNBrZJcqiU5/Z8fabRFlgWNRo8pL4dJhNxjEi/PA32taNj9/5BUc2JfiRnF5MadZfujDA
	C4sXigiUM5Bda8vpegcDXoVSggQ4t+yQ=
X-Gm-Gg: ATEYQzxkh8YjHh6zs+TG+2C6MMiXfmyi6o3u5rtzUDGOrlNmtlM9MBjgeWGinuZdwiN
	m/E6aJmyTQv9xn323QlmmwTnsCQyLnfsjoLtoZbEjOuzEkfhcyi17uwTpK2drUDtTMRn0bjqbr0
	Mx+1khjHNZAs6D2NjPTwiLGTqksIq7ZWPGMh3Gy6xjT0MsCCEvGYnnsAeSvF1y1DV2KEdzbB+Um
	t+AgERqVlb0Q0ndo8e1J+Bauw3am0CV/LcmCS1wAbahryJJMpwztc3m89+xRoqwzuc1iMwcrc5b
	xCUKyKPJ70z0BgTFxOHgXoA5bhSITCU6O1VCGP4ojLHKALjCLkFd2XNrG8/i2xjDydKPWBR+
X-Received: by 2002:a05:690c:ed5:b0:79d:7e70:d364 with SMTP id
 00721157ae682-7a20fbdb9d0mr29364667b3.13.1775032359519; Wed, 01 Apr 2026
 01:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320130615.1109449-1-kartikey406@gmail.com>
 <acvkAuq4_cWmegC7@infradead.org> <fa551c4c-7e9b-47b4-9011-92adc880ed1a@kernel.dk>
 <acvmXDBm1xOak_Uq@infradead.org> <26d2e8f0-8b82-4192-9edb-e31f3975bb82@kernel.dk>
 <e3gspf7vh2h7r5llbc7qman7tmqiyr3pd4nrzpu3cyuqtlolxy@2kobbzkgjr4d>
In-Reply-To: <e3gspf7vh2h7r5llbc7qman7tmqiyr3pd4nrzpu3cyuqtlolxy@2kobbzkgjr4d>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 1 Apr 2026 14:02:27 +0530
X-Gm-Features: AQROBzDJRSe-fLcJfJG0jBntRqmvkJRy6QAb10saTvA92yg38WYavnvn3IFtDeQ
Message-ID: <CADhLXY7N5qbXn0K+rTE4po9Kdt25vH4wcdD6fT22Dbu=CpJHzA@mail.gmail.com>
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 01, 2026, Jan Kara wrote:
> Hum, I'm probably missing something but I just
> don't see how the proposed deadlock is supposed
> to happen.

You are correct, I apologize for the incorrect
analysis in the patch description.

After looking more carefully at the code, the
actual deadlock involves sendfile() and a
concurrent fallocate() on the same inode:

1. sendfile() write side calls blkdev_write_iter()
   which acquires inode_lock_shared().

2. Concurrent fallocate() calls blkdev_fallocate()
   which tries inode_lock() (exclusive) and blocks
   waiting for the shared lock to be released.

3. sendfile() read side then calls
   blkdev_read_iter() which tries
   inode_lock_shared() but is blocked because
   rwsem prevents new readers when a writer
   is waiting.

This creates a circular dependency where nobody
can proceed, causing the hung task.

My original patch was fixing the wrong thing.
I will investigate the correct fix.

Thank you for the careful review!
