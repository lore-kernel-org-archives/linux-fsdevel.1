Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555138D3F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038431; cv=pass; b=cRr6MavBj51smQVOHG561FFtHF4CTGpu5AxtWgYrZ8RSNjISfTT36CDE8mz7p5uvm7Fk8h8MuKZSjXXKaltj8uarX6mr98MJR1S4YTRvoiT+8WvtMxL7dzNUxMMD5o1fZumKG7z1j6KlCTxr4xrxd/cA6UI6TFapP0H/JfFMAn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038431; c=relaxed/simple;
	bh=mKNO5uns5cr5MbP8cJom1LkhTdyHNmNZ6pPGnq6nH7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXzjWHPbBb4M0ezh2diatLuL9gSlc1aLSKJpJLowZUZQIUcWJh+CNSf/VXkc1B7Jm3DxdDCwrWV9a1+Bmu4uvL5qmiGhzJNm0XBSzPvcK2CGzMkN8s6Ien1C3R6XgIj/9wHZ7/FgOBYxwDADq1Z87TqIisGlklgQfRiUCCAttL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BhvOaSJC; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BhvOaSJC"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930f618435cso249852485a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 00:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787038427; cv=none;
        d=google.com; s=arc-20260327;
        b=sZ5DNqz7d4b2GY8zhqG4TYPoyStJ//LnZ5YsNREy2lBRjRqhmh2Otd03KYb62Os3g1
         o3gGdGX/BpnHMdD+HAKHHz4bSM64C6we5EQ7s1OENM4rvc4RaBJSW4yF9d8eUvB1o1Ty
         C8Px8WtsHX6IyDQ+GfEyWk6XHPbixeLmFXPyreY5D4xcI3HNNEJxAoyEcA9ckMMlkgb5
         sYKrNUX9ZVo128iPxIz3CPHkAC1UOK9biAAiXytfVNpPlISwWs85kDxa8xQJ0mJIIjfQ
         pOQwtjhgZGXpRxid2+Lg3M6HuNSae8PZS00qPTxScqyZfEZguAw8w2wjzmD/lHFCYO4m
         hXhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=23pp+2untshEdvFcYO1a+Ff6qkMCJDJWfvL37J4f4Gg=;
        fh=KxEyu/L8rOr5JsGAkPxoMp+t5nxyibDF/Ofn5Wtu3eU=;
        b=WC5mtn+4Oo53QXsL8+CigOuWuY0eg3IkVShp28LJYf7VrIblkVE4w0z48OE2FRzt3P
         FG8b4Y+KjKE29Q7s+B7KfMIroaXIHZhmNlGzV+sPQR44N2jevC6F3mOwlpkk81DjHSSg
         liUXX869QT4FYtYPGFwudtyp1gyUza4if1qziYkecl2to2p+MHD1/uhVNMpAaciBnC/C
         CWfVaOeg2wbZa4MBlXXTPkEGw/wnfAtk+ky9xbvHFJ66cIoO7pAFau7ccU8xZJFzvwh/
         p88Iro9ZVwf9hfHahXmR0pmEBzXBpCuwFniXTk42tQR/5h6dvTCGUCYzYd49tsnjjkCC
         YucQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787038427; x=1787643227; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23pp+2untshEdvFcYO1a+Ff6qkMCJDJWfvL37J4f4Gg=;
        b=BhvOaSJCksrMl/wuzzpk9nr8ZyTVX4vFQKBPafM9e6ms4IQV6I6vvu6uFp1QEV2nL8
         IuLcw/tVRdXIBI4kjMagrDicyvmOj93BejORAzVnuVDl/mI4C8ZeB/zPtiUZ086yKVo0
         lt2hGVGidkuMTdLm6NyGNHryTEgCPS5gsqw4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787038427; x=1787643227;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=23pp+2untshEdvFcYO1a+Ff6qkMCJDJWfvL37J4f4Gg=;
        b=UhC9lWDX6r+x1tt3u9VGNl8IkasztDPYnUm8G03sDPUXR3abzf2p9jKxj0Ty6p7pGj
         CfFCmRZm85C9dhRw9SyUZuuNlL3zEdXoLTrzL9QJxWdV64xQ7CvSS7vZ3THs1r/j19RB
         cyyrkUd/DrshTODIQq+jPc4q7HpOPsVBjpsX4m6okPTHHaKtOxOBsQ4m7NaQ0oB+SBSt
         54/MVppls3RqaUkQI2bU3EMBNW7+t8+Pzwdivsah/+S5XLWarN/4lIQ3Edd5phGlf0/w
         jl3gjPulfVyl5+E+E+LB2BgoZ0h7JjAVnR4+LBSa8ZJWD2aHINkjOSaNiBvzVhj0CPqN
         MnLg==
