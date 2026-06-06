Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34F3A5E96
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749502; cv=none; b=AJdxZLW1K/S+iK8nGoXd0igwNBvk86Jmo0ta8nrPGlszw1S0J5UcdFxLh7P9Jb9LGJBWgnJvp2SxGb8GXAl5voY90n2aQ+VeY+KZcXKv6TG2WyjnaoT6eYw1sPIJdDguYR+b94WvRPSuwDHptG4vEmEgy6lC9UrxpYDYZ81In5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749502; c=relaxed/simple;
	bh=5bF6U3qRuqcKHlsLeyp8RXBNPx8GWRLq1CN6/KzYY3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jENRfm+gogDyc0lqYEFSGoBREBiX5BWyRmXIthRiDJomyPesjHJcnwXw3b2ZLwq//Bw/D+FwytMxlSuwrrVfPMsdwNGBlCbi3Q5JhIH8nD+GZ9Oc96wh3G+fiHwvnaRrAx4ObQrF3Wy1z1ZY6QlUuFkToxABMhaUMssaizW58yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXCc7MkC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXCc7MkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2AB1F00893
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749501;
	bh=5bF6U3qRuqcKHlsLeyp8RXBNPx8GWRLq1CN6/KzYY3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GXCc7MkC6fUrWOQ1WS7gNE7AjaOmsHuwWd7pwS0HHLMkEAyOaRFxUeo4hT8YlTte1
	 5pB8veDK7UddnDraYuJgTaSu6FyNcR1FZZdAtKXLf2ETJ2p/ZUVCqpSPnaKv58bOQS
	 WKn6vS/B1lZsCj46bwkSvL3hJzNKpXcbxphy+dv+ysUNMHE0p1qMDOe0yxYoMdgyTL
	 wu4A7eL7Izdf8F/mccsU6/ZVu6Ch9bmY3DsA1tTPGF1Im/wblZTYTvI7FrlhbkqXNS
	 3+nBMYSHwgy0+kxWODxOQI3tEvVWwvGqZdqj8Yv04asuN2n4yARhewap8dDzmfZZPy
	 QKfShpVAigmhA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec450b950dso401870466b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 05:38:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+7LMVn7kkgxZnoyCoJfaefPlEgC6Fr/gLnQT8ohcdiS7QHmnV64ZKEO5AgWj564U7jLSLcMO7btxtsaw8R@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq91ykSJ/27kgEojpn+SPmTsrTuCs1SEAt1tvNvVMtjQbpaW0S
	YVLR7YHUE7zlzDlRjzEAJ99UyXyB2Sa0d/SDrydb2OMQ3XbZBdhMH20cxbft9wanNud+eQSrxyd
	9dvJph99IxEOyFKVjkZcGMV8vhEGwFC8=
X-Received: by 2002:a17:907:60d5:b0:bee:66ba:36b9 with SMTP id
 a640c23a62f3a-bf3739f9d34mr373654666b.44.1780749499788; Sat, 06 Jun 2026
 05:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606102606.74510-1-hexlabsecurity@proton.me>
In-Reply-To: <20260606102606.74510-1-hexlabsecurity@proton.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 6 Jun 2026 21:38:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_F-SAXX2_hzxJEz6f6q2XOaZqMPf=NktqmELPKTxdUeg@mail.gmail.com>
X-Gm-Features: AVVi8CfUnc-0hKG-zgv2udORvzzdt7_hO3dxPSobgJ_DYjBSuL7cZAFKpmyOtlY
Message-ID: <CAKYAXd_F-SAXX2_hzxJEz6f6q2XOaZqMPf=NktqmELPKTxdUeg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix u16 truncation of restart-area length check
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bryam,

It seems your email client is using Quoted-Printable encoding instead
of plain text mode. As a result, tabs are converted to =09, and lines
are broken with =, which corrupts the patch and makes it impossible to
apply via git am.
This issue affects all of your recent ntfs patches, so none of them
can be applied.
Please configure your email client to send messages in plain text mode
without any encoding, or preferably, use git send-email to resend the
patches.

diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -132,7 +132,8 @@ static bool ntfs_check_restart_area(struct inode *vi, s=
truct restart_page_header *rp)
 {
 =09u64 file_size;
 =09struct restart_area *ra;
-=09u16 ra_ofs, ra_len, ca_ofs;
+=09u16 ra_ofs, ca_ofs;
+=09u32 ra_len;
 =09u8 fs_bits;

 =09ntfs_debug("Entering.");
--
2.43.0
