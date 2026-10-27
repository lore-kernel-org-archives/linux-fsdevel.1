Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793136731;
	b=nikuoIGlfCOFYk0ml1tWchrUj1/qBsg29be/+2iSlul5ChKBsPHVX56NucR9ULUCD80h
	 r4HyM1WPXCngTqx1qrG1MnLMldFpFkIwp1L/AT/DzEV3VumASIrmjGonsTkpzL+ftJo0k
	 zGGuKjprCh6rc7NRjmNBu2AhOr1A2fw9TF6yjHHVaJVJQyGiBxLuc4absbmumeY8d0Qxd
	 LC26JHYlB1qNfwMdx0zW/XxwCIcME59TYa6eaw2R1+/NCdPVAV8VdtL4EGZMY1bdc03yx
	 VLQPrACmuuy3AsLV0JPh6u4HdEoUMmcTUk5oVvxrFNOiIxXVxlk8JLiJxk6ExAIWNYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QuhHDIMVu5WYcDA1LFoQtTkJOtLD/1lu0y5o2UH4ICo=;
	b=Sb9RsjeN5NfjkCqCgTqunslrySREi4S3Z1qUKJFt3HbnhH1oKF1RHoXqFpNCjZ7Y7Dq0
	 yueRljfjpvk7lsOlw5VNqfKeaohNgDGTNusTWu4dB1iKrQP57H/EJwkhzVmNjbjkk2xBc
	 bBu7mHivLIA1V+cE8JU6f8LwnOEgtz5SMrUXHHfm5+eGdamsErN+2fQYixUdgB586mK1K
	 GDCDEeKwo5rR30fuQXHmlqWZnTwNL2R2UdtqI1tOIMWAwrjzNc+1qQ2s22jl2qhLW87kz
	 CXGH7TlOyNNZ5l5wLNfI3gNYboG33eeZxbIPMzD2zoHo5Wg31/J64gBJUbifwIqMGaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S4q8x2rQ;
	arc=fail smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55185606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55185606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S4q8x2rQ
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c45551fa84eso45603966b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793136730; cv=none;
        d=google.com; s=arc-20260327;
        b=Uq80oKNYV0eCmusEsa8A9f306++749wdSvvcRZCoaYzWegMw+5IwUecrYFK4FwjGcU
         TCgKyOsz27+VehPrAVAMNPw2D4uyFlu8QCbh2/ieJe6MCfhvM3kDEgcCdKYDYOvNOVal
         7hdyg0nqzYC2W2JQFyNtxdYjQmEZSDX0nnGyc+kImYCoiwiJWi1Vdx9+pRLYv5CileN0
         jDm1ekR8BxrrQNwJT/yvoL/XY2hiBTNBPuIAhjmyF7zeZj/p52zqWpTQIr5QaLVj94au
         cQwljORmKyUKosgZHuvLXWhKMZIEtrLMQFSR7rfdX85epYZcph0f3pkIYdEPFN5+sViz
         J9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QuhHDIMVu5WYcDA1LFoQtTkJOtLD/1lu0y5o2UH4ICo=;
        fh=VBjRJBm5orvpaGp6hLwhckaOXDmby+w4ate2EpU1BaU=;
        b=L5ihijJlMem1fwtf4RuHHcmVp2/ec7bkzb1yqVh8tzLpSTxIXXcPChWqEpiSU1pcS7
         a8p82oMRAUcizMHU0fLSz5VERTcHxuMojCVQjNxbWH6LdtnIaSntuJhly4w1aw2Pvu6U
         zAgS4TsO0gptNV0LSaQq5nBxylOF9iiYl2r+DVGfoLb/Z//QhcAXAV3zjQJu2RArLJms
         wYdJAulv0H0TvcL1jtnSFLLj+1HJwTBJ5VbYYDr8S5MvnrjqqkKAMG4aMBGwDSNAkw5y
         OD1u8cJ9vJDtVx6+Ln8X8WL3Xqe6SSlDqfzLuX/Xr0cAMA354CYui7PJGGJv2rIzcSin
         hBtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793136730; x=1793741530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QuhHDIMVu5WYcDA1LFoQtTkJOtLD/1lu0y5o2UH4ICo=;
        b=S4q8x2rQcUgbgnB2taH0pkeX7W824XEztlulInCkstTN98gFWl50fOUHsLcMogIWem
         +SWWuuIF9ShMS36X+rzUjPd7KU7unYZs0GbPKlZZc+H50ZsfMxB5kFt9pJF7G8rQPafS
         Yj/Qmgt7zp+vc5tnLKCYLsenY72iRxUoBzH1XWuLuKRRylx2sc/th56B7WwrxdvuqIlj
         tisiwgUTXoSytzPTLshRseVU8MV/f68st3yxUw4yxkUyz/mWdH6jW87vSpFl3DClcaci
         WvuRRwXmAgU+OVFLKqPNuTNITzE4a/9IGHAuQqBbyFGnX3jJ2y/T3HqHGFlomaAJHMvR
         E4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136730; x=1793741530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuhHDIMVu5WYcDA1LFoQtTkJOtLD/1lu0y5o2UH4ICo=;
        b=M20xaGrjqvTE/LPhKtHrvonpZheMke2OKCruACE9LSxGnzshHuUuxSOMPuXvxG6HC9
         KlOvHkvgsxW+loMnXIQkMNEiyl+nF/Rctzuf6ZwbWb86TQJ1Pzz8vDjcx+ufVG1/p7pi
         DC28TaqtA8dtC2eJWHtJ3OYivyjH9umhovsLzBbsgwUus0PSkq5dtKHEM2/mfTqNm93Z
         z9Om4oKX80Go9NRcSl01o4m8FqEszCiNOe7aD/hoFw8KCT0P9VPhzzGkfWNIg2/G28D2
         0BwqqdB+ag52U+PkbSZuR08Umxnp0Qv/PMOSjgLkxY9ulBUkTQ/B8bKM5Zu4+nvnKuK5
         52jQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdbOdPk8xqO56KMVs3ezz4nhVgK+rqeEtBH39DNbRhxZuIpuoGMaqaY9bgyEcY1+uVehL/be/RFpXljq69@vger.kernel.org
