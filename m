Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769341;
	b=pBM9S8b9vSx+A+EwaHi5rwgElKZEUZkbNdTFjgO8S5ruyA59Wx4yG+wcMa9Mi4VMnTYj
	 a9Ta9RW86zLxa1ZknZduJC9gsWF35upHBVS8P+eBKhDILaTs5pRGIrw3Wct+m8KMLn5ga
	 QsrYzLJxuTqGsuA+6rvzU/oOV1OLmbHzGAg31BO1sDjPUwfUxANz6760QfEh3RwX3gV7D
	 463w8qxIDx31t2c5aGY8S3qzJkD/ENkoMnzuvSDkHkrL+Rqc++ciCT4EPtZQgasy8DXqd
	 WYtgYP6KCuEz0NlNBItLCowk7QIv1+rHQcDmXAnlCA6urKkuc+ydihnbwHYPYa6RcQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aSulb1ZKSxB82Q0DHVFpLluzjXlQ4n39cXbO7GHm4Hg=;
	b=IvtDD9kMnxRvMYUZmNmGrTJgX1ULUbx5IXreAaVYK/UY2asPBJu7+++knTVC2n5QrxmF
	 bBXQYpf8EtTvl6YSv1OgHRF0dkYQpx9R7Ek/uvAAphjVsbwCbYiFVv16x9zgwOCW7WTz7
	 W8+J83WyMpwTuHLIrWwj0A5uIfizRfKmymUk0sGu1j/ZeICW+Na6pBnAGXoYu3STy2UmS
	 IcqAL1TF+XpP94TqD2t+HELMbkmCgq9KiU4HfHRwiImoTmGO4Ozdy73JUqawpUuEgpBfL
	 P/Q51b7I1YtYHJSB4T2BM6GvasY6ofCHvgQ6q1C4YLYHcgMTKzUVr7u0O5EUHcRGdOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jaXo+qjx;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84860A2600
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 08:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D84860A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jaXo+qjx
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f046b0adc0so44898135ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769340; x=1796374140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aSulb1ZKSxB82Q0DHVFpLluzjXlQ4n39cXbO7GHm4Hg=;
        b=jaXo+qjxS4fzoJ1sRQ8Yi81AgRWhimCxet1u+2ypHmWVaS4F6bD4yNr48nufv3HKEd
         pBuvi91xlP2kgry/49Zibz3buJuD3yv+nFgstbLMZWbv6FIEqVoOgzgtfIGKMqmfyEAs
         exUFaN1Vb5eB1op9z7SruKPxs3jk4eq4fe35/q9m8jSAZqh+jhIXQIfjD55LG/5Lgzlk
         k4gzG5VzILL+/MablkEU1WzCDIm2tVf1seXgNRskbhviWLdrizUghgXqkPF5kN1xOQRh
         /x0cI0WdKXCfxTXYXH6OprpaNmImqlEly/ESj6RiS2UD918BLS2MxJ3CmRtYY4RU40SO
         7D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769340; x=1796374140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aSulb1ZKSxB82Q0DHVFpLluzjXlQ4n39cXbO7GHm4Hg=;
        b=oIFE2O+2EeIFxos1UL9ynqojCjFAQOFqHdXgb04dKDBlMs9KmKgykWZluDrxlauzbQ
         +QKZ0vLLLzxRV0s1WnxJjNXu2Kh2rUcVuFIvZ/0cYKWBt0OZhqpLnVTO9SzYx9L1hsVT
         13pFIm8GvhiTR0dutLhD+NSrFB6Qw1RN66Vvy3HcmLXsa0K89hJRZUu0/06vF4MxVoTT
         vwLDkczXlq75TN6L0qByqc+7/suMzl9tvdkeQbykkBbqSiTbGppAoNehmy+BjW+oll41
         7m6LOamMNiPf33XEM2yfo5l05nCUB4IPAgVEgBJV7o1Dr+g1QcY0G0N/9meqbskKZeeq
         itDA==
X-Forwarded-Encrypted: i=1; AL+hErFY+mjv/bLdEBhWspI+WjZAExcELwnGyGqH1i1/K8OpSJ+Aet6sVECI3dpzSS1XAoHp6ki3IgMWkWsP6gYq@vger.kernel.org
X-Gm-Message-State: APuU4Z9gl/YZii7KPa3WQdOW8viqqDqXW6mu8uBuVt9ZIFFFKeLYqXcI
	hkDEGGTiHCk1uPGz5sLp8njmuuYccxr7c4TLwvA9oZ1ItcHFM2AS6FVv
