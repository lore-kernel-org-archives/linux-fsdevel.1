Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794111899;
	b=KbtNc/O9LiRy6cYTUo1p8xUXB80bzmBv7wSiw28gVF9OOjyNlruXuZ/eZLJHyzH9Laml
	 XaSmcVi5ZR6T71IdbS5zEfnNHhfuRvUvxiNGwugMA2gofTO4av3hh11mYTN4hFeTVXvL5
	 VADRcZhZIXyt8SIm/Xlz6mneX51iqj8pKwXvCeJoX503PuD2hPwWYizjOYXD8D6wW5zve
	 8HXugL2thNF7mhCwMVdg+6UXCO4wxZPLK+quZccBq0z4wMjxlYxmmaY4TZsM/IH6c3d5b
	 JSYMYMOv8RY7swRNCzeLKODABacJS7YCCw5oum7fe5XXTB/X9PTb68+kxV8rdjmch8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794111899;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=K+8Bg6EUw3TF1wR9YyKQuQJJAgHFmn9Yf5SnbT8zOjA=;
	b=jQhjhUjk8nCIbrJk1lXZI7M+cNLH3RrqmazV2RXnxmY6eSNuwFpWNrqqQAPk6i/uNp1r
	 56xYWZwCbusrS+chpP5L3C2FHwG7X6ZhC4zyrLs+A2sP/iC7MxPLJ8MhRQvifnU09SbdL
	 TyEQvBFrGE8JmIpD/Pk4ny1GDoASKygi3OQdejV4V73wW6tw2cG6jEEA5HwscXcqRohUv
	 sw4eXQFurg+NCpf2LHPAg568ohXpY2t1A3Wpl2rJNZnAHuP/WedemOXX2IUDkKasTzVBz
	 B/D/GNA3RPrA8atcT0SfXKGeEJ1MkXC/Srg58DLSk/UxuFW9aWfFJQIwTVPMqZcHiXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=NA+eMRwy;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=M6UZqeGy;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF49606A31C
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 04:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DF49606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=NA+eMRwy;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=M6UZqeGy
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A83fjjo2444268
	for <linux-fsdevel@vger.kernel.org>; Sat, 7 Nov 2026 23:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=K+8Bg6EUw3TF1wR9YyKQuQJJAg
	HFmn9Yf5SnbT8zOjA=; b=NA+eMRwysoiN1QqrWsbt0Rr0FUO3Ilui52wc1rcSmO
	en6V7Ir8uKs8LkuguDrcnqd1Kcam+Batzv2jaT1PfxF2nygaoL7XUKJiTz1pry6W
	8B1CVmCDU7meCThFXHtqI1Hzt41QT46OxMOpdeTnbljnl/R5wxhlMeYnriQ3RToJ
	VyLusS52dlctIy2ZDmYtjCfGmKV3URoK5HgPEPNk+6rY6GsYcQEkmDeNOET3wur4
	vS5gdv0f9/sFEGJcIVzbnI8WzF9dMCvDFa1zsOm7jaHtTXo5cXLtQH4KyAGB0hbp
	xpubgBwv3V2nH1+Qq8/je55ze5OKg2jpfWGHBE9C+3UA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hswwgma33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 23:24:56 -0500 (EST)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91ea0c20af3so3097416d6.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 20:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794111896; x=1794716696; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K+8Bg6EUw3TF1wR9YyKQuQJJAgHFmn9Yf5SnbT8zOjA=;
        b=M6UZqeGyCCs71GXwtMsnjxVweAjJnJbO98QMbCdn3nrbyEqFpypYPEN83l//wHMfDT
         6oacT/xFjTsM16dMuPHGW0o5OoKNHk+m2OB6/LkbrpdEYHIt1ANfZ3Jp4G1zaVKBo0a0
         4xNWOz+MURlXYb+r5HWe1axQb9aRGr6RfZJ/R0PHmgTQlzP733QwJLoa/j2zESUoykfL
         J4CbKibCm0hs0WRCYaRaNSIajE8tQudXpcN7uHMI+dXPw9ALS7jPjxaHGMxwgN05zg+9
         a9I9OyXKwTYHJQSE3DDH6qSA//SMb6VraQA+19N0z9mXTDth4RfOEUfg8NOxbKuY6WYU
         7Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794111896; x=1794716696;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K+8Bg6EUw3TF1wR9YyKQuQJJAgHFmn9Yf5SnbT8zOjA=;
        b=qNTCNMTXVnWgjZ8ibwwq/K0a9lVbWeauEAkImSDO/AshKuaGz6gLGWlHHxLBEetiQo
         jaSiauOQhv2OE06AVUjmhrK+vxQPmAnTb0Iq2ONuhM1wac7XmuTGZcPLEAKpOYV0TgOo
         1XLztMCJ6VaXOuVB0l43UkgMguE+y05x6S09CEsZfbT90N39dTliZDL/G5MSnJ6/ORP6
         w/rw6Oz5qYYjrd8ZCCOat5lncAHPT/3l/poCehkTMHEw9dtF3lLhGSP3xI2wYIP7U9y8
         P6c6qGKiJw6fNDKUNDvZ/aEb1st+gN11g5GszUvN6QsXJVr349DSI9odu3D7yARPjA6a
         hMBA==
