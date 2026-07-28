Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1016D46F49C
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265647; cv=pass; b=nE+rhFImaWhpO8YdX7wT4CEVE5B+Z1N1eONI9ZwwQD2dL60I/AUgGZqu6GuhlIYyY2tqwdSKzweX4smqYBXBgFHU1jzoZ3O3iRNs23QbRiCI2ojDf8lBbJJeMSrb1hIUrcIiwOvbj/1oMk+6/zxjaPuMgCdoWPLXlJqlJSDCNIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265647; c=relaxed/simple;
	bh=SH2IHLDio+NDuaGDNJz4MlNmJaY2jeiniMqmqafc/Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKl3WmEls+WuwEfzPIcruX2sMTUWAXrxyin+UuaWTPlNS+2G3mD0T9QD7ApGBK64eJpBYfLtnBOff05+78XcKFt15TyP+QHTm4RXWolPUT+mwIo2W9qo+PpY3oJK8obh3aobDkqDP6EFZ+xTmYjDghroy99lOpjCzJv+ruPvHt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTlZ0aDI; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTlZ0aDI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495590dde14so2238815e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 12:07:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785265642; cv=none;
        d=google.com; s=arc-20260327;
        b=j4Q998BCxNm2J1mQqUNC1Y8ewFr9isxaFM6SmXTVirgCjX829RXAfbh0HNiSSWW/Rv
         cRJkdnrDtg1lejjWi6PCxQMbVyQMAJV3PAeEgvVGFSy5RFbMJ8kYJWAF64CjcPQJ/oOo
         Uwb4b6DJrceH0Yqvu4OBpE3BYFCYnwM86wB4jD/PvEp+LgT9FQSQ6VRglzPD1tfOSwGD
         x1knsXvrAe166podkJknoJ5buuW5N1btyMtgYWCJySX7p3xUgiwUOCU6lRIx4IcJ9NTO
         lsqkqLaHgtxiwcFTihmTHSCKY9nOFyaWLkXMRbA5JpG0monCTTGWFQ/fngt/mtlm7xLU
         Mi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SH2IHLDio+NDuaGDNJz4MlNmJaY2jeiniMqmqafc/Kg=;
        fh=ncb5BzEetvGucww7ZLymflrsnYd+ASX9fwWJ/VRm+UQ=;
        b=kvS00IStvX/d24WYSSlPbOcyrPUtq6mqYU2xvxkcpy1BOZIIfiW0CkjseEqz4UcvKZ
         cPb8deo3RaeBFHpx5lyeSHhIFCbP/BPS6Qh+jolWRboYH430k4xsvpxaMqJNciYeDtvA
         o+VEm5C/Sc4/G9t+cKY+nMO2TuPriaO8mplr/RtCh840UCDY1v0o1X388+goj+RjSyBD
         Lubt1znupuhVC0oaAtYLo4LhDHow/aUwHbu7ff3rEggMPgkVqvF020V68xs2qqD2sDqs
         oh79QNv+8fuxfEFj9Z+0RUC+7yjaP4kmk9u1nd1onHOSVDtpvOOSzSoqwOtE3oDkK93Y
         1+zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785265642; x=1785870442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SH2IHLDio+NDuaGDNJz4MlNmJaY2jeiniMqmqafc/Kg=;
        b=mTlZ0aDIPeSlD5uBkRFD1KhBaSmjGdptcbegN+U/970FFglW+eF51LqYEuuCVhL8fS
         cfZwPSOgKwolHtF10TwsfD7/COTlj+DtC6Cj3gRJUCf/uUX6JCLd7tVJI887nb769U0D
         wGys03GeNCNPl8HzxAfvVKl6ab1ilSuJVCbptObQSsXOf6lyeqjt7mBNgnjcmjzTmHJk
         4kLdccyYVS/inDYC8hliydwJJeaR/v3KkZcBEc7vQVLo+6dJ+pcZxTbpfv5jjphuAK93
         NcE/+9zb/kNR7y47rQxMz8/R62kKXvMciadtm034lpKXOt+dhX2826x2arIrWdBEmBrn
         FKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265642; x=1785870442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SH2IHLDio+NDuaGDNJz4MlNmJaY2jeiniMqmqafc/Kg=;
        b=JGy6Ng1r4/JyEDdhAlkEgmaxlpKfIqJ4Gu/5m9xjPP7jhcKnBOFKEhlfLmtk12tyq1
         BKPtbHlPfJ0px5lSNQgDyYvGq4HmkNrhBYbMziVAxEX7ExK/lDHMFtvWs2KaB3fIugtD
         GCCGynKUnA89iLymBgZzMf26ldQcJiEhYH+lcnyOFcfWL+ch+5FV2bqW37bCqPwgmhpN
         yictqWXL0KybZjs53oA2AikzDNgaIqqmcDWQS6sFwNXEJvZ7sb7Y4ZxUbvy92dwidZda
         iB1iNOcNbMan8nGs4Q6nQDSZcbbZbx9T5TkTaHqkzoHaviJjbNX2VABP1kepm0jhJHMh
         0Uhw==