X-Forwarded-Encrypted: i=1; AHgh+RrRv3r0kCwSZYz/o48zE2xUcxjuclAinrPF39Z2mTpDYxgeG3NMxIAVCdb2r4Hv+tJJyRAjSe0ghUPMsaFo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8koqOOwjOk+C9zZKzJver4t2W1qb80atL7JR5wgJOt0bP1w4+
	HSYYZYiURSO+JX4q0zUIu6Vaix5rz/RELIERogEH+GAkaOKRoKKcm884783/QOl4yiwD+R2KlmF
	ptYzR1lJCTYT3ZEZ41mbp0d/jxlDkh0kduaZfrO4UR9LkRrG8h5mRhv4=
X-Gm-Gg: AR+sD13NLVk5rdBMLmRcM6Ql6in+wIF4AgVU/JVK5YhNyzTxf/gFDyoMwCMt5fwh/N3
	GJLkgnMxV6HlCW2E59auHS3/WgtRCz4CGyWQFKBmdcKulxyrKdXkXzuhiJ+/WzSySq1MMzzu2Fk
	+xlAozioWOnp9OaEeFtIh2ewlthJvgCFiM0Eq0SFw3cw4LkXR0X0o3+EXBItxVDhtwF+vkAYAKm
	Mtb3y3dvLE+fKhCghqXlQxHTzRnUTXP+s2E4ZXv+CNP1dqwDgqE5xrcFHDFIOdR5MEygghw+AFW
	53Yl/jMlNm4UakBR4y8TY7LOgplK1kyndu8YDmUfxEKJc5v4kcqsubKjo2quhg1/GBrNf/GBnCS
	8
X-Received: by 2002:a05:620a:271b:b0:936:dc16:206b with SMTP id
 af79cd13be357-936dc1620c8mr2881763985a.26.1787038427231; Tue, 18 Aug 2026
 00:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814134015.618488-1-libaokun@linux.alibaba.com>
In-Reply-To: <20260814134015.618488-1-libaokun@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 09:33:35 +0200
X-Gm-Features: AcwNN1VmZ7FJUacjPq2eYj75UI5ip2KFg-NgUAA1tOeLQqY9VC0g5LvYqVXKsdQ
Message-ID: <CAJfpegvKQrOGAFCDidFeELrQb08sebJVo=WHXB5SoWAwjodSKA@mail.gmail.com>
Subject: Re: [PATCH] cuse: wait for pending RCU callbacks on module exit
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Aug 2026 at 15:40, Baokun Li <libaokun@linux.alibaba.com> wrote:
>
> Since commit 053fc4f755ad ("fuse: fix UAF in rcu pathwalks"),
> fuse_conn_put() frees the fuse_conn through call_rcu() rather than
> synchronously.  For cuse, fc->release is cuse_fc_release(), which
> lives in the cuse module.  If the module is removed before the RCU
> grace period ends, the callback jumps into freed module memory:

free_module() calls synchronize_rcu(), so this should not be an issue.

Thanks,
Miklos
