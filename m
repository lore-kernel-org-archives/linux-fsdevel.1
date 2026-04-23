Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38D2DEA9B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929545; cv=pass; b=h7YQ6fbBwMPRgVuV6/MsNUvEzYYPpLu/E6DtfoXXX9rPeKzOmTYB1WyMXrRD9LH6gWxhg7ocblPER25LCZO3ESqj506zNGlGRIGNNmyJLf/yw7/912FhJFYG3OPgwMRUAgJYnEKFpj2RUMeOEeLR/mK8WNwmhPvrL7uWqlu+Ft4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929545; c=relaxed/simple;
	bh=IpohdUHrqp7Bcpsv6ZOtuAITGFOK2N+08ThfiOE7Jkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjOk3zcz4M21xLuEqbk14dXDBzkKbFimqxYltv+DUiVfidGi3HLMIi/yvOKbRNgXQzpfccVWXqH/IQfY2MHc3LUVYKwk+ez2BCVDEan4lcN334sL19B11usmZPPlzwDEIftXrKNv2kZB8kuLWrPQ//OzajCg72VfyjDluwLzsCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=baQV1QQE; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="baQV1QQE"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a032383008so63786836d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 00:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776929542; cv=none;
        d=google.com; s=arc-20240605;
        b=bre1zi8ZCv7BuZDRUfC2tmrTvs+4pOh8ErAx37lNvMD3rpiAPnQUQBgyXbf5bFAnfN
         L4TRqCNl7/bAWR2SuTHtT2DGi9m5wkivxnFA1JHGjzfuicxkm8S8FUso+fcdQIQ8EAzb
         O2xBA5SLM2hh/aDYek4kzHUm/1Gs0D7tm7Ge96l6glZZhFV0NE5d0vIEBCukWrk9PVWG
         a4EAPBjgrbnqbh9aeEJIl3usnoybdplWsSmbhkSOFt6cwOTLKfDL+OHOCTO/sDEearol
         46Ge5nXC+etzDRjGTXy+ZNXTwK8qtBhvdO3eJ277PkC5VgN9TPCz12+B7FOzpuAoCvZO
         Jhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IpohdUHrqp7Bcpsv6ZOtuAITGFOK2N+08ThfiOE7Jkw=;
        fh=bsnwo/FqE/Onu/mIDre2mpzK85vxV0+JGhGvHdLLVCw=;
        b=dWrT9T5BkKeCf95IQQah6h5D5e72Pf4nJNDvXTj9Ft87uFMBCy3BUjAIZvejbtWYmp
         Aqxba43mRpKaXEWsr5y8RA7Pej4HjwdPJv3DlXGmuOmUq9ng4XUHAMWDFJ9ge3lVCO2K
         blVQo0It2qJj+125h6ADfqmiTSYKfo2uUcU1N1mGlWG33yo3TowXtFG9UUOmFlNe63sp
         eMwXwHaJ6vV1P5ZBAqqzmOWUf3ob0W7YfXJ4LbzqqkEr5EMLdhp824Z6f4klFm4Qjp65
         dzH4gcc6dz7RFE7dfhifjKiSthIToWs/ldeuBI1hBpVFu7+Q/xVztCtwMz1ioLFhf8id
         yKAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776929542; x=1777534342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IpohdUHrqp7Bcpsv6ZOtuAITGFOK2N+08ThfiOE7Jkw=;
        b=baQV1QQEKrL/GCCCie6V6WS4LoeVfWy4mGN77Xt3zydRP/+pmt7m7lF/4pgkunmmvc
         leGMOjmkT2eJD+xbpKHfYA0hNF5QC3zPg7SjdmznTJk0Br5ekXO3PT0iuoEDYQD7Aok5
         0ZqtqvnCNrXS+Yghxl66+9vO5fF0vKjuf96YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776929542; x=1777534342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpohdUHrqp7Bcpsv6ZOtuAITGFOK2N+08ThfiOE7Jkw=;
        b=phJdzA83yeWmleltUCdNcLzFGunkWignpVm6/ciGMoKXSwmE4SZvNlLk+YxaAOsILU
         AEufX5/aUNAavQuSD67sKS/sKDZ6TSAGdRc0GMSDWE8X5PQJUf3X7m95petJLtydxdXH
         A3gbDMboFGZZnLONbfV46omtiIFrglIIbCNLs/WUW88lI3FLkZnhJ+59/RhcTRQsY8H7
         WrgPEdexbm0hoWOjPBqFhO6ZyVqciqo1c3+gsE2F3PXmaJvSZXanmQ8hdmTGjFuTK+NB
         5GxYZTFOz0SnI9uKcUh1eEk5WS/0bULVJDX1I4e254iQCg9O0pSGRbgyDVXvS6Me+v14
         O41g==
X-Forwarded-Encrypted: i=1; AFNElJ+jOi2S1CTtNu7yXNKe4kTNJ2D7wZF1Jg4hENyMPYE9/V41Kwy2kgcIw5kWoNZy12J4yFca8afjgCWRzRrz@vger.kernel.org
X-Gm-Message-State: AOJu0YwOIb3Cj1mzfOKTI+fZmYP4MM/XT/JSPAvlOtbH5Y/eYE/i3CqR
	9y8+BCDY48YFpULYXdWhUvNJk8pMQ4TUMqN2tt3uS2vvComlwU8Bad9eeok9hiE+10MqIQ19dnj
	ZayJe+Kv/W9GKVej0BXO5h8e9eD4eQGJbZsqZXtfr7g==
X-Gm-Gg: AeBDievZNFq5t9XeeiOojiNTHmZvMFIlIgPwFZH4+DNXd8X64pmmwmaNqWSAth5ZXtm
	4MdwKMxqNFvJfR9VGg7IowVDdCA1DQJFN+UqPkzTYOyvRZIUD+PoX5+RG3Ol3ENRB8KfPQEMc31
	4jLattJw1003UxM2jJx4M+VyDf/xJl0cBtlxdkhftUBX4PcKI5tiesUA8w3WE6FYFsbSulsxLpM
	Zek4sfMEDwOAOpNtv+spugOb65bEn6FrIAW+qE1Xei41DcUO83IL/F1snxXoI9YSvtOFi7lrPxe
	/Ji/PcA0zy+jbj2E4hqBLJha78ZzPTuZOr47xbJP7Bot4U0bMZQ=
X-Received: by 2002:ad4:5f8e:0:b0:8ac:a82c:1c43 with SMTP id
 6a1803df08f44-8b02813c979mr422929336d6.41.1776929542373; Thu, 23 Apr 2026
 00:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420030900.4944-1-liwang@kylinos.cn> <20260421033816.6546-1-liwang@kylinos.cn>
In-Reply-To: <20260421033816.6546-1-liwang@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Apr 2026 09:32:11 +0200
X-Gm-Features: AQROBzD8W1q96l8SQctD59yW8R_KX0xeccUZU2-An1mshUChheb41Gvv1o210LA
Message-ID: <CAJfpegtwiJaaxqa7kS4TradNuoggx0HBK31qWeu8Ks8zEkOzbA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: drop redundant check in fuse_sync_bucket_alloc()
To: Li Wang <liwang@kylinos.cn>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Apr 2026 at 05:38, Li Wang <liwang@kylinos.cn> wrote:
>
> kzalloc_obj with __GFP_NOFAIL is documented to never return failure,
> and checking for NULL is redundant (__GFP_NOFAIL in gfp_types.h).
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Applied, thanks.

Miklos
