Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632403;
	b=Q751QbTeGsoUk/MTs3pClyoPtL5oAF7EfDMHI4mpcGxyx5AfTbMx5Md/gdYsAMDnUYPm
	 Abx26nBDcmioQeDxP9wylPRogr0cJ1e/uyeBrtRiV3BFiKjzMrA2UZsHkEJvN/Q/Z8XHP
	 aqUhEge5JZGV6k+2T9gXUNKi+raF8Q5srlwrBuXHTz9clzpqqqhTn6rA5O6xTwExS3xjH
	 TDfTTjl5zLiCqjlcl0zPa9y+/pAR7aoRXtiFsy3CInar374rc+60FPgFfSpfMmFiXyBqb
	 MvrNbiFLycreHzTLg9MtMOk2Sq5zNt8V8zTPf14H9Z+lomIPyp6xkeYZ34rZqtt2A5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=mjng7Grfi+u3FVsnhecehgfZVWYTQAiCxYEYWdDHAjg=;
	b=IwIDv1eH1nMdRe6BlUn1qmXPgJQXtBYSuxK2RCfTRXf/6Ihc2kwcE0PIoeigMho8x/D+
	 6ygKtQk+eqy5ACz1acC7yXq6QBKJbFmUWReIs871tSWmPqvwBVjshlNkeRHs1eG9YGZBr
	 rJpxf4ucmvMtdytFUOt+URwnF89es0ok58lRIOCoweTmVeyt67t59FYvJmWw+KzQJkJ2e
	 kF4L0Yw9NhBqWfj9tBIIaVGIK7hKom/J1sk/D7zAzmc44BNIIGeDC2JTUNEVy73bRAktW
	 UjP/0/M5wDeRVvd9Q0Huu7FrD042TLt07HX0I+IwP+ngUDjrjs6BJowpurz6Zh7kUWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=FCVWvL3A;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577CB606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 577CB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=FCVWvL3A
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-48ed188ee81so3382198fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795632402; x=1796237202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjng7Grfi+u3FVsnhecehgfZVWYTQAiCxYEYWdDHAjg=;
        b=FCVWvL3A9pPajRsorw5xKgFeZtg8bNqB9d5z48BRmkv/RN0ksV7mW8feJ1FdHXkX7D
         M5MhCMa6fP8Jo/YZIxdt3QdFhae3xdx70I2xdYN3OcrY7j8Vex1PQlRxc5WuFNxckaRY
         sgJQGpIJ6gc3jCCPLiRW70LNGrZW2+wfGQb4P+Gh0kXnCng4AP9SSLgQlCk5CdpJ+6Mg
         9ZeyYGwMPMtfJy7L3vA7kf2Lh/3D+XQXq5YvwgfaCXThcgJSor1qc8v4bVjNJq/CugrF
         1gIA5oqKYDMc3d2PPtJvFVXJPWM9FFpPZEHjxawHbALUzFf4qVIWEEWsI1OLfhH8kg+s
         lzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632402; x=1796237202;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjng7Grfi+u3FVsnhecehgfZVWYTQAiCxYEYWdDHAjg=;
        b=1gr7HTOXDlzp3zEZ7GjL/TUQps4B9kXXEODZSoutJDCrxD6mcOT9QIqPUtX6Bacag+
         g471QlfgJ/QD0F3L1Ppx2aNGkohrsdgwnvwwk5NIbdd/ZzBr6TRaYzU19rN2LTVI4MSj
         mwrhsLEVJpAvTasXff8zld/f9YYtc0Xh56G9rWjRgZN875bM7x9HLFewEFQz+g9kwQSI
         zCFmXnBzpwSsvwXLfVw3x3iSToT2Ed2JvvIeeILJi2FMwGLhfE6l8GpOkWoC7hu+F3Uz
         lhrfh5HuclKFd+uD1LYVluw6SWAsBv43FfJspnyQd9w+XMe1qEIPHOSJ8zXtDyJ6vW1z
         Bjvg==