X-Gm-Message-State: AFq9FYI7+t/8zZ9m878ZulvhK4H3hnczShBClbMqHSPWlqq/eFJakUjM
	VMqsHBdV7/Qotb5iHqvD2KhMJtepoEgPRbqE9TJbmMlO8tpCLVlT1BrpnL02X5fwbuQHKg5q0nY
	CMiJYEynxTARJ4t3jNvsC7aBwiTKxttOGehU8Mme2
X-Gm-Gg: AYBFou1OfPf8K22fAHkRyC9yyOz5sTceUUG+HoqekyeudsBuJSi4aXb+RUZ/mMUgqcg
	aA9jf4awp2SuqdspeEh66LtnyYgDVgh8b3iSmqfTVHCvz4kQNTR3uWz+wREbNw2Mg/1tjRTrm2D
	0yymmXz4ifL/w4SKaCCpUIFbKFBzbLAyStg+ZgrKvsnHzCCbwPdiVXfg1Mel9QGTEmyyGHeRyfl
	uDRkYg6T0sqzIFkSrd7STSJAd0KekWJAlAGvfYiSkZrYqdJiUphq3u7CgxeVEgQiCarBSV8AG2m
	zs9x2L6TWBQmrZ76xlLCwKmwfPwUoik0xVnrQCzR5SZrOT7FR1wgB6nlXEYngPlZQQfff2MmObw
	o38hCNScyItjGjI6D24UDLskeJEZ6IQiMnnmoNX5UramxvQctp8TUz2S8k6W5CnnGFn08tRg68i
	xI9bV9s48hfGiB
X-Received: by 2002:a17:907:868c:b0:c46:bbde:734b with SMTP id
 a640c23a62f3a-c49bdf39dc0mr39237466b.32.1793136729307; Tue, 27 Oct 2026
 14:32:09 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-9-wusamuel@google.com> <a925a7a8362e8e9aa0270c2b252aedcc10694857db29c31f66d6f7c5ba89ac08@mail.kernel.org>
In-Reply-To: <a925a7a8362e8e9aa0270c2b252aedcc10694857db29c31f66d6f7c5ba89ac08@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 27 Oct 2026 14:31:57 -0700
X-Gm-Features: AclHuK_3f2GFNzZ4NDx25anrHi3Bvdsj3Ks-ELoCN4hDAJz29yzPop2fh0fcApc
Message-ID: <CAG2Kctryf8+44WKQzUOzyMmtL4biW3Pbg3Pntzkn3Ot49RhFow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: bot+bpf-ci@kernel.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, andrii@kernel.org, 
	eddyz87@gmail.com, ihor.solodrai@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:51=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> [ ... ]
>
> Should the BY_ADDR path return -ENOENT when kallsyms_lookup() resolves to=
 a
> BPF address (for example, is_bpf_text_address(addr) is true and the addre=
ss
> is not in vmlinux or a module) unless bpf_jit_kallsyms_enabled() is true?
>

Thanks for the catch. In v3, I'll update BY_ADDR to gate on
bpf_jit_kallsyms_enabled() so hidden BPF JIT symbols return -ENOENT.
