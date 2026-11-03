Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793733286;
	b=wpt7Vf0KXQIifkjqIkKL6/1EsBJ2Vsqff1Bu8JhluzgbXbhicF/Zjn3WoXy90Wpg1uw3
	 Ay6wxoKCKMV6Zdz8NzGo707f1oZ8PuPEoMdkaqwpuNIXNMV+ymUnntRBH/BuHi5hsCF4z
	 iKqE4z16ZR7iLS5Sb96UCgIzhXEgzlDmY5BfGbZIGIrp8pJqnHrmUYKvxblMeGPHDO8oh
	 c+eGwyvkCTfqW9Rn95fwwdIZPRSuljZgvWyyksmiC1nVWb/t2VPQcb4y3VEUYgZeXj8ia
	 PL9iVLtPmtqiUVORzOSZTKP3n4l0YUv2g7Yoe0b4aPvjr8F8Jn3Z+0+PN+6lUcFOkxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Zc8kDAvAGcUtSSTv1tiJtX+vTgkLMgafaiJRnJ1QVh4=;
	b=kg2/3SY8aS2DOvzGoBB7uYZXNoehjcy2wH9sBaDU6nfUo6642wKh+IVLGD+c/ffXnVCL
	 KxEWgDzjruOgy23udnly7p4NEWIcbjPl5/dFx+ySvttLbATw6f4eBrAjdcFQTPiO5RWmD
	 pQRyXy4ZeaCAI+4gEfZi0Aqhe/MZC1LVuBiObwFCDNIZvpP42Nd2Y6pV6NRiXy5a+hS0y
	 EkiPV4A6yxcUmNUPHqPwQ4BCiZLBjV1AsBoBNnFZxWhHpHPAzfls7FA6u5NnE05QEMzVl
	 uVXFGmvdUOn660WGpNxC4vjS4968GsKKqCshMM30EnwuG+640L5LT8DYLHvd/KCotMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SiydzYN6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C71606A324
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 19:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C71606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SiydzYN6
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-539edfadfa9so2040670b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 11:14:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793733280; cv=none;
        d=google.com; s=arc-20260327;
        b=NI9C11eM6zj0vqYk6AcTDevBkDv0d+FjIFmqxTmGf8Nw4s1dtj9b72J7wpQCUydlZK
         Ygo4H7E9tpN10o5tOxnsAEkwsMZePciVtFTN5Nelqe72B9UWjiiHYSKIaVqNgwi6Ak4y
         TYjNj9/h/mLhGJiS+7tV513ag/MvP3U3WIW3biwCja4pGhDmo0arnP8FmgzgeuSQpD5V
         5Ladir4ZTG1ednWUZmqD68kUiJOk7/ZUTgWEn8NOK/vYNRSzMQIdcu+qO/YoEy67c09O
         PvglCMY8HuS80CZ3ZkGqcNuV4Ykb9nnF/VQDu8yqzsgtd53aFw7Nr0rbBz+yIjh9m2f4
         PVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zc8kDAvAGcUtSSTv1tiJtX+vTgkLMgafaiJRnJ1QVh4=;
        fh=jVEfI6kgKHBJ8pEJid7K4/ChLbbTleDO41c/VSo9/BY=;
        b=hmiZ+hRyJOBRVKSeOxInedpMdL6186RNbPRMd4dOPhQVJjqFGDbLJnNJxqIT5F/Lci
         EkNRBcj+i92VNeUtDPoBjLKdTcVGnz2Eo33O4E/6+yt5XQ4iiNXg7/5BQdRY1OzpnJ++
         Vm++hbNEjeKovqBcBPjMafdzNBBys6N2oLlF3z1rpatK+XzNhsFEHw7QRACH/CUVDpjV
         I2bJZFeNRwSbjtGIPIhk7HA+JNRuICFTMvLBEqiEKxj2ztGm8gLN2lNDQUx2hs9ieMny
         VCa7hjnh8Krk8FHp6r8pmaTGb7v1ySE4duQBsV2DCifsNhXZsm7lIIUmMPw9LWfXMQ5d
         4EYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793733280; x=1794338080; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zc8kDAvAGcUtSSTv1tiJtX+vTgkLMgafaiJRnJ1QVh4=;
        b=SiydzYN6TtHDWtb4/2fslTv9U9W3eohofdHMi+vgsK8sqM8Xf92PZmLtV6C0q3vEab
         9k40X2VfLvtL5WrgBbwLyiRNacLzRtD+vyj0fo960l9NcebV9zSl43c0Nv7ox2IHkEVH
         U/cylVbXKnS+yxgEgxEAirzs1f4+vb/xrrIM6zzAXeMSgWdiOY+3L5eSBQgHntjdJrQq
         QKAS0GD6ku+vmnPfhqpq54KbPUjrxFp+ih3Oz3L7N9e5jcONjOTIhEvxN/fWpSmdQBq3
         viKiA3Qvd8AVuN+qqcs244S67XX3QcHIHZPFBnB41CGKLr9IcvDwmoUsAMqqnor+J32e
         6W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793733280; x=1794338080;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zc8kDAvAGcUtSSTv1tiJtX+vTgkLMgafaiJRnJ1QVh4=;
        b=aDHKvNedLdzhycOBlgLN78tPvrole+mzhMHrWB434QzrilPVkjYFGcq0AvSRKHO/Hb
         ToCao3Md2LECiJ/VLIfx55pZS8SRjVZDj0/FoJpriK5peWq0zQML8KGaxoFFq9fZabFV
         a5DwhHHCBhQm9ZKpqsiPT6Rxcjr4mDPaN5zsma6rl6VMzfUjczOUK1ZKBz4RpcNCgMqS
         Szp8QEG1nhDAEAiX1hkp5JTNgSXSBXz5qcsWT/x8fAovTH85M70Kx3+S44e/v29nZe7b
         8cPuNkF9f0FxfZAt4ot4N1dEsW+2LJKjWykeS45Y6AqOaeq+GxF+NGpL95mj4os9iiug
         4G/A==