X-Forwarded-Encrypted: i=1; AL+hErGlSpUifhdfodD8vwQRwhb2X1lipaBHtkJyYqbCVmNv3wqK52+HoZknFk9lfJl3nfoa3xP1v9GVX3nA2eHN@vger.kernel.org
X-Gm-Message-State: APuU4Z82qqW4I+TrUDRV9gkaNZG48Gh91mEVGdrEebMX39fEmn4lplGV
	RK1RX2QrVMRbDllI9yxtTQl2cue/dMudSrQplAduPsHVkRTGb0dPjr6l9402k2dw2uQ=
X-Gm-Gg: AZFdTZc0azZFensl08qJYVmVTZrrnbeJ+Xmxi9BZF9XTQPmg2TrTXPmwpGTjGD5oNQc
	jcj0Rt8ji8kw3nRww2bta0IgvefPPY+CtycRB1SRpX+Iuh1/fjwRMULE4uTkRcodtU+vvrPL+aI
	vdigwkV06nF39GWOa2g+wu11XAiU3FLHkapOKsl6csqCCiEgkXbYXJzkLGTlxNa4HdYu4zcl42o
	aquhaoucLSaPdV57A1KVhn+EU/DwrGUnO0A9u14D/zmp3mo3Z2kMOLvv2JglmA4GyArYcgTp44/
	pWKlH6OSzKgwqx2OSRgCif84T1aU1VlOnRhMsa83lb+YLKLuo3DtLIYUfssLGrNtEu9TULu2bc7
	OSUF8+h9QEyaKdN+CI2MndBUpUznp1O8E/PO5cON0LUR7qGqu4hNydSWnl1iUWyn25aALeZeX2W
	5P9cnZB3e/U/7t6bHLD16NUz94zD8XdL5f6nP/kTmgSzGa9frVCPeu9g5Y20EsvCSjHPJrf4F1b
	GTJyrVtgx6EUtRoxw1TpTPg0m3I4ZCrHyEl8zPOOEZQZge+xgQBnvVdIIQI4KGXOTrcM1TkF0Gt
	qwhcXfWeAJkjH7fH4VB13BM7GMIivaszuUobcczg5pPE6xLl1YocDokXbKrEuxM4SPE2ATwXTcn
	QxDFCz0GrE0puITi47yMxcA/tZPcmckaR3YCKgl0spmXhcbw=
X-Received: by 2002:a05:6870:9f06:b0:447:a816:9328 with SMTP id 586e51a60fabf-4bc7d27004dmr15233245fac.6.1795632402212;
        Wed, 25 Nov 2026 10:46:42 -0800 (PST)
Received: from [192.168.0.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdbb4fsm16100211fac.5.2026.11.25.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:46:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, 
 Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261125180817.3682397-1-hengyul@cs.unc.edu>
References: <20261125180817.3682397-1-hengyul@cs.unc.edu>
Subject: Re: [PATCH] io_uring/openclose: allow an empty path with
 O_EMPTYPATH
Message-Id: <179563239982.59738.3885070855102608736.b4-ty@b4>
Date: Wed, 25 Nov 2026 11:46:39 -0700
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 25 Nov 2026 13:08:17 -0500, Hengyu Liang wrote:
> Commit 31cf44efa6df ("vfs: add O_EMPTYPATH to openat(2)/openat2(2)")
> made build_open_flags() accept O_EMPTYPATH and turn it into
> LOOKUP_EMPTY, so that openat(fd, "", O_EMPTYPATH) reopens the file
> behind fd.
> 
> However, io_uring also uses build_open_flags(), but __io_openat_prep()
> still copies the name with delayed_getname(), which rejects an empty
> name with -ENOENT. As of now, IORING_OP_OPENAT and IORING_OP_OPENAT2
> accept O_EMPTYPATH, but fail on the empty path this flag is meant for.
> 
> [...]

Applied, thanks!

[1/1] io_uring/openclose: allow an empty path with O_EMPTYPATH
      commit: 15ca993634424898cc0c055ef84dfbe29ae0370c

Best regards,
-- 
Jens Axboe



