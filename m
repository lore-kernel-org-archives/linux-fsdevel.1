Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079725;
	b=Qcr0eUwerZB3BPt1+thzjM+rB5KowkyGWUH7ajn8Su+Rkhs/pZiPrP3qh8JifDVI7u7i
	 mbdc/dTmeZNxQ2QYzMmqFEOd5MHfkA8aBdEfpJjkLSIKDBniYK5hLCVEBxgVwXn9n086z
	 Ruq3+u/mzBecmgvtNv97RtIJAgCRO6tnzEP+5uKnxIjS7HBuCAX8a4NtutgHciD2LALF7
	 yXJBlItXfVZTM7XCS9XXjVQSenOr5GIt/obFQaMizg9qBpziX74G/bd7nRpq3U17bZcHM
	 yTovcubviWLUd+fA9ZynsCIslmDGNB/sBtb/BMdDbaBVXoLhddhrstAeR6xv9qJE5Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w90szJpdzekfEVNOhw/amrduU9AsVHLVBfjyoWv/t+A=;
	b=SxwE2yOraDq86Rj62Gv63ZlFIL+7BgBbP3Q2Xux2l5Ta+JhskhFkA9LMYnh7s6s3AccK
	 dlFxQjQnjbr9+VnZTdu0xobp7d86W95g9cq1eGNMU9HTcEsI9Osgtd6il2S6bCC1xdR50
	 17v1AAa35oHMUAe9XOon1+oKROvPVgxhp52kJw9OOnMe8VPIAZjFTv/19iG7cP5KF4Sk2
	 BCT30FH9evHhM6zlBxDBNCtcPBFFysnSYQxu0+VxcTV3G61vv7tYt3gmiJHjsMUNK5iN2
	 lVzCWptMKrqlKZp1fQYiHLMlGSYqdnU+0ThGvwc2JdA/jpFIQjGIWBImucY4Yk/hLSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RGr0hTsv;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA444606A32D
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 19:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA444606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RGr0hTsv
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso57295eec.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794079724; x=1794684524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w90szJpdzekfEVNOhw/amrduU9AsVHLVBfjyoWv/t+A=;
        b=RGr0hTsvyDG9kcYi8oObA5cl5JlsF0oZFUgGMVMyW8SLmtQ+h3JpPrwQSS6D++cvR9
         gxcXj7JBZbHOaEGrZR85aG5xKyZH645cimD0jAa53sNhV7jREcwQqyuMSesdSatcYJGl
         AhdLbRTc7u8WhkGQVklb8nnBxcyYt4ARztUYWEikdVYbbYuZu4QMxVwYSeACdwo/mWjz
         6CxVV5iz6AzfZc7ilsiNQPhd4MkdP+5szujUtQ3OoC47FTWmgivZLyqreQN+oPFwSaZk
         tLBkd2vlNoYbwEGXAsHOfT1IOz6WgsnDfhmhdz/7EsskpmeqeEriFXHjU6PSwjiYBabF
         BKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794079724; x=1794684524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w90szJpdzekfEVNOhw/amrduU9AsVHLVBfjyoWv/t+A=;
        b=tZy8k2E9mC0enZE2h+vxQa5lw+oo4oXYvT7FRSrEtAj/EMFRuNYicGdHXD7Ieuvnvb
         oaFukx9sRHvRbGi6dHtGPKGCjJKEsRMnBpHIoaWfL3Cs666/wPgTnhWe7Nx+Nb/gq3Yb
         RV9JTl2IPeYbZBcrLkK8z90+O70SmmsArlabxWzYB1793URIYaPX7bP9ZUAr46JBLCuC
         3YeuPCq2AUyOLivErUtc9fa+t39tIuKBeTy2a38VsX7yQeR2Qqb42WZqIzr6kV5sVD5C
         DmxiJ6uPapv3FcdlIiWV6Gf8P4aXGZvQ88oM32XxcI2c4P/3iFigToG9+CvmKByeFkR5
         zxwA==
X-Forwarded-Encrypted: i=1; AL+hErGTxmIVHGdSW2wcSmsMsJYsoN/JYicMVC6C4Bbsf5d3So1XJuKvOJU26p2XvKSAOtO/eRX0JF0weB83mK1o@vger.kernel.org
X-Gm-Message-State: APuU4Z8K0wlUEqKWEjxLic3WtW6Ipixrp5cA8JiNYtRbIzS6fx4hSJ0s
	sJ5qOMYF5v22rO+mTpnAtqLzRbwfxJrBEZnMTe1KSKEtADBAXKQH4PpL
