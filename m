Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.201
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795716535;
	b=gOC/nDhGP3mZbDr2b6VbKYZ7C5A0liitlKK4vj5ic1iMBfDVSGISSM5r0JTc2U1KV5rQ
	 RHKvvK6p0ej272P8C1xSWInw0K9GYun4xW3GTiVvseVgFywrTlxnFoWJN0zTD6NF2RvQS
	 i6BQG1kWmz4KjxOlcpVPXxTujr2Woi92TnIB5J+koNetH081eRn4y8jWL8itWB4oh48Ii
	 Hz4REVi5DjULDaYVz6X3VWK0RPlYFRv1F2OQQqSE2Rw8kn92BaS1H7z6hDg4ZDU1cHmAb
	 1CDZBWJl/gjHtskmx7IBtTVNLYcAqyTxPsnfam+2zq6dPlpg69t222nO+inostw5AkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=GPDH5iymDD1XKiojTuDMjg7ZZbxBabRJM2yU5TRq6AU=;
	b=ysOJIjoWQskXuQkcODigYYkeZSwINijEABcOGRtexfmK8DNy7N+aAQRQbwlIE7vCQT27
	 eVUklME946HxpXcMD6YZMR6bR3PXXY/f6pBQvdQIsJnDB0D/Ai2gGRkoQwz7ejidDm/md
	 aale0z9cD2IQGa3+T82nL0O1kpumWPOQqb7I8pqGFIY6pNDjFXq6pY7AGfyvhB4dCt8J4
	 IN3hB6R/zlhXiur3t/xRrA999SgLhqaxhdmgMWNBGi7ocm621f7adLR77saeRcEhR7Bvp
	 7N+ZaAzNkpK7MH02hfg5WXIGuggs2P3r7kQD6ra408iKUsprJ67l/3wfKDsA4Kr2PJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M5y2t0eW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.201
Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300F606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 18:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D300F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M5y2t0eW
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f61e12e8e0so946869b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 10:08:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795716533; cv=none;
        d=google.com; s=arc-20260327;
        b=UpC05mkY8aFk7TnXYfAfWVRSeRpgflCcnocYEB8wlrlBbkhNdGLFpR0c9Oi+tksm5Y
         4WgLDG1pv6afmMhZFuonn62jkcJla9IlmrGMgDhUSX4H/vYIDDxp/Pqut9jUzaQ2oP2E
         TfYth/VwSvRLJ8lBOaYD+d1acN/hVq0wVmhr4yK6gBMYmgDLlYQNeYoQquLM+ZOTeyBB
         tJ/h4KPNEKqDMnulfzs+jbu57AuKkj+mcpvRtD+XWQMugVW8XCHTTWW8FPjh0AciY5CW
         quB1K6lqgnO4p3UXoYg3aHQLOgUPyHEMtY0xpGgma1uDklCEqB5GX5lB40ydwKQGfjuE
         ar+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GPDH5iymDD1XKiojTuDMjg7ZZbxBabRJM2yU5TRq6AU=;
        fh=Xm1AzT4X/MUJWR+6HeQMik8NB31SuVAhcse1OilJ0W0=;
        b=kIYEsa5LC05G9+CHQeEacRnhh0fMoTlER1opkOD7q9U+oq74XF0vk3z5CmChDV66/w
         XH/kH9wa0yPATAOViyKhVQzsSTaMlz89hFpRlKiTjOTi6kow8FW/sIy32Epn1wpU2lXh
         voBmaQU5FAJAF47KfvCo8ByMPwccSwkfDc8KvAPbLu2afDa2kSv/lMp9JlWGUReNdkqF
         SDE8tri6ADH1hTXXvs2nRNjnIo0dMPpiJxXbz4XnPehbhvmw7PosWUZUKasU2RNuK9ht
         DYCkm35eqZLS4XT6Ee+s/T2IYFaIBzeSGRnZoXHYwea2ooc1Nibti8BkZhNrKWXj9WHo
         zzyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795716533; x=1796321333; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GPDH5iymDD1XKiojTuDMjg7ZZbxBabRJM2yU5TRq6AU=;
        b=M5y2t0eW699s8skqtUYN0i50s4bbAZ/h5qrTZoU0S3m81uLm32Ezh8TD3xFGtlERN4
         Lrx8DZkcjPtPC7qYdoBmulkkS9yTt6kKgp1sx7xxUdEU4BXb+rOYD+u6leFPG2WFIGJ6
         MFlKpGiFojNKsRS/MXkZs3J7nxs4RbI59qRdJ8yMwCCt7vj3ZE8sYKQxW+CIZMAfgyCJ
         AwnvyRu5lig0WXf9/QiPpD5sgmOaIia1PTW4UIpsx6hl4beFTdQBiLvaM6aHQ3YIOLQY
         ZMKlDbNbCJ7E9K2cvPbLYmPHh4l7b7Yvl82BmQAVbuQJZJUn5wVBm1nHK7cwRWdE1NeI
         Z0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795716533; x=1796321333;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GPDH5iymDD1XKiojTuDMjg7ZZbxBabRJM2yU5TRq6AU=;
        b=qZMtR6PAOwL57j8srGKLhRSh5fZaRhgLF34jolvXprVU4nCmQ69CaOlJ6zsw2mFjuV
         ykHOfQniK8tUBNB+Qat2IN1gH+P+YRCANQcaktFZ8ZAqvK9jQCZMPqW7tShksJyyD9+O
         85wIzoQ1OD7x3/6UcIhdxmJ4YKpKFCHMtPrLtKK2mjhGHd46O4HOk37zVCKS9pzab+d3
         beMklB9PoixQ+tADHvko7JRsujT24SD+S0X82BcQZZh7elnem9RfxPc4V4hCCTCLktsK
         VLrPBzna2EORiSvKjBaKtGh63bQZSXKLtJDopngJPzX7hTs+8jvYS7gkozETDMDiIxk8
         5U3g==
