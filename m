Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D453BED56
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479400; cv=none; b=MZFnbkppl3OCYC7fRDG5Nase1V62qZJlHx4ywR9dLb4jCVc6mMqs0MfkqQm8L6twoFC5q7oeR02VB1xfIay5GyNWkLfGpxXIt/onoPACJPVEQ0SbdeXgNrZad0ddXtm/+AqExj/4pE7BoK9/GtuTLYwACvZ/sE/9MembyCoiPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479400; c=relaxed/simple;
	bh=Gs5qktynB3HDXrcuUgXkDPkA6vP85YgVlznC3ykj1ZA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BlmVh+xBllxpfzhYNFNgtlFySk5LVDltjJcGccYv4FGCb+KUw18VmgoHKr58B0gAYJOsGB9tGrPplhDt8+V4WT3B/RAFYvrHwUMjxqw1K2en0CwjX/RzqNypAS4ido3s177zfeWSeFKXIdMg1l0xFBBKx4i2nw8nUiLJpwlRcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F0mHMS9v; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F0mHMS9v"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-907ae240ac3so1698946d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786479397; x=1787084197; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xH0SwTCGvwIVAyy3MlPE//WhIac69+nmmcFLLqN73Jk=;
        b=F0mHMS9viwiPwd7gMcx/Lv3zHNyIpx0e7AU5waZ+QLlfHPSplJZq/C19lIA9Iwoh3k
         Uaiq5PmTULwhJ7sqgwpOlaukxaxUSRW/J+8AJM79bt9VODWEmHPop6cQy2bjPg0CbeqB
         WCgMIM4OiBCKf6gNkPOoL6XSRm5ZnrFTERIDCB6INW5af8/LxRCay9+ruBFVVFsZct60
         fgMNIqBtjAPYvqSSVLIXkfH2SrAEDbCOBPutibL4PMMc4Jjl6rsbs6bYv/l0tvw3ecmv
         34p7tYeXQmmcP7+tUCORbyL5cs0doTsLfyfwzX6cW5yM5dmfW5/psvN8LOegYgCqeOtU
         Nl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786479397; x=1787084197;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xH0SwTCGvwIVAyy3MlPE//WhIac69+nmmcFLLqN73Jk=;
        b=pousdgRfjkp5xm8qM31fjh+ZYAJvb1BU5dC1Imrvh2OUP+08HWaITjeOaDylyHEkrX
         QI/O6Iq1GBsi+olhcTTqVN4Oyon/yWk9CbDTNG+3AGXR3/PclDQOF4mX++n6SevDvUiw
         UWhpNd2J0EapfV1oPBFZf2htmI8ZammPByR4qKzVU3AOs82V6UkvhXHJLd5v5HMGwHsK
         jhjC+CKpXTzDakWAdmdUMBdAC0gqjnKYp/3B+jszALonJ3xTpuTp/a+XJmBWCZGL0IOi
         DA4qSPvLIi0dIPW/qmSG02hc/qIZj72WxGGvQ8IsQDFlEo8o+1XRSiamCgFpvGhgxMBC
         ng7w==
X-Forwarded-Encrypted: i=1; AHgh+Ror5E1hl/lCyq/QYg2fXWbd2MmU0x0slKLkR6Lw/ngMxxebB1oipM6xy4G0hLO0QnvLDTWB1GyJuyXEJiaM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BZHNTXfcQbA/tcexxBwyRd51VEtCFwKi+GBdUawcKmwIhOXs
	W4Z2MM8x/+DKSnI3IpsfbC7TLdzo4nzDwMfrisiLi2qc5vDcwJs6iolWNCnnpROk7J3OIbPeFF5
	OqLoC9A==
