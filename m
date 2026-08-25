Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192B382381
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663013; cv=pass; b=aQBn5VkiXa44jM52UdNauRWd2bFo4Qz0aHOezLmU/dYJu9PsL4br5AbY+2OgSRctfV5D33fKVEjKr5kjdJFYzG7KgYDEfHJ6TjP1zP3HU8CmQnqcUNL0C5hyksyXYnK+fp5ayh2D1mQd7Zd9tE9bNH6rTbWi25LmFoTMMLo1fHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663013; c=relaxed/simple;
	bh=CUEr/e5MholbNaYQzXTmEQ6JBM5Dsq0Y//IYN7xJv38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvI1WrOAUCTZoC3mbzQaHWaN3SP3oZr6RVLY009Na8peLrNRRdmNnSMRL32aiXIi0SLQS0rnUo4aoQMjKEXEIX+filjBre2WvJUePRcv716S1NpTPtudgcYgYl5qTuEwjKz6kiDRiR/POHXAoova0TL1szE6KbyypPbiIp7Qzsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=igfNUx6T; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="igfNUx6T"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52d56b08213so4078801cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 06:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787663011; cv=none;
        d=google.com; s=arc-20260327;
        b=P1glMVP/onasjgjIsP4/3/lvlzQgG5osCXE1ybcZF+ARUC+gmLxMYVBrdEjhGBY7ss
         1CGPXpGP5KLB0Lk3ax36tWKXXKdJwou/gDuY76iPmkc0qeXMvUvPvTGZ9p4UNdscbsEh
         RMrZz4mzoGgYDCGDBCgTvQOAZJTRAlE5oQYqx8UpfpIlfMcPegPrw0dYS+JFekeIlEGj
         gXNgsVAkbXQox1F04smXx6N2+nOYyu+VSGc6reKqqgDUMG/6B5KISGcoISwSKQwPBxVZ
         NHyMCRbYMLU7Ky7N6f1bs8YtJJAF2k5OEYPSW534V9LTv9x1afIHL7L3Cnk672iJ6VH8
         3iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CUEr/e5MholbNaYQzXTmEQ6JBM5Dsq0Y//IYN7xJv38=;
        fh=Fj8bxJaFGqKNimWcIkAJFvaQavE0Z7IbUKSE9BzJJ3c=;
        b=MPlK2lswrtPxd8mqdZ9V9hTjXtfPz6VloMTIsZLR88lqcZcXWbPVaFcb43uA8s4Ghg
         TC7+uS81z0lLanw01PW5CrHg13BcEW+b44i9Fz3JnIycbEjTLCaf0wVdxxksOPpw30P5
         IMrRPmMHKMxGKainZd6451u33fBDbrGoJJj3S5K2Nq+XRN40afSnMyYSfC6AfpOR/R4K
         f+bs22zwuX7aGGnLhm04F1KzSxalOdeVZwHLNoy6d3jycdu5wfyJ4x8qt1SFw6LfNiAW
         T5m4/7du5m4Ll88LrXUzR45Umkad37GATcQOEJkmT5qpQa3edtzGbB6FnwzybMoneBGL
         TeEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787663011; x=1788267811; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUEr/e5MholbNaYQzXTmEQ6JBM5Dsq0Y//IYN7xJv38=;
        b=igfNUx6TRkijZXNCsa2gzlyOZhmY7aFlP1NihPuqE23iSFuW7UJjUCzSXn7JkCpkn/
         QjNtyQk7Jt6mOfU/MkJ9nxzx/xGaLikqc2ua1LAr1IMd8kIHLVmp26thr4NIdGi0VHEg
         A5TwijWL5y+5pJJPrDPlSbRJw87vdWLE4Mfis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663011; x=1788267811;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CUEr/e5MholbNaYQzXTmEQ6JBM5Dsq0Y//IYN7xJv38=;
        b=KOwdo9mly9gee4W4KYIJnlYKy+3fj4YLwY8o8aqeu1uthsxP1XZnksmC8OZIHf3LU3
         Df9TooOynPofMTwscoChWQOPxZ+8eM/QPGvUxB8kny1ZCovnqkBnbHFlNpnSMU/cklvM
         9JwjetAAv2A9N4Au49DJd5HmywH9PRIV6WrPEtguEWBdqySWC+OZVUxx3CZsG8n9e8Pl
         lIwYPuIZThw0wTtS9J3wFCPVoS83rvvcde9/sU1JnGeBXwgJGd4CrkBRFv7ULogZQ/gW
         eYw+n3iJH3UU6wzkjKA38Ic+SnjowFKTeO1rkZgU0y9sn5TbJin8WiHViAQh66D+vwuh
         xS8g==
X-Forwarded-Encrypted: i=1; AHgh+RqZwTgOZkdIQ/Wk0nqK2Z75CLdlYX8nBMrhiGztv/zHNgWbduBDFujA56O9FVSFPDYBAt9uMgezeeCTIjBu@vger.kernel.org
X-Gm-Message-State: AFuF++namGiCypXl/9JMADL0TZn7bHRM2B9ZHHC2jQuNyA1wP9p/Pmtf
	godw6/2jYClw9uXjDQR5Juo8elXz9/apv9m/OSzvG9UMbCRAGp6r+cWV9sfY809C44IG9OwC60c
	UBH5e+UD+mkLWP8YikmnxOueyo5plb6WxrP0af491gg==
X-Gm-Gg: AR+sD10sMHe9A5cqh7fLw5HdDcikt0+xzeIK1FKQ2tqIEZV2L8+ksq+7Rx8vPJOfjtM
	6/rq1NGbZPraPdvA0PPeE6bG6kywUQhwNsJoUDAJ6Mq1jGPUOjGe8au3+OxiXqmtBBATugnDiG9
	AlJQpaEL7uaVMqALD+FWsVDXjM+9yJ7eb2S2gLh7VuA9+mRiIsdxvvOj0cg6dlyI3GMnMPlRwhZ
	FEo1QyZoikuhP6TOsDybjwPkgeaId0ZWxrNIatZxZmFzI0ymUcYgNlYeQYQyC7m4dupoDO99BKV
	8SrHCBg7hVoS/4abOACCK6yByszqJ6B3+pT4fimUn0j6toL1hiK4zfioKx/oueXcjpyGT1RHNW+
	KqXQ=
X-Received: by 2002:a05:622a:118d:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-52e2ec1e5demr67516461cf.4.1787663011283; Tue, 25 Aug 2026
 06:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820130158.254808-1-jamz@amazon.com>
In-Reply-To: <20260820130158.254808-1-jamz@amazon.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Aug 2026 15:03:19 +0200
X-Gm-Features: AcwNN1V-E0YVDUa4WhV6OmS9gRNJfrQeO1sZEy5JreCrY0gVdVTUszFjJtAbGlQ
Message-ID: <CAJfpegsR1oNh_PnmK-a+k=6ttdpXYAyg6SsQe=ZMCZN03gvPhA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fuse: allow FUSE_SYNCFS for privileged userspace servers
To: Jimmy Zuber <jamz@amazon.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Aug 2026 at 15:02, Jimmy Zuber <jamz@amazon.com> wrote:

> This series lets a plain /dev/fuse server opt in via a new FUSE_HAS_SYNCFS
> INIT flag, honored only when the server opened /dev/fuse with CAP_SYS_ADMIN
> privilege in the initial user namespace -- checked with file_ns_capable() at
> mount time.

Applied, thanks.

Miklos
