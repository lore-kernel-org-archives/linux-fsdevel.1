Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F6329E4B
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963961; cv=none; b=pKxUrVfFdmh5ysEEXaTmTUI+wZTvFdv/EFyYWY4M8MBY9eRLp3L1k45smbMJOAFpoyiNcjtb46dh4IJdR6Kd39kOm3vOWm0CInLXMf9GbuZkehOvBYjKhw0+LmA5H209HKkgQbxiHEzzqioLExOl7MEwoYZXdv5MOtwQU73WPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963961; c=relaxed/simple;
	bh=Wfxc9Jvu01LuJeIXc9Ci8t/2fCy0RFq5kmo+owUynfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ct0GoRJekU18Q5PhMCwpsqUhax2GO4bRkqBA/KRklc9lRy4dy549Tt4+GTu7vWJhTtRw25JHC+PBDdpZth3J1uLzG7lgCGRoNuSx3UDi+oB8UDYuWgP/zKoMnqMZMkdoI/YeL1cZtVdKUqMnJG1LO7dXgQugMvhPn9fI11zP1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O8gdE8xD; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O8gdE8xD"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-662efd1bdd4so3248945eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774963958; x=1775568758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ui6y6e7r2v03MUXf5GqhDfyt5JoqpZVHnb40SG6xI2c=;
        b=O8gdE8xDsTDJR/HIjN0DbmOHM3h3xvgTwMQw6Ih+81OP4snXAzkYkKUcXGgQ9BGv9f
         hO6KGiJC85qtufYhPwtQfeqseAaYKNtsfaIOtgE3oi+yrkdYBvvTRcQCmi4NAjgEQcQh
         bTM0Lq9Qp0vHkWwye4joaiiVHFuovvsMLlnaqu7wXejfDufAAbPm73HVZ+1he+RwujtY
         /D25ImZ1EiLjUOpDM+TRaWw0JTSQL3vifg/SW1f3I4qjjv/yjZU1OE1utOrj6I/hrSHz
         1PHTxky8XRjG4tiMnkj9DMuIstI1g7ks4sc80S0/YhtERZ/2b+UraLA5UXZf4mi7kCxt
         Yq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774963958; x=1775568758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ui6y6e7r2v03MUXf5GqhDfyt5JoqpZVHnb40SG6xI2c=;
        b=rUY9MiNg7VNiVos/R4V7ZCcId1j220R09axpHlns3qeyIcwjyoX10gFL2barDCyttA
         Xggos/NdUf8d+/9mMFpqV6y718Zx51eQU0imJj6C6XrZNz+ibytPIN9F4590YafNTO+U
         kynSRAf/6f5il8gGvAsaBQJKOK3ZvbTzw1gcMQvFlmkoTHtdy9UAywgDbf6Txzhqv+Cq
         AJlgh6EUqxroIvslR20bUAI7xZgP5iKdWfmsX+UQuYe/RGWTEt3LUSe2l3cNHS/Jn4Op
         CBiH5Yyapp5znEbelzc2OhWDu9eR38LSutWtczntW0lFuf1s3xM4AEXY2Sb/Sv6+IhXL
         O+kw==
X-Forwarded-Encrypted: i=1; AJvYcCU4xmrVqahFc1cjmNH/scXJgY+E/fCmY93gEGNymahRLZgi6eC1y4XYAruMgiIWiFHfA80YJSDL6XIsxwux@vger.kernel.org
X-Gm-Message-State: AOJu0YzutRW7CYtzVfdAE25zxuIqBAlNE7bR5/RdRZaNe9SeTYUZUS2g
	K2M1ZTPOC/4Oa2FjFTzFTzznHd/wEkuszHLRlor3nrE/ZgVBc89DfpkJqEPyrFM+YfY=
X-Gm-Gg: ATEYQzzpgKwnby5y2UDHaSNr/CQdeBYFe6bX4Ecjls1ldxBAmP2DxjNI8/YvnH2N0fd
	jzu/I5It1eouUaAivN46ClEiFY6lWc4tne2NOFAms5nKY6zHsiBH7TH/g9iNsjL51kITjnDXAJV
	f6NJi6oofAOPjUTxfAWZdQAcSKJiKcv8NYVn+erMtTqJNmU57A/thPp4opArcxDqEqqr1ItYlb2
	OR7lwdZo2YHld+X1crPAc9bhNOK6aMP4g3vpMmk5E7QS9hPPl9Vtwlxs0skkrTZ1tDO6Li34Dg0
	Y/etQVVjGyr8BuKiuZ3TA2rxi01eEPpxqtTDQXnxxttpq1y0QHLdLiVL5f3ZS4As6+s6KbujtDZ
	wU7PTwFh6vvPsjIWGzBrAmuZQQ9WomAjtxAV6Y1UNnfEX+vLixv2VPj1t9qcixfl5awLxl5g7B1
	kmrbWD4ZBreF7mXgax6X12M8GiIZwkqxrMXTzQgNgp3IM5p56VnmhvpqgKimzhz4lHZVjGs1eZH
	BWZKZaqhA==
X-Received: by 2002:a4a:e749:0:b0:67e:151b:1554 with SMTP id 006d021491bc7-67e3d95e5cdmr1673416eaf.30.1774963958399;
        Tue, 31 Mar 2026 06:32:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04958090sm7633561fac.7.2026.03.31.06.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 06:32:37 -0700 (PDT)
Message-ID: <1ec5669f-9dee-43f2-aed9-48d1247b68cb@kernel.dk>
Date: Tue, 31 Mar 2026 07:32:36 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
To: Christian Brauner <brauner@kernel.org>,
 Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
References: <20260320130615.1109449-1-kartikey406@gmail.com>
 <20260331-hornissen-beklagen-f63db82fdcc1@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260331-hornissen-beklagen-f63db82fdcc1@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 3:33 AM, Christian Brauner wrote:
> On Fri, Mar 20, 2026 at 06:36:15PM +0530, Deepanshu Kartikey wrote:
>>
>> When do_splice_direct_actor() is called with the same inode
>> for both input and output files (either via the same fd or a
>> dup'd fd), it causes a hung task in blkdev_write_iter().
>>
>> The deadlock occurs because sendfile() calls do_splice_direct()
>> which tries to acquire inode_lock_shared() for reading, while
>> the write side already holds the same inode lock, causing the
>> task to block indefinitely in rwsem_down_read_slowpath().
>>
>> Fix this by checking if the input and output files share the
>> same inode before proceeding, returning -EINVAL if they do.
>> This mirrors the existing check in do_splice() for the
>> pipe-to-pipe case where ipipe == opipe.
>>
>> Reported-by: syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=d31a3b77e5cba96b9f69
>> Tested-by: syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
>> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
>> ---
> 
> @Jens?

Fix looks reasonable to me.

-- 
Jens Axboe