X-Gm-Gg: AR+sD120sE9Iusr1hDRpP+N3gW8j7fyt+lTIXA8WbeDWb+f1Dp6oZk26rOjey6efzXx
	ZjOVqBq3MnoXe/QchJooglsUTxKRGd2COUlILUzp9MulGzTk5uRVp9tid5jVy90MnhnAvMNqAjG
	Y+P3CLIoMNSvS1JeM4b0MxBlRJ36s3CJMIOCaa8IeYniFObe+20aGPcl3PMy9dB1FNw1zCUSWyr
	SE+ZCSa8PgTk3LuXOxV+4GwwLoXj29iYNgV5JPjxyUDeZGgdsrrnXhexAZ1ojSmoABiTVIZHK0f
	s0nkzWbeKG70huaXOeU7VDQn7s9QIQwMYOwuQsbRWot9gdXx2iZoUH3o9laCsq6efJQ5zdUhxP7
	FAec0kyuCPZeubRsOci1uYnkF13em7SypzJiJjER4fsVwAQVkcaAlSgnjqZIqvKjusn8n+g8Nmh
	rUh1wJz3xwAvkYwzcQxVPrKwDCy+XrQYrLGubDjOWz2AC+QDJRRKvkeahGF7waJ5NEG7cNGAzF4
	ii6Ipgnz3KyQ90/QqK2I+vEkS8fGSFk+g==
X-Received: by 2002:a05:6214:8589:20b0:90a:6c34:ed5d with SMTP id 6a1803df08f44-90a6c34ed7amr22377466d6.13.1786479397190;
        Tue, 11 Aug 2026 13:16:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c29a1f3sm6900626d6.17.2026.08.11.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:16:36 -0700 (PDT)
Date: Tue, 11 Aug 2026 16:16:35 -0400
Message-ID: <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260811_1529/pstg-lib:20260811_1529/pstg-pwork:20260811_1529
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Christian Brauner <brauner@kernel.org>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Daniel Durning <danieldurning.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 3/12] security: Add LSM_AUDIT_DATA_NS for namespace  audit records
References: <20260726161400.3010511-4-mic@digikod.net>
In-Reply-To: <20260726161400.3010511-4-mic@digikod.net>

On Jul 26, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
> information in audit records.  Two fields are provided:
> 
> - ns_type: the CLONE_NEW* flag identifying the namespace type, logged
>   in hexadecimal.
> 
> - ns_id: the unique 64-bit namespace identifier, retrievable from
>   userspace via NS_GET_ID or listns(2).  Unlike the proc inode number
>   (inum), ns_id is never recycled.  For namespace creation denials,
>   ns_id is 0 because the namespace does not exist yet.

Based on the code in this patch, "ns_type" should be "namespace_type"
and a similar change needs to be done for "ns_id".  Regardless, the
first three patches look fine to me (I can fixup the above during a
merge).

As mentioned previously, I want to merge at least the first three
patches via the LSM tree since we have multiple LSMs which depend on
these new hooks.  I'm happy to also merge the remaining Landlock
patches in this patchset via the LSM tree, or you can manage those
separately; let me know how you would like to proceed with that.

Since we are at -rc7, this is obviously something for after the
upcoming merge window so I'm going to merge the first three patches
into the lsm/dev-staging branch now with the understanding that they
will move over to the lsm/dev branch after the upcoming merge window
is finished.  If you want me to merge the Landlock patches too, just
let me know.

> A new audit data type is needed because no existing LSM_AUDIT_DATA_*
> type carries namespace information.  The closest alternatives (e.g.
> LSM_AUDIT_DATA_TASK or LSM_AUDIT_DATA_NONE with custom strings) would
> either lose the namespace type or require ad-hoc formatting that
> bypasses the structured audit data union.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> Changes since v1:
> https://patch.msgid.link/20260312100444.2609563-3-mic@digikod.net
> - Replace inum with ns_id in the audit record: ns_id is the stable
>   64-bit namespace identifier (never recycled), accessible to
>   userspace via NS_GET_ID and listns(2) (suggested by Christian
>   Brauner).
> - Add Reviewed-by: Christian Brauner.
> - Add Reviewed-by: Günther Noack.
> ---
>  include/linux/lsm_audit.h | 5 +++++
>  security/lsm_audit.c      | 4 ++++
>  2 files changed, 9 insertions(+)

--
paul-moore.com