X-Forwarded-Encrypted: i=1; AL+hErHVLLrJFKyJQRzvZ3Ajxbm5DKv+tjd8xqvz0RNGTH3enTEc5RlCsCXhCGBz9/qVFyP3/i5O3OFtvkok2Iuy@vger.kernel.org
X-Gm-Message-State: APuU4Z9atJvGbNk0O/LnWTOJ6t6yNcnpF6z74ibSYUxz5XjSlq8U6+7z
	aQtbpvsluyQJSXeE3/Fa6K2ee1yUwI7PnBwTEG9FM8zqmL/ZQLA+UcAgQZRjzCxW9g9qv/HPN6I
	d1sLzgTa0axhsRIOPyo82E83hJy+OaWy7eYEykZ5oSSFTF+gwZ5/4f90LH9Q5NkU=
X-Gm-Gg: AYBFou3BxAW6vXSl9ok0DVybmidEpne6dPAV1uhL/+hcfDVIVfPf2twYC8eDIg2Gz5C
	q3YUbDnTVBcD59urnraMZowPuf8kcN9HgcCt1KU5hUXDw6Xk31k5ok4B6FCRL73TfDsTmR8eZ2f
	Z1mOdHly2vcdGUQ4To91hvumd59xVnFtnIcu3H2pccVnyZGJw2zQVvFdRN6iwUFJdExlY3/KQkj
	DuG2Cj4ZvJmQoKCU8O7nYmitdYB9i99ElRA2NQDPQd6i3LjKKiexPSqs7SYg43j8cNd0Wpmpb5h
	Wrw33bwyQXYuP/6D4Vvog7l9cNrkYkBH7sTLZ69v0t7UuyZD7CqJ4DgBc/miNv5v+wAQbdalP9l
	GVMJElIjL+kNTmPCBYWnlunLHq0Res24V8yxYyZWxsbzYfPFuL7drsy9KHMEqzuasqe+9i3RpzI
	c09cgq4RADZDe/xJEiMg==
X-Received: by 2002:a05:6214:4b07:b0:91e:8ed6:896d with SMTP id 6a1803df08f44-91ed2476a9fmr5970766d6.41.1794111896373;
        Sat, 07 Nov 2026 20:24:56 -0800 (PST)
X-Received: by 2002:a05:6214:4b07:b0:91e:8ed6:896d with SMTP id 6a1803df08f44-91ed2476a9fmr5970596d6.41.1794111895960;
        Sat, 07 Nov 2026 20:24:55 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eceb56290sm10085586d6.1.2026.11.07.20.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 20:24:55 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] block: fail short atomic bounce bios in
 bio_iov_iter_bounce_write()