X-Forwarded-Encrypted: i=1; AL+hErEitWFi7mc1UFWYsT7qdy1dOdzr+I+pGYxyaLUMuHAJI1FzeMsM5urtrNDfr3bQpbRibH3JexKHI0xdJzgW@vger.kernel.org
X-Gm-Message-State: APuU4Z+mRrzWos6a/yVWPglr3J1LV9cuFwymjiLzwdDUQV5ZxUqrTFZo
	Yz8rRoSXA0v8iX2PncWhEqtbJyID6r702pu+eiuFlaSZvb+0gc+dYep+PJefT+2VQquca0UFWXI
	w/q6TYx0tEZ6uLaPMqa9MkAQX5mIFzDk=
X-Gm-Gg: AZFdTZeG7jHU2M9JQTp+QC6mlGNoOmrnJNVghwc4Hq+ASvw0bEb7W82ueLczWPqFUin
	cwut7X+oQ8XIwrZCxKOk/LMaCkfhJPFWJQ3cG+0GksRVS0n3dvI+urKsnjtiqOUWh15baJ2T9ro
	6KgBuETsPbqtsoZftgnKOsq5E0UFFzoDcYfrueV2MI4ifsdTbeF8hm+YySwQsf9Jcf+o8xpMD9a
	aItFAl50poZsiEokeCMIM+eFHRiOc60SvyehSke/RSh2Mauhi8Cl90qYKaVcfoW8l8ZJnZ/TDIu
	zQFl5xqI9dSw40g9oGry9TEYgvNUqz/GHakp5cK2uaYvzrFq3T32APp5fQFoMn7P+ykm8L53WM2
	33vZ7AOCNbkqqHrGtzTG4kWp4FCrkCSdkaFiiUa1dkJMHl6y8+6QseCuWNM89LQgRoG8RC73Nu+
	1ZVTVO5wFWSxnxJficn8RpM5OU9lrs6JmJoiI70KxA3/YK+bFLrDS+
X-Received: by 2002:a05:6808:16a7:b0:567:c40e:c79e with SMTP id
 5614622812f47-57a0a7199a1mr21127806b6e.24.1795716533448; Thu, 26 Nov 2026
 10:08:53 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126045222.20770-1-dennylin0707@gmail.com> <awgPDmEbGpJsT_iS@redhat.com>
In-Reply-To: <awgPDmEbGpJsT_iS@redhat.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 26 Nov 2026 10:08:42 -0800
X-Gm-Features: Aa3M54o_0peM6H-aXQD7e8ntI65htstUEnHPSULUoro50ukRn0p_g-FggU8niJE
Message-ID: <CAGEkeHcK2rSWyQOp5a6Ub2SJ4wi8qK_Wz5uKH0WN+pLksL9jLw@mail.gmail.com>
Subject: Re: [PATCH] proc: also check the opener's capability for
 oom_score_adj and oom_adj
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, adobriyan@gmail.com, 
	jannh@google.com, jack@suse.cz, sforshee@kernel.org, me@black-desk.cn, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 11:50:54AM +0100, Oleg Nesterov wrote:
> do we really need to keep the old capable(CAP_SYS_RESOURCE) check?
>
> If a privileged opener of /proc/<pid>/oom_score_adj passes fd to
> to unprivileged writer, we probably don't care?

A write that needs CAP_SYS_RESOURCE still needs it from the writer,
even if the opener was privileged. For example, a task can open its
own oom_score_adj with CAP_SYS_RESOURCE and still have the fd after
dropping that capability and calling execve(). If we only check the
opener, it could then lower its value down to OOM_SCORE_ADJ_MIN, and
any children it creates afterward would inherit that.

I kept capable() so that a fix for stable doesn't relax anything. Or do
you think the opener check alone is enough?

Thanks,
Hungyu