X-Forwarded-Encrypted: i=1; AKwUvBwn+7u9KSv+WotDJ/yUItTAEINb27FQjG2R0bLa8uZRuN/hf0mYFKryi4Oc6gUAT92ii/16VYQZADQDxmTy@vger.kernel.org
X-Gm-Message-State: APuU4Z9t+gski2cCGuPskq9i1mUYUdzLZEqxrlDuznp/U48pNmxejUIP
	S591T+FTT+3CmuAvfVO6jTlbtr/WpPAjhC97F60zA+5rdpxfEJax9hOMq8xo6m0Hyvw892PiUe9
	w4+ukLOlMCXLD4Oixz/UTfNi/PpuH03g=
X-Gm-Gg: AYBFou2KQ2q2NWCujikd0cCgiH0JsEd0u372LPPsxE97JnUpZ+mxrg+CjPyCT938YjQ
	YHfkS2BMNb8KHdkyoWf54svR3x0AlFyIQol/h/g3BI2oszmtMwUvlBmCT3b66bR5MzqJ4ogCFyX
	WmvBkgLC06M7BSFniJP0qKwfe/yO5wDpug5RyA8f1P8TA9budaFzXImx23NVi2yI0w9FetH/98B
	HmeblqouA+r7iGuehinyE/zEmRRCc7uU+MRS4dQUjnABtBU5eFn8AMggZQroz8UDHmKtOPUm8/t
	ev1fVEFtvn8UpMulVthGuNTX3YMiop2pec6PmD2rW6SChJZKQ5S50heQS3yQz4jjqZ8iqKKuar9
	WEZH7V3aeolDC8ZcEdpLQrXEVB9JHRsknxQQmtt7ZR9piz7cjLSmaJfGR1YXmaSpKJivt
X-Received: by 2002:a05:6808:3203:b0:55c:925:9d5c with SMTP id
 5614622812f47-5640df0b09amr9395153b6e.55.1793733279946; Tue, 03 Nov 2026
 11:14:39 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025164619.89992-1-dennylin0707@gmail.com>
 <at9xXRhD2xZhszEj@thinkstation> <xmp7ni65vbinfj4j2baisrhp6xzro3asbepuq7xp3mvx6maptn@r4dnoj63uw4t>
 <at-XtWBQg3jv3H8Z@thinkstation> <CAGEkeHfq1xZf_jMw9a9cz3iunj6O3UZ4-=iW-65aN2Ss0oT3Uw@mail.gmail.com>
 <rfvf7awrww55bg3hwq4edbz2ioorodlrb3wcmf45wcrof22cda@yduswvswhz2c>
In-Reply-To: <rfvf7awrww55bg3hwq4edbz2ioorodlrb3wcmf45wcrof22cda@yduswvswhz2c>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 3 Nov 2026 11:14:29 -0800
X-Gm-Features: AclHuK_K2i58ZgKI0ZncbiD-FXwtR_64S7t8qdGgihK-Yj_K5O78XEMeQeLdpHo
Message-ID: <CAGEkeHdALf_Pb8m+qUE5ZSqTWNn69rXyy33Sz1-PKJSmGxvYCQ@mail.gmail.com>
Subject: Re: [PATCH] shmem: do not extend i_size when no data was copied
To: Jan Kara <jack@suse.cz>
Cc: Kiryl Shutsemau <kas@kernel.org>, willy@infradead.org, hughd@google.com, 
	baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The trouble is that practically any filesystem is going to have these
> issues with 0-length writes starting beyond i_size. So if we can fix it in
> generic code, it would be certainly easier in the grand scheme of things.

Understood. I'll try Kiryl's approach in generic_perform_write() and test
it across the affected filesystems before sending a patch.

Thanks,
Hungyu