Date: Sat, 07 Nov 2026 23:24:34 -0500
Message-Id: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAIL572oC/yXMQQ6CMBBA0auQWTtJCyroVYwLOh1gAFvSAjEh3
 N2Cy7f4f4PIQTjCM9sg8CpRvEvQlwyoq13LKDYZcpXftdJXNONgecV69h8hNH5xxNjQg25Voar
 ClpDSKXAj33P7ev8dF9MzzccL9v0HmrkbengAAAA=
X-Change-ID: 20261014-blkdev-atomic-bounce-fc9c583083d7
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: John Garry <john.garry@linux.dev>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794111894; l=996;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=MQysUVjlstPiGv0HFbdIIHEKVGY3qk9oBru4ywVAac8=;
 b=ZFIpiuUVZQBRB9X/AYDUXtP1xkrxSWzeG52xXn4uDmJFAT+3ouMLtp87i4lyR+EjUxAB/zX2n
 numf/QkOPTuDfVi31ykeyiHjhEgiSSSyJiFjO0NEm0fExmh7ItRJ5Yy
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfX90FY8PiP3qu1
 XYKL5hdTvoBX7DwlPBSWIrlPmHVX/R4Lqw74OWvihHxz+/SEwNGt70CJpOnG6Bufk6W3AgUVqur
 6BdLllib9Onq8x1ijxGA4J4jalp7p8QKr5g+x/pLfJIA9CADHNTs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAxNyBTYWx0ZWRfXy+uRwLI8hIfF
 m3eXOvISp6nh0pkoWHbXPWcZaG7DTbLyAdrDS6Cy1dK8N2pm4X60NY8LINFUz5mxOQ0rh5a4BHX
 qs64qa0tCjevrGx3pl5gKFuiwZUNIirzHeP9CQJ3jfNka/BNj7QQm/2jtu0fKelGOYh6faPieQV
 Zw3Qk+uG28GFZV+mRBC/FJ9x90Z6F7Fw9mzI7c40gzXE7ze4nzMXHuaGWrRt6daetrs6IEaf+m0
 WC7bDxPqXXGwwJGBFp7Qf6ykV+dV3HILfkMgh5WjTvYMc1kN4McRpk7Hdj1qYFCiDRQK0il4yJh
 Jv3AtXwxJY+7/KUgOm08nrDeBy4zsLzgb5utQkXB/AD1lwgmTeyi6q3mqepM4X69uOEd3NuQ7MI
 nC0N6VgJlo4puLBKBwp51zBQ0G5vHO14mE43TmS6kO8SpG213QpHYOux9tkh1TrzxvnBfBCaQD1
 QDPyGUa1HGyu9j4NjOw==
X-Authority-Analysis: v=2.4 cv=e/yT2qp/ c=1 sm=1 tr=0 ts=6aeff998 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=kv0fz9X2Bfwy0Ckj0RYA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: OV-OY4LKICIkAKSI7JEDhOBAHIhRXTVW
X-Proofpoint-GUID: OV-OY4LKICIkAKSI7JEDhOBAHIhRXTVW
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11959
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=10 clxscore=1015
 phishscore=0 suspectscore=0 bulkscore=10 priorityscore=1501
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611080017

bio_iov_iter_get_pages() fails a short REQ_ATOMIC bio. In contrast,
bio_iov_iter_bounce_write() doesn't, so a bounced atomic write that runs
into a folio allocation failure triggers a WARN_ON_ONCE() in
iomap_dio_bio_iter_one().

The first patch makes bio_iov_iter_bounce_write() also check that a
REQ_ATOMIC bio covers the whole iterator, and clean up and return
-EINVAL if it doesn't. With both paths covered the iomap check can't
trigger, so the second patch removes it, as suggested by John Garry.

---
Tal Zussman (2):
      block: fail a short atomic bounce in bio_iov_iter_bounce_write()
      iomap: remove the atomic write length check in iomap_dio_bio_iter_one()

 block/bio.c          | 10 ++++++++++
 fs/iomap/direct-io.c | 14 --------------
 2 files changed, 10 insertions(+), 14 deletions(-)
---
base-commit: 839203759f536e6ef1267c80309c3532a7d588cc
change-id: 20261014-blkdev-atomic-bounce-fc9c583083d7

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