X-Gm-Gg: AZFdTZd6k5iHnJywIA7g0xNJAMW6QmclKyvWs5J0qXTezZm1pbrRRhSWG9EijKkqV5s
	54o8iRR0Usd8q86SDV04oZNWXrcCnVvVBLId5TzXGTUwxI+6dVjCPO0xiUkjtJbnFXJnTfUiFw1
	m5tUm3a9LHxrCAIOtHUI9zWURifDgkpJ15T3mLb53AQJXGS0qR3n9m+KKuCDSvdkWT2LU9u7avF
	BSQauoOB8Ky9e5kZTu1rQ8jSMK6sWaMLU+ZGfOpIPYPypjLI0WX7Oxd3jfSlQxH1WawLHYiGjdN
	/JrwUiBwJeBI38f58cZKjFi8Gdb1kcqmzq+/8CwzCAnmKYHBs0wuPo8KFRhci+Qhjll0+0I64hI
	z6fFFtu0TyY9HyVwb/NiXx8hgrvklMwqK6IQ67XILm1lC5SG5fwYTdNH6AzhZzrdn+x5EPXcMbS
	1tE8OI26jXNWHStLkkMadvf0pFF10kgAHD0b7qRTYuMFcwI5wf/Ie41hEmMtcMZfmXd724oMdhx
	uBAsFekvcheIjsJ2dUa/mtzYu+PwNnHkiEVWoVJgBvWmcDVur0FDuA4tZncT9YUDDSKysVS1wZf
	00atbz7CMjotpsGk5rFxqSlWASY85CTW0vWa05m+NTo0TGbv6hFfvwmCaknC02MLDQ==
X-Received: by 2002:a17:903:22c8:b0:2ef:e563:d2a2 with SMTP id d9443c01a7336-2f11414c317mr10473615ad.57.1795769339572;
        Fri, 27 Nov 2026 00:48:59 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0818c1sm12289058a12.30.2026.11.27.00.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:48:59 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v6 1/2] f2fs: complete dropbehind write bios in task context
Date: Fri, 27 Nov 2026 16:48:44 +0800
Message-ID: <323235fbdeb5131f83569541c602ddc88f412b18.1795746008.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795746008.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <cover.1788795700.git.qiwenjie@xiaomi.com> <cover.1795746008.git.qiwenjie@xiaomi.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark dropbehind write bios BIO_COMPLETE_IN_TASK so the block layer can
defer their completion to task context before folio invalidation.

Allow normal and dropbehind folios to share IPU and OPU bios. Set the
flag after a dropbehind folio is successfully added, checking the original
page-cache folio rather than an encrypted or compressed replacement.

Exclude metadata-cache I/O, which may not have a file-data folio. Leave
the existing large-ATC completion path unchanged.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v5:

- Rebase onto dev, preserving the updated bio_len/bio_offset merge paths.
- Skip metadata-cache I/O before testing the original folio's hint.

 fs/f2fs/data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdc9e6e8633c..37d74afc8b26 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -624,6 +624,9 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
+	if (!is_read_io(fio->op) && !fio->is_cache &&
+	    folio_test_dropbehind(fio->folio))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 	bio->bi_iter.bi_sector = sector;
 	F2FS_BIO(bio)->entry = NULL;
 	bio->bi_private = NULL;
@@ -1077,6 +1080,8 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 					fio_folio->mapping->host,
 					fio_lblk, fio) &&
 			    bio_add_folio(*bio, folio, bio_len, bio_offset)) {
+				if (folio_test_dropbehind(fio->folio))
+					bio_set_flag(*bio, BIO_COMPLETE_IN_TASK);
 				ret = 0;
 				break;
 			}
@@ -1359,6 +1364,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 		goto alloc_new;
 	}
+	if (folio_test_dropbehind(fio->folio))
+		bio_set_flag(io->bio, BIO_COMPLETE_IN_TASK);
 
 	F2FS_BIO(io->bio)->entry_cnt++;
 
-- 
2.43.0

