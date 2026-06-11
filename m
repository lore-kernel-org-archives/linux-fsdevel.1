Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0504071EB
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183779; cv=pass; b=di1nrU4q6zPNI3/gRY840/cmoTT5OdUpGTrtfJqry61IYvWERVUDCyBbUcd/CHVy8OLKZCD9PkKpMB5Ep4HCRodULQWZKhH9YczWLmnL/kyaphAPRbo4lUD8Yd0eNasROb5F2MgsVvo5yzIJQ8wOUJK6b1Zx6EIC/WTtIJat0F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183779; c=relaxed/simple;
	bh=rpvjpPicNn+zjhi3M9Ew9PwUMSc/xxAGxgGF22F/Ffk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpEoAmX1D9bPT/9xneuQL/l1czWWMm9V/m5tAVguZO5qug9VoE96E7kvojZ3O8rdjr51sY0jWZq/V91xoMsi2ql+m8ep7HaHph0NNK5kSHONFZILC/N50+qTST/uRQV/uNZnx9o4Z62B+lN1W92dfPU+dhwrfrN4ebLyPrJIuQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LurOrSRa; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LurOrSRa"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30807ba471bso1390848eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 06:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781183774; cv=none;
        d=google.com; s=arc-20240605;
        b=dR5CYWclBQeC0+3+lZvkfXkRaxymwOyR7Q16AA3EiplyiILw19gxIjO/2tysKpxolq
         xAltvMdLZigEEw8Z4fClDQu92JhA2Wwrw1j+WYjv2ONV5OTnriF5vidOoluE1Cl6I5ZV
         eUR0yk8SR3MrTzL+LS9MNbDYr6upgKOZVKc+nthgYItbqxiyo4tqqfkX3Ie+XthTCupg
         JDzNq7AbAMjn3qMIJa/LuFvwOB6LwhK+m/8tCTxWsIdZ+BN9YuZxc7xjmt0J8vniT4l0
         l5cPh1IyEsWeITQ48gw0ANPKqwLyEBzj/1ypqObuTf8DwsuqZdGFi2IwKeVH/TRN8zlH
         BxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XHeZCLcFc/mQIagjY8mWKZ+oOET+8XYWGzngWYDKVfw=;
        fh=zlfVpRN1Kom160mfPfJTeRujH34ofbs3FA/OS56li2c=;
        b=H++JF88skw+SwS8MDcK6faopGqRii6UsXLj9q3yWJaiL3fquG1EGv6o2ycmWJoLfKa
         8uUj1LYxretVRwQ+O6N7dQbLZDOLJ5QC9SPokW2IGlZeU40ws3iI32GZXFfV1g6lu/iS
         v9MAtRE7T2AZi6dYKBe+6+RfPSrJL4Or3g17HzKSAXFocxRO0oJmPos1pNBgThVVIN3K
         ad4xrZREJ1YMOi3h4DuOZMaHfRF7BMyAtvCFfwP84oHxW4idQnFE3RsJa6LPoesFFwnt
         KZYs7kugluuPpZJj7fpFd6NiJ86CcI7gPbEOMjkMAqhZCrUKoVYcT5UcifLrBkgeQLHE
         lCnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781183774; x=1781788574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XHeZCLcFc/mQIagjY8mWKZ+oOET+8XYWGzngWYDKVfw=;
        b=LurOrSRaT9YA+qp3zCfM+fXhgdf09iaxLY6DOBGDkNQagmdnJi1HPhXqezVRzwqq98
         fRJrNVhLMGd01ceiOdqc/o2GVxoVlsbCkp7MUEhQg7R9qsrp/0GMBqTqN8PKHyC19jP+
         WexGhzeQHVfJhmhEU+W65WlBK9QDD525NB52s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183774; x=1781788574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHeZCLcFc/mQIagjY8mWKZ+oOET+8XYWGzngWYDKVfw=;
        b=TvM9gzp1gR+be8MGXGoMAxNBQ7hK+AOX2lFwXMcGQVNJodPy5ywoK+40DXbLg/h2l9
         mMTdQ7qvMj/1yTlIwPL9JGaPlPSLexeqjNhvNT65b93NHSP8kFINec+zYWHoOoOTOSS+
         v6egxw0g4nGz+9VDbOeDf1MCF+bvNDj0osP2gPq1svH8ZD6t9/PestZvcPuedE1zSTSM
         dcKLs0u0FJB41TgOsj+HyvDd/N+fBarJIX4xoyBqILGuf3qYE6wMjqgES6lI/hHXHQ7a
         xDklUSUJA2qr1ih/xzw9yzaLTcAq5w2MntZ3bch7p/towx2FaNPnad0R93wPHB03AnoQ
         aZWw==