X-Gm-Gg: AYBFou2pc7ekjuP+Bq0C83ht2XB5r8Nb4faIc5KkJBir+uRZ8t96Lj3k35Lbu+IkVSs
	sB0ogrUTeThKOjZIadeaeerLIq21v1SLKAeAXc4eS1ADYunjOekfTzlToNviaAqMNnIgiM9Y0/0
	h7qecWr9W+wmpghaOZzWqI8fL4SZhJLRyV4MFfHkTYYy0XhxLBAfBhB6T4Z4NZBR/GYdlqFt/hD
	GPr2F1oQfJwGDRK/lnKMRYhxpcmdCnQ0E/G/cRcQX5ob4uHjw4yRNUtknezs8d1yWc4yaxdAFtY
	XTAhNNa5eIWkOpQHdFLFr/Qa+GTDuPDRpkZt9/8vIMsUiiMJQb+120bWnIGXfifuiCATRA6c9Ub
	sFHQMcy2ZSOE6+vIjcv7QhkHlWMDpgyg5XYUbUeoQJokIALi/Wvh7geTSoZlcTSb0NWJ8AEa0a6
	7s6g+JAdULom4XG4pVZaq5RhAVMTLAhEUCEIGuLtnqqArKaqigcIaFhTSQJl9JKXPWaYIgcyhla
	X9CXNHohOvbmFiOQon4CWR5Y7CIREpYOrw/caaTnaNhrO/JMNkzepSdoHbqN3yOGCBpZ7tywJ9M
	yFWOU3LDW9MugsCKq5V5KtIO5fd+17dFK6ZOZIKCDhNZQWJYnKPABsUpZd1OpnNOXXmCjE0Nvsu
	NmLOvRLNie+A=
X-Received: by 2002:a05:7300:f498:b0:369:fe4c:b48f with SMTP id 5a478bee46e88-3724ff5b718mr132577eec.0.1794079723626;
        Sat, 07 Nov 2026 11:28:43 -0800 (PST)
Received: from anon-laptop ([103.187.196.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fc92fasm23026419eec.19.2026.11.07.11.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:28:43 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ntfs: open a named $DATA stream by name when making room in a record
Date: Sun,  8 Nov 2026 00:58:36 +0530
Message-ID: <20261107192836.3908453-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
References: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
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

When an attribute has to grow and the mft record is full,
ntfs_resident_attr_resize() walks the other resident attributes and
converts them to non-resident ones. For $DATA it always opens the
unnamed data inode of the base inode, even if the attribute found is a
named stream:

  tvi = ntfs_iget(sb, base_ni->mft_no);
  ntfs_attr_make_non_resident(NTFS_I(tvi), value_len);

value_len is the length of the stream, so it does not match the
attribute that ntfs_attr_make_non_resident() looks up for the unnamed
inode, and the WARN_ON() on entry fires:

  WARNING: fs/ntfs/attrib.c:2115 at ntfs_attr_make_non_resident
   ntfs_resident_attr_resize
   ntfs_attr_expand_locked
   ntfs_expand_for_write
   ntfs_file_write_iter
   vfs_write

With debug output the values were attr_size 13 (unnamed $DATA) and
data_size 550 (named stream) for the same mft record.

It does not need a damaged volume. A file with an alternate data stream
whose record has no room left is enough. The fuzzer found it through a
single changed byte in a file name of an image from mkntfs, which made
a write grow a resident attribute in such a record.

Use ntfs_attr_iget() with the name of the attribute for a named $DATA
stream, as is already done for the other attribute types in this loop,
and keep ntfs_iget() for the unnamed one.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
v3: open a named $DATA stream with ntfs_attr_iget(), as suggested, instead
    of skipping it (v2). Same change as v1 of this patch.

 fs/ntfs/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index ce7c1b524180..c92d1b06afc3 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -4933,7 +4933,7 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		if (a->type == AT_DATA && !value_len)
 			continue;
 
-		if (a->type == AT_DATA)
+		if (a->type == AT_DATA && !a->name_length)
 			tvi = ntfs_iget(sb, base_ni->mft_no);
 		else
 			tvi = ntfs_attr_iget(VFS_I(base_ni), a->type,
-- 
2.56.0