X-Gm-Message-State: AOJu0Yx8j1Pa/UqZcgDxhBcYg3ME/3mZtNEsW6sVPfsWa5yWFOsMfx83
	JtwufqrSJZV2pnydBS/1mdimYDR9dc0o4UjXh2vxpM8jnKz0lBmDkQQrj107CluCn3vmrsnGAaQ
	HMKlQruLoBecj9VSxgbDv/hYn8sR4X+w=
X-Gm-Gg: AR+sD11GaDEp45ipLiXJQgcF146xy/d2j8zfn9rePJobJWOlofUq5bAQvlAiZefxISE
	LELgfCw1SfijXNMG798YYUOr0+VXpk19c2gOJbxMXvGNyxEfyofTX1s+kCBFSRrIKTvZhPYJcB4
	R1fS0E7vUxoONdtU/Oe//qumWtdPHHfpdy54auFPZIiw5ecGmrjeNWmeDbj+aRPxtx4BoZtnSfa
	0eiEyvy1I9Cs1koDBCUFK78VPTTkW4Y0nJvj+YitzRd12Q1R0LyZER97K4YDVRC7yxvwjuA0Iku
	eyjkeqwZkkTvccvemxTdp1aK+ibcM1UBWlqilz0m3Q==
X-Received: by 2002:a05:600c:470d:b0:496:c249:dd9b with SMTP id
 5b1f17b1804b1-496c6431be1mr40349165e9.13.1785265641769; Tue, 28 Jul 2026
 12:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728183005.92395-1-bfoster@redhat.com>
In-Reply-To: <20260728183005.92395-1-bfoster@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 28 Jul 2026 12:07:10 -0700
X-Gm-Features: AUfX_mxVO9lB7sxDP3N-Wyk1cZUT_me-dSPmxEW5UopG3XjcAk33ZqkzbDUJiQs
Message-ID: <CAJnrk1Z=qohEjesFFn-YbmU0mqSPkMH_Jy+E6qSCw4pM8niPhw@mail.gmail.com>
Subject: Re: [PATCH] iomap: release the folio batch on iomap callback failures
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de, 
	djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 11:30=E2=80=AFAM Brian Foster <bfoster@redhat.com> =
wrote:
>
> A sashiko review of an unrelated patch points out that the folio
> batch mechanism used for iomap zero range fails to release the batch
> in a couple error scenarios. If either calls to ->iomap_end() or
> ->iomap_begin() fail, the direct return paths bypass the batch
> cleanup.
>
> The ->iomap_end() case is not a practical issue at the moment
> because there is no user of the mechanism that returns an error from
> this path. The ->iomap_begin() case is theoretically possible
> because XFS can invoke the fill helper and error out at various
> points thereafter. This subtly complicates things because XFS does
> not transfer iomap_flags to the iomap data structure in the error
> path.
>
> To deal with both of these issues, first make sure to invoke the
> cleanup helper in the error path for either fs callback. Second,
> update the helper to clear the flag unconditionally and release the
> batch so long as it is populated. This more clearly delineates the
> purpose of the flag to control the I/O path and not necessarily the
> status of the fbatch, so add a comment around this as well.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Assisted-by: LLM
> Fixes: 395ed1ef0012 ("iomap: optional zero range dirty folio processing")
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>
> As noted here[1], I'm aware this conflicts with the outstanding iomap
> iter rework. I'm happy to rebase onto that if that is ultimately
> preferred. I've got at least one vote to get this in sooner, so this
> version is based on 7.2-rc5.
>

Hi Brian,

As I understand your analysis of the bug in [1], given that it's an
unlikely / second-order scenario nobody is hitting in reality, maybe
it'd be easiest if I fold this patch into the iomap iter rework series
as a preparatory patch (keeping your authorship and Fixes: tag), make
the needed changes in the iomap iter series to be compatible with your
patch, and then submit everything together to the vfs-7.3.iomap branch
as v5 of the series? I think that avoids the nontrivial merge conflict
Christian/Stephen would have to deal with.

Alternatively, if you prefer to have this as part of 7.2, I can send a
v5 of the series to try minimizing the conflict, and then send
Christian or Stephen a diff for how to resolve the merge when they hit
it.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/amjztG-DisHYbV9W@bfoster/