X-Forwarded-Encrypted: i=1; AFNElJ9jr3QIhJXEhGiF4v/eiXlHXvr5+r+qyeLlbliHcg627EWewbS0WVHwK2m+UK29hv89cIGDZhf043aFePsx@vger.kernel.org
X-Gm-Message-State: AOJu0YwboP3l2jqq9NAETMDsnMIgWA57FFoIXkWndPFQXHqBUNnAA8Fp
	cJ/+DiKYaqtwIRjOJ+Gaskd4XJdwLKZqvPH8PL3X7ON70eGsPBZdU3+RBhG0sbsE+a/YmBaVXbj
	XEXmOxiDCVvmfCPAmQzwx0ap7jhwrZuGtI9fE8TomcA==
X-Gm-Gg: Acq92OEFUwMGKANmolJJfjm3jzcAVqY9IfQCfzPmIS4BT3xARp3xsS9nxRz2SbLmVs0
	2ppPGgovfJnpHg6d9H1DFogAUNBRTrPUxz9cQBhIIgYIYZCy3KngoP8bFIzJzFqx8IITCIeENzU
	Dc/0oONoafWZ14hfY0GuPmNMhUVdB/P7hibo4G5BSMHIxeC1kKueA5Xn17MmqKyQsmf/nHBRRtq
	kGUBtUueabZU9ApfsxQ9gtG9wnTEMnh9r0drNv5IWl6aGoPFZn8CdGvv3GsSdCoeJXIsr/XBUGp
	JWhJOgBbVf6Rc3FUp0lGxkMMIEsz8iJw+R9zp4y6IwzSpn0pmGHCex41OKwpeA==
X-Received: by 2002:a05:7300:b90b:b0:2c1:6676:5ebd with SMTP id
 5a478bee46e88-308047f2d97mr2134685eec.10.1781183774392; Thu, 11 Jun 2026
 06:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526152021.891412-1-mochs@nvidia.com>
In-Reply-To: <20260526152021.891412-1-mochs@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 15:16:01 +0200
X-Gm-Features: AVVi8CcXMSOXQHHyt5_Is6rWepSACZHd-9SlsjjwxhuHNCsbLA3hfeHrP9neohs
Message-ID: <CAJfpegvSrDgTajqWxkgRCkwxNoR6f4NU9cvKvcpThVDX-jmh-w@mail.gmail.com>
Subject: Re: [PATCH v4] fuse: back uncached readdir buffers with pages
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 May 2026 at 17:20, Matthew R. Ochs <mochs@nvidia.com> wrote:
>
> Commit dabb90391028 ("fuse: increase readdir buffer size") changed
> fuse_readdir_uncached() to size its temporary buffer from ctx->count.
> This is useful for overlayfs and other in-kernel callers that use
> INT_MAX to indicate an unlimited directory read.
>
> The larger buffer is currently supplied as a kvec output argument. For
> virtiofs, kvec arguments are copied through req->argbuf, which is
> allocated with kmalloc(..., GFP_ATOMIC). A large uncached readdir buffer
> can therefore require a multi-megabyte contiguous atomic allocation
> before the request is queued.
>
> Avoid the large bounce-buffer allocation by backing uncached readdir
> output with pages and setting out_pages. Transports such as virtiofs can
> then pass the pages as scatter-gather entries instead of copying the
> output through argbuf.
>
> Map the pages with vm_map_ram() only while parsing the returned dirents.
> The existing parser can then continue to use a linear kernel mapping.
>
> Fixes: dabb90391028 ("fuse: increase readdir buffer size")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>

Applied with cleanups.  Please verify:

https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/commit/?h=for-next&id=2fcb1dd15faba5657b825cc5d54423251c70e79a

Thanks,
Miklos
