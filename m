Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793538522;
	b=gbBVxBJJDsaU4YtEW3oM8v0aLzHBQOvGge1+y1272kbMU53yZ1PJW6lYQpAkftXcQ8Cu
	 Sz1K4RYqVaBrK817f3wYbhEIheLECTm39VwBYX7bLohBdDnpQYkVUajgmssgVkZKbs8/q
	 4WqcUSMZKaxN5hqnZYlilOnMEwGQsudRZfBqkLOMkrz4zrlb5hdQp/rkL6Un27or46I/z
	 dymyNg5HnW3/P66LlEVbxbexckoatdgb92q0oFF8Me6/0jyEakCYYhhpanzvC2QchSjm0
	 Pf/dgcqAbYcErcTp+Gz6bAiJ+0iojMj9hBQzaRnmpYUVCLIl4eMbDkmUDGRtBtyyNjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793538522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=DN+73IopgojkHF5owDqrZcQJFph061u4C7fIX+4pVMM=;
	b=gL2jN6PB4yyN5bBGn4DuQt+ZF7u1WTSpHDRgHPkFy3T+qLi2d7bu9zPFW5sEXP5h/7UO
	 x1yqR88uFHf1Y3d2n8e0Fz/fQDZ1oSOwtBjY3eVQ2+SRzw03VJx9eEg8cVRy5Yxk0at2X
	 /5PVby593MJfFGV3c5vG7KhlH9EegUKMgAj6rDjO/EPW5wdOWjkTtpLqlEMcYec35VHVE
	 xfxLTEySndZkcHnY7X0cGGVA7y77QtoJdk90U9P9V3bBw6dVfKOIwfHwaJcsb2oi31oL3
	 nHUdlfUw5SpdL4A7SEkygvCBEidKEUfNAQDspzHpnTGHPfE0XWB8fC+QF2rnm00J/sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui8X5Z4V;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344E606A32F
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 13:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B344E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui8X5Z4V
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35eaf84cc66so2287074eec.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 05:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793538520; x=1794143320; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DN+73IopgojkHF5owDqrZcQJFph061u4C7fIX+4pVMM=;
        b=Ui8X5Z4Vcsi3afFDuZP4c7n6Y1u3hrIwd8imnTwYv527JuxpSlDa2Nt2iKqKLIeSx9
         LGWnxWwerWrqDvDtxh5ZfjScTg5ojvqr/StdKLGzfm2EvegZQPV3R7c9TH/SYao6N4a+
         9WpXfACIGBRheiQoRfuJBvD4TwwtlHxnLiV7hjAX2J8mR9vW7QdjOdnoVoTJpEuD66Pe
         /JI1XNpXhyXZmga3BDNQB7vhuj4BNBnv4vgtl8XVuYTEN4gnHATgeCEVJMtklcj/H0ab
         4qwHpK1idThI+nh0Usu9fTCkZFxA835HPggfOKY7B+PX643PF+tw0v4ksdU2Jp72wRJV
         l88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793538520; x=1794143320;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DN+73IopgojkHF5owDqrZcQJFph061u4C7fIX+4pVMM=;
        b=JlIcphi3x4Ri+tSAG/d8SLSLWJykSNC5G23nZZhTpPCZMDZtxXx/ipJ66ooBY100mI
         JwMSb21p3q7mPLnA2+yyz+Xtdu/gAimgWdY6c21udVVjymC1+5H7D83Fz5dS8cQjgQTP
         i+56EUIljAMR3T/L3l7u1fCNY8HJQCDLER9ooQ+tSBzioRrpb4wvoY0hybbArNK1Pbqq
         6h8nwsk7FGLK9NclaByw88LwT8bqv/xN4Eh7tuT4o5u23g0ShS4bbIJkpKh+WKY9vP0f
         ukhN92BbTjVn4npDzwOConlyafJQqW6uXYjmKYu8obmz0YyX6HJ3BknhsUKMAkk0VRGf
         3MJw==
X-Forwarded-Encrypted: i=1; AKwUvBwsqAL3WLX8E4SccHcp2eACnICPBzOsPw2BR8AgJ2NPhwo7c6tf5uVc9MU7HyPSzUbCXImULj0CNR3BGGT3@vger.kernel.org
X-Gm-Message-State: APuU4Z+QGajCcE96i22T7EeDr3LwIMMBqq/TIJEo6HIY7mCW4rML9dRp
	Tde6Tq/jS4YMyuKh0yGSDGn3S4rAqyfiFGtMrPpP09a64fOtcy5mYPH7
X-Gm-Gg: AYBFou0VVMxg6YOA4mxN2fi27ZCw49m0uyWGCfM2URmQ2nY1P/T+J0OM0C0eVbZZcLa
	GQtBlRooMztJLyAHo0rb+Wkywk7gKnZglN/fgVxqTjc1ERiFZxAF5gxsB7898/XJPkX7j1to6Kd
	bLHsCxyNgTjR6b1OG6Kbvw/HiD4Pk5kLGLmKz3cRr33S/QT8//8uVQGoHR39bob4jtLSh6z/ckz
	jHZ7Pxcr5FqbHEhJawjCUS3i6H01WWQ0w0CfQ0JRWcnSE+IjJh0BMdcFK0U8ZDCsvyCa1uXRzWQ
	2tisrH/7MSoyh21YEyGFIsLyS7yn4IrfPNhJB7nDcb9s+euDvF4Hoe9C8fEFMjqJABVwkkWc40K
	bc67QjIETowosxdRsJIvfNTek+KLtPtbdFLAQAHqFl9qcf/66H+Gj/68VZY0P9s0jKnj17Mc3wI
	ywEKjkbtl2OqgIaM8ImBhhEpTx4MsG60k5jTjnPFtozVg0HN9098OyXJ7jQS6GNSrON3Y7USARC
	PR2Xwu0A3TNshOTaVc8zBdHKi4JMH0Wxa3kI6ILpxJM3VG5Kb6ZSsoBGSbpnALWA7uaMTdF4AUT
	QpErk/j9ej8T971jH10u0ed2J8lSB1ij4gBsN5hojmj5bN7Z/UlDbxkC8kS8sfFH9oIGPfUhitN
	7P2FJSN+PWddzygygNNILiLH25hE=
X-Received: by 2002:a05:7301:da83:b0:366:83dd:46f3 with SMTP id 5a478bee46e88-36a423a1f05mr10839613eec.14.1793538519681;
        Sun, 01 Nov 2026 05:08:39 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4294419dsm25939660eec.18.2026.11.01.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 05:08:39 -0800 (PST)
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
Subject: Re: [PATCH] hugetlbfs: report inode limits without a memory
 subpool
From: Aveline Noir <jm5905938@gmail.com>
Date: Sun, 01 Nov 2026 23:58:16 +1100
Message-Id: <179353789680.2.16953097023348053073.b4-reply@b4>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>
In-Reply-To: <20261101122653.53982-1-dennylin0707@gmail.com>
References: <20261101122653.53982-1-dennylin0707@gmail.com>
X-Mailer: b4 0.16.0

Hi Hungyu,

On Sun, 01 Nov 2026 12:26:53 +0000 Hungyu Lin wrote:

> Report the inode counters when an inode limit is configured,
> independently of the memory subpool. Preserve the existing zero and -1
> results for unlimited inode counts.

Tested in an x86-64 QEMU/KVM guest and all checks passed.
Inode-only counts are fixed, and unlimited counts are unchanged.
Makes sense to me.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
